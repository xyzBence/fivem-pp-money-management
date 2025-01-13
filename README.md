# fivem-pp-money-management
This FiveM script allows server administrators to manage custom points (PP) and money for players through simple commands. It includes detailed Discord webhook logging, real-time database synchronization, and custom permissions to ensure secure usage. Fully compatible with older ESX versions and easy to integrate.

## **Created by**: Bence



## **Features**

1. **Add or Remove PP**:
   - Add or remove custom points (PP) for any player.
2. **Add or Remove Money**:
   - Add or remove in-game money for players in real-time.
3. **Discord Webhook Logging**:
   - Detailed logs for each command, including executor, target player, amount, reason, and timestamp.
4. **Real-Time Synchronization**:
   - Changes are reflected immediately in the game, without the need for server or client restarts.
5. **Custom Permissions**:
   - Only specific groups (e.g., `owner`, `admin`) can execute the commands.

---

## **Commands**

### **Adding Commands**
- **`/setpp [id|me] [amount] [reason]`**
  - Adds PP to a specified player. Use "me" for yourself.
  - Example: `/setpp 2 100 Reward for event`

- **`/setmoney [id|me] [amount] [reason]`**
  - Adds money to a specified player. Use "me" for yourself.
  - Example: `/setmoney me 5000 Compensation`

### **Removing Commands**
- **`/removepp [id|me] [amount] [reason]`**
  - Removes PP from a specified player. Use "me" for yourself.
  - Example: `/removepp 3 50 Punishment`

- **`/removemoney [id|me] [amount] [reason]`**
  - Removes money from a specified player. Use "me" for yourself.
  - Example: `/removemoney me 2000 Fine`

---

## **Configuration**

The script uses a `config.lua` file for customization. Here are the key settings:

- **Allowed Groups**:
  - Define which groups can execute the commands. Example: `owner`, `admin`.
- **Discord Webhook**:
  - Set your Discord webhook URL for logging. Example: 
    ```lua
    Config.WebhookURL = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_URL'
    ```

---

## **Requirements**

- **FiveM Framework**: Compatible with **older ESX versions**.
  - Uses `TriggerEvent('esx:getSharedObject')` for compatibility.
- **Database**: Requires `oxmysql` for database integration.

---

## **Installation**

1. Download the script from the [GitHub repository](https://github.com/xyzBence).
2. Place the script folder into your server's `resources` directory.
3. Add the following line to your `server.cfg`:
