
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

#Скопировать в новую таблицу фильмы с жанром драма
INSERT drama_films(Id_drama_films, Lenth, Genre, Rating, Name, Actors, Directors, Description, Film_company)
SELECT * FROM films
WHERE Genre = 'драма';

#Скопировать в новую таблицу сессии с форматом 3D
INSERT sessions_3D(Id_session_3D, Format, Date, Time, Id_film, Id_hall)
SELECT * FROM sessions
WHERE Format = '3D';

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



#Вывод таблицы сотношения названий фильмов к дате их проведения
SELECT Name as Name_film, Date as Date_film, Time as Time_film
FROM sessions
JOIN films ON sessions.Id_films = films.Id_films;

#Вывод таблицы сотношения названий кинотеатров к номерам залов 
SELECT Name as Name_cinema, Number as Number_hall
FROM halls
Left JOIN cinemas ON halls.Id_cinema = cinemas.Id_cinemas;

#Вывод таблицы сотношения названий кинотеатров к их работникам
SELECT Name as Name_cinema, Fullname
FROM employees
JOIN cinemas ON employees.Id_cinema = cinemas.Id_cinemas;

#Вывод таблицы сотношения билетов к сеансам и местам
SELECT Id_tickets, Reservation, Date, time, Format, Place_№, Line_№
FROM tickets
JOIN places ON tickets.Id_place = places.Id_places
JOIN sessions ON tickets.Id_session = sessions.Id_session;

#Вывод таблицы соотношения сеансов к фильмам
SELECT * FROM sessions
natural JOIN films;

#Вывод таблицы сотношения секторов зала к залам
SELECT *
FROM hall_sectors
right JOIN halls ON hall_sectors.Id_hall = halls.Id_hall;

#Вывод таблицы сотношения залов к кинотеатрам
SELECT Id_hall, Size, Number as Number_hall, Name as Name_cinema
FROM halls
JOIN cinemas ON halls.Id_cinema = cinemas.Id_cinemas;
 
#Вывод таблицы сотношения сеансков к залам 
SELECT Id_session, Date, Time, Format, Size, Number, Id_cinema
FROM sessions
JOIN halls ON sessions.Id_hall = sessions.Id_session;
 
#Вывод таблицы сотношения мест к их стоимости
SELECT Place_№, Line_№, Price 
FROM places
JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors;
 
#Вывод таблицы сотношения работников кассы к кассам
explain SELECT Number as Number_booth, Fullname, Shedule, Qualification
FROM booth_employees
JOIN employees ON booth_employees.Id_booth_employees = employees.Id_employee
JOIN ticket_booths ON booth_employees.Id_booth = ticket_booths.Id_ticket_booths;


 
#Вывод таблицы сотношения билетов к работникам кассы которые их продали 
explain SELECT Id_tickets, Fullname, number as Number_booth,  Name_cinema
FROM tickets
JOIN booth_employees ON tickets.Id_booth_employee = booth_employees.Id_booth_employees
JOIN employees ON booth_employees.Id_booth_employees = employees.Id_employee
JOIN ticket_booths ON booth_employees.Id_booth = ticket_booths.Id_ticket_booths
JOIN cinemas ON employees.Id_cinema = cinemas.Id_cinemas;


#Вывод таблицы сотношения работников кассы к работникам, кинотеатрам и номерам касс
SELECT Fullname, Shedule, Qualification, number as Number_booth,  Name_cinema, address
FROM booth_employees
JOIN employees ON booth_employees.Id_booth_employees = employees.Id_employee
JOIN ticket_booths ON booth_employees.Id_booth = ticket_booths.Id_ticket_booths
JOIN cinemas ON employees.Id_cinema = cinemas.Id_cinemas
where number = 1;

create index idx_employee_fullname on ticket_booths(number);

drop index idx_employee_fullname on ticket_booths;

