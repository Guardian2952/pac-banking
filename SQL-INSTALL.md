# PAC Banking - SQL Install Guide

PAC Banking may auto-create its SQL tables depending on your private build and configuration.

This guide is still included for servers that prefer manual database setup, want to verify table structure, or need to troubleshoot account history not saving correctly.

## Before you start

Make sure your server has:

- A working MySQL or MariaDB database
- `oxmysql` or the database wrapper required by your private PAC Banking build
- Database credentials configured in `server.cfg`

Example `server.cfg` database connection:

```cfg
set mysql_connection_string "mysql://user:password@localhost/database_name?charset=utf8mb4"
ensure oxmysql
ensure pac-banking
```

Do not publish your real database connection string.

## Auto-create behavior

If your private PAC Banking build auto-creates SQL tables, you normally only need to:

1. Start the database resource.
2. Start `pac-banking`.
3. Watch the server console for SQL creation or migration messages.
4. Open the database and confirm the banking/account-history tables were created.

Recommended start order:

```cfg
ensure oxmysql
ensure pac-banking
```

## Manual SQL install

If auto-create is disabled or fails, import the SQL file included with your private PAC Banking package.

Typical steps:

1. Open your database manager.

   Examples:

   - HeidiSQL
   - phpMyAdmin
   - Adminer
   - MySQL Workbench

2. Select your FiveM server database.

3. Import the private PAC Banking SQL file.

   Common names may include:

   ```text
   pac-banking.sql
   banking.sql
   install.sql
   ```

4. Restart the resource.

   ```cfg
   restart pac-banking
   ```

5. Confirm that accounts and account history are saving.

## Account history fields

For job income and expense history, the database should support enough information to show:

- account or job identifier
- account display name
- transaction type
- amount
- reason or description
- timestamp/date
- income versus expense direction

Income should display as a positive value.

Expense should display as a negative value or be marked with an expense transaction type so the UI can display it as money leaving the account.

## Example reference table

The exact schema may differ in your private build. This is only a reference for what a job account history table commonly needs.

```sql
CREATE TABLE IF NOT EXISTS pac_banking_account_history (
  id INT NOT NULL AUTO_INCREMENT,
  account_identifier VARCHAR(100) NOT NULL,
  account_name VARCHAR(100) DEFAULT NULL,
  transaction_type VARCHAR(50) NOT NULL,
  amount DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  description VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  INDEX idx_account_identifier (account_identifier),
  INDEX idx_created_at (created_at)
);
```

Only use the example above if your private PAC Banking code expects this table name and column structure.

## Troubleshooting

### Tables do not auto-create

Check that:

- The database connection string is correct.
- `oxmysql` starts before `pac-banking`.
- The database user has permission to create tables.
- There are no SQL errors in the server console.

### Job payments do not appear in history

Check that:

- The account history table exists.
- The job resource is calling the PAC Banking export server-side.
- The job name matches the stored account identifier.
- The amount is numeric and greater than zero.
- Your private PAC Banking code inserts the correct transaction type for income and expense.

### Expenses show as income

Check that the transaction type or direction is saved correctly.

Expenses should either use a dedicated transaction type such as `expense` or store the amount as a negative value, depending on how your private UI reads account history.
