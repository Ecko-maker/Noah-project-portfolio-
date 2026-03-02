-- Noah Asgodom 
-- 5/12/2025
-- Library Managment System

-- create database:
create database LibraryDB;
-- use database we create:
use LibraryDB;

-- Create Authors table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(150) NOT NULL,
    BirthYear INT,
    Biography TEXT
);
-- Add Nationalty column to Authors
ALTER TABLE Authors
ADD COLUMN Nationaliy VARCHAR(50);

-- Insert data sample for Authors
INSERT INTO Authors (AuthorID, AuthorName, Nationality, BirthYear, Biography) VALUES
(1, 'Jane Austen', 'British', 1775, 'Renowned for novels exploring themes of love, class, and morality.'),
(2, 'George Orwell', 'British', 1903, 'Known for dystopian works like 1984 and Animal Farm.'),
(3, 'Mark Twain', 'American', 1835, 'Famous for The Adventures of Tom Sawyer and Huckleberry Finn.'),
(4, 'Gabriel García Márquez', 'Colombian', 1927, 'Pioneer of magical realism, author of One Hundred Years of Solitude.'),
(5, 'Haruki Murakami', 'Japanese', 1949, 'Blends surrealism and introspection in novels like Kafka on the Shore.'),
(6, 'Chinua Achebe', 'Nigerian', 1930, 'Author of Things Fall Apart, a cornerstone of African literature.'),
(7, 'Toni Morrison', 'American', 1931, 'Pulitzer and Nobel Prize-winning author of Beloved and The Bluest Eye.'),
(8, 'Leo Tolstoy', 'Russian', 1828, 'Epic novelist known for War and Peace and Anna Karenina.'),
(9, 'Isabel Allende', 'Chilean', 1942, 'Writes historical fiction with strong female protagonists.'),
(10, 'J.K. Rowling', 'British', 1965, 'Creator of the Harry Potter series, blending fantasy and coming-of-age themes.'),
(11, 'Fyodor Dostoevsky', 'Russian', 1821, 'Explores psychology and morality in Crime and Punishment and The Brothers Karamazov.'),
(12, 'Zadie Smith', 'British', 1975, 'Contemporary author known for White Teeth and On Beauty.'),
(13, 'Khaled Hosseini', 'Afghan-American', 1965, 'Author of The Kite Runner and A Thousand Splendid Suns.'),
(14, 'Margaret Atwood', 'Canadian', 1939, 'Known for speculative fiction like The Handmaid’s Tale.'),
(15, 'Salman Rushdie', 'British-Indian', 1947, 'Blends history and myth in Midnight’s Children and The Satanic Verses.'),
(16, 'Ngũgĩ wa Thiong\'o', 'Kenyan', 1938, 'Writes in Gikuyu and English, focusing on colonialism and cultural identity.'),
(17, 'Octavia Butler', 'American', 1947, 'Pioneering African-American science fiction writer.'),
(18, 'James Baldwin', 'American', 1924, 'Explores race, sexuality, and identity in works like Giovanni’s Room.'),
(19, 'Arundhati Roy', 'Indian', 1961, 'Author of The God of Small Things, blending politics and personal narrative.'),
(20, 'Eleanor Catton', 'New Zealander', 1985, 'Youngest winner of the Booker Prize for The Luminaries.');

-- Create Genre table
CREATE TABLE Genre (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(100) NOT NULL,
    Descriptions TEXT,
    Categorycode int,
    CreatAt Date,
    Updateat Date
);

-- Insert Sample Data for Genre
INSERT INTO Genre (GenreID, GenreName, Descriptions, Categorycode, CreatAt, Updateat) VALUES
(1, 'Fiction', 'Narrative literature created from imagination.', 101, CURDATE(), CURDATE()),
(2, 'Non-Fiction', 'Literature based on facts, real events, and people.', 102, CURDATE(), CURDATE()),
(3, 'Mystery', 'Fiction dealing with the solution of a crime or unraveling secrets.', 103, CURDATE(), CURDATE()),
(4, 'Science Fiction', 'Fiction based on futuristic science and technology.', 104, CURDATE(), CURDATE()),
(5, 'Fantasy', 'Fiction with magical or supernatural elements.', 105, CURDATE(), CURDATE()),
(6, 'Historical', 'Fiction set in a past time period.', 106, CURDATE(), CURDATE()),
(7, 'Romance', 'Fiction centered around love and relationships.', 107, CURDATE(), CURDATE()),
(8, 'Biography', 'Detailed account of a person’s life.', 108, CURDATE(), CURDATE()),
(9, 'Poetry', 'Literary work in verse form.', 109, CURDATE(), CURDATE()),
(10, 'Horror', 'Fiction intended to scare or disturb.', 110, CURDATE(), CURDATE());

