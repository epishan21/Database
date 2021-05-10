use cinema;

SET SQL_SAFE_UPDATES = 0;
SET foreign_key_checks = 0;

#Изменить формат сессии с индексом 1
UPDATE sessions
SET Format = "IMAX"
WHERE Id_session = 1;

#Изменить имя у сотрудника с индексом 9
UPDATE employees
SET Fullname = 'Сухова Алина'
WHERE Id_employee = 9;

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


#Вывод сеансов формата 2D
SELECT * FROM sessions
WHERE Format = '2D';

#Вывод фильмов с жанром мелодрама 
SELECT * FROM films
WHERE Genre = 'мелодрама';

#Вывод забронированных билетов
SELECT * FROM tickets
WHERE Reservation = 'true';

#Вывод холов имеющих размер
SELECT * FROM halls
WHERE Size IS NOT NULL;

#Вывод холов не имеющих размер
SELECT * FROM halls
WHERE Size IS NULL;

#Вывод всех фильмов в заданном промежутке рейтинга
SELECT * FROM films
WHERE Rating BETWEEN 7 AND 9;

#Вывод сотрудников с заданным именем
SELECT Fullname, Shedule, Qualification
FROM employees
WHERE Fullname = 'Ширяев Иван';

#Вывод сессий вормата 3D или IMAX
SELECT * FROM sessions
WHERE Format = '3D' OR Format = 'IMAX'; 

#Вывести холы с заданным айди кинотеатра
SELECT * FROM halls
WHERE Id_cinema = 2;

#Вывести сотрудников с заданным айди кинотеатра
SELECT Fullname, Shedule, Qualification
FROM employees
WHERE Id_cinema = 1;

#Вывести фильмы длиной от 0 до 120 и от 150 до бесконечности 
SELECT * FROM films
WHERE NOT Length BETWEEN 120 and 150;

#Вывести цену сектора хола со значениями 150 и 200
SELECT sec.price, sec.Id_hall_sectors
FROM hall_sectors as sec
WHERE price IN(150, 200);

#Вывести сеансы с временем 18:00 и 16:00
SELECT * FROM sessions
WHERE time = "16:00:00" OR time = "18:00:00";

#Вывести сеансы с временем 18:00 и форматом 2D
SELECT * FROM sessions
WHERE time = "16:00:00" AND Format = "2D";

#Вывести неповторяющиеся жанры
SELECT distinct genre
FROM films;

#Вывести фильмы компании warner brothers 
SELECT Name, Genre, Rating
FROM films
WHERE Film_company = "WB";

#Вывести первые 5 кинотеатров в списке
SELECT Name
FROM cinemas
WHERE Id_cinemas BETWEEN 1 AND 5;

#Вывести все строки таблицы сотрудников
SELECT * FROM employees;

#Вывести всех сотрудников имеющие заданную должность
SELECT Fullname, Qualification
FROM employees
WHERE Qualification = "Среднеквалифицированные";

#Вывести холы с номером 1
SELECT * FROM halls
WHERE Number = 1;



#Вывести все фильмы с рейтиногом 8.%
SELECT * FROM films
WHERE Rating LIKE '8.%';

#Вывести все цены билетов, где нулейвой разрялд равен 1 
SELECT * FROM hall_sectors
WHERE price LIKE '1%';

#Вывести кинотеатры, названия которых начинается с П
SELECT * FROM cinemas
WHERE Name LIKE 'П%';

#Вывести длины фильмов, где нулейвой разрялд равен 1 
SELECT * FROM films
WHERE length LIKE '1%';

#Вывести всех сотрудников у которых в графике 2 выходных
SELECT Fullname
FROM employees
WHERE Shedule LIKE '%2';

#Скопировать в новую таблицу фильсы с жанром драма
INSERT drama_films(Id_drama_films, Lenth, Genre, Rating, Name, Actors, Directors, Description, Film_company)
SELECT * FROM films
WHERE Genre = 'драма';

#Заполнить таблицу cleaners_to_halls
INSERT INTO cleaners_to_halls(id_cleaner, id_hall, day_of_week_of_cleaning, time_of_cleaning)
Values (1, 1, 'Среда', '8:00:00');



#Вывести кол-во работников в каждой квалификации
SELECT Qualification, COUNT(Id_employee) AS count_employees
FROM employees
GROUP BY Qualification;
 
#Вывести кол-во работников для каждого расписания
SELECT Shedule, COUNT(Id_employee) AS count_employees
FROM employees
GROUP BY Shedule;
 
#Вывести кол-во сеансов для каждого формата
SELECT Format, COUNT(Id_session) AS count_sessions
FROM sessions
GROUP BY Format;

#Вывести средний рейтинг для каждого жанра
SELECT Genre, AVG(Rating) AS genre_rating
FROM films
GROUP BY Genre
Order by genre_rating;
 
#Вывести среднюю длину для каждого жанра
SELECT Genre, AVG(Length) AS Genre_Lenth
FROM films
GROUP BY Genre
Order by Genre_Lenth desc;
 
#Вывести кол-во размеров зала 
SELECT size, COUNT(size) AS count_halls
FROM halls
WHERE size IS NOT NULL
GROUP BY size;

#Вывести минимальную цену места в зале
SELECT Id_hall, min(price) AS min_price
FROM hall_sectors
GROUP BY Id_hall;

#Вывести максимальную цену места в зале
SELECT Id_hall, max(price) AS max_price
FROM hall_sectors
GROUP BY Id_hall;

#Вывести жанры имеюищие средний рейтинг большее 8
SELECT Genre, AVG(Rating) AS genre_rating
FROM films
GROUP BY Genre
HAVING genre_rating > 8;

#Вывести кол-во забронированных и не забронированных билетов 
SELECT reservation, COUNT(Id_tickets) AS count_tickets
FROM tickets
GROUP BY reservation;

#Вывести кол-во залов у кинотеатров 
SELECT Id_cinema, COUNT(id_hall) AS count_halls
FROM halls
GROUP BY Id_cinema;

#Вывести кол-во цен у залов
SELECT Id_hall, COUNT(price) AS count_price
FROM hall_sectors
GROUP BY Id_hall;

#Вывести кол-во мест в ряду
SELECT line_№, COUNT(place_№) AS count_places
FROM places
GROUP BY line_№;

#Вывести кол-во работников кинотеатров
SELECT Id_cinema, COUNT(Id_employee) AS count_employees
FROM employees
GROUP BY Id_cinema;

 




