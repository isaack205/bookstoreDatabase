-- Create the database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS bookstore;

-- Switch to the `bookstore` database
USE bookstore;

-- Create a table to store book languages
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each language
    language_name VARCHAR(100) -- Name of the language
);

-- Create a table to store publishers
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each publisher
    publisher_name VARCHAR(100) -- Name of the publisher
) AUTO_INCREMENT = 101; -- Start auto-increment from 101

-- Create a table to store authors
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each author
    first_name VARCHAR(100) NOT NULL, -- Author's first name
    last_name VARCHAR(100) -- Author's last name
);

-- Create a table to store books
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each book
    book_title VARCHAR(100) NOT NULL, -- Title of the book
    publication_year SMALLINT, -- Year the book was published
    language_id INT NOT NULL, -- Foreign key referencing `book_language`
    publisher_id INT NOT NULL, -- Foreign key referencing `publisher`
    CONSTRAINT fk_book_language FOREIGN KEY (language_id) REFERENCES book_language(language_id), -- Enforce language_id exists in `book_language`
    CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id) -- Enforce publisher_id exists in `publisher`
);

-- Create a table to associate books with authors (many-to-many relationship)
CREATE TABLE book_author (
    book_id INT NOT NULL, -- Foreign key referencing `book`
    author_id INT NOT NULL, -- Foreign key referencing `author`
    CONSTRAINT fk_book_author_book FOREIGN KEY (book_id) REFERENCES book(book_id), -- Enforce book_id exists in `book`
    CONSTRAINT fk_book_author_author FOREIGN KEY (author_id) REFERENCES author(author_id) -- Enforce author_id exists in `author`
);

-- Create a table to store customers
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each customer
    first_name VARCHAR(100) NOT NULL, -- Customer's first name
    last_name VARCHAR(100), -- Customer's last name
    email VARCHAR(100) UNIQUE NOT NULL -- Customer's email (must be unique)
);

-- Create a table to store countries
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each country
    country_name VARCHAR(50) -- Name of the country
);

-- Create a table to store addresses
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each address
    street_address VARCHAR(100) NOT NULL, -- Street address
    city VARCHAR(50), -- City name
    postal_code VARCHAR(50), -- Postal code
    country_id INT NOT NULL, -- Foreign key referencing `country`
    CONSTRAINT fk_address_country FOREIGN KEY (country_id) REFERENCES country(country_id) -- Enforce country_id exists in `country`
);

-- Create a table to store address statuses
CREATE TABLE address_status (
    address_status_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each address status
    status_name VARCHAR(50) -- Name of the status
);

-- Create a table to associate customers with addresses
CREATE TABLE customer_address (
    customer_id INT NOT NULL, -- Foreign key referencing `customer`
    address_id INT NOT NULL, -- Foreign key referencing `address`
    address_status_id INT NOT NULL, -- Foreign key referencing `address_status`
    CONSTRAINT fk_customer_address_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id), -- Enforce customer_id exists in `customer`
    CONSTRAINT fk_customer_address_address FOREIGN KEY (address_id) REFERENCES address(address_id), -- Enforce address_id exists in `address`
    CONSTRAINT fk_customer_address_status FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id) -- Enforce address_status_id exists in `address_status`
);

-- Create a table to store order statuses
CREATE TABLE order_status (
    order_status_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each order status
    status_name VARCHAR(50) NOT NULL -- Name of the status
);

-- Create a table to store shipping methods
CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each shipping method
    method_name VARCHAR(50) NOT NULL, -- Name of the shipping method
    charges DECIMAL(10,2) -- Shipping charges
) AUTO_INCREMENT = 1100; -- Start auto-increment from 1100

