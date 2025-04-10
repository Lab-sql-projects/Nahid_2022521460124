-- TASK 1: Secure member directory view with proper error handling

-- First, drop the view if it already exists
DROP VIEW IF EXISTS member_directory;

-- Create the view with proper email masking
CREATE VIEW member_directory AS
SELECT
    member_id,
    first_name,
    last_name,
    CASE
        WHEN email LIKE '%@%' 
        THEN substr(email, 1, 1) || '***' || substr(email, instr(email, '@'))
        ELSE '***@invalid' -- Handle malformed emails
    END AS masked_email,
    membership_type,
    join_date
FROM
    members;

-- Insert test data (ensure this matches your actual columns)
-- First check your table structure if needed:
-- PRAGMA table_info(members);

-- Example insert (adjust columns to match your table)
INSERT OR IGNORE INTO members (member_id, first_name, last_name, email, membership_type, join_date)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', 'VIP', '2023-01-15'),
    (2, 'Jane', 'Smith', 'j.smith@company.org', 'Standard', '2023-02-20');

-- Verify the view
SELECT * FROM member_directory;

-- Expected output:
-- member_id | first_name | last_name | masked_email       | membership_type | join_date  
-- 1         | John       | Doe       | j***@example.com   | VIP             | 2023-01-15
-- 2         | Jane       | Smith     | j***@company.org   | Standard        | 2023-02-20