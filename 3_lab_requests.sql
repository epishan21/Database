use cinema;

#Изменить времся сессии с индексом 1
UPDATE sessions
SET Time = '16:00'
WHERE Id_session = 1;

#Изменить имя у сотрудника с индексом 9
UPDATE employees
SET Fullname = 'Сухова Алина'
WHERE Id_employee = 9;

SET SQL_SAFE_UPDATES = 0;
SET foreign_key_checks = 0;

#Изменить имя актера у фильма Властелин колец: Братство Кольца
UPDATE films
SET Actors = 'Элайджа Вуд'
WHERE Name = 'Властелин колец: Братство Кольца';

#Изменить жанр у фильма Робот по имени Чаппи
UPDATE films
SET Genre = 'боевик'
WHERE Name = 'Робот по имени Чаппи';

#Изменить размер хола с индексом 1
UPDATE halls
SET Size = '30x50x6'
WHERE Id_hall = 1;

#Добавить и удалить хол с размером 10x10x10
INSERT INTO halls(Id_hall, Size, Number, Id_cinema) VALUES
(15 ,'10x10x10' , 100, 25);
DELETE FROM halls WHERE Size = '10x10x10';

#Добавить и удалить место с id = 15
INSERT INTO places(Id_places, Place_№, Line_№, Id_sector) VALUES
(15, 10, 10, 20);
DELETE FROM places WHERE Id_places = 15;

#Добавить и удалить хол с без размера 
INSERT INTO halls(Id_hall, Number, Id_cinema) VALUES
(25, 10, 15);
DELETE FROM halls WHERE Size IS NULL;

#Удалить место с id = 10 и Place_№ = 10
DELETE FROM places WHERE Id_places = 10 AND Place_№ = 10 AND Line_№ = 3;

#Удалить билет с Id_session = 10 и id_place = 10;
DELETE FROM tickets WHERE Id_session = 10 AND id_place = 10;