-- Create Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    PublishedYear INT,
    AuthorID INT,
    GenreID INT,
    Availability BIT DEFAULT 1,
    ShelfLocation varchar(50),
    Languge varchar(50),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID)
);
-- Insert the Sample Data for Books 
INSERT INTO Books (BookID, Title, ISBN, PublishedYear, AuthorID, GenreID, Availability, ShelfLocation, Language) VALUES
(1, 'Echoes of Eternity', '978-0000000001', 2001, 5, 4, 1, 'B2', 'English'),
(2, 'Whispers in the Wind', '978-0000000002', 1995, 12, 7, 0, 'C3', 'Spanish'),
(3, 'The Quantum Garden', '978-0000000003', 2018, 3, 2, 1, 'A1', 'English'),
(4, 'Shadows of the Empire', '978-0000000004', 1987, 8, 5, 1, 'D4', 'Russian'),
(5, 'The Forgotten Manuscript', '978-0000000005', 2020, 15, 6, 0, 'E1', 'French'),
(6, 'The Last Horizon', '978-0000000006', 1999, 2, 1, 1, 'A2', 'English'),
(7, 'Fragments of Light', '978-0000000007', 2005, 14, 6, 0, 'B1', 'French'),
(8, 'Digital Dreams', '978-0000000008', 2010, 10, 4, 1, 'C2', 'English'),
(9, 'The Silent Archive', '978-0000000009', 1982, 3, 2, 1, 'D3', 'Spanish'),
(10, 'Beyond the Veil', '978-0000000010', 2021, 17, 5, 0, 'E4', 'English'),
(11, 'Voices of Tomorrow', '978-0000000011', 2015, 6, 3, 1, 'A3', 'English'),
(12, 'The Crystal Path', '978-0000000012', 1992, 9, 5, 1, 'B4', 'Japanese'),
(13, 'Chronicles of the Deep', '978-0000000013', 2008, 11, 1, 0, 'C1', 'English'),
(14, 'The Iron Kingdom', '978-0000000014', 1997, 4, 6, 1, 'D2', 'Russian'),
(15, 'Dreamcatcher Tales', '978-0000000015', 2019, 7, 7, 1, 'E3', 'English'),
(16, 'The Hidden Oracle', '978-0000000016', 2003, 13, 4, 0, 'A4', 'English'),
(17, 'Labyrinth of Stars', '978-0000000017', 1990, 1, 5, 1, 'B5', 'French'),
(18, 'The Painted Sky', '978-0000000018', 2012, 16, 2, 1, 'C4', 'English'),
(19, 'Secrets of the Ancients', '978-0000000019', 1985, 18, 6, 0, 'D1', 'Spanish'),
(20, 'The Eternal Flame', '978-0000000020', 2022, 20, 1, 1, 'E5', 'English'),
(21, 'The Glass Tower', '978-0000000021', 2007, 2, 4, 1, 'A5', 'English'),
(22, 'Moonlit Shadows', '978-0000000022', 1998, 5, 7, 0, 'B3', 'French'),
(23, 'The Digital Prophet', '978-0000000023', 2016, 8, 2, 1, 'C5', 'English'),
(24, 'The Scarlet Horizon', '978-0000000024', 1989, 12, 6, 1, 'D5', 'Spanish'),
(25, 'The Emerald Compass', '978-0000000025', 2020, 14, 5, 0, 'E2', 'English'),
(26, 'Voices in the Mist', '978-0000000026', 2002, 3, 1, 1, 'A1', 'English'),
(27, 'The Silver Crown', '978-0000000027', 1994, 6, 3, 1, 'B2', 'Japanese'),
(28, 'The Burning Tide', '978-0000000028', 2011, 9, 4, 0, 'C3', 'English'),
(29, 'The Hidden Fortress', '978-0000000029', 1983, 11, 6, 1, 'D4', 'Russian'),
(30, 'The Golden Thread', '978-0000000030', 2018, 15, 7, 1, 'E1', 'English'),
(31, 'The Sapphire Key', '978-0000000031', 1996, 17, 5, 0, 'A2', 'English'),
(32, 'The Crimson Blade', '978-0000000032', 2009, 19, 2, 1, 'B4', 'French'),
(33, 'The Obsidian Mirror', '978-0000000033', 1981, 20, 6, 1, 'C2', 'English'),
(34, 'The Ivory Tower', '978-0000000034', 2013, 1, 1, 0, 'D3', 'Spanish'),
(35, 'The Jade Phoenix', '978-0000000035', 1991, 4, 4, 1, 'E4', 'English'),
(36, 'The Amber Throne', '978-0000000036', 2006, 7, 5, 1, 'A3', 'English'),
(37, 'The Onyx Gate', '978-0000000037', 1993, 10, 2, 0, 'B1', 'Russian'),
(38, 'The Ruby Chalice', '978-0000000038', 2017, 13, 6, 1, 'C4', 'English'),
(39, 'The Pearl Dagger', '978-0000000039', 1984, 16, 7, 1, 'D2', 'French'),
(40, 'The Diamond Crown', '978-0000000040', 2021, 18, 1, 0, 'E3', 'English'),
(41, 'The Emerald Throne', '978-0000000041', 2000, 2, 3, 1, 'A4', 'English'),
(42, 'The Sapphire Sword', '978-0000000042', 1997, 5, 4, 1, 'B5', 'Spanish'),
(43, 'The Golden Chalice', '978-0000000043', 2014, 8, 6, 0, 'C1', 'English'),
(44, 'The Silver Dagger', '978-0000000044', 1986, 12, 7, 1, 'D5', 'French'),
(45, 'The Crimson Crown', '978-0000000045', 2019, 14, 5, 1, 'E2', 'English'),
(46, 'The Obsidian Throne', '978-0000000046', 2004, 3, 2, 0, 'A5', 'English'),
(47, 'The Ivory Chalice', '978-0000000047', 1992, 6, 6, 1, 'B3', 'Japanese'),
(48, 'The Jade Dagger', '978-0000000048', 2010, 9, 1, 1, 'C5', 'English'),
(49, 'The Amber Crown', '978-0000000049', 1988, 11, 4, 0, 'D1', 'Russian'),
(50, 'The Onyx Chalice', '978-0000000050', 2022, 15, 7, 1, 'E5', 'English');
-- Create Members table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Email VARCHAR(150) UNIQUE,
    Phone VARCHAR(20),
    MembershipDate DATE,
    MembershipLevel Int,
    Birthdate Date,
    Bio VARCHAR(100)
);

