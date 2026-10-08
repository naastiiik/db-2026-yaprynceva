ALTER TABLE clients ADD COLUMN city VARCHAR(50);
ALTER TABLE clients ADD COLUMN street VARCHAR(100);
ALTER TABLE clients ADD COLUMN building VARCHAR(20);


UPDATE clients SET 
    city = 'Казань',
    street = 'Тверская',
    building = '3'
WHERE first_name = 'Светлана';

UPDATE clients SET 
    city = 'Казань',
    street = 'Баумана',
    building = '14'
WHERE last_name = 'Попова';

UPDATE clients SET 
    city = 'Москва',
    street = 'Ленина',
    building = '25'
WHERE first_name = 'Иван';

UPDATE clients SET 
    city = 'Казань',
    street = 'Танковая',
    building = '15'
WHERE first_name = 'Егор';


ALTER TABLE clients DROP COLUMN address;