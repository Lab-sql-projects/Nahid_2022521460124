-- Start transaction
BEGIN TRANSACTION;

-- Insert a new member
INSERT INTO members (member_id, first_name, last_name, email, membership_type, join_date)
VALUES (3, 'Alice', 'Wonder', 'alice.wonder@example.com', 'Standard', '2023-04-01');

-- Update the new member to VIP
UPDATE members
SET membership_type = 'VIP'
WHERE member_id = 3;

-- Check the current state before committing
SELECT * FROM members WHERE member_id = 3;

-- If everything looks good, COMMIT
-- COMMIT;

-- OR, if you want to cancel everything, use ROLLBACK
-- ROLLBACK;