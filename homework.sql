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






