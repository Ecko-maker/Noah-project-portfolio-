-- =========================================================
-- Author: Noah Asgodom
-- Date: 16/12/2025
-- Project: Library Management System
-- Course: CIS 203 – Relational Database Capstone
-- Description:
--   This script creates, populates, and analyzes a relational
--   database for a Library Management System. It supports
--   operational tracking and financial analytics.
-- =========================================================


-- =========================================================
-- DATABASE CREATION & SELECTION
-- =========================================================

-- Create a new database for the Library Management System
CREATE DATABASE LibraryDB;

-- Select the database to use
USE LibraryDB;

-- Display all databases (verification step)
SHOW DATABASES;

-- Ensure correct database is selected
USE LibraryDB;


-- =========================================================
-- TABLE CREATION (DDL)
-- =========================================================

-- 1. AUTHORS TABLE
-- Stores author information for books
CREATE TABLE Authors (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(100),
    Status VARCHAR(50),
    Nationality VARCHAR(50)
);

-- 2. GENRES TABLE
-- Stores book genre classifications
CREATE TABLE Genres (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    CategoryCode VARCHAR(10)
);

-- 3. STAFF TABLE
-- Stores staff members responsible for loan processing
CREATE TABLE Staff (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE
);

-- 4. MEMBERS TABLE
-- Stores library member demographic and membership details
CREATE TABLE Members (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    MembershipDate DATE,
    MembershipLevel VARCHAR(50),
    DateOfBirth DATE
);

-- Add City column (demographic analysis support)
ALTER TABLE Members
ADD COLUMN City VARCHAR(50);

-- 5. BOOKS TABLE
-- Stores book inventory details
CREATE TABLE Books (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Isbn VARCHAR(20),
    ShelfLocation VARCHAR(50),
    Language VARCHAR(50),
    GenreId INT,
    AuthorId INT,
    FOREIGN KEY (GenreId) REFERENCES Genres(Id),
    FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
);

-- Add Price column for financial analysis
ALTER TABLE Books
ADD COLUMN Price DECIMAL(10, 2);

-- 6. LOANS TABLE
-- Central transactional table recording book loans
CREATE TABLE Loans (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    BookId INT NOT NULL,
    MemberId INT NOT NULL,
    StaffId INT NOT NULL,
    LoanDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookId) REFERENCES Books(Id),
    FOREIGN KEY (MemberId) REFERENCES Members(Id),
    FOREIGN KEY (StaffId) REFERENCES Staff(Id)
);

-- 7. FINES TABLE
-- Stores fines associated with overdue loans
CREATE TABLE Fines (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    LoanId INT,
    Amount DECIMAL(5, 2) NOT NULL,
    PaidStatus BOOLEAN DEFAULT FALSE,
    IssueDate DATE,
    PaidDate DATETIME,
    FOREIGN KEY (LoanId) REFERENCES Loans(Id)
);

-- Verify all tables were created successfully
SHOW TABLES;


-- =========================================================
-- DATA POPULATION (DML)
-- =========================================================

-- Temporarily disable foreign key checks for bulk inserts
SET FOREIGN_KEY_CHECKS = 0;

-- Insert sample author data
INSERT INTO Authors (AuthorName, Status, Nationality) VALUES
('J.R.R. Tolkien', 'Deceased', 'UK'),
('Isaac Asimov', 'Deceased', 'USA'),
('Jane Austen', 'Deceased', 'UK'),
('Neil Gaiman', 'Active', 'UK'),
('Toni Morrison', 'Deceased', 'USA'),
('Stephen King', 'Active', 'USA'),
('Yuval Noah Harari', 'Active', 'Israel'),
('Gabriel Garcia Marquez', 'Deceased', 'Colombia'),
('Virginia Woolf', 'Deceased', 'UK'),
('Homer', 'Deceased', 'Greek');

