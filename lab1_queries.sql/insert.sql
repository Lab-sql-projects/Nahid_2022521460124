-- insert.sql
-- Sample data for Fitness Center Management System

-- Insert members
INSERT INTO members (first_name, last_name, email, phone, join_date, membership_type)
VALUES 
    ('John', 'Doe', 'john.doe@example.com', '555-1234', '2023-01-15', 'Premium'),
    ('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '2023-02-20', 'VIP'),
    ('Mike', 'Johnson', 'mike.johnson@example.com', '555-9012', '2023-03-10', 'Basic'),
    ('Sarah', 'Williams', 'sarah.williams@example.com', '555-3456', '2023-04-05', 'Premium');

-- Insert trainers
INSERT INTO trainers (first_name, last_name, email, phone, specialization, hire_date)
VALUES 
    ('David', 'Lee', 'david.lee@example.com', '555-7890', 'Yoga and Pilates', '2022-05-10'),
    ('Emily', 'Chen', 'emily.chen@example.com', '555-2345', 'HIIT and Strength Training', '2022-08-15'),
    ('Robert', 'Brown', 'robert.brown@example.com', '555-6789', 'Cycling and Cardio', '2023-01-05');

-- Insert workout classes
INSERT INTO workout_classes (class_name, trainer_id, schedule, duration_minutes, max_capacity)
VALUES 
    ('Morning Yoga', 1, '2023-06-01 07:00:00', 60, 15),
    ('HIIT Blast', 2, '2023-06-01 18:00:00', 45, 20),
    ('Spin Class', 3, '2023-06-02 17:30:00', 50, 12),
    ('Pilates Core', 1, '2023-06-03 09:00:00', 55, 10);

-- Insert member schedules
INSERT INTO member_schedules (member_id, class_id, attendance_status)
VALUES 
    (1, 1, 'Scheduled'),
    (1, 2, 'Attended'),
    (2, 1, 'Attended'),
    (2, 3, 'Scheduled'),
    (3, 4, 'Scheduled'),
    (4, 2, 'Attended');