-- 1. Создание таблиц --
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name CHARACTER VARYING(100),
	email CHARACTER VARYING(150),
	created_at TIMESTAMP
);

INSERT INTO users (id, name, email, created_at) VALUES
(1, 'Иван Иванов', 'ivan@example.com', '2023-01-15 10:00:00'),
(2, 'Петр Петров', 'petr@example.com', '2023-02-10 11:00:00'),
(3, 'Сидор Сидоров', 'sidor@example.com', '2023-03-05 12:00:00'),
(4, 'Анна Аннова', 'anna@example.com', '2023-04-20 13:00:00'),
(5, 'Мария Морина', 'maria@example.com', '2023-05-25 14:00:00'),
(6, 'Дементий Деменьтев', 'dementiy@example.com', '2023-01-07 17:00:00');

CREATE TABLE categories (
	id SERIAL PRIMARY KEY,
	name CHARACTER VARYING(100)
);

INSERT INTO categories (id, name) VALUES
(1, 'Электроника'),
(2, 'Одежда'),
(3, 'Книги'),
(4, 'Мебель'),
(5, 'Спорт');

CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name CHARACTER VARYING(100),
	price NUMERIC(10,2) CHECK (price >= 0),
	category_id INTEGER CHECK (category_id >= 0),
	FOREIGN KEY (category_id) REFERENCES categories (id)
);

INSERT INTO products (id, name, price, category_id) VALUES
(1, 'Смартфон', 29999.99, 1),
(2, 'Ноутбук', 59999.99, 1),
(3, 'Футболка', 1999.99, 2),
(4, 'Джинсы', 4999.99, 2),
(5, 'Книга "SQL для начинающих"', 999.99, 3),
(6, 'Книга "Python для профессионалов"', 1499.99, 3),
(7, 'Диван', 29999.99, 4),
(8, 'Стул', 4999.99, 4),
(9, 'Велосипед', 19999.99, 5),
(10, 'Гантели', 2999.99, 5);

CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id INTEGER CHECK (user_id >= 0),
	status CHARACTER VARYING(50),
	created_at TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO orders (id, user_id, status, created_at) VALUES
(1, 1, 'Оплачен', '2023-01-20 10:00:00'),
(2, 2, 'Ожидает оплаты', '2023-02-15 11:00:00'),
(3, 3, 'Доставлен', '2023-03-10 12:00:00'),
(4, 4, 'Оплачен', '2023-04-05 13:00:00'),
(5, 5, 'Ожидает оплаты', '2023-05-01 14:00:00'),
(6, 1, 'Доставлен', '2023-01-25 15:00:00'),
(7, 2, 'Оплачен', '2023-02-20 16:00:00'),
(8, 3, 'Ожидает оплаты', '2023-03-15 17:00:00'),
(9, 4, 'Доставлен', '2023-04-10 18:00:00'),
(10, 5, 'Оплачен', '2023-05-05 19:00:00'),
(11, 1, 'Ожидает оплаты', '2023-01-30 20:00:00'),
(12, 2, 'Доставлен', '2023-03-25 21:00:00'),
(13, 3, 'Оплачен', '2023-03-20 22:00:00'),
(14, 4, 'Ожидает оплаты', '2023-04-15 23:00:00'),
(15, 5, 'Доставлен', '2023-05-10 10:00:00'),
(16, 1, 'Оплачен', '2023-01-05 11:00:00'),
(17, 2, 'Ожидает оплаты', '2023-02-28 12:00:00'),
(18, 3, 'Доставлен', '2023-03-25 13:00:00'),
(19, 4, 'Оплачен', '2023-04-20 14:00:00'),
(20, 5, 'Ожидает оплаты', '2023-06-15 15:00:00');

CREATE TABLE order_items (
	id SERIAL PRIMARY KEY,
	order_id INTEGER CHECK (order_id >= 0),
	product_id INTEGER CHECK (product_id >= 0),
	quantity INTEGER CHECK (quantity >= 0),
	FOREIGN KEY (order_id) REFERENCES orders (id),
	FOREIGN KEY (product_id) REFERENCES products (id)
);

