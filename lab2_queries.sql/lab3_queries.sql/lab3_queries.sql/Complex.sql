-- Step 5: Complex Query with JOIN, Subquery, and HAVING

SELECT 
    m.first_name, 
    m.last_name, 
    COUNT(ms.class_id) AS attended_classes
FROM 
    members m
JOIN 
    member_schedules ms ON m.member_id = ms.member_id
WHERE 
    ms.attendance_status = 'Attended'  -- Only consider attended classes
GROUP BY 
    m.member_id
HAVING 
    COUNT(ms.class_id) > 1;  -- Only include members who attended more than 1 class
