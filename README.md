# Inventory Management System — SQL Project
Models a store's inventory with product categories, stock tracking, expiry dates and sales transactions.

## Database

**Name:** `Inventory_mgmt`

## Tables

- **Categories** — stores product categories (Dairy, Snacks, Beverages)
- **Products** — stores product details including price, stock count and expiry date, linked to a category via foreign key
- **SalesTransactions** — records every sale with quantity and date, linked to a product via foreign key

## Queries

**Basic selects** — view all products, transactions and categories

**Expiry alert** — finds products expiring within the next 7 days that still have significant stock (> 50 units), so staff can prioritise selling them

**Dead stock detection** — finds products with no sales in the last 60 days, or products that have never been sold at all, using a LEFT JOIN to catch nulls

**Monthly revenue by category** — joins all 3 tables to calculate total revenue per category for a given month, using `Price × Quantity` per transaction

## How to run

1. Open MySQL Workbench or any MySQL client
2. Open `Inventory_mgmt.sql`
3. Run the full script — it creates the database, tables, inserts sample data and runs all queries

## Tech

MySQL · SQL Joins · Aggregate Functions · Date Functions · Foreign Keys
