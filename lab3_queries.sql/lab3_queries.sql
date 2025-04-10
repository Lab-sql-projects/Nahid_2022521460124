-- LAB 3: SQL Operations & Database Management
-- Student: MD Najmul Hossain Nahid
-- File: lab3_queries.sql
-- Date: April 10, 2025

-- ====================================
-- TASK 1: CREATE A SECURE VIEW
-- ====================================
-- Create a view that masks member email addresses for privacy

DROP VIEW IF EXISTS member_directory;

CREATE VIEW member_directory AS
SELECT
    member_id,
    first_name,
    last_name,
    CASE
        WHEN email LIKE '%@%'
        THEN substr(email, 1, 1) || '***' || substr(email, instr(email, '@'))
        ELSE '***@invalid'
    END AS masked_email,
    membership_type,
    join_date
FROM
    members;

-- Test the view
SELECT * FROM member_directory LIMIT 5;

-- ====================================
-- TASK 2: ADD INTEGRITY CONSTRAINTS
-- ====================================
-- Rebuild the 'members' table with appropriate constraints

CREATE TABLE IF NOT EXISTS members_new (
    member_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    membership_type TEXT CHECK (membership_type IN ('VIP', 'Standard')),
    join_date TEXT NOT NULL
);

-- Optional: Copy old data if applicable
-- INSERT INTO members_new SELECT * FROM members;

-- Rename tables manually if needed:
-- DROP TABLE members;
-- ALTER TABLE members_new RENAME TO members;

-- ====================================
-- TASK 3: CREATE AN INDEX
-- ====================================
-- Improve search performance by indexing the email field

CREATE INDEX IF NOT EXISTS idx_member_email ON members(email);

-- ====================================
-- TASK 4: CREATE AND TEST A TRANSACTION
-- ====================================
-- Insert and roll back a sample transaction to ensure integrity

BEGIN TRANSACTION;

INSERT INTO members (member_id, first_name, last_name, email, membership_type, join_date)
VALUES (999, 'Test', 'User', 'test.user@example.com', 'VIP', '2025-04-10');

UPDATE members SET membership_type = 'Standard' WHERE member_id = 999;

-- Roll back to undo all changes
ROLLBACK;

-- Confirm rollback
SELECT * FROM members WHERE member_id = 999;

-- ====================================
-- TASK 5: COMPLEX QUERY WITH JOIN AND SUBQUERY
-- ====================================
-- List members who attended more than 1 class before 2024

SELECT 
    m.first_name || ' ' || m.last_name AS member_name,
    m.membership_type,
    COUNT(ms.class_id) AS total_attended_classes
FROM 
    members m
JOIN 
    member_schedules ms ON m.member_id = ms.member_id
WHERE 
    m.join_date < '2024-01-01'
    AND ms.attendance_status = 'Attended'
GROUP BY 
    m.member_id
HAVING 
    COUNT(ms.class_id) > 1
ORDER BY 
    total_attended_classes DESC;

-- ====================================
-- BONUS TASK: AUTHORIZATION
-- ====================================
-- SQLite does not support user roles and privileges natively.
-- Use file system permissions or implement role-based access control in the application layer.

-- END OF LAB 3
