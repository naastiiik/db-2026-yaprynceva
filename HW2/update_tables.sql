UPDATE clients SET phone='+79342561780' WHERE first_name='Светлана';

UPDATE clients SET address='г. Казань, ул. Баумана, д. 14' WHERE last_name='Попова';

UPDATE trainers SET specialization='Профессиональный волейбол' WHERE first_name='Тимофей';

UPDATE workouts SET duration_min = 120 WHERE title = 'Волейбол' AND duration_min = 90;

UPDATE visits SET rating = 5 WHERE client_id = 2 AND workout_id = 1;