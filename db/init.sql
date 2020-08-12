--Practice Joins--
-- 1
SELECT *
FROM invoice i
    JOIN invoice_line il
    ON il.invoice_id=i.invoice_id
WHERE il.unit_price > 0.99;
-- 2
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
    JOIN customer c
    ON i.customer_id=c.customer_id;
-- 3
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
    JOIN employee e
    ON c.support_rep_id=e.employee_id;
-- 4
SELECT al.title, ar.name
FROM Album al
    JOIN artist ar
    ON al.artist_id=ar.artist_id;
-- 5
SELECT pt.track_id
FROM playlist_track pt
    JOIN playlist p
    ON pt.playlist_id=p.playlist_id
WHERE p.name IN ('Music');
-- 6
SELECT t.name
FROM track t
    JOIN playlist_track pt
    ON t.track_id=pt.track_id
WHERE pt.playlist_id = 5;
-- 7
SELECT t.name, p.name
FROM track t
    JOIN playlist_track pt ON pt.track_id = t.track_id
    JOIN playlist p ON p.playlist_id = pt.playlist_id;
-- 8
SELECT t.name, a.title
FROM track t
    JOIN album a ON a.album_id=t.album_id
    JOIN genre g ON  g.genre_id=t.genre_id
WHERE g.name=('Alternative & Punk');


-- Nested Query--
-- 1
SELECT *
FROM invoice
WHERE invoice_id IN ( 
    SELECT invoice_id
FROM invoice_line
WHERE unit_price > 0.99 
    );
-- 2
SELECT *
FROM playlist_track
WHERE playlist_id IN (
    SELECT playlist_id
FROM playlist
WHERE name = ('Music')
);
-- 3
SELECT name
FROM track
WHERE track_id IN (
    SELECT track_id
FROM playlist_track
WHERE playlist_id=5
);
-- 4
SELECT *
FROM track
WHERE genre_id IN(
    SELECT genre_id
FROM genre
WHERE name = 'Comedy'
);
-- 5
SELECT *
FROM track
WHERE album_id IN(
    SELECT album_id
FROM album
WHERE title = 'Fireball'
);
-- 6
SELECT *
FROM track
WHERE album_id IN (
    SELECT album_id
FROM album
WHERE artist_id IN (
        SELECT artist_id
FROM artist
WHERE name = 'Queen'
    )
);

--Updateing rows--
-- 1
UPDATE customer 
SET fax = null
WHERE fax IS NOT null;
-- 2
UPDATE customer
SET company = 'Self'
WHERE company IS null;
-- 3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name ='Barnett';
-- 4
UPDATE customer 
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';
-- 5
UPDATE track 
SET composer = 'The darkness around us'
WHERE composer = null AND genre_id= (
    SELECT genre_id
    FROM genre
    WHERE name = 'Metal');
--Group Up--
-- 1
SELECT COUNT(*), g.name
FROM track t
    JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
;
-- 2
SELECT COUNT(*), g.name
FROM track t
    JOIN genre g ON g.genre_id=t.genre_id
WHERE g.name = 'Pop' OR g.name= 'Rock'
GROUP BY g.name
;
-- 3
SELECT COUNT(*), ar.name
FROM album al
    JOIN artist ar
    ON ar.artist_id=al.artist_id
GROUP BY ar.name;

--Distint--
-- 1
SELECT DISTINCT composer
FROM track;
-- 2
SELECT DISTINCT billing_postal_code
FROM invoice;
-- 3
SELECT DISTINCT company
FROM customer;

--Delete Rows--
-- 1
-- Done 
-- 2
DELETE FROM practice_delete
WHERE type = 'bronze';
-- 3
DELETE FROM practice_delete
WHERE type = 'silver';
-- 4
DELETE FROM practice_delete
WHERE value = 150;

-- eCommerce Simulation--
--Create and add data--
CREATE TABLE users
(
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(20),
    email VARCHAR(65)
);
INSERT INTO users
    (user_name, email)
VALUES
    ('Ryan', 'ryan@mail.com'),
    ('Kevin', 'kevin@mail.com'),
    ('Corey', 'corey@mail.com');

CREATE TABLE products
(
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    price FLOAT(2)
);
INSERT INTO products
    (product_name, price)
VALUES
    ('Bottle', 5.99),
    ('Glass', 10.99),
    ('Bag', 15.99)

CREATE TABLE orders
(
    order_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    order_quanity INT
);
INSERT INTO orders
    (product_id, order_quanity)
VALUES
    (1, 2),
    (2, 2),
    (3, 1)
 --Run queries--
--  1
SELECT p.product_name
FROM products p 
JOIN orders o ON p.product_id=o.product_id
WHERE order_id = 1;
--  2
SELECT * FROM orders;
--  3
SELECT SUM(p.price * o.order_quanity)
FROM orders o
JOIN products p ON p.product_id=o.product_id
WHERE o.order_id = 2
--Add Foreign key to users from orders--
ALTER TABLE orders
ADD COLUMN users_id INT REFERENCES users(users_id);
--Update the orders table to link a user to each order--





