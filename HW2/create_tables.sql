CREATE TABLE Clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    birth_date DATE
);

CREATE TABLE Trainers (
    trainer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Halls (
    hall_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    capacity INT CHECK (capacity > 0),
    floor INT
);

CREATE TABLE Workouts (
    workout_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    trainer_id INT REFERENCES Trainers(trainer_id),
    hall_id INT REFERENCES Halls(hall_id),
    start_time TIMESTAMP,
    duration_min INT CHECK (duration_min > 0)
);

CREATE TABLE Visits (
    visit_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES Clients(client_id),
    workout_id INT REFERENCES Workouts(workout_id),
    visit_date DATE,
    rating INT CHECK (rating >= 1 AND rating <= 5)
);