-- Cigna Week 1 Assignment 1

-- 1) List books with exactly one copy

SELECT Title FROM Books
WHERE Available_Copies = 1

-- 2) List authors whose names start with a specific letter(eg. j)

SELECT Author_Name
FROM Authors
WHERE Author_Name LIKE "J%"

-- 3) List Members with no address recorded

SELECT * FROM Members 
WHERE Address is NULL

-- 4) List borrowings with a specific borrow date

SELECT * FROM Borrowings
WHERE BORROW_DATE = TO_DATE('2025-10-01','YYYY-MM-DD');

-- 5) List books with a publication year after 2000

SELECT * FROM Books
WHERE Publication_Year > 2000;

--6) List borrowings with no fines

SELECT * FROM Borrowings
WHERE FINE = 0;

--7) List Members sorted by membership date in descending order.

SELECT * FROM Members
ORDER BY Membership_Date DESC;

--8) Count the total number of authors

SELECT COUNT(Author_ID) AS Total_Authors
FROM Authors

-- 9) List books with titles containing a specific word. (eg. Potter)

SELECT Title from Books
WHERE Title LIKE "%POTTER%";

-- 10) List borrowings returned on a specific date

SELECT * FROM Borrowings
WHERE TO_CHAR(Return_Date,'YYYY-MM-DD') = '2025-10-01';

-- 11) List members with a specific area code in their phone number (eg. 111)

SELECT * FROM MEMBERS
WHERE Phone LIKE "111%" OR "+111%";

-- 12) List books sorted by title alphabetically

SELECT * from Books
ORDER BY Title;

-- 13) Sum the total available copies across all books

SELECT SUM(Available_Copies) AS Total_Copies
FROM Books 

-- 14) List borrowings with a due date in a specific month (eg. October 2025)

SELECT * FROM BORROWINGS
WHERE TO_CHAR(Due_Date, 'YYYY-MM') = '2025-10'

-- 15) List authors with names longer than 10 characters

SELECT * FROM Authors 
WHERE LENGTH(Author_Name) > 10;




