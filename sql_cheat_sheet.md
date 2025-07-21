# Data Set
```sql
CREATE DATABASE IF NOT EXISTS dict_edit;
USE dict_edit;
```




# DATE & TIME

## 1. Retrieve Current Date and Time
```sql
SELECT NOW();  -- Example: '2024-12-20 14:30:45'
SELECT CURDATE();  -- Example: '2024-12-20'
SELECT CURTIME();  -- Example: '14:30:45'
```
## 2. Extract Parts of Date or Time
```sql
SELECT QUATER('2024-12-20');-- Output: Q4
SELECT YEAR('2024-12-20');  -- Output: 2024
SELECT MONTH('2024-12-20');  -- Output: 12
SELECT DAY('2024-12-20');  -- Output: 20
SELECT HOUR('14:30:45');  -- Output: 14
SELECT MINUTE('14:30:45');  -- Output: 30
SELECT SECOND('14:30:45');  -- Output: 45
```
## 3. Date and Time Arithmetic
```sql
SELECT DATE_ADD('2024-12-20', INTERVAL 5 DAY);  -- Output: '2024-12-25'
SELECT DATE_SUB('2024-12-20', INTERVAL 1 MONTH);  -- Output: '2024-11-20'
SELECT ADDDATE('2024-12-20', INTERVAL 10 DAY);  -- Output: '2024-12-30'
SELECT TIMESTAMPDIFF(DAY, '2024-12-15', '2024-12-20');  -- Output: 5
```
## 4. Date Formatting
```sql
SELECT DATE_FORMAT('2024-12-20 14:30:45', '%Y-%m-%d %H:%i:%s');
-- Output: '2024-12-20 14:30:45'
```
## 5. Time Conversion
```sql
SELECT UNIX_TIMESTAMP();  -- Example: 1734802245
SELECT FROM_UNIXTIME(1734802245);  -- Example: '2024-12-20 14:30:45'
```
## 6. Miscellaneous Functions
```sql
SELECT DATEDIFF('2024-12-25', '2024-12-20');  -- Output: 5
SELECT LAST_DAY('2024-12-20');  -- Output: '2024-12-31'
# MAKEDATE(year, dayofyear): Creates a date from the year and day-of-year.
SELECT MAKEDATE(2024, 355);  -- Output: '2024-12-20'
```


# Records
```sql
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    registration_date DATE
);
```
## 1. Insert records
```sql
# NULL for auto-increment columns
INSERT INTO users
VALUES (NULL, 'david', 'david@example.com', '2024-12-20');

# insert single row of data
INSERT INTO users (username, email, registration_date)
VALUES ('johndoe', 'johndoe@example.com', '2024-12-20'); 

# insert multiple rows
INSERT INTO users (username, email, registration_date)
VALUES 
    ('alice', 'alice@example.com', '2024-12-19'),
    ('bob', 'bob@example.com', '2024-12-18'),
    ('charlie', 'charlie@example.com', '2024-12-17');
    
# Insert Data from Another Table
INSERT INTO users (username, email, registration_date)
SELECT name, email, CURDATE()
FROM customer_data
WHERE is_active = 1;

#  Insert with Default Values
INSERT INTO users (username, email)
VALUES ('eve', 'eve@example.com');
## If registration_date has a default value (e.g., CURRENT_DATE), it will automatically be filled.

# Update an existing record if there is a conflict with a unique key or primary key
REPLACE INTO users (user_id, username, email)
VALUES (1, 'johndoe', 'johndoe@example.com');

# Avoid duplicates
INSERT INTO users (username, email)
VALUES ('johndoe', 'johndoe@example.com')
ON DUPLICATE KEY UPDATE email = 'newemail@example.com';

# Update an existing record if there is a conflict with a unique key or primary key
REPLACE INTO users (user_id, username, email)
VALUES (1, 'johndoe', 'johndoe@example.com');
```
Difference Between `REPLACE INTO` and `INSERT ... ON DUPLICATE KEY UPDATE`

 `REPLACE INTO`:
  - Deletes the old row and inserts a new row.
  - Triggers `DELETE` and `INSERT` events (if applicable).
 `INSERT ... ON DUPLICATE KEY UPDATE`:
  - Updates the existing row without deleting it.
