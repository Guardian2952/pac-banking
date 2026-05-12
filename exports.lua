--[[
PAC Banking job export helper

Use this file as a server-side reference/helper for job resources.
The actual PAC Banking exports are registered in server.lua.

Recommended calls from any server-side job script:
  exports['pac-banking']:AddJobIncome(jobName, amount, reason, accountName)
  exports['pac-banking']:AddJobExpense(jobName, amount, reason, accountName)
  exports['pac-banking']:RecordJobIncome(jobName, amount, reason, accountName)
  exports['pac-banking']:RecordJobExpense(jobName, amount, reason, accountName)

Use Add* when PAC Banking should also change the job account balance.
Use Record* when another resource already changed the balance and you only need the history row.
]]

PACBankingJobs = PACBankingJobs or {}

function PACBankingJobs.AddIncome(jobName, amount, reason, accountName)
  return exports['pac-banking']:AddJobIncome(jobName, amount, reason, accountName)
end

function PACBankingJobs.AddExpense(jobName, amount, reason, accountName)
  return exports['pac-banking']:AddJobExpense(jobName, amount, reason, accountName)
end

function PACBankingJobs.RecordIncome(jobName, amount, reason, accountName)
  return exports['pac-banking']:RecordJobIncome(jobName, amount, reason, accountName)
end

function PACBankingJobs.RecordExpense(jobName, amount, reason, accountName)
  return exports['pac-banking']:RecordJobExpense(jobName, amount, reason, accountName)
end

function PACBankingJobs.AddPayment(jobName, amount, direction, reason, accountName)
  return exports['pac-banking']:AddJobPayment(jobName, amount, direction, reason, accountName)
end

function PACBankingJobs.RecordPayment(jobName, amount, direction, reason, accountName)
  return exports['pac-banking']:RecordJobPayment(jobName, amount, direction, reason, accountName)
end
