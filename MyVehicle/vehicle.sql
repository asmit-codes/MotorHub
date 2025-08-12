-- 1. Drop tables if they exist (to avoid conflicts during re-run)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE bookings CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vehicles CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE cities CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE users CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

------------------------------------------------------
-- 2. USERS table
------------------------------------------------------
CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50) NOT NULL,
    password VARCHAR2(50) NOT NULL,
    email VARCHAR2(100)
);

------------------------------------------------------
-- 3. CITIES table
------------------------------------------------------
CREATE TABLE cities (
    city_id NUMBER PRIMARY KEY,
    city_name VARCHAR2(50) NOT NULL
);

------------------------------------------------------
-- 4. VEHICLES table (references users & cities)
------------------------------------------------------
CREATE TABLE vehicles (
    vehicle_id NUMBER PRIMARY KEY,
    owner_id NUMBER,
    city_id NUMBER,
    model VARCHAR2(100),
    type VARCHAR2(50),
    price_per_day NUMBER,
    FOREIGN KEY (owner_id) REFERENCES users(user_id),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

------------------------------------------------------
-- 5. BOOKINGS table (references vehicles & users)
------------------------------------------------------
CREATE TABLE bookings (
    booking_id NUMBER PRIMARY KEY,
    vehicle_id NUMBER,
    user_id NUMBER,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

------------------------------------------------------
-- 6. Insert sample data
------------------------------------------------------
INSERT INTO users (user_id, username, password, email) VALUES (1, 'testuser', 'pass123', 'test@example.com');

INSERT INTO cities (city_id, city_name) VALUES (1, 'Hyderabad');
INSERT INTO cities (city_id, city_name) VALUES (2, 'Mumbai');

INSERT INTO vehicles (vehicle_id, owner_id, city_id, model, type, price_per_day)
VALUES (1, 1, 1, 'Honda City', 'Car', 1500);

INSERT INTO vehicles (vehicle_id, owner_id, city_id, model, type, price_per_day)
VALUES (2, 1, 2, 'Yamaha R15', 'Bike', 800);

INSERT INTO bookings (booking_id, vehicle_id, user_id, start_date, end_date)
VALUES (1, 1, 1, DATE '2025-08-15', DATE '2025-08-18');

COMMIT;
