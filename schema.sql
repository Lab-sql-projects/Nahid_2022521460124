-- schema.sql
-- Database schema for Fitness Center Management System

-- Drop existing tables if they exist
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS trainers;
DROP TABLE IF EXISTS workout_classes;
DROP TABLE IF EXISTS member_schedules;

-- Create members table
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    join_date DATE NOT NULL,
    membership_type VARCHAR(20) CHECK (membership_type IN ('Basic', 'Premium', 'VIP')),
    is_active BOOLEAN DEFAULT TRUE
);

-- Create trainers table
CREATE TABLE trainers (
    trainer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    specialization VARCHAR(100),
    hire_date DATE NOT NULL
);

-- Create workout_classes table
CREATE TABLE workout_classes (
    class_id SERIAL PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    trainer_id INT REFERENCES trainers(trainer_id),
    schedule TIMESTAMP NOT NULL,
    duration_minutes INT NOT NULL,
    max_capacity INT NOT NULL,
    current_enrollment INT DEFAULT 0
);

-- Create member_schedules table
CREATE TABLE member_schedules (
    schedule_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    class_id INT REFERENCES workout_classes(class_id),
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    attendance_status VARCHAR(20) DEFAULT 'Scheduled' CHECK (attendance_status IN ('Scheduled', 'Attended', 'Cancelled'))
);