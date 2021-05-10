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

#Изменить имя актера у фильма Властелин колец: Братство Кольца
UPDATE films
SET Actors = 'Элайджа Вуд'
WHERE Name = 'Властелин колец: Братство Кольца';

#Изменить жанр у фильма Робот по имени Чаппи
UPDATE films
SET Genre = 'боевик'
WHERE Name = 'Робот по имени Чаппи';

#Изменить размер хола м индексом 1
UPDATE halls
SET Size = '30x50x6'
WHERE Id_hall = 1;