## 2. Update records
```sql
# update a single records
UPDATE users
SET email = 'newemail@example.com'
WHERE user_id = 5;

# update multiple records
UPDATE users
SET email = 'updatedemail@example.com',
    last_login = NOW()
WHERE user_id = 5;

# update all rows
UPDATE products
SET price = price * 1.1;

# replace records
UPDATE users
SET email = REPLACE(email,'oldemail@example.com', 'newemail@example.com' )
WHERE user_id = 5;

# update records with subquery
UPDATE employees e
SET manager_id = (
    SELECT manager_id
    FROM departments d
    WHERE d.department_id = e.department_id
)
WHERE e.department_id IS NOT NULL;

# conditional update
UPDATE products
SET discount = CASE
    WHEN price > 100 THEN 20
    WHEN price BETWEEN 50 AND 100 THEN 10
    ELSE 5
END;
```

3. Delete records
```sql
# Delete Multiple Records
DELETE FROM users
WHERE registration_date < '2024-01-01';

# Delete All Records
DELETE FROM users 
or
TRUNCATE TABLE users;

# Delete Using Subqueries
DELETE FROM orders
WHERE user_id IN (SELECT user_id FROM users WHERE status = 'inactive');

# Delete Records with JOIN
DELETE u
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE o.order_date < '2024-01-01';
```

# TABLE
## 1. Create table
```sql
# 
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    registration_date DATE
);
#  If Table Already Exists
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);
```
![image-20241222163539356](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241222163539356.png)
DECIMAL(10, 2) 不包括小数点，最长10位数字，小数点后最多两位
### create table with array 
## Insert array
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    hobbies JSON
)
INSERT INTO users (name, hobbies) 
VALUES 
    ('Alice', '["Reading", "Swimming", "Gaming"]'),
    ('Bob', '["Cooking", "Traveling"]'),
    ('Charlie', '["Hiking", "Photography", "Gaming", "Cycling"]');
```
![image-20250131124952877](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250131124952877.png)
## 2. Update table
```sql
# Add a column
ALTER TABLE users
ADD phone_number VARCHAR(15);

# Drop a Column
ALTER TABLE users
DROP COLUMN middle_name;

# Modify a column
ALTER TABLE users
MODIFY phone_number BIGINT AFTER email;

# Rename a Column
ALTER TABLE users
RENAME COLUMN username TO user_name;

# Rename a table
ALTER TABLE users
RENAME TO customers;

# Add a Primary Key
ALTER TABLE orders
ADD PRIMARY KEY (id);

# Drop a Primary Key
ALTER TABLE orders
DROP PRIMARY KEY;

# Add a Foreign Key
ALTER TABLE orders
ADD CONSTRAINT [fk_user] ## 不重要
FOREIGN KEY (user_id)
REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE orders
ADD CONSTRAINT [fk_user]
FOREIGN KEY (user_id)
REFERENCES users(id) ON DELETE SET NULL;

# Drop a Foreign Key
ALTER TABLE orders
DROP FOREIGN KEY fk_user
```
## 3. Drop table 
```sql
# drop a single table 
DROP TABLE IF EXISTS orders;

# drop multiple tables
DROP TABLE users, orders;

# Dropping a Table with Foreign Key Constraint
DROP TABLE orders CASCADE;
```

# INDEX
1. 创建索引
```sql
# 创建普通索引
CREATE INDEX idx_users_name
ON users(name);

# 创建唯一索引
CREATE UNIQUE INDEX idx_users_name
ON users(name);

# 创建全文索引，用于string搜索
CREATE FULLTEXT INDEX idx_users_name
ON users(name);
```
2. 删除索引
```SQL
DROP INDEX idx_users_name ON users;
or 
ALTER TABLE users
DROP INDEX idx_users_name
```
3. 查看表中的索引
```sql
SHOW INDEX FROM users;
```

4. 强制索引
```sql
SELECT * 
FROM salaries FORCE INDEX (idx_emp_no) 
WHERE emp_no = 10005;
```

# VIEW

1. create a view
```sql
CREATE VIEW active_users AS
SELECT id, name, email
FROM users
WHERE status = 'active';
```
2. drop a view
```sql
DROP VIEW active_users;
```

3. Show a view
```sql
select *
from active_users;

or 

show create view active_users;
```

# TRIGGER