#Вывод таблицы сотношения залов к времени уборки к уборщикам
SELECT Number as Number_hall, day_of_week_of_cleaning, time_of_cleaning, Fullname, Name_cinema
FROM halls
JOIN cleaners_to_halls ON halls.id_hall= cleaners_to_halls.id_cleaner
JOIN cleaners ON cleaners_to_halls.id_cleaner = cleaners.id_cleaner
JOIN employees ON cleaners.Id_cleaner = employees.Id_employee
JOIN cinemas ON employees.Id_cinema = cinemas.Id_cinemas;


#Вывести объединение работников и кинотеатров
SELECT Fullname, 'работник'
FROM employees
UNION
SELECT name, 'кинотеатр'
FROM cinemas;


#Вывести объединение места с ценой мест
SELECT Fullname, 'работник кассы'
FROM booth_employees
JOIN employees ON booth_employees.Id_booth_employees = employees.Id_employee
UNION
SELECT Fullname, 'уборщик'
FROM cleaners
JOIN employees ON cleaners.Id_cleaner = employees.Id_employee;
    
#Вывести объединение мест с ценой мест
SELECT Place_№, 'номера места'
FROM places
UNION
SELECT price, 'цена места'
FROM hall_sectors;

#Вывести самый большой рейтинг среди фильмов каждого жанра
SELECT name, Genre, Rating
FROM films f1
where f1.Rating > ALL(
       SELECT f2.Rating
       FROM films f2
       WHERE f2.Genre = f1.Genre
       AND f2.id_films <> f1.Id_films
       AND f2.Rating IS NOT NULL
       );
       
#Вывести самый длиный фильм каждого жанра
SELECT name, Genre, Length
FROM films f1
where f1.Length > ALL(
       SELECT f2.Length
       FROM films f2
       WHERE f2.Genre = f1.Genre
       AND f2.id_films <> f1.Id_films
       AND f2.Length IS NOT NULL
       );
 
#Расчитать для ряда среднюю стоимость
SELECT Line_№, avg(Price) as avg_price 
FROM places
JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors
group by line_№;

#Транзакционные (задачи учета)
#	Вывести список фильмов.
SELECT * FROM films;

#	Вывести список кинотеатров.
SELECT * FROM cinemas;

#	Вывести список сотрудников.
SELECT * FROM employees;

#	Добавить/Удалить фильм.
INSERT INTO films(Id_films, Length, Genre, Rating, Name, Actors, Directors, Description, Film_company) VALUES
(11, 150, 'Жанр', 8, 'Имя', 'Актер', 'Режиссер', 'Описание', 'Компния');
DELETE FROM films WHERE Name = 'Имя';

#	Добавить/Удалить сотрудника.
INSERT INTO employees(Id_employee, Fullname, Shedule, Qualification, Id_cinema) VALUES
(11, 'Имя', 1-1, 'Квалификация', 1);
DELETE FROM employees WHERE Fullname = 'Имя';

#	Задать жанр фильму.  
UPDATE films
SET Genre = 'триллер'
WHERE Name = 'Пушки Акимбо';

#Справочные (оперативные запросы)
#	Показать все сеансы на фильм.
SELECT Name as Name_film, Date as Date_film, Time as Time_film, Format
FROM sessions
JOIN films ON sessions.Id_films = films.Id_films
WHERE name = 'Титаник';

#	Показать рейтинги фильмов в прокате.
SELECT Name as Name_film, rating, Date as Date_film
FROM sessions
JOIN films ON sessions.Id_films = films.Id_films;

#	Показать секторы зала.
SELECT * FROM hall_sectors;

#	Показать всех сотрудников.
SELECT Fullname FROM employees;

#Справочные расчетные (аналитические запросы)
#	Показать число проданных билетов с 14 декабря по 16 декабря.
SELECT COUNT(Id_tickets) as count_tickets
FROM tickets
JOIN sessions ON tickets.Id_session = sessions.Id_session
where date IN("2020-11-14", "2020-11-15", "2020-11-16");

#	Показать количество билетов на сеансы 14 декабря.
SELECT COUNT(Id_tickets) as count_tickets, Date, time
FROM tickets
JOIN sessions ON tickets.Id_session = sessions.Id_session
GROUP BY time;

