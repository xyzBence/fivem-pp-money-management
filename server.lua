ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('setpp', function(source, args)
    handleAddOrRemove(source, args, 'pp', true)
end, false)

RegisterCommand('setmoney', function(source, args)
    handleAddOrRemove(source, args, 'money', true)
end, false)

RegisterCommand('removepp', function(source, args)
    handleAddOrRemove(source, args, 'pp', false)
end, false)

RegisterCommand('removemoney', function(source, args)
    handleAddOrRemove(source, args, 'money', false)
end, false)

function handleAddOrRemove(source, args, field, isAdd)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    if not isAllowed(xPlayer.getGroup()) then
        xPlayer.showNotification('You are not authorized to use this command.')
        return
    end

    local targetId = args[1] == 'me' and source or tonumber(args[1])
    local amount = tonumber(args[2])
    local reason = table.concat(args, " ", 3)

    if not targetId or not amount or not reason then
        xPlayer.showNotification(string.format('Incorrect syntax! /%s [id|me] [amount] [reason]', isAdd and 'set'..field or 'remove'..field))
        return
    end

    local targetPlayer = ESX.GetPlayerFromId(targetId)
    if not targetPlayer then
        xPlayer.showNotification('Target player not found.')
        return
    end

    local identifier = targetPlayer.identifier
    local operation = isAdd and "+" or "-"
    MySQL.Async.execute(string.format('UPDATE users SET %s = %s %s @amount WHERE identifier = @identifier', field, field, operation), {
        ['@amount'] = amount,
        ['@identifier'] = identifier
    }, function(affectedRows)
        if affectedRows > 0 then
            if field == 'money' then
                local currentMoney = targetPlayer.getMoney()
                targetPlayer.setMoney(isAdd and currentMoney + amount or currentMoney - amount)
            end
            targetPlayer.showNotification(string.format('%s %s: %d', field == 'pp' and 'PP' or 'Money', isAdd and 'added' or 'removed', amount))
            xPlayer.showNotification(string.format('Successfully %s %d %s.', isAdd and 'added' or 'removed', amount, field == 'pp' and 'PP' or 'money'))
            sendToDiscord(xPlayer.getName(), xPlayer.source, targetPlayer.getName(), targetId, string.format('/%s%s', isAdd and 'set' or 'remove', field), amount, reason)
        else
            xPlayer.showNotification('An error occurred during the operation.')
        end
    end)
end

function sendToDiscord(executorName, executorId, targetName, targetId, action, amount, reason)
    PerformHttpRequest(Config.WebhookURL, function(err, text, headers) end, 'POST', json.encode({
        username = 'Bence Adding Log',
        embeds = {{
            title = 'Command Executed',
            description = string.format('**Command:** %s\n**Executor:** %s (ID: %d)\n**Target:** %s (ID: %d)\n**Amount:** %d\n**Reason:** %s\n**Time:** %s',
                action, executorName, executorId, targetName, targetId, amount, reason, os.date('%Y-%m-%d %H:%M:%S')),
            color = 3447003
        }},
    }), {['Content-Type'] = 'application/json'})
end

function isAllowed(group)
    for _, allowedGroup in ipairs(Config.AllowedGroups) do
        if group == allowedGroup then
            return true
        end
    end
    return false
end
