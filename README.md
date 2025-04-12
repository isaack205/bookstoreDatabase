# bookstoreDatabase

# Bookstore Database Schema

This project defines the schema for a **Bookstore Management System** using SQL. The schema includes tables for managing books, authors, customers, orders, and more. It also defines user roles with specific permissions to ensure secure and efficient database operations.

## Table of Contents

- [Overview](#overview)
- [Database Structure](#database-structure)
  - [Tables](#tables)
  - [Relationships](#relationships)
- [User Roles and Permissions](#user-roles-and-permissions)
- [How to Use](#how-to-use)
- [Future Enhancements](#future-enhancements)

---

## Overview

The `bookstore.sql` script creates a database named `bookstore` and defines its structure. It includes tables for storing information about books, authors, customers, orders, and related entities. The script also creates user roles with specific permissions to manage the database securely.

---

## Database Structure

### Tables

The database consists of the following tables:

1. **book_language**: Stores the languages in which books are available.
2. **publisher**: Stores information about book publishers.
3. **author**: Stores details about authors.
4. **book**: Stores information about books, including their title, publication year, language, and publisher.
5. **book_author**: Associates books with authors (many-to-many relationship).
6. **customer**: Stores customer details.
7. **country**: Stores country information.
8. **address**: Stores customer addresses.
9. **address_status**: Stores the status of addresses (e.g., active, inactive).
10. **customer_address**: Associates customers with their addresses and address statuses.
11. **order_status**: Stores the status of orders (e.g., pending, shipped).
12. **shipping_method**: Stores available shipping methods and their charges.
13. **cust_order**: Stores customer orders, including shipping and billing addresses.
14. **order_line**: Stores details of items in each order.
15. **order_history**: Tracks the history of order status changes.

### Relationships

- **Books and Authors**: Many-to-many relationship managed by the `book_author` table.
- **Customers and Addresses**: Many-to-many relationship managed by the `customer_address` table.
- **Orders**: Linked to customers, addresses, shipping methods, and order statuses.

---

## User Roles and Permissions

The script creates the following user roles with specific permissions:

1. **Admin**:
   - Full access to all tables and operations.
   - Username: `admin`
   - Password: `admin2025`

2. **Order Management Processor**:
   - Can manage orders and view related data.
   - Username: `order_mngt_processor`
   - Password: `@2025`

3. **Customer Manager**:
   - Can manage customer and address data.
   - Username: `customer_manager`
   - Password: `2025`

4. **Customer**:
   - Read-only access to books, authors, publishers, and languages.
   - Username: `customer`
   - Password: `1234`

---

## How to Use

1. **Setup**:
   - Run the `bookstore.sql` script in your MySQL database server to create the database and its schema.

2. **Access**:
   - Use the provided user roles to interact with the database based on their permissions.

3. **Testing**:
   - Insert sample data into the tables to test the schema and relationships.

4. **Security**:
   - Update passwords for the user roles as needed for production environments.

---

## Future Enhancements

- Add triggers to automate certain actions (e.g., updating order history).
- Implement stored procedures for common operations (e.g., placing an order).
- Add indexes to optimize query performance.
- Expand the schema to include additional features like book reviews or inventory management.

---

## License

This project is open-source and available for use under the [MIT License](https://opensource.org/licenses/MIT).

---

## Contact

For questions or suggestions, feel free to reach out to the project maintainer.
