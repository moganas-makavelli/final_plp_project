-- This SQL script creates a relational database for a Library Management System.
-- The schema includes tables for books, authors, library members, and borrowing records,
-- with appropriate relationships and constraints.

-- Database Creation

CREATE DATABASE IF NOT EXISTS library_management;
USE library_management;

-- Table Authors
-- This table stores information about the authors.

CREATE TABLE Authors (
author_id INT NOT NULL AUTO_INCREMENT,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
birth_year INT,
PRIMARY KEY (author_id)
);

-- Table Books
-- This table stores information about the books in the library.

CREATE TABLE Books (
book_id INT NOT NULL AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
publication_year INT,
publisher VARCHAR(100),
available_copies INT NOT NULL DEFAULT 1,
PRIMARY KEY (book_id)
);

-- Table Members
-- This table stores information about the library members.

CREATE TABLE Members (
member_id INT NOT NULL AUTO_INCREMENT,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL,
phone_number VARCHAR(20),
join_date DATE NOT NULL,
PRIMARY KEY (member_id)
);

-- Junction Table BookAuthors
-- This table represents the Many-to-Many relationship between Books and Authors.

CREATE TABLE BookAuthors (
book_id INT NOT NULL,
author_id INT NOT NULL,
PRIMARY KEY (book_id, author_id),
FOREIGN KEY (book_id) REFERENCES Books (book_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (author_id) REFERENCES Authors (author_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table Borrowings
-- This table stores the borrowing records for books. It links Books and Members.
-- This is a One-to-Many relationship from Members to Borrowings and from Books to Borrowings.

CREATE TABLE Borrowings (
borrowing_id INT NOT NULL AUTO_INCREMENT,
book_id INT NOT NULL,
member_id INT NOT NULL,
borrow_date DATE NOT NULL,
due_date DATE NOT NULL,
return_date DATE,
PRIMARY KEY (borrowing_id),
FOREIGN KEY (book_id) REFERENCES Books (book_id) ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (member_id) REFERENCES Members (member_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Sample Data Insertion

-- Insert some authors
INSERT INTO Authors (first_name, last_name, birth_year) VALUES
('Jane', 'Austen', 1775),
('George', 'Orwell', 1903),
('Stephen', 'King', 1947),
('J.R.R.', 'Tolkien', 1892),
('J.K.', 'Rowling', 1965);

-- Insert some books
INSERT INTO Books (title, publication_year, publisher, available_copies) VALUES
('Pride and Prejudice', 1813, 'T. Egerton', 2),
('1984', 1949, 'Secker & Warburg', 1),
('The Shining', 1977, 'Doubleday', 1),
('The Lord of the Rings', 1954, 'George Allen & Unwin', 3),
('Harry Potter and the Sorcerer''s Stone', 1997, 'Bloomsbury', 2);

-- Link books to authors (Many-to-Many relationship)
INSERT INTO BookAuthors (book_id, author_id) VALUES
(1, 1), -- Pride and Prejudice by Jane Austen
(2, 2), -- 1984 by George Orwell
(3, 3), -- The Shining by Stephen King
(4, 4), -- The Lord of the Rings by J.R.R. Tolkien
(5, 5); -- Harry Potter by J.K. Rowling

-- Insert some members
INSERT INTO Members (first_name, last_name, email, join_date) VALUES
('Alice', 'Johnson', 'alice.j@email.com', '2023-01-15'),
('Bob', 'Williams', 'bob.w@email.com', '2023-02-20'),
('Charlie', 'Brown', 'charlie.b@email.com', '2023-03-01');

-- Insert some borrowing records
INSERT INTO Borrowings (book_id, member_id, borrow_date, due_date) VALUES
(1, 1, '2023-04-01', '2023-04-22'), -- Alice borrows Pride and Prejudice
(2, 2, '2023-04-05', '2023-04-26'), -- Bob borrows 1984
(3, 1, '2023-04-10', '2023-05-01'); -- Alice borrows The Shining