INSERT INTO order_items (id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 2, 3, 2),
(4, 2, 4, 1),
(5, 3, 5, 1),
(6, 3, 6, 1),
(7, 4, 7, 1),
(8, 4, 8, 2),
(9, 5, 9, 1),
(10, 5, 10, 1),
(11, 6, 1, 1),
(12, 6, 3, 1),
(13, 7, 2, 1),
(14, 7, 4, 1),
(15, 8, 5, 1),
(16, 8, 7, 1),
(17, 9, 6, 1),
(18, 9, 8, 1),
(19, 10, 9, 1),
(20, 10, 10, 1),
(21, 11, 1, 1),
(22, 11, 2, 1),
(23, 12, 3, 1),
(24, 12, 4, 1),
(25, 13, 5, 1),
(26, 13, 6, 1),
(27, 14, 7, 1),
(28, 14, 8, 1),
(29, 15, 9, 1),
(30, 15, 10, 1),
(31, 16, 1, 1),
(32, 16, 3, 1),
(33, 17, 2, 1),
(34, 17, 4, 1),
(35, 18, 5, 1),
(36, 18, 7, 1),
(37, 19, 6, 1),
(38, 19, 8, 1),
(39, 20, 9, 1),
(40, 20, 10, 1);

CREATE TABLE payments (
	id SERIAL PRIMARY KEY,
	order_id INTEGER CHECK (order_id >= 0),
	amount NUMERIC(10,2) CHECK (amount >= 0),
	payment_date TIMESTAMP,
	FOREIGN KEY (order_id) REFERENCES orders (id)
);

