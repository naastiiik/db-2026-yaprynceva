CREATE TABLE WorkoutTypes (
    workout_type_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    trainer_id INT REFERENCES Trainers(trainer_id),
    hall_id INT REFERENCES Gyms(hall_id),
    duration_min INT CHECK (duration_min > 0)
);


INSERT INTO WorkoutTypes (title, trainer_id, hall_id, duration_min)
SELECT DISTINCT title, trainer_id, hall_id, duration_min
FROM Workouts;


ALTER TABLE Workouts ADD COLUMN workout_type_id INT REFERENCES WorkoutTypes(workout_type_id);


UPDATE Workouts
SET workout_type_id = WorkoutTypes.workout_type_id
FROM WorkoutTypes
WHERE Workouts.title = WorkoutTypes.title 
  AND Workouts.trainer_id = WorkoutTypes.trainer_id 
  AND Workouts.hall_id = WorkoutTypes.hall_id 
  AND Workouts.duration_min = WorkoutTypes.duration_min;


ALTER TABLE Workouts DROP COLUMN title;
ALTER TABLE Workouts DROP COLUMN trainer_id;
ALTER TABLE Workouts DROP COLUMN hall_id;
ALTER TABLE Workouts DROP COLUMN duration_min;