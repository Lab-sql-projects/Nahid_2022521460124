-- queries.sql
-- Sample queries for Fitness Center Management System

-- 1. Basic SELECT queries
-- Get all members
SELECT * FROM members;

-- Get all active premium members
SELECT first_name, last_name, email 
FROM members 
WHERE membership_type = 'Premium' AND is_active = TRUE;

-- 2. JOIN operations
-- Get class details with trainer names
SELECT c.class_name, c.schedule, t.first_name || ' ' || t.last_name AS trainer_name
FROM workout_classes c
JOIN trainers t ON c.trainer_id = t.trainer_id;

-- Get member schedules with class details
SELECT m.first_name || ' ' || m.last_name AS member_name, 
       c.class_name, c.schedule, ms.attendance_status
FROM member_schedules ms
JOIN members m ON ms.member_id = m.member_id
JOIN workout_classes c ON ms.class_id = c.class_id;

-- 3. Aggregation queries
-- Count members by membership type
SELECT membership_type, COUNT(*) AS member_count
FROM members
GROUP BY membership_type;

-- Get average class duration by trainer
SELECT t.first_name || ' ' || t.last_name AS trainer_name, 
       AVG(c.duration_minutes) AS avg_duration
FROM workout_classes c
JOIN trainers t ON c.trainer_id = t.trainer_id
GROUP BY trainer_name;

-- 4. Filtering and sorting
-- Get upcoming classes sorted by date
SELECT class_name, schedule 
FROM workout_classes 
WHERE schedule > CURRENT_TIMESTAMP
ORDER BY schedule;

-- Get members who joined in the last 3 months, sorted by join date
SELECT first_name, last_name, join_date
FROM members
WHERE join_date >= CURRENT_DATE - INTERVAL '3 months'
ORDER BY join_date DESC;

-- 5. Update and delete examples
-- Update a member's phone number
UPDATE members
SET phone = '555-9999'
WHERE email = 'john.doe@example.com';

-- Cancel a class booking
UPDATE member_schedules
SET attendance_status = 'Cancelled'
WHERE member_id = 2 AND class_id = 3;

-- Delete an inactive member (example only - would need proper conditions)
-- DELETE FROM members WHERE is_active = FALSE;