-- DROP Bio column from Members
ALTER TABLE Members
DROP COLUMN Bio;

-- Insert Sample Data for Members
INSERT INTO Members (MemberID, Name, Email, Phone, MembershipDate, MembershipLevel, Birthdate) VALUES
(1, 'Alice Johnson', 'alice.johnson@example.com', '555-0101', '2023-01-15', 1, '1990-05-12'),
(2, 'Brian Smith', 'brian.smith@example.com', '555-0102', '2023-02-10', 2, '1985-08-22'),
(3, 'Catherine Lee', 'catherine.lee@example.com', '555-0103', '2023-03-05', 1, '1992-11-30'),
(4, 'David Kim', 'david.kim@example.com', '555-0104', '2023-04-01', 2, '1988-03-18'),
(5, 'Emma Davis', 'emma.davis@example.com', '555-0105', '2023-05-20', 1, '1995-07-07'),
(6, 'Franklin Moore', 'franklin.moore@example.com', '555-0106', '2023-06-12', 2, '1983-09-25'),
(7, 'Grace Taylor', 'grace.taylor@example.com', '555-0107', '2023-07-08', 1, '1991-12-14'),
(8, 'Henry Wilson', 'henry.wilson@example.com', '555-0108', '2023-08-03', 2, '1986-06-02'),
(9, 'Isabella Martinez', 'isabella.martinez@example.com', '555-0109', '2023-09-17', 1, '1993-10-10'),
(10, 'Jack Thompson', 'jack.thompson@example.com', '555-0110', '2023-10-22', 2, '1989-01-05'),
(11, 'Karen White', 'karen.white@example.com', '555-0111', '2023-11-11', 1, '1994-04-19'),
(12, 'Liam Harris', 'liam.harris@example.com', '555-0112', '2023-12-01', 2, '1987-07-30'),
(13, 'Mia Clark', 'mia.clark@example.com', '555-0113', '2024-01-09', 1, '1996-02-28'),
(14, 'Noah Lewis', 'noah.lewis@example.com', '555-0114', '2024-02-14', 2, '1990-09-09'),
(15, 'Olivia Hall', 'olivia.hall@example.com', '555-0115', '2024-03-21', 1, '1992-06-15'),
(16, 'Paul Allen', 'paul.allen@example.com', '555-0116', '2024-04-18', 2, '1984-12-03'),
(17, 'Quinn Young', 'quinn.young@example.com', '555-0117', '2024-05-25', 1, '1993-03-27'),
(18, 'Rachel King', 'rachel.king@example.com', '555-0118', '2024-06-30', 2, '1986-08-08'),
(19, 'Samuel Wright', 'samuel.wright@example.com', '555-0119', '2024-07-12', 1, '1991-11-11'),
(20, 'Tina Scott', 'tina.scott@example.com', '555-0120', '2024-08-19', 2, '1989-05-01'),
(21, 'Umar Adams', 'umar.adams@example.com', '555-0121', '2024-09-05', 1, '1995-10-20'),
(22, 'Victoria Baker', 'victoria.baker@example.com', '555-0122', '2024-10-10', 2, '1987-01-17'),
(23, 'William Perez', 'william.perez@example.com', '555-0123', '2024-11-03', 1, '1990-06-06'),
(24, 'Xavier Rivera', 'xavier.rivera@example.com', '555-0124', '2024-12-15', 2, '1983-04-04'),
(25, 'Yasmine Brooks', 'yasmine.brooks@example.com', '555-0125', '2025-01-20', 1, '1994-09-29'),
(26, 'Zachary Reed', 'zachary.reed@example.com', '555-0126', '2025-02-28', 2, '1985-12-12'),
(27, 'Amber Price', 'amber.price@example.com', '555-0127', '2025-03-10', 1, '1992-07-07'),
(28, 'Blake Bennett', 'blake.bennett@example.com', '555-0128', '2025-04-04', 2, '1988-10-10'),
(29, 'Chloe Cox', 'chloe.cox@example.com', '555-0129', '2025-05-15', 1, '1993-03-03'),
(30, 'Dylan Gray', 'dylan.gray@example.com', '555-0130', '2025-06-01', 2, '1986-06-06'),
(31, 'Ella Foster', 'ella.foster@example.com', '555-0131', '2025-06-20', 1, '1991-01-01'),
(32, 'Finn Howard', 'finn.howard@example.com', '555-0132', '2025-07-07', 2, '1989-09-09'),
(33, 'Gianna Ward', 'gianna.ward@example.com', '555-0133', '2025-07-25', 1, '1995-05-05'),
(34, 'Hudson Torres', 'hudson.torres@example.com', '555-0134', '2025-08-08', 2, '1984-08-08'),
(35, 'Ivy Peterson', 'ivy.peterson@example.com', '555-0135', '2025-08-30', 1, '1996-06-06'),
(36, 'Jake Ramirez', 'jake.ramirez@example.com', '555-0136', '2025-09-12', 2, '1987-07-07'),
(37, 'Kylie Simmons', 'kylie.simmons@example.com', '555-0137', '2025-09-28', 1, '1992-02-02'),
(38, 'Logan Butler', 'logan.butler@example.com', '555-0138', '2025-10-10', 2, '1985-05-05'),
(39, 'Madeline Barnes', 'madeline.barnes@example.com', '555-0139', '2025-10-25', 1, '1993-09-09'),
(40, 'Nathaniel Ross', 'nathaniel.ross@example.com', '555-0140', '2025-11-05', 2, '1988-03-03'),
(41, 'Olive Jenkins', 'olive.jenkins@example.com', '555-0141', '2025-11-20', 1, '1990-12-12'),
(42, 'Parker Hayes', 'parker.hayes@example.com', '555-0142', '2025-12-01', 2, '1986-01-01'),
(43, 'Quincy Long', 'quincy.long@example.com', '555-0143', '2025-12-15', 1, '1994-04-04'),
(44, 'Riley Freeman', 'riley.freeman@example.com', '555-0144', '2025-12-28', 2, '1983-02-02'),
(45, 'Sophie Neal', 'sophie.neal@example.com', '555-0145', '2025-12-30', 1, '1991-11-11'),
(46, 'Tyler Gibbs', 'tyler.gibbs@example.com', '555-0146', '2026-01-05', 2, '1989-09-09'),
(47, 'Uma Patel', 'uma.patel@example.com', '555-0147', '2026-01-15', 1, '1995-03-03'),
(48, 'Victor Miles', 'victor.miles@example.com', '555-0148', '2026-02-01', 2, '1988-04-04');


