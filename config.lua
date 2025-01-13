Config = {}

-- GROUPS ALLOWED TO USE THE COMMANDS
Config.AllowedGroups = {
    'owner',
    'admin'
}

-- DISCORD WEBHOOK URL
Config.WebhookURL = ''

-- FUNCTION TO FORMAT THE WEBHOOK MESSAGE
Config.WebhookMessage = function(executorName, targetName, action, amount, reason)
    return string.format(
        '**%s** executed the command: **%s**\nTarget player: **%s**\nAmount: **%d**\nReason: **%s**.',
        executorName, action, targetName, amount, reason
    )
end
