-- lab2_queries.sql
-- SQL queries for Lab 2 - Joins, Updates, Aggregations & Subqueries

-- ======================
-- 1. TWO JOIN QUERIES
-- ======================

-- (A) INNER JOIN: Shows members and their scheduled classes (only if they have bookings)
SELECT 
    m.first_name, m.last_name,
    wc.class_name, wc.schedule,
    ms.attendance_status
FROM 
    member_schedules ms
INNER JOIN members m ON ms.member_id = m.member_id
INNER JOIN workout_classes wc ON ms.class_id = wc.class_id;

-- (B) LEFT JOIN: Shows ALL members, even if they have no classes booked
SELECT 
    m.first_name, m.last_name,
    wc.class_name,
    ms.attendance_status
FROM 
    members m
LEFT JOIN member_schedules ms ON m.member_id = ms.member_id
LEFT JOIN workout_classes wc ON ms.class_id = wc.class_id;

-- ======================
-- 2. UPDATE QUERY
-- ======================
-- Give VIP membership to members who joined before March 2023
UPDATE members
SET membership_type = 'VIP'
WHERE join_date < '2023-03-01';

-- ======================
-- 3. DELETE QUERY
-- ======================
-- Remove old cancelled bookings (older than 30 days)
DELETE FROM member_schedules
WHERE attendance_status = 'Cancelled' 
AND booking_date < CURRENT_DATE - INTERVAL '30 days';

-- ======================
-- 4. AGGREGATION QUERY (GROUP BY + HAVING)
-- ======================
-- Count classes per trainer, showing only trainers with >1 class
SELECT 
    t.first_name, t.last_name,
    COUNT(wc.class_id) AS total_classes
FROM 
    trainers t
JOIN workout_classes wc ON t.trainer_id = wc.trainer_id
GROUP BY t.trainer_id
HAVING COUNT(wc.class_id) > 1;

-- ======================
-- 5. SUBQUERY
-- ======================
-- Find members who never attended any class
SELECT first_name, last_name
FROM members
WHERE member_id NOT IN (
    SELECT member_id 
    FROM member_schedules 
    WHERE attendance_status = 'Attended'
);