-- Create Loans table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    DueDate DATE,
    ReturnDate Time,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
-- Modify ReturnDate column in Loans.
ALTER TABLE Loans
MODIFY ReturnDate Date;

-- Insert sample Data for Loans
INSERT INTO Loans (LoanID, BookID, MemberID, LoanDate, DueDate, ReturnDate) VALUES
(1, 5, 12, '2025-11-01', '2025-11-15', '2025-11-14'),
(2, 3, 8, '2025-11-05', '2025-11-19', NULL),
(3, 7, 20, '2025-11-10', '2025-11-24', '2025-11-23'),
(4, 2, 15, '2025-11-12', '2025-11-26', NULL),
(5, 10, 1, '2025-11-15', '2025-11-29', '2025-11-28'),
(6, 6, 25, '2025-11-18', '2025-12-02', NULL),
(7, 1, 30, '2025-11-20', '2025-12-04', NULL),
(8, 4, 18, '2025-11-22', '2025-12-06', '2025-12-05'),
(9, 8, 5, '2025-11-25', '2025-12-09', NULL),
(10, 9, 22, '2025-11-28', '2025-12-12', NULL),
(11, 11, 33, '2025-12-01', '2025-12-15', NULL),
(12, 12, 7, '2025-12-03', '2025-12-17', NULL),
(13, 13, 40, '2025-12-05', '2025-12-19', NULL),
(14, 14, 10, '2025-12-07', '2025-12-21', NULL),
(15, 15, 45, '2025-12-09', '2025-12-23', NULL),
(16, 16, 3, '2025-12-11', '2025-12-25', NULL),
(17, 17, 27, '2025-12-13', '2025-12-27', NULL),
(18, 18, 50, '2025-12-15', '2025-12-29', NULL),
(19, 19, 6, '2025-12-17', '2025-12-31', NULL),
(20, 20, 13, '2025-12-19', '2026-01-02', NULL);
 