#	Показать среднее цену билета, который покупали с 14 декабря по 16 декабря.
SELECT  avg(price) as average_ticket_price
FROM tickets
JOIN sessions ON tickets.Id_session = sessions.Id_session
JOIN places ON tickets.Id_place = places.Id_places
JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors
where date IN("2020-11-14", "2020-11-15", "2020-11-16");

#	Показать прибыль кинотеатра с 14 декабря по 18 декабря.
SELECT sum(price) as cinema_profit
FROM tickets
JOIN sessions ON tickets.Id_session = sessions.Id_session
JOIN places ON tickets.Id_place = places.Id_places
JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors
where date IN("2020-11-14", "2020-11-15", "2020-11-16", "2020-11-17", "2020-11-18");

#	Показать топ самых просматриваемых фильмов за 14, 15, 16, 17 и 18 декабря.
SELECT COUNT(Id_tickets) as count_tickets, Name
FROM tickets
JOIN sessions ON tickets.Id_session = sessions.Id_session
JOIN places ON tickets.Id_place = places.Id_places
JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors
JOIN films ON sessions.Id_films = films.Id_films
where date IN("2020-11-14", "2020-11-15", "2020-11-16", "2020-11-17", "2020-11-18")
GROUP BY Name
Order by count_tickets desc;

#   Показать имена всех сотрудников квалификации 'Среднеквалифицированные'
SELECT Qualification, GROUP_CONCAT(fullname) as name 
FROM employees
where Qualification = 'Среднеквалифицированные'
GROUP BY Qualification;

#   Показать названия всех фильмов для каждого жанра
SELECT genre, GROUP_CONCAT(name) as name
FROM films
GROUP BY genre;

#   Модификация
#   Вывести для заданного фильма за 14 декабря все сеансы с залами и кинотеатрами (вся информация) 
SELECT Date, time, Name as name_film, Name_cinema, number as hall_number
FROM sessions
JOIN halls ON sessions.Id_hall = sessions.Id_session
JOIN films ON sessions.Id_films = films.Id_films
JOIN cinemas ON halls.Id_cinema = cinemas.Id_cinemas
where name = "Властелин колец: Братство Кольца" AND date = "2020-11-14";

#   Для заданного сеанса определенного фильма в заданном зале и в заданном кинотеатре вывести состояние всех мест 
SELECT distinct Place_№, Reservation, Id_booth_employee, date, time, Name as name_film, Format, Name_cinema, number as hall_number 
FROM tickets
JOIN places ON tickets.Id_place = places.Id_places
JOIN sessions ON tickets.Id_session = sessions.Id_session
JOIN films ON sessions.Id_films = films.Id_films
JOIN halls ON sessions.Id_hall = sessions.Id_session
JOIN cinemas ON halls.Id_cinema = cinemas.Id_cinemas
WHERE date = "2020-11-14"  AND time = "12:30:00"  AND name = "Зеленая миля"  AND Format = "3D" AND number = 1  AND Name_cinema = "Киномакс";

#   Для каждого сотрудника на кассе вывести сколько он заработал денег за период времени (сколько билетов продал и их суммарную цену)
SELECT  Fullname, sum(price) as employee_profit, count(Id_tickets) as count_tickets
FROM tickets
JOIN sessions ON tickets.Id_session = sessions.Id_session
JOIN places ON tickets.Id_place = places.Id_places
JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors
JOIN booth_employees ON tickets.Id_booth_employee = booth_employees.Id_booth_employees
JOIN employees ON booth_employees.Id_booth_employees = employees.Id_employee
JOIN cinemas ON employees.Id_cinema = cinemas.id_cinemas
where date IN("2020-11-14", "2020-11-15", "2020-11-16", "2020-11-17", "2020-11-18") AND Id_cinema = 1
GROUP BY Fullname
Order by employee_profit desc;

#Процедуры

#Показать фильмы заданной компании и посчитать их
DELIMITER $$
CREATE PROCEDURE Show_cmpany_films(IN company VARCHAR(45), OUT count_films INT)
BEGIN
    SELECT films.Name, Genre, Rating, Film_company
	FROM films
	WHERE Film_company = company;
    
    SELECT COUNT(Name) INTO count_films
	FROM films
	WHERE Film_company = company;