-- Create a table to store customer orders
CREATE TABLE cust_order (
    cust_order_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each order
    order_date TIMESTAMP NOT NULL, -- Date and time of the order
    customer_id INT NOT NULL, -- Foreign key referencing `customer`
    shipping_address_id INT NOT NULL, -- Foreign key referencing `address` (shipping address)
    billing_address_id INT NOT NULL, -- Foreign key referencing `address` (billing address)
    shipping_method_id INT NOT NULL, -- Foreign key referencing `shipping_method`
    order_status_id INT NOT NULL, -- Foreign key referencing `order_status`
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id), -- Enforce customer_id exists in `customer`
    CONSTRAINT fk_order_shipping_address FOREIGN KEY (shipping_address_id) REFERENCES address(address_id), -- Enforce shipping_address_id exists in `address`
    CONSTRAINT fk_order_billing_address FOREIGN KEY (billing_address_id) REFERENCES address(address_id), -- Enforce billing_address_id exists in `address`
    CONSTRAINT fk_order_shipping_method FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id), -- Enforce shipping_method_id exists in `shipping_method`
    CONSTRAINT fk_order_status FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id) -- Enforce order_status_id exists in `order_status`
);

-- Create a table to store order line items
CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each order line
    cust_order_id INT NOT NULL, -- Foreign key referencing `cust_order`
    book_id INT NOT NULL, -- Foreign key referencing `book`
    CONSTRAINT fk_order_line_order FOREIGN KEY (cust_order_id) REFERENCES cust_order(cust_order_id), -- Enforce cust_order_id exists in `cust_order`
    CONSTRAINT fk_order_line_book FOREIGN KEY (book_id) REFERENCES book(book_id), -- Enforce book_id exists in `book`
    quantity INT, -- Quantity of the book ordered
    price_at_order DECIMAL(10, 2) -- Price of the book at the time of order
);

-- Create a table to store order history
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- Unique identifier for each history record
    cust_order_id INT NOT NULL, -- Foreign key referencing `cust_order`
    order_status_id INT NOT NULL, -- Foreign key referencing `order_status`
    CONSTRAINT fk_history_order FOREIGN KEY (cust_order_id) REFERENCES cust_order(cust_order_id), -- Enforce cust_order_id exists in `cust_order`
    CONSTRAINT fk_history_status FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id), -- Enforce order_status_id exists in `order_status`
    change_timestamp TIMESTAMP NOT NULL -- Timestamp of the status change
);

-- Create users with specific roles and passwords
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin2025'; -- Admin user
CREATE USER 'order_mngt_processor'@'localhost' IDENTIFIED BY '@2025'; -- Order management processor
CREATE USER 'customer_manager'@'localhost' IDENTIFIED BY '2025'; -- Customer manager
CREATE USER 'customer'@'localhost' IDENTIFIED BY '1234'; -- Customer user

-- Grant permissions to the `customer` user
GRANT SELECT ON bookstore.book TO 'customer'@'localhost';
GRANT SELECT ON bookstore.book_author TO 'customer'@'localhost';
GRANT SELECT ON bookstore.author TO 'customer'@'localhost';
GRANT SELECT ON bookstore.book_language TO 'customer'@'localhost';
GRANT SELECT ON bookstore.publisher TO 'customer'@'localhost';

-- Grant permissions to the `customer_manager` user
GRANT SELECT,INSERT, UPDATE ON bookstore.customer TO 'customer_manager'@'localhost';
GRANT SELECT,INSERT, UPDATE ON bookstore.customer_address TO 'customer_manager'@'localhost';
GRANT SELECT,INSERT, UPDATE ON bookstore.address TO 'customer_manager'@'localhost';
GRANT SELECT,INSERT, UPDATE ON bookstore.address_status TO 'customer_manager'@'localhost';

-- Grant permissions to the `order_mngt_processor` user
GRANT SELECT,INSERT, UPDATE ON bookstore.order_line TO 'order_mngt_processor'@'localhost';
GRANT SELECT,INSERT, UPDATE ON bookstore.cust_order TO 'order_mngt_processor'@'localhost';
GRANT SELECT ON bookstore.order_history TO 'order_mngt_processor'@'localhost';
GRANT SELECT ON bookstore.order_status TO 'order_mngt_processor'@'localhost';
GRANT SELECT ON bookstore.customer TO 'order_mngt_processor'@'localhost';
GRANT SELECT ON bookstore.address TO 'order_mngt_processor'@'localhost';
GRANT SELECT ON bookstore.shipping_method TO 'order_mngt_processor'@'localhost';

-- Grant all privileges to the `admin` user
GRANT ALL PRIVILEGES ON bookstore.* TO 'admin'@'localhost';