-- Create Fines table
CREATE TABLE Fines (
    FineID INT PRIMARY KEY,
    LoanID INT,
    Amount DECIMAL(10,2),
    PaidStatus BIT DEFAULT 0,
    Issuedate Date,
    PaidDate Date,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

-- Inser the sample data for Fines
INSERT INTO Fines (FineID, LoanID, Amount, PaidStatus, Issuedate, PaidDate) VALUES
(1, 2, 5.00, 0, '2025-11-20', NULL),
(2, 4, 3.50, 1, '2025-11-28', '2025-12-01'),
(3, 6, 7.25, 0, '2025-12-05', NULL),
(4, 8, 2.00, 1, '2025-12-10', '2025-12-12'),
(5, 10, 4.75, 0, '2025-12-15', NULL),
(6, 12, 6.00, 1, '2025-12-20', '2025-12-22'),
(7, 14, 3.25, 0, '2025-12-25', NULL),
(8, 16, 5.50, 1, '2025-12-30', '2026-01-02'),
(9, 18, 2.75, 0, '2026-01-04', NULL),
(10, 20, 8.00, 1, '2026-01-08', '2026-01-10');

-- Create Staff table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Role VARCHAR(100),
    HireDate DATE,
    ContactInformation Varchar(100)
);

-- Inser the Sample Data for Staff 
INSERT INTO Staff (StaffID, Name, Role, HireDate, ContactInformation) VALUES
(1, 'Linda Carter', 'Librarian', '2022-03-15', 'linda.carter@library.com'),
(2, 'James Osei', 'Assistant Librarian', '2023-01-10', 'james.osei@library.com'),
(3, 'Maria Nguyen', 'Archivist', '2021-07-22', 'maria.nguyen@library.com'),
(4, 'Robert King', 'IT Support', '2022-11-05', 'robert.king@library.com'),
(5, 'Aisha Patel', 'Membership Coordinator', '2023-06-01', 'aisha.patel@library.com'),
(6, 'Daniel Brooks', 'Loan Desk Clerk', '2024-02-18', 'daniel.brooks@library.com'),
(7, 'Sophia Zhang', 'Cataloging Specialist', '2021-09-30', 'sophia.zhang@library.com'),
(8, 'Michael Torres', 'Facilities Manager', '2020-05-12', 'michael.torres@library.com'),
(9, 'Emily Johnson', 'Children’s Librarian', '2023-03-25', 'emily.johnson@library.com'),
(10, 'Kevin Lee', 'Digital Services Coordinator', '2022-08-14', 'kevin.lee@library.com'),
(11, 'Fatima Ali', 'Outreach Coordinator', '2024-01-05', 'fatima.ali@library.com'),
(12, 'Thomas Green', 'Security Officer', '2023-10-20', 'thomas.green@library.com'),
(13, 'Natalie Brown', 'Volunteer Coordinator', '2022-04-09', 'natalie.brown@library.com'),
(14, 'Jason Kim', 'Acquisitions Manager', '2021-12-01', 'jason.kim@library.com'),
(15, 'Olivia Reed', 'Reference Librarian', '2023-07-17', 'olivia.reed@library.com');