END $$
DELIMITER ;

drop PROCEDURE Show_cmpany_films;

CALL Show_cmpany_films('WB', @count_films);
SELECT @count_films;

#Показать билеты которые продали работники и их количество
DELIMITER $$
CREATE PROCEDURE Show_employee_tickets(IN employee VARCHAR(45), OUT count_tickets INT)
BEGIN
	SELECT Id_tickets, Fullname, number as Number_booth, Name_cinema
	FROM tickets
	JOIN booth_employees ON tickets.Id_booth_employee = booth_employees.Id_booth_employees
	JOIN employees ON booth_employees.Id_booth_employees = employees.Id_employee
	JOIN ticket_booths ON booth_employees.Id_booth = ticket_booths.Id_ticket_booths
	JOIN cinemas ON employees.Id_cinema = cinemas.Id_cinemas
    WHERE Fullname = employee;
    
	SELECT COUNT(Id_tickets) INTO count_tickets
	FROM tickets
	JOIN booth_employees ON tickets.Id_booth_employee = booth_employees.Id_booth_employees
	JOIN employees ON booth_employees.Id_booth_employees = employees.Id_employee
	JOIN ticket_booths ON booth_employees.Id_booth = ticket_booths.Id_ticket_booths
	JOIN cinemas ON employees.Id_cinema = cinemas.Id_cinemas
    WHERE Fullname = employee;
END $$
DELIMITER ;

CALL Show_employee_tickets('Кравц Андрей', @count_tickets);
SELECT @count_tickets;

#Показать прибыль кинотеатра с одной даты по другую и вывести количество проданных билетов.
DELIMITER $$
CREATE PROCEDURE Show_cinema_profit(IN cinema_name VARCHAR(45), IN first_date date, IN last_date date, OUT count_tickets INT)
BEGIN
	SELECT sum(price) as cinema_profit
	FROM tickets
	JOIN sessions ON tickets.Id_session = sessions.Id_session
	JOIN places ON tickets.Id_place = places.Id_places
	JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors
    JOIN halls ON sessions.Id_hall = sessions.Id_session
	JOIN cinemas ON halls.Id_cinema = cinemas.Id_cinemas
	where date between first_date and last_date and Name_cinema = cinema_name;
    
	SELECT COUNT(Id_tickets) INTO count_tickets
	FROM tickets
	JOIN sessions ON tickets.Id_session = sessions.Id_session
	JOIN places ON tickets.Id_place = places.Id_places
	JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors
    JOIN halls ON sessions.Id_hall = sessions.Id_session
	JOIN cinemas ON halls.Id_cinema = cinemas.Id_cinemas
    where date between first_date and last_date and Name_cinema = cinema_name;
END $$
DELIMITER ;

CALL Show_cinema_profit('Киномакс', "2020-11-14", "21-05-15", @count_tickets);
SELECT @count_tickets;


# Вывести для сотрудника на кассе сколько он заработал денег за период времени (сколько билетов продал и их суммарную цену)
DELIMITER $$
CREATE PROCEDURE Show_profit_emp(IN emp_name VARCHAR(45), IN first_date date, IN last_date date, OUT employee_profit INT)
BEGIN
	SELECT sum(price) INTO employee_profit
	FROM tickets
	JOIN sessions ON tickets.Id_session = sessions.Id_session
	JOIN places ON tickets.Id_place = places.Id_places
	JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors
	JOIN booth_employees ON tickets.Id_booth_employee = booth_employees.Id_booth_employees
	JOIN employees ON booth_employees.Id_booth_employees = employees.Id_employee
	JOIN cinemas ON employees.Id_cinema = cinemas.id_cinemas
	where date between first_date and last_date and Fullname = emp_name
	GROUP BY Fullname
	Order by employee_profit desc;
END $$
DELIMITER ;

drop PROCEDURE Show_profit_emp;

