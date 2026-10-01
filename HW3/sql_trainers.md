CREATE TABLE Specializations (
    spec_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);


INSERT INTO Specializations (name) VALUES 
('Плавание'),
('Профессиональный волейбол'),
('Пилатес');


ALTER TABLE Trainers ADD COLUMN spec_id INT REFERENCES Specializations(spec_id);


UPDATE Trainers SET spec_id = 1 WHERE specialization = 'Плавание';
UPDATE Trainers SET spec_id = 2 WHERE specialization = 'Профессиональный волейбол';
UPDATE Trainers SET spec_id = 3 WHERE specialization = 'Пилатес';


ALTER TABLE Trainers DROP COLUMN specialization;