-- Speed up searches by ISBN
CREATE INDEX idx_books_isbn ON Books(ISBN);

-- Speed up member lookups by Email
CREATE INDEX idx_members_email ON Members(Email);

-- Composite index for quick filtering by Author and Genre
CREATE INDEX idx_books_author_genre ON Books(AuthorID, GenreID);

-- Show all the Borrowed Books 
CREATE VIEW BorrowedBooks AS
SELECT b.Title, m.Name, l.LoanDate, l.DueDate
FROM Books b
JOIN Loans l ON b.BookID = l.BookID
JOIN Members m ON l.MemberID = m.MemberID
WHERE l.ReturnDate IS NULL;

-- Shows all the books with their availeblity and genre. 
CREATE VIEW vw_BookAvailability AS
SELECT 
    b.Id AS BookID,
    b.Title,
    b.Isbn,
    g.Name AS Genre,
    b.Availability,
    b.ShelfLocation,
    b.Language
FROM Books b
JOIN Genres g ON b.GenreId = g.Id;

-- Tracks the loans with members and staffs. 
CREATE VIEW vw_LoanDetails AS
SELECT 
    l.Id AS LoanID,
    b.Title AS BookTitle,
    m.Name AS MemberName,
    s.Name AS StaffName,
    l.LoanDate,
    l.DueDate,
    l.ReturnDate
FROM Loans l
JOIN Books b ON l.BookId = b.Id
JOIN Members m ON l.MemberId = m.Id
JOIN Staff s ON l.StaffId = s.Id;

-- Summrizes how many books each members has borrowed 
CREATE VIEW vw_MemberBorrowing AS
SELECT 
    m.Id AS MemberID,
    m.Name,
    COUNT(l.Id) AS TotalLoans
FROM Members m
LEFT JOIN Loans l ON m.Id = l.MemberId
GROUP BY m.Id, m.Name;

-- show how many books each authores has in the library
CREATE VIEW vw_AuthorBookCount AS
SELECT 
    a.Id AS AuthorID,
    a.AuthorName,
    COUNT(b.Id) AS TotalBooks
FROM Authors a
LEFT JOIN Books b ON a.Id = b.AuthorId
GROUP BY a.Id, a.AuthorName;

-- Summerizes loans by genre to see the catagorize most borrowd 
CREATE VIEW vw_GenrePopularity AS
SELECT 
    g.Name AS Genre,
    COUNT(l.Id) AS TotalLoans
FROM Loans l
JOIN Books b ON l.BookId = b.Id
JOIN Genres g ON b.GenreId = g.Id
GROUP BY g.Name;

-- Inner joint, Members who actual borrowed books.
SELECT m.Name, b.Title, l.LoanDate, l.DueDate
FROM Members m
INNER JOIN Loans l ON m.MemberID = l.MemberID
INNER JOIN Books b ON l.BookID = b.BookID;

-- Right joins Shows all fines even some loans are missing.
SELECT l.LoanID, f.FineID, f.Amount, f.PaidStatus
FROM Loans l
RIGHT JOIN Fines f ON l.LoanID = f.LoanID;

-- Full Join, Shows all genre and all the loans  
SELECT g.GenreName, b.Title, l.LoanID, l.LoanDate
FROM Genre g
LEFT JOIN Books b ON g.GenreID = b.GenreID
LEFT JOIN Loans l ON b.BookID = l.BookID
UNION
SELECT g.GenreName, b.Title, l.LoanID, l.LoanDate
FROM Genre g
RIGHT JOIN Books b ON g.GenreID = b.GenreID
RIGHT JOIN Loans l ON b.BookID = l.BookID;