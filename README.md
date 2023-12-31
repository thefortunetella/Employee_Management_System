# Employee Management System SQL

This SQL code defines the schema and data for an Employee Management System. The system includes tables for employees, branches, clients, works_with relationships between employees and clients, branch suppliers, and a trigger to log when a new employee is added.

## Table of Contents

- [Table Descriptions](#table-descriptions)
- [SQL Queries](#sql-queries)
- [Database Design](#database-design)
- [How to Use](#how-to-use)
- [Contributing](#contributing)

## Table Descriptions

1. **Employee**: Stores information about employees, including personal details, salary, supervisor, and branch affiliation.

2. **Branch**: Contains information about branches, including the branch manager and their start date.

3. **Client**: Contains information about clients and their association with branches.

4. **Works_With**: Represents relationships between employees and clients, including total sales made.

5. **Branch_Supplier**: Records branch-supplier relationships and the types of supplies they provide.

6. **Trigger_Test**: Stores log messages generated by the trigger.

7. **Triggers**: Includes a trigger called `my_trigger` that logs a message in the `Trigger_Test` table whenever a new employee is added to the `Employee` table.

## SQL Queries

The code includes a variety of SQL queries for querying information from the tables, such as retrieving employee data, branch information, client details, statistics, and more.

## Database Design

The database is designed to manage employee information within different branches, track client relationships, and log new employee additions using triggers.

## How to Use

1. **Database Setup**: You can use a MySQL database management tool (e.g., phpMyAdmin) or the MySQL command line to run the provided SQL code to create the tables and insert sample data.

2. **Querying Data**: Use the SQL queries provided to retrieve information from the database, such as employee details, branch information, client data, and more.

3. **Triggers**: The trigger `my_trigger` will automatically log a message in the `Trigger_Test` table whenever a new employee is added to the `Employee` table.

## Contributing

If you would like to contribute to this project or improve the database schema, feel free to fork this repository, make your changes, and submit a pull request. Your contributions are welcome!