-- Insert genre data
INSERT INTO Genres (Name, Description, CategoryCode) VALUES
('Fantasy', 'Imaginary worlds and magic.', 'FNT'),
('Science Fiction', 'Future technology and space.', 'SCI'),
('Classics', 'Timeless literary works.', 'CLS'),
('Thriller', 'Suspense and high tension.', 'THR'),
('Biography', 'Life stories of notable individuals.', 'BIO'),
('History', 'Non-fiction events and periods.', 'HIS');

-- Insert staff data
INSERT INTO Staff (Name, Role, Department, HireDate) VALUES
('Alice Manager', 'Director', 'Administration', '2021-06-01'),
('Bob Worker', 'Librarian', 'Circulation', '2023-05-15'),
('Cathy Clerk', 'Librarian', 'Reference', '2024-01-10'),
('David Intern', 'Assistant', 'Circulation', '2024-06-01');

-- Insert member data (25 records)
INSERT INTO Members (Name, Email, Phone, City, MembershipDate, MembershipLevel, DateOfBirth) VALUES
('Alex Johnson', 'alex.j@library.org', '312-1001', 'Chicago', '2022-01-10', 'Premium', '1985-05-20'),
('Ben Smith', 'ben.s@library.org', '312-1002', 'Chicago', '2022-03-15', 'Standard', '1992-11-03'),
('Chloe Davis', 'chloe.d@library.org', '312-1003', 'Chicago', '2022-05-01', 'Standard', '1975-01-01'),
('David Miller', 'david.m@library.org', '312-1004', 'Chicago', '2022-07-20', 'Premium', '1998-08-15'),
('Eva Green', 'eva.g@library.org', '630-1005', 'Naperville', '2023-01-05', 'Premium', '2001-02-28'),
('Frank White', 'frank.w@library.org', '630-1006', 'Naperville', '2023-02-15', 'Standard', '1988-12-12'),
('Grace Hall', 'grace.h@library.org', '630-1007', 'Naperville', '2023-03-25', 'Standard', '1965-04-17'),
('Henry Lee', 'henry.l@library.org', '630-1008', 'Naperville', '2023-04-10', 'Premium', '1995-06-21'),
('Ivy Chen', 'ivy.c@library.org', '630-1009', 'Naperville', '2023-05-30', 'Standard', '1990-10-05'),
('Jack Ryan', 'jack.r@library.org', '312-1010', 'Chicago', '2024-01-01', 'Standard', '1979-07-07'),
('Kate Perry', 'kate.p@library.org', '312-1011', 'Chicago', '2024-02-14', 'Premium', '1982-01-25'),
('Liam Foster', 'liam.f@library.org', '312-1012', 'Chicago', '2024-03-22', 'Standard', '1996-03-03'),
('Mia Wilson', 'mia.w@library.org', '312-1013', 'Chicago', '2024-04-05', 'Premium', '2000-11-18'),
('Noah King', 'noah.k@library.org', '312-1014', 'Chicago', '2024-05-18', 'Standard', '1993-09-09'),
('Olivia Scott', 'olivia.s@library.org', '312-1015', 'Chicago', '2024-06-25', 'Premium', '1970-02-02'),
('Peter Adams', 'peter.a@library.org', '847-1016', 'Evanston', '2022-08-01', 'Standard', '1987-05-05'),
('Quinn Bell', 'quinn.b@library.org', '847-1017', 'Evanston', '2023-06-10', 'Standard', '1999-04-24'),
('Rachel Cook', 'rachel.c@library.org', '847-1018', 'Evanston', '2024-01-20', 'Premium', '1980-12-31'),
('Sam Torres', 'sam.t@library.org', '312-1019', 'Chicago', '2022-11-11', 'Premium', '1991-06-19'),
('Tina Lopez', 'tina.l@library.org', '312-1020', 'Chicago', '2023-09-01', 'Standard', '1974-03-16'),
('Victor West', 'victor.w@library.org', '312-1021', 'Chicago', '2024-03-10', 'Standard', '2003-09-29'),
('Wendy Hall', 'wendy.h@library.org', '630-1022', 'Naperville', '2023-08-05', 'Premium', '1983-04-11'),
('Xavier Ross', 'xavier.r@library.org', '847-1023', 'Evanston', '2022-10-25', 'Standard', '1978-10-08'),
('Yara Cruz', 'yara.c@library.org', '312-1024', 'Chicago', '2024-04-15', 'Premium', '1997-07-03'),
('Zane Young', 'zane.y@library.org', '312-1025', 'Chicago', '2023-11-20', 'Standard', '1989-01-20');

