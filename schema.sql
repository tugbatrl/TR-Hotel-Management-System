-- ÖNCE VAR OLAN TABLOLARI TEMİZLE (Bağımlıdan bağımsıza doğru silinmeli)
-- CASCADE komutu, eğer tablolar birbirine bağlıysa sorunsuz silinmesini sağlar.
DROP TABLE IF EXISTS reservation_service CASCADE;
DROP TABLE IF EXISTS reservation_room CASCADE;
DROP TABLE IF EXISTS reservation CASCADE;
DROP TABLE IF EXISTS room CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS service CASCADE;
DROP TABLE IF EXISTS room_type CASCADE;
DROP TABLE IF EXISTS guest CASCADE;

-- 1. GUEST (Misafir) Tablosu
CREATE TABLE guest (
    guest_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    address VARCHAR(255),
    telephone_number VARCHAR(20),
    email_address VARCHAR(100),
    national_identification VARCHAR(20),
    national_id_photograph BYTEA 
);

-- 2. ROOM TYPE (Oda Tipi) Tablosu
CREATE TABLE room_type (
    room_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    standard_capacity INT,
    standard_price DECIMAL(10,2),
    photograph BYTEA
);

-- 3. SERVICE (Hizmet) Tablosu
CREATE TABLE service (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    standard_price DECIMAL(10,2)
);

-- 4. EMPLOYEE (Çalışan) Tablosu
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    address VARCHAR(255),
    telephone_number VARCHAR(20),
    email_address VARCHAR(100),
    job_title VARCHAR(50),
    employment_date DATE,
    national_id VARCHAR(20),
    photograph BYTEA,
    department VARCHAR(50)
);

-- 5. ROOM (Oda) Tablosu
CREATE TABLE room (
    room_id SERIAL PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    floor INT,
    capacity INT,
    current_status VARCHAR(20),
    room_type_id INT REFERENCES room_type(room_type_id) 
);

-- 6. RESERVATION (Rezervasyon) Tablosu
CREATE TABLE reservation (
    reservation_id SERIAL PRIMARY KEY,
    reservation_date DATE,
    check_in_date DATE,
    check_out_date DATE,
    reservation_status VARCHAR(20),
    total_reservation_amount DECIMAL(10,2),
    cancellation_status VARCHAR(20),
    cancellation_date DATE,
    guest_id INT REFERENCES guest(guest_id),
    employee_id INT REFERENCES employee(employee_id)
);

-- 7. REZERVASYON - ODA ARA TABLOSU
CREATE TABLE reservation_room (
    reservation_id INT REFERENCES reservation(reservation_id),
    room_id INT REFERENCES room(room_id),
    nightly_price DECIMAL(10,2),
    PRIMARY KEY (reservation_id, room_id)
);

-- 8. REZERVASYON - HİZMET (KULLANIM) ARA TABLOSU
CREATE TABLE reservation_service (
    usage_id SERIAL PRIMARY KEY,
    reservation_id INT REFERENCES reservation(reservation_id),
    service_id INT REFERENCES service(service_id),
    date_of_use DATE,
    quantity INT,
    price_applicable DECIMAL(10,2)
);