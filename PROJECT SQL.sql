CREATE DATABASE BOOK_STORE;

-- BOOK TABLE
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
    );
    
    -- CUSTOMERS TABLE
    CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

-- ORDERS TABLE
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- data is imprted from excel CSV files

select * from orders;
select * from books;
select * from customers;



-- Basic queries for SQL

-- 1) Retrieve all books in the "Fiction" genre:
select * from books
where genre = "fiction";

-- 2) Find books published after the year 1950:
select * from books 
where Published_Year > 1950;

-- 3) List all customers from the Canada:
select * from customers
where country = "canada";

-- 4) Show orders placed in November 2023:
select * from orders
where month(order_date) = 11;

-- 5) Retrieve the total stock of books available:
select sum(stock) as total_stock_books 
from books;

-- 6) Find the details of the most expensive book:
select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders 
where quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders 
where total_amount > 20;

-- 9) List all genres available in the Books table:
select genre from books group by genre;

-- 10) Find the book with the lowest stock:
select * from books 
order by stock asc
limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as renenue_generated
from orders;



-- Advance Queries for SQL

-- 1) Retrieve the total number of books sold for each genre:
select b.genre, sum(o.quantity)
from books b
join orders o on b.Book_ID = o.Book_ID
group by genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) as avg_price
from books 
where genre = "fantasy";

-- 3) List customers who have placed at least 2 orders:
select Customer_ID, count(Order_ID) as order_count
from orders
group by Customer_ID
having count(Order_ID) >= 2;

-- 4) Find the most frequently ordered book:
select o.book_id, b.title, count(o.order_id) as total_book_ordered
from orders o
join books b on b.book_id = o.Book_ID
group by b.Title, o.Book_ID
order by total_book_ordered desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books 
where genre = "fantasy" 
order by price desc limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select b.author, sum(o.quantity) total_books_sold 
from orders o 
join books b on b.Book_ID = o.Order_ID
group by b.author
order by total_books_sold desc;

-- 7) List the cities where customers who spent over $30 are located:
select c.city, o.total_amount
from orders o
join customers c on c.Customer_ID = o.Customer_ID
where o.Total_Amount > 30;

-- 8) Find the customer who spent the most on orders:
select c.name, c.customer_id, sum(o.total_amount) as total_spend
from orders o
join customers c on c.Customer_ID = o.Customer_ID
group by c.name, c.customer_id
order by total_spend desc limit 1;

-- 9) Find books that have never been ordered
SELECT b.Book_ID, b.Title, b.Author, b.Genre
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL;

-- 10) Find books whose stock is below the average stock.
SELECT Title, Stock
FROM Books
WHERE Stock < (SELECT AVG(Stock) FROM Books);

-- 11) Display books with their price category.
SELECT Title, Price,
CASE
    WHEN Price >= 30 THEN 'Expensive'
    WHEN Price >= 15 THEN 'Moderate'
    ELSE 'Affordable'
END AS Price_Category
FROM Books;