INSERT INTO payments (id, order_id, amount, payment_date) VALUES
(1, 1, 89999.98, '2023-01-20 10:05:00'),
(2, 2, 8999.97, NULL),
(3, 3, 2499.98, '2023-03-10 12:05:00'),
(4, 4, 39999.97, '2023-04-05 13:05:00'),
(5, 5, 22999.98, NULL),
(6, 6, 31999.98, '2023-01-25 15:05:00'),
(7, 7, 64999.98, '2023-02-20 16:05:00'),
(8, 8, 30999.98, NULL),
(9, 9, 6499.98, '2023-04-10 18:05:00'),
(10, 10, 22999.98, '2023-05-05 19:05:00'),
(11, 11, 89999.98, NULL),
(12, 12, 6999.98, '2023-02-25 21:05:00'),
(13, 13, 2499.98, '2023-03-20 22:05:00'),
(14, 14, 34999.98, NULL),
(15, 15, 22999.98, '2023-05-10 10:05:00'),
(16, 16, 31999.98, '2023-01-05 11:05:00'),
(17, 17, 64999.98, NULL),
(18, 18, 30999.98, '2023-03-25 13:05:00'),
(19, 19, 6499.98, '2023-04-20 14:05:00'),
(20, 20, 22999.98, NULL);
'''

--Задача 1. Средняя стоимость заказа по категориям товаров
WITH order_totals AS (
    SELECT 
        orders.id AS order_id, 
        categories.name AS category_name,
        SUM(order_items.quantity * products.price) AS order_total
    FROM orders
    INNER JOIN order_items ON orders.id = order_items.order_id
    INNER JOIN products ON order_items.product_id = products.id
    INNER JOIN categories ON products.category_id = categories.id
    WHERE orders.created_at >= '2023-03-01' AND orders.created_at < '2023-04-01'
    GROUP BY orders.id, categories.name
)
SELECT 
    category_name, 
    AVG(order_total) AS avg_order_amount
FROM order_totals
GROUP BY category_name;

--Задача 2. Рейтинг пользователей по сумме оплаченных заказов
WITH total_payments AS (
	SELECT name AS user_name, SUM(amount) as total_spent FROM users
	JOIN orders ON orders.user_id = users.id
	JOIN payments ON payments.order_id = orders.id
	WHERE orders.status = 'Оплачен'
	GROUP BY name
	ORDER BY total_spent DESC 
	LIMIT 3
)
SELECT user_name, total_spent, ROW_NUMBER() OVER () AS user_rank FROM total_payments;

--Задача 3. Количество заказов и сумма платежей по месяцам
WITH total_orders AS (
	SELECT TO_CHAR(created_at, 'YYYY-MM') AS year_month, COUNT(*), SUM(amount) from orders
	JOIN payments ON payments.order_id = orders.id
	WHERE TO_CHAR(created_at, 'YYYY') = '2023'
	GROUP BY TO_CHAR(created_at, 'YYYY-MM')
	ORDER BY TO_CHAR(created_at, 'YYYY-MM')
)
SELECT * from total_orders;

--Задача 4. Рейтинг товаров по количеству продаж
WITH product_sales AS (
    SELECT 
        p.name AS product_name,
        SUM(oi.quantity) AS total_sold
    FROM products p
    INNER JOIN order_items oi ON p.id = oi.product_id
    GROUP BY p.name
),
total_sales AS (
    SELECT SUM(total_sold) AS total
    FROM product_sales
)
SELECT 
    ps.product_name,
    ps.total_sold,
    ROUND((ps.total_sold * 100.0 / ts.total), 2) AS sales_percentage
FROM product_sales ps, total_sales ts
ORDER BY ps.total_sold DESC
LIMIT 5;

--Задача 5. Пользователи, которые сделали заказы на сумму выше среднего
WITH order_totals AS (
    SELECT 
        users.name AS nm, 
        orders.status AS st, 
        SUM(products.price * order_items.quantity) AS fn,
        AVG(SUM(products.price * order_items.quantity)) OVER () AS avg_fn 
    FROM users
    INNER JOIN orders ON orders.user_id = users.id
    INNER JOIN order_items ON orders.id = order_items.order_id
    INNER JOIN products ON products.id = order_items.product_id
    WHERE orders.status = 'Оплачен'
    GROUP BY users.name, orders.status
  ORDER BY SUM(products.price * order_items.quantity) DESC
)
SELECT nm, fn FROM order_totals
WHERE fn > avg_fn;

--Задача 6. Рейтинг товаров по количеству продаж в каждой категории
WITH ranked_products AS (
    SELECT
        c.name AS category_name,
        p.name AS product_name,
        SUM(o.quantity) AS total_sold,
        ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY SUM(o.quantity) DESC) AS rank
    FROM
        categories c
    JOIN products p ON p.category_id = c.id
    JOIN order_items o ON o.product_id = p.id
    GROUP BY
        c.name, p.name
)
SELECT
    category_name,
    product_name,
    total_sold
FROM
    ranked_products
WHERE
    rank <= 3;

--Задача 7. Категории товаров с максимальной выручкой в каждом месяце
WITH monthly_data AS (
    SELECT DISTINCT ON (TO_CHAR(created_at, 'YYYY-MM'))
        TO_CHAR(created_at, 'YYYY-MM')  AS month, c.name AS category_name, SUM(o.quantity * p.price) AS total_revenue
    FROM
        orders
    JOIN order_items o ON o.order_id = orders.id
    JOIN products p ON p.id = o.product_id
    JOIN categories c ON c.id = p.category_id
	GROUP BY TO_CHAR(created_at, 'YYYY-MM'), c.name
	ORDER BY TO_CHAR(created_at, 'YYYY-MM'), total_revenue DESC
)
SELECT
    *
FROM
    monthly_data
WHERE
    month >= '2023-01'
    AND month <= '2023-06';


--Задача 8. Накопительная сумма платежей по месяцам
WITH values AS (
	SELECT TO_CHAR(payment_date, 'YYYY-MM') AS month, SUM(amount) as monthly_payments
	FROM payments
	WHERE TO_CHAR(payment_date, 'YYYY') = '2023'
	GROUP BY month
	ORDER by month
) 
SELECT month, monthly_payments, SUM(monthly_payments) OVER(ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_payments FROM values;
