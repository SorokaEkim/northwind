-- Выбрать все данные из таблицы customers.
SELECT * FROM customers

-- Выбрать все записи из таблицы customers, но только колонки "имя контакта" и "город".
SELECT contact_name, city FROM customers

-- Выбрать все записи из таблицы orders, но взять две колонки: идентификатор заказа и колонку, значение в которой мы рассчитываем как разницу между датой отгрузки и датой формирования заказа.
SELECT order_id, shipped_date - order_date FROM orders

-- Выбрать все уникальные города в которых "зарегестрированы" заказчики.
SELECT DISTINCT city FROM customers

-- Выбрать все уникальные сочетания городов и стран в которых "зарегестрированы" заказчики.
SELECT DISTINCT city, country FROM customers

-- Посчитать кол-во заказчиков.
SELECT COUNT(*) FROM customers;
SELECT COUNT(DISTINCT customer_id) FROM customers; -- Уникальные заказчики.

-- Посчитать кол-во уникальных стран в которых "зарегистрированы" заказчики
SELECT COUNT (DISTINCT country) FROM customers

-- Выбрать все заказы из стран France, Austria, Spain.
SELECT *
FROM orders
WHERE ship_country IN ('France', 'Austria', 'Spain')

-- Выбрать все заказы, отсортировать по required_date (по убыванию) и отсортировать по дате отгрузке (по возрастанию).
SELECT *
FROM orders
ORDER BY required_date DESC, shipped_date ASC

-- Выбрать минимальную цену среди тех продуктов, которых в продаже более 30 единиц.
SELECT MIN(unit_price)
FROM products
WHERE units_in_stock > 30

-- Выбрать максимальную цену среди тех продуктов, которых в продаже более 30 единиц.
SELECT MAX(unit_price)
FROM products
WHERE units_in_stock > 30

-- Найти среднее значение дней уходящих на доставку с даты формирования заказа в USA
SELECT AVG(shipped_date - order_date)
FROM orders
WHERE ship_country = 'USA'

-- Найти сумму, на которую имеется товаров (кол-во * цену) причём таких, которые планируется продавать и в будущем (см. на поле discontinued).
SELECT SUM(units_in_stock * unit_price)
FROM products
WHERE discontinued = '0'

-- Выбрать все записи заказов в которых наименование страны отгрузки начинается с 'U'
SELECT *
FROM orders
WHERE ship_country LIKE 'U%'

-- Выбрать записи заказов (включить колонки идентификатора заказа, идентификатора заказчика, веса и страны отгузки), которые должны быть отгружены в страны имя которых начинается с 'N', отсортировать по весу (по убыванию) и вывести только первые 10 записей.
SELECT order_id, customer_id, freight, ship_country
FROM orders
WHERE ship_country LIKE 'N%'
ORDER BY freight DESC
LIMIT 10

-- Выбрать записи работников (включить колонки имени, фамилии, телефона, региона) в которых регион неизвестен.
SELECT first_name, last_name, home_phone, region
FROM employees
WHERE region IS NULL

-- Подсчитать кол-во заказчиков регион которых известен.
SELECT COUNT(*)
FROM customers
WHERE region IS NOT NULL

-- Подсчитать кол-во поставщиков в каждой из стран и отсортировать результаты группировки по убыванию кол-ва
SELECT country, COUNT(*)
FROM suppliers
GROUP BY country
ORDER BY COUNT(*) DESC

-- Подсчитать суммарный вес заказов (в которых известен регион) по странам, затем отфильтровать по суммарному весу (вывести только те записи где суммарный вес больше 2750) и отсортировать по убыванию суммарного веса.
SELECT SUM(freight), ship_country
FROM orders
WHERE ship_region IS NOT NULL
GROUP BY ship_country
HAVING SUM(freight) > 2750
ORDER BY SUM(freight) DESC

-- Выбрать все уникальные страны заказчиков и поставщиков и отсортировать страны по возрастанию.
SELECT country
FROM customers
UNION
SELECT country
FROM suppliers
ORDER BY country ASC

-- Выбрать такие страны в которых "зарегистированы" одновременно и заказчики и поставщики и работники.
SELECT country
FROM customers
INTERSECT
SELECT country
FROM suppliers
INTERSECT
SELECT country
FROM employees
ORDER BY country ASC

-- Выбрать такие страны в которых "зарегистированы" одновременно заказчики и поставщики, но при этом в них не "зарегистрированы" работники.
SELECT country
FROM customers
INTERSECT
SELECT country
FROM suppliers
EXCEPT
SELECT country
FROM employees

-- Создать таблицу teacher с полями teacher_id serial, first_name varchar, last_name varchar, birthday date, phone varchar, title varchar
CREATE TABLE teacher (
	teacher_id serial,
	first_name varchar,
	last_name varchar,
	birthday date,
	phone varchar,
	title varchar
)

-- Добавить в таблицу после создания колонку middle_name varchar
ALTER TABLE teacher 
ADD COLUMN middle_name;

-- Переименовать колонку birthday в birth_date
ALTER TABLE teacher 
RENAME COLUMN birthday TO birth_date;

-- Изменить тип данных колонки phone на varchar(32)
ALTER TABLE teacher 
ALTER COLUMN phone TYPE varchar(32);

-- Создать таблицу exam с полями exam_id serial, exam_name varchar(256), exam_date date
CREATE TABLE exam (
	exam_id serial,
	exam_name varchar(256),
	exam_date date
)

-- Вставить три любых записи с автогенерацией идентификатора
INSERT INTO exam (exam_name, exam_date) VALUES
('Математика - базовый уровень', '2024-03-15'),
('Физика - профильный уровень', '2024-03-17'),
('Информатика - олимпиада', '2024-03-20');

-- Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
TRUNCATE TABLE exam RESTART IDENTITY;