-- Re-enable foreign key enforcement
SET FOREIGN_KEY_CHECKS = 1;


-- =========================================================
-- ANALYTICAL SQL QUERIES (DOCUMENTED)
-- =========================================================

-- 1. Check for duplicate ISBN values (data quality check)
SELECT Isbn, COUNT(*) AS DuplicateCount
FROM Books
GROUP BY Isbn
HAVING COUNT(*) > 1;

-- 2. Remove duplicate book records (keeping the lowest ID)
SET SQL_SAFE_UPDATES = 0;
DELETE b1
FROM Books b1
JOIN Books b2
  ON b1.Isbn = b2.Isbn AND b1.Id > b2.Id;
SET SQL_SAFE_UPDATES = 1;

-- 3. LEFT JOIN: Show all members and their borrowing activity
SELECT
    M.Name AS MemberName,
    M.MembershipDate,
    L.LoanDate,
    L.ReturnDate
FROM Members M
LEFT JOIN Loans L ON M.Id = L.MemberId;

-- 4. RIGHT JOIN: Ensure all loan records are matched to members
SELECT
    M.Name AS MemberName,
    L.Id AS LoanID,
    L.BookId
FROM Members M
RIGHT JOIN Loans L ON M.Id = L.MemberId
ORDER BY LoanID;

-- 5. FULL OUTER JOIN (Emulated): Audit members and loans
SELECT M.Name AS MemberName, L.Id AS LoanID
FROM Members M
LEFT JOIN Loans L ON M.Id = L.MemberId
UNION
SELECT M.Name AS MemberName, L.Id AS LoanID
FROM Members M
RIGHT JOIN Loans L ON M.Id = L.MemberId
WHERE M.Id IS NULL;

-- 6. Aggregate Function: Calculate average fine amount
SELECT AVG(f.Amount) AS AverageFine
FROM Fines f;

-- 7. Correlated Subquery: Identify members with above-average borrowing
SELECT m.Id AS MemberID, m.Name
FROM Members m
WHERE
    (SELECT COUNT(l.Id) FROM Loans l WHERE l.MemberId = m.Id)
    >
    (
        SELECT AVG(LoanCount)
        FROM (
            SELECT COUNT(Id) AS LoanCount
            FROM Loans
            GROUP BY MemberId
        ) AS LoanStats
    );

-- 8. Subquery: Identify the most frequently borrowed book
SELECT b.Id AS BookID, b.Title
FROM Books b
WHERE b.Id = (
    SELECT l.BookId
    FROM Loans l
    GROUP BY l.BookId
    ORDER BY COUNT(l.Id) DESC
    LIMIT 1
);

-- 9. Multi-table Star Schema Join
-- Purpose: Create the analytical fact table for Power BI
SELECT
    L.Id AS LoanKey,
    L.LoanDate,
    L.ReturnDate,
    L.DueDate,
    M.Id AS MemberKey,
    M.Name AS MemberName,
    M.City,
    M.MembershipLevel,
    B.Id AS BookKey,
    B.Title AS BookTitle,
    B.Price,
    A.AuthorName,
    G.Name AS GenreName,
    S.Name AS StaffName,
    F.Amount AS FineAmount,
    F.PaidStatus,
    DATEDIFF(L.ReturnDate, L.DueDate) AS DaysOverdue
FROM Loans L
LEFT JOIN Members M ON L.MemberId = M.Id
LEFT JOIN Books B ON L.BookId = B.Id
LEFT JOIN Authors A ON B.AuthorId = A.Id
LEFT JOIN Genres G ON B.GenreId = G.Id
LEFT JOIN Staff S ON L.StaffId = S.Id
LEFT JOIN Fines F ON L.Id = F.LoanId
ORDER BY L.LoanDate DESC;
