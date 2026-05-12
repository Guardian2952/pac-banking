# PAC Banking - Install and Setup

This repository is a public integration/reference package for PAC Banking.

The full PAC Banking resource should remain private unless your repository visibility is changed to private.

## Requirements

- A FiveM server using `fxmanifest.lua` resources
- The private `pac-banking` resource installed on the server
- A supported database resource such as `oxmysql`, if your private PAC Banking build uses database persistence
- Job scripts that call PAC Banking exports from the server side

## Installation

1. Place the private `pac-banking` resource in your server resources folder.

   Example:

   ```text
   resources/[pac]/pac-banking
   ```

2. Copy `config.example.lua` to your private resource as `config.lua`.

   ```text
   config.example.lua -> config.lua
   ```

3. Edit `config.lua` for your server.

   Do not commit your real `config.lua` if it contains private server values, webhook URLs, credentials, framework-specific settings, or other sensitive information.

4. Make sure `exports.lua` is included by your private `fxmanifest.lua` if you want to load the helper file directly.

   Example:

   ```lua
   server_scripts {
     'config.lua',
     'exports.lua',
     'server.lua'
   }
   ```

5. Add the resource to `server.cfg` after its dependencies.

   Example:

   ```cfg
   ensure oxmysql
   ensure pac-banking
   ```

6. Restart the server or run:

   ```cfg
   refresh
   ensure pac-banking
   ```

## Job export usage

Use these exports from server-side job scripts.

### Add income

Use this when PAC Banking should add money to the job account and write an account history row.

```lua
exports['pac-banking']:AddJobIncome('police', 2500, 'Citation revenue', 'LSPD Account')
```

### Add expense

Use this when PAC Banking should remove money from the job account and write an account history row.

```lua
exports['pac-banking']:AddJobExpense('mechanic', 750, 'Vehicle parts order', 'Mechanic Account')
```

### Record income only

Use this when another script already handled the balance change and PAC Banking only needs to write history.

```lua
exports['pac-banking']:RecordJobIncome('ambulance', 5000, 'Hospital payout', 'EMS Account')
```

### Record expense only

Use this when another script already handled the balance change and PAC Banking only needs to write history.

```lua
exports['pac-banking']:RecordJobExpense('police', 300, 'Equipment purchase', 'LSPD Account')
```

## Recommended order for job scripts

Start PAC Banking before any job resources that call its exports.

Example:

```cfg
ensure oxmysql
ensure pac-banking
ensure police-job
ensure ambulance-job
ensure mechanic-job
```

## Troubleshooting

### Export not found

Check that:

- `pac-banking` is started before the job resource.
- The export exists in your private server-side PAC Banking code.
- The job script is calling the export server-side, not client-side.

### History does not show income or expenses

Check that:

- The job name matches the account/job identifier used by PAC Banking.
- The amount is a positive number.
- The account history table exists.
- The private PAC Banking server code is writing the correct transaction type for income and expense rows.

### Balance changes but history does not update

Use the `Add*` exports if PAC Banking should change the balance and write history.

Use the `Record*` exports only when another resource already changed the balance.
