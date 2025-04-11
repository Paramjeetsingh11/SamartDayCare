-- Create the database
CREATE DATABASE IF NOT EXISTS smartdaycare;
USE smartdaycare;

-- Create Users table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'TEACHER', 'PARENT') NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Children table
CREATE TABLE IF NOT EXISTS children (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    parent_id INT,
    enrollment_date DATE NOT NULL,
    age_group ENUM('INFANT', 'TODDLER', 'PRESCHOOL') NOT NULL,
    medical_info TEXT,
    emergency_contact VARCHAR(100),
    FOREIGN KEY (parent_id) REFERENCES users(id)
);

-- Create Activities table
CREATE TABLE IF NOT EXISTS activities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    age_group ENUM('INFANT', 'TODDLER', 'PRESCHOOL') NOT NULL,
    teacher_id INT,
    schedule_time TIME,
    duration INT, -- in minutes
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (teacher_id) REFERENCES users(id)
);

-- Create Attendance table
CREATE TABLE IF NOT EXISTS attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    child_id INT,
    check_in DATETIME,
    check_out DATETIME,
    status ENUM('PRESENT', 'ABSENT', 'LATE') NOT NULL,
    notes TEXT,
    FOREIGN KEY (child_id) REFERENCES children(id)
);

-- Create Payments table
CREATE TABLE IF NOT EXISTS payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    parent_id INT,
    child_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    due_date DATE NOT NULL,
    payment_status ENUM('PENDING', 'COMPLETED', 'FAILED') NOT NULL,
    payment_method VARCHAR(50),
    FOREIGN KEY (parent_id) REFERENCES users(id),
    FOREIGN KEY (child_id) REFERENCES children(id)
);

-- Create Messages table
CREATE TABLE IF NOT EXISTS messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    subject VARCHAR(200),
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id)
);

-- Insert default admin user
INSERT INTO users (username, password, role, first_name, last_name, email) 
VALUES ('admin', 'admin123', 'ADMIN', 'System', 'Administrator', 'admin@smartdaycare.com');

-- Insert sample activities
INSERT INTO activities (name, description, age_group) VALUES
('Morning Circle Time', 'Group activity for learning songs and basic concepts', 'PRESCHOOL'),
('Nap Time', 'Afternoon rest period', 'TODDLER'),
('Story Time', 'Interactive story reading session', 'INFANT'),
('Art & Craft', 'Creative activities with various materials', 'PRESCHOOL'),
('Outdoor Play', 'Supervised playground activities', 'TODDLER'); 