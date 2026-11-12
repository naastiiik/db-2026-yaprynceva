-- ПОЛНАЯ ИНИЦИАЛИЗАЦИЯ БД 


-- Удаляем таблицы в правильном порядке (из-за FK)
DROP TABLE IF EXISTS visits CASCADE;
DROP TABLE IF EXISTS workouts CASCADE;
DROP TABLE IF EXISTS workouttypes CASCADE;
DROP TABLE IF EXISTS trainers CASCADE;
DROP TABLE IF EXISTS specializations CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS gyms CASCADE;


-- СОЗДАНИЕ ТАБЛИЦ

CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(30),
    email VARCHAR(100) UNIQUE,
    birth_date DATE,
    city VARCHAR(50),
    street VARCHAR(100),
    building VARCHAR(20)
);

CREATE TABLE specializations (
    spec_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE trainers (
    trainer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    senior_trainer_id INT REFERENCES trainers(trainer_id),
    spec_id INT REFERENCES specializations(spec_id) 
);

CREATE TABLE gyms (
    hall_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    capacity INT CHECK (capacity > 0),
    floor INT
);

CREATE TABLE workouttypes (
    workout_type_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    trainer_id INT REFERENCES trainers(trainer_id),
    hall_id INT REFERENCES gyms(hall_id),
    duration_min INT CHECK (duration_min > 0)
);

CREATE TABLE workouts (
    workout_id SERIAL PRIMARY KEY,
    workout_type_id INT REFERENCES workouttypes(workout_type_id),
    start_time TIMESTAMP
);

CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(client_id),
    workout_id INT REFERENCES workouts(workout_id),
    visit_date DATE,
    rating INT CHECK (rating >= 1 AND rating <= 5)
);


-- ВСТАВКА ДАННЫХ

-- Специализации (ID: 1-3)
INSERT INTO specializations (name) VALUES 
('Плавание'),
('Профессиональный волейбол'),
('Пилатес');

-- Тренеры (ID: 1-3)
INSERT INTO trainers (first_name, last_name, phone, email, senior_trainer_id) VALUES 
('Елена', 'Суркина', '+79012940068', 'elena@mail.ru', NULL), -- Главный тренер, Плавание
('Тимофей', 'Орлов', '+79892541058', 'tim@mail.ru', 1), -- Подчиняется Елене, Волейбол
('Екатерина', 'Воронина', '+79222945295', 'katya@mail.ru', 2); -- Подчиняется Тимофею, Пилатес

-- Залы (ID: 1-5)
INSERT INTO gyms (name, capacity, floor) VALUES 
('Зал А', 20, 1),
('Зал B', 15, 2),
('Зал C', 10, 2),
('Зал D', 25, 3),
('Бассейн', 30, 1);

-- Типы тренировок (ID: 1-3)
INSERT INTO workouttypes (title, trainer_id, hall_id, duration_min) VALUES 
('Пилатес для начинающих', 3, 2, 60),
('Плавание для взрослых', 1, 5, 45),
('Волейбол', 2, 1, 120);

-- Клиенты (ID: 1-6)
INSERT INTO clients (first_name, last_name, phone, email, birth_date, city, street, building) VALUES 
('Светлана', 'Иванова', '+79342561780', 'sveta@mail.ru', '1989-12-02', 'Казань', 'Тверская', '3'),
('Мария', 'Попова', '+79012840078', 'mari@mail.ru', '2009-01-10', 'Казань', 'Баумана', '14'),
('Иван', 'Селиванов', '+79123456789', 'vanya@mail.ru', '2001-06-05', 'Москва', 'Ленина', '25'),
('Егор', 'Мельников', '+79000236579', 'egor@mail.ru', '1993-07-07', 'Казань', 'Танковая', '15'),
('Анна', 'Смирнова', '+79031112233', 'anna@mail.ru', '1995-03-15', 'Казань', 'Пушкина', '10'),
('Дмитрий', 'Козлов', '+79044445566', 'dima@mail.ru', '1988-11-20', 'Москва', 'Арбат', '5');

-- Тренировки (ID: 1-11)
INSERT INTO workouts (workout_type_id, start_time) VALUES 
(1, '2026-09-12 10:00:00'),   -- Пилатес
(2, '2026-09-18 17:00:00'),   -- Плавание
(3, '2026-09-02 16:00:00'),   -- Волейбол
(1, '2026-08-22 11:00:00'),   -- Пилатес
(3, '2026-08-07 16:30:00'),   -- Волейбол
(1, '2026-10-01 10:00:00'),   -- Пилатес (новая)
(2, '2026-10-05 17:00:00'),   -- Плавание (новая)
(3, '2026-10-10 16:00:00'),   -- Волейбол (новая)
(1, '2026-10-15 11:00:00'),   -- Пилатес (новая)
(3, '2026-10-20 16:30:00'),   -- Волейбол (новая)
(2, '2026-11-01 17:00:00');   -- Плавание (новая, НЕ посещена)

-- Посещения (ID: 1-13)
INSERT INTO visits (client_id, workout_id, visit_date, rating) VALUES 
(1, 3,  '2026-09-02', 5),
(2, 1,  '2026-09-12', 5),
(3, 4,  '2026-08-22', 5),
(4, 2,  '2026-09-18', 5),
(1, 5,  '2026-08-07', 4),
(5, 6,  '2026-10-01', 4),
(6, 7,  '2026-10-05', 5),
(1, 8,  '2026-10-10', 3),
(2, 9,  '2026-10-15', 5),
(3, 10, '2026-10-20', 4),
(4, 6,  '2026-10-01', 4),
(5, 7,  '2026-10-05', 5),
(6, 8,  '2026-10-10', 3);