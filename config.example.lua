-- PAC Banking public example config
-- Copy this file to config.lua inside your PRIVATE pac-banking resource and adjust as needed.
-- Do not commit your real config.lua if it contains private server values, webhook URLs, credentials, or framework-specific secrets.

Config = Config or {}

-- Public integration/export settings only.
-- The main banking resource code should stay private unless the repository is changed to private.
Config.JobExports = {
  Enabled = true,

  -- Account labels shown in history/UI when a job resource records income or expenses.
  HistoryLabels = {
    Income = 'Job Income',
    Expense = 'Job Expense'
  },

  -- Default text when a job script does not pass a reason.
  DefaultReasons = {
    Income = 'Job payment received',
    Expense = 'Job payment spent'
  }
}

-- Example job names that may call the exports.
-- This is only documentation/config reference; enforce permissions in your private server code.
Config.ExampleJobAccounts = {
  police = true,
  ambulance = true,
  mechanic = true
}