CALL Show_profit_emp('Кравц Андрей', "2020-06-14", "2021-05-15", @employee_profit);
SELECT @employee_profit;


# Функции

#	Показать количество проданных билетов на сеансы в определенную дату.
DELIMITER $$
CREATE FUNCTION Сalc_tickets_session(
    date_ses date
)
RETURNS INT 
DETERMINISTIC	
BEGIN
	DECLARE count INT;
	SELECT COUNT(Id_tickets) 
    INTO count
	FROM tickets
    JOIN sessions ON tickets.Id_session = sessions.Id_session
    JOIN films ON sessions.Id_films = films.Id_films
	where Date = date_ses
	GROUP BY Date;
RETURN count;
END $$
DELIMITER ;

drop FUNCTION Сalc_tickets_session;

SELECT Сalc_tickets_session( "2020-11-14" ) as count_ticket
FROM tickets
GROUP BY count_ticket;


#Рассчитать кол-во сотрудников в кинотеатре, чья квалификации 'Среднеквалифицированные'
DELIMITER $$
CREATE FUNCTION Сalc_employee_qualification(
    qua VARCHAR(45)
)
RETURNS INT 
DETERMINISTIC	
BEGIN
	DECLARE count INT;
	SELECT count(fullname)
    INTO count
	FROM employees
	where Qualification = qua
	GROUP BY Qualification;
RETURN count;
END $$
DELIMITER ;

drop FUNCTION Сalc_employee_qualification;

SELECT Сalc_employee_qualification("Среднеквалифицированные") AS count_employee
FROM employees
GROUP BY count_employee;


#Рассчитать кол-во сотрудников в кинотеатре 
DELIMITER $$
CREATE FUNCTION Сalc_count_employee(
    cinema_name VARCHAR(45)
)
RETURNS INT 
DETERMINISTIC	
BEGIN
	DECLARE count INT;
	SELECT COUNT(id_employee)
    INTO count
	FROM employees
	JOIN cinemas ON employees.Id_cinema = cinemas.Id_cinemas
    WHERE Name_cinema = cinema_name;
RETURN count;
END $$
DELIMITER ;

SELECT Name_cinema AS cinema_name, Сalc_count_employee(Name_cinema) AS count_employee
FROM cinemas
ORDER BY count_employee DESC;


# Представления
#Вывод фильмов и их сеансов
CREATE VIEW session_film
AS
SELECT Name, date, time, rating, genre
FROM sessions
JOIN films ON sessions.Id_films = films.Id_films;

drop VIEW session_film;

SELECT * FROM session_film;


#Вывод таблицы уборки залов(временя и кто убирал)
CREATE VIEW time_clean
AS
SELECT Number as Number_hall, day_of_week_of_cleaning, time_of_cleaning, Fullname, Name_cinema
FROM halls
JOIN cleaners_to_halls ON halls.id_hall= cleaners_to_halls.id_cleaner
JOIN cleaners ON cleaners_to_halls.id_cleaner = cleaners.id_cleaner
JOIN employees ON cleaners.Id_cleaner = employees.Id_employee
JOIN cinemas ON employees.Id_cinema = cinemas.Id_cinemas;

SELECT * FROM time_clean;

#Вывод таблицы сотношения мест к их стоимости
CREATE VIEW price_place
AS
SELECT Place_№, Line_№, Price 
FROM places
JOIN hall_sectors ON places.Id_sector = hall_sectors.Id_hall_sectors;

SELECT * FROM price_place;

#Вывод таблицы билетов и работников кассы которые их продали 
CREATE VIEW tickets_empl
AS
SELECT Id_tickets, Fullname, number as Number_booth,  Name_cinema
FROM tickets
JOIN booth_employees ON tickets.Id_booth_employee = booth_employees.Id_booth_employees
JOIN employees ON booth_employees.Id_booth_employees = employees.Id_employee
JOIN ticket_booths ON booth_employees.Id_booth = ticket_booths.Id_ticket_booths
JOIN cinemas ON employees.Id_cinema = cinemas.Id_cinemas;

SELECT * FROM tickets_empl