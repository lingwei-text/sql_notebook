# DBMS理论

Record = row=tuple都代表行

column=field=atrribute=data items都是列  

表名和标题合称为关系模式，表名、标题、表内容合称为表或者关系，相互有关联关系的数据.**

**![image-20241128174100960](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241128174100960.png) **![image-20241201114244536](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241201114244536.png)

==以元组为单位进行组合==

![image-20241201114643096](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241201114643096.png)

**![image-20241201213737024](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241201213737024.png)**

```sql
Create table film_descriptions (
    film_id INT,
    long_description text
);

-- Copy the descriptions from the film table
insert into film_descriptions
SELECT film_id, long_description FROM film;
```

### data definition/manipulation/control language

definition定义表名、表标题、列名及其结构形式

manipulation 对数据值进行更改，control对数据全县进行控制

# DBMS DML

# sWHERE

```sql
WHERE (release_year = 1990 OR release_year = 1999)
	AND (language = 'English' OR language = 'Spanish')
	AND (gross >= 2000000)
```

单个条件内有or and，需要用括号归类

## like, not like, in, not in
```sql
WHERE gov_form LIKE '%Republic%' OR gov_form LIKE '%Monarchy%'
```
or and 需要重新写column name不可以直接用 or and连接要找的的词

`IN (xx, xx)` commas means or 括号中的任意一个

##  IS NULL, IS NOT NULL

WHERE filter IS NULL, IS NOT NULL

```sql
FROM countries
FULL JOIN currencies
USING (code)
WHERE region = 'North America' OR  name IS NULL
ORDER BY region;
```

## EXISTS

It is typically used to test for the existence of rows in a subquery 
```sql
# find employees who have assigned project
SELECT employee_id, employee_name
FROM employees e
WHERE EXISTS (SELECT 1 FROM projects p WHERE p.employee_id = e.employee_id);
```
```sql
# find employees who doesn't hava assigned projects
SELECT employee_id, employee_name
FROM employees e
WHERE NOT EXISTS (SELECT 1 FROM projects p WHERE p.employee_id = e.employee_id);
```

# Group by
## Aggregation function

==因为聚合函数**自动忽略**值为null的行，所以不用担心它会把score为空值的行加到计算平均数的分母中去，也不用担心有没有重复值。==
```sql
count(col1) # only count the number of non-null values 
count(*) # count all the values, including null values**
```
 **![image-20241118172057871](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241118172057871.png)**
### round()

```sql
SELECT ROUND(AVG(budget,2))
SELECT ROUND(AVG (budget,-5))
SELECT ROUND(AVG(budget),0)
```
第一行，保留小数点后两位；第二行，后五位都是0；第三行，小数点后为0，即不保留小数点
##  HAVING FOR GROUP FILTER

``` sql
SELECT region, SUM(amount) AS total_sales
FROM sales
GROUP BY region
HAVING SUM(amount) > 10000;
```
运行顺序FROM WHERE GROUP BY HAVING SELECT ORDERY BY LIMIT

## rollup()

```sql
SELECT region, product, SUM(sales_amount) AS total_sales
FROM sales
GROUP BY region, product with rollup;
```
## group_concat()
```sql
```

# Combine tables
## combine horizontally- join

### outer/inner join 
outer join : full outer join, outer left join, outer right join
```sql
SELECT *
FROM left_table
LEFT JOIN right_table
ON left_table.column_name = right_table.column_name;
```
在这个完整的语句中，`left_table` 是左表，`right_table` 是右表。
### Cross join 
Result Rows = Rows in Table A × Rows in Table B.
```sql
SELECT p.ProductName, r.RegionName
FROM Products p
CROSS JOIN Regions r;
```
![image-20250127160758034](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250127160758034.png)
![image-20250127160814360](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250127160814360.png)

### using() vs on

using for two tables have the same column name

on for tables with diferent column name.

## Combine Vertically- union

```sql
SELECT employee_name AS Name, position
FROM employees
UNION
SELECT manager_name AS Name, position
FROM managers;
# 每个 `SELECT` 语句必须有相同数量的列，并且相应的列也必须有兼容的数据类型。且列名使用alias保持一致。
```
`ORDER BY` 子句只能应用于整个 `UNION` 或 `UNION ALL` 操作的结果集，不能单独对一部分表格使用
### union/ union all
==UNION（records不重复的合集）==UNION ALL（有重复records出现的合集)

# CASE STATEMENTS

```sql
SELECT 
	season,
	date,
    -- Identify when Bologna won a match
	CASE WHEN hometeam_id = 9857 AND home_goal > away_goal 
         THEN 'Bologna Win'
         WHEN awayteam_id = 9857 AND away_goal > home_goal 
         THEN 'Bologna Win' 
         ELSE 'tie'
         END AS outcome
FROM matches_italy;
```

```sql
SELECT team_name,
       AVG(goals_scored) AS average_goals_scored,
       AVG(CASE WHEN result = 'win' THEN 1 ELSE 0 END) AS win_percentage
FROM matches
WHERE team_name = 'Team A'
group by team_name;
```
# if statement
```sql
SELECT 
    name,
    IF(age >= 18, 'Adult', 'Minor') AS AgeGroup
FROM users;
# if(conditon, value if ture, value if false)
```

# SUBQUERY

## Independent SUBQUERY

```sql
WHERE (home_goal+away_goal) > 
       (SELECT 3 * AVG(home_goal + away_goal)
        FROM matches_2013_2014); 
#两个column相加需要放进括号里
```
```sql
SELECT DISTINCT hometeam_id
FROM match
WHERE hometeam_id NOT IN (SELECT DISTINCT team_api_id
FROM team)
# subquery应该放在 not in的右边
```
subquery in where can only return single column.因为在where只能是单个column对比subquery的单个column

```sql
SELECT
    country,
    date,
    home_goal,
    away_goal
FROM
	(SELECT c.name AS country, 
     	  m.date, 
     		m.home_goal, 
     		m.away_goal,
       (m.home_goal + m.away_goal from match) AS total_goals
    FROM match AS m
    LEFT JOIN country AS c
    ON m.country_id = c.id) AS subq
WHERE total_goals >=10 ;
```

## Correlated subquery



==按行查询外部query，只有满足inner query where clause，才能触发内部查询，进而完成外部查询==

应用范围：==表内有层级， 多个item，多个order。item层属于order层， 属于同一个order的item1的值与item2的值进行对比==

以下是相关子查询执行顺序的详细步骤：

1. **执行外部查询**：首先执行外部查询的主表或视图，获取所有符合条件的行。
2. **传递值给子查询**：对于外部查询的每一行，将该行的相关列值传递给子查询。
3. **执行子查询**：子查询使用从外部查询传递的值作为条件，执行查询并返回结果。
4. **应用外部查询条件**：外部查询根据子查询返回的结果，应用 WHERE 子句中的条件，决定是否将当前行包含在最终结果集中。
5. **重复过程**：重复步骤 2-4，直到外部查询的所有行都被处理完毕。

记住 correlated subquery from table只包含一行的数据，不是整个表格。

```sql
-- 计算高于所属部门平均工资的员工信息
SELECT employee_id, salary
FROM employee e1
WHERE salary > (SELECT AVG (salary) FROM employee e2 WHERE e2. depart_name = e1. department_name)
# 执行顺序：
#1. 从 employee_id 1号开始，查询1号员工的所有信息只返回工号和工资
#2. 第一步查询到了一号员工的部门编号，外部查询将该编号通过where clause传递给inner query开始在e2查找部门平均工资。
#3. subquery执行完毕，与outerquery salary进行对比，满足条件可以保留 1号员工信息，不满足就不返回。
#3. 继续执行 employee_id 2,3,4,......

```

# CTE
```sql
 WITH home AS (
  SELECT m.id, m.date, 
  		 t.team_long_name AS hometeam, m.home_goal
  FROM match AS m
  LEFT JOIN team AS t 
  ON m.hometeam_id = t.team_api_id),

away AS (
  SELECT m.id, m.date, 
  		 t.team_long_name AS awayteam, m.away_goal
  FROM match AS m
  LEFT JOIN team AS t 
  ON m.awayteam_id = t.team_api_id)
SELECT id, date
FROM away
-- 有多个cte的时候，只需要用comma 不用从新加with
```

# WINDOW FUNCTION

`OVER`：指定窗口函数的计算范围。

## Rank Function
ROW_NUMBER(): 按指定顺序为每行生成唯一编号。
RANK(): 按排序字段排名，存在并列时跳过排名。122456
DENSE_RANK(): 与 RANK() 类似，但不跳过排名。1223456
NTILE(n): 将数据分为 n 个桶，返回每行的桶编号。normally don't use partition by in this statement

```sql
SELECT 
    employee_id,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    RANK() OVER (ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;
```
```sql
SELECT 
    employee_id, 
    name, 
    salary,
    NTILE(4) OVER (ORDER BY salary DESC) AS quartile
FROM employees;
```
## Aggregation Function
sum(salary) over()
avg(salary)over()
count(salary)over()
min(salary)over()
max(salary)over()
```sql
SELECT 
    employee_id,
    salary,
    SUM(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS running_total,
    AVG(salary) OVER (PARTITION BY department_id) AS avg_salary
FROM employees;
```
### Non- set windows

不分区，仅求和，跟没有使用windows function功能一样

假设有一张表 `sales`：

| emp_id | sale_date  | amount |
| ------ | ---------- | ------ |
| 1      | 2024-01-01 | 100    |
| 2      | 2024-01-02 | 200    |
| 3      | 2024-01-03 | 150    |
| 4      | 2024-01-04 | 250    |

```sql
SELECT emp_id, sale_date, amount,
       SUM(amount) OVER () AS total_amount
FROM sales;
```

**结果：**

| emp_id | sale_date  | amount | total_amount |
| ------ | ---------- | ------ | ------------ |
| 1      | 2024-01-01 | 100    | 700          |
| 2      | 2024-01-02 | 200    | 700          |
| 3      | 2024-01-03 | 150    | 700          |
| 4      | 2024-01-04 | 250    | 700          |

**解释**:

- `SUM(amount) OVER ()` 计算整个表中的总和（没有分区）。
- 每一行都会显示整个表的 `amount` 总和 **700**。

### Set windows partition by 

假设我们给 `sales` 表增加一个 `region` 列：

| emp_id | sale_date  | amount | region |
| ------ | ---------- | ------ | ------ |
| 1      | 2024-01-01 | 100    | East   |
| 2      | 2024-01-02 | 200    | East   |
| 3      | 2024-01-03 | 150    | West   |
| 4      | 2024-01-04 | 250    | West   |

```sql
SELECT emp_id, region, amount,
       SUM(amount) OVER (PARTITION BY region) AS region_total
FROM sales;
```

**结果：**

| emp_id | region | amount | region_total |
| ------ | ------ | ------ | ------------ |
| 1      | East   | 100    | 300          |
| 2      | East   | 200    | 300          |
| 3      | West   | 150    | 400          |
| 4      | West   | 250    | 400          |

**解释**:

- `PARTITION BY region` 将数据按照 `region` 分为两个分区（`East` 和 `West`）。
- 每个分区内分别计算 `SUM(amount)`。

### Moving aggregation（ `ORDER BY`）

1. 假设我们需要计算每天的销售累积和（按日期升序）。

**SQL 查询：**

```sql
SELECT emp_id, sale_date, amount,
       SUM(amount) OVER (ORDER BY sale_date) AS cumulative_sum
FROM sales;
```

**结果：**

| emp_id | sale_date  | amount | cumulative_sum |
| ------ | ---------- | ------ | -------------- |
| 1      | 2024-01-01 | 100    | 100            |
| 2      | 2024-01-02 | 200    | 300            |
| 3      | 2024-01-03 | 150    | 450            |
| 4      | 2024-01-04 | 250    | 700            |

**解释**:

- `ORDER BY sale_date` 按日期顺序排序。
- `SUM(amount) OVER (ORDER BY sale_date)` 计算累积和。

2. 指定窗口范围累积

```sql
SELECT emp_id, sale_date, amount,
       SUM(amount) OVER (ORDER BY sale_date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum
FROM sales;
```

**结果：**

| emp_id | sale_date  | amount | moving_sum |
| ------ | ---------- | ------ | ---------- |
| 1      | 2024-01-01 | 100    | 100        |
| 2      | 2024-01-02 | 200    | 300        |
| 3      | 2024-01-03 | 150    | 350        |
| 4      | 2024-01-04 | 250    | 400        |

**解释**:

- `ROWS BETWEEN 1 PRECEDING AND CURRENT ROW` 定义窗口范围为：当前行及前一行。
- 计算的是移动窗口内的和。

3. calculate the avg revenue 
```sql
SELECT 
    sale_date,
    revenue,
    AVG(revenue) OVER (
        ORDER BY sale_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg
FROM sales;

```

#### Customize moving windows
##### rows frame
grammer:
```sql
ROWS BETWEEN {start_bound} AND {end_bound}
```
Boundaries:
==UNBOUNDED PRECEDING==: Includes all rows before the current row.
==n PRECEDING==: Includes exactly n rows before the current row.
==CURRENT ROW==: Includes only the current row.
==n FOLLOWING==: Includes exactly n rows after the current row.
==UNBOUNDED FOLLOWING==: Includes all rows after the current row.

**示例：计算 3 天滚动销售和**

假设表 `sales` 有如下数据：
| sale_date  | amount |
| ---------- | ------ |
| 2024-01-01 | 100    |
| 2024-01-02 | 200    |
| 2024-01-03 | 300    |
| 2024-01-04 | 400    |
| 2024-01-05 | 500    |

``` sql
SELECT sale_date, amount,
       SUM(amount) OVER (
           ORDER BY sale_date 
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS rolling_sum
FROM sales;
```
**结果：**
| sale_date  | amount | rolling_sum |
| ---------- | ------ | ----------- |
| 2024-01-01 | 100    | 100         |
| 2024-01-02 | 200    | 300         |
| 2024-01-03 | 300    | 600         |
| 2024-01-04 | 400    | 900         |
| 2024-01-05 | 500    | 1200        |
**解释：**

```sql
  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```
- 当前行及前两行的 `amount` 之和。
- 严格基于行的偏移量，不关心 `sale_date` 的间隔是否连续。

##### Range frame
syntax:
```sql
RANGE BETWEEN {start_bound} AND {end_bound}
```
Boundaries:
UNBOUNDED PRECEDING: Includes all rows with values less than or equal to the ==current row’s value in the ORDER BY column(s).==
n PRECEDING: Includes all rows within n units of the current row’s value in the ORDER BY column(s).
CURRENT ROW: Includes only the rows with the same value as the current row in the ORDER BY column(s).
n FOLLOWING: Includes all rows within n units of the current row’s value in the ORDER BY column(s).
UNBOUNDED FOLLOWING: Includes all rows with values greater than or equal to the current row’s value in the ORDER BY column(s).

示例：计算同一天的累计销售和
假设表 `sales` 中有重复日期：
| sale_date  | amount |
| ---------- | ------ |
| 2024-01-01 | 100    |
| 2024-01-01 | 200    |
| 2024-01-02 | 300    |
| 2024-01-03 | 400    |
| 2024-01-03 | 500    |

```sql
SELECT sale_date, amount,
       SUM(amount) OVER (
           ORDER BY sale_date 
           RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_sum
FROM sales;
```
**结果：**
| sale_date  | amount | cumulative_sum |
| ---------- | ------ | -------------- |
| 2024-01-01 | 100    | 300            |
| 2024-01-01 | 200    | 300            |
| 2024-01-02 | 300    | 600            |
| 2024-01-03 | 400    | 1500           |
| 2024-01-03 | 500    | 1500           |
**解释：**

```sql
  RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```
- 按日期排序，==累加从最开始到当前== `sale_date` 的 `amount`。
- ==同一天的行会被视为一个整体，窗口自动扩展到包含相同的 `sale_date`。==
###### INTERVAL
```sql
SELECT 
    sale_date,
    revenue,
    SUM(revenue) OVER (
        ORDER BY sale_date
        RANGE BETWEEN INTERVAL 7 DAY PRECEDING AND CURRENT ROW
    ) AS weekly_revenue
FROM sales;
```
INTERVAL DAY, MONTH, YEAR, or even INTERVAL 0.5 HOUR.

##### ROWS BETWEEN vs RANGE BETWEEN

**`ROWS BETWEEN`**：基于行的偏移，
**`RANGE BETWEEN`**：基于order by列的值进行分组

## 值检索函数

FIRST_VALUE(): 获取窗口内第一行的值。
LAST_VALUE(): 获取窗口内最后一行的值。
NTH_VALUE(): 获取窗口内第 n 行的值。

```sql
SELECT 
    employee_id,
    salary,
    FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS first_salary,
    LAST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY employee_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_salary
FROM employees;
```
## 差值类函数 lag / lead

grammer:
```sql
LAG(column_name, offset, default_value) OVER (PARTITION BY partition_column ORDER BY order_column)
LEAD(column_name, offset, default_value) OVER (PARTITION BY partition_column ORDER BY order_column)
# offset：偏移量, default_value：如果超出窗口范围，返回的默认值（默认为 NULL）
```
```sql
SELECT 
    employee_id,
    salary,
    LAG(salary, 1) OVER (PARTITION BY department_id ORDER BY employee_id) AS previous_salary,
    LEAD(salary, 1) OVER (PARTITION BY department_id ORDER BY employee_id) AS next_salary
FROM employees;
```
# Pivot Table 
将 行数据转换为列 来进行汇总分析

![image-20250131121337851](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250131121337851.png)
```sql
SELECT 
    '2024' AS Year,
    SUM(CASE WHEN month = 'Jan' THEN amount ELSE 0 END) AS Jan,
    SUM(CASE WHEN month = 'Feb' THEN amount ELSE 0 END) AS Feb,
    SUM(CASE WHEN month = 'Mar' THEN amount ELSE 0 END) AS Mar
FROM sales;
```
# coalesce
填充null
```sql
COALESCE(value1, value2, ..., valueN)
# Returns the first non-NULL value 
# If all values are NULL, it returns NULL.
```

```sql
SELECT name, COALESCE(email, phone, 'No Contact') AS contact_info
FROM users;
# Returns email if available, otherwise phone, or 'No Contact' if both are NULL.
```

# Array
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

## Query JSON Arrays

## Get Nth Values
```sql
SELECT name, JSON_EXTRACT(hobbies, '$[0]') AS first_hobby 
FROM users;
```
## Get Specific Values
```sql
SELECT name 
FROM users 
WHERE JSON_CONTAINS(hobbies, '"Gaming"');
```
## Count number of values 
```sql
SELECT name, JSON_LENGTH(hobbies) AS hobby_count 
FROM users;
```

# Date & Time data type

## INTERVAL
INTERVAL is used to add or subtract time from dates, Works with DATE_ADD(), DATE_SUB(), and direct date arithmetic(+,-)
``` sql
SELECT
	rental_date,
	return_date,
	rental_date + INTERVAL 3 days AS expected_return_date
	# date_add(rental_date, INTERVAL 3 days) as expected_return_date
FROM rental;
```
### date_sub & date_add
can work with DATE, DATETIME, and TIMESTAMP values. They do not work with TIME

```sql
DATE_ADD(date, INTERVAL value unit)
DATE_SUB(date, INTERVAL value unit)
```
```sql
SELECT DATE_SUB('2024-01-30 14:25:45', INTERVAL 3 HOUR) AS new_datetime;
```

## TIMESTAMP & DATE TIME
### year(), month(), day()
YEAR(), MONTH(), DAY(), HOUR(), MINUTE(), SECOND(), all return integers in MySQL
 ```sql
WHERE YEAR(submit_time) < 2021
 ```
#### week()
```sql
SELECT WEEK('2024-01-30', 1);  -- ISO standard week number, starting from Monday
SELECT WEEK('2024-01-30')# default 0, week start from sunday
```
#### dayofweek()
```sql
SELECT * FROM orders WHERE DAYOFWEEK(order_date) = 1;  -- Sunday
````
### date(), time()
```sql
SELECT DATE('2025-01-30 14:45:30'); -- Output: 2025-01-30
```
```sql
SELECT TIME('2025-01-30 14:45:30'); -- Output: 14:45:30
```
### Current
#### NOW()
current timestamp
```sql
SELECT NOW(); -- Output: 2025-01-30 14:45:30
```
#### CURDATE()
current date only
```sql
SELECT CURDATE(); -- Output: 2025-01-30
```
#### CURTIME()
```sql
SELECT CURTIME(); -- Output: 14:45:30
```
### TIMESTAMPDIFF
```sql
TIMESTAMPDIFF(unit, start_time, end_time)
```
  - SECOND 秒
  - MINUTE 分钟（返回秒数差除以60的整数部分）
  - HOUR 小时（返回秒数差除以3600的整数部分）
  - DAY 天数（返回秒数差除以3600*24的整数部分）
  - MONTH 月数
  - YEAR 年数

### date_format()
format a DATETIME or TIMESTAMP value into a specific string format.
```sql
DATE_FORMAT(date, format)
```
- `%y`：两位数的年份（00-99）。%Y四位数年份
- `%m`：两位数的月份（01-12）。
- `%d`：两位数的一个月中的第几天（01-31）



## EXTRACT
Could apply to datetime, timestamp and even interval 
syntax:
```sql
extract (unit from data_value)
```
![image-20250131184259737](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250131184259737.png)
```sql
SELECT 
    EXTRACT(YEAR FROM '2024-01-30') AS year_part,
    EXTRACT(MONTH FROM '2024-01-30') AS month_part,
    EXTRACT(DAY FROM '2024-01-30') AS day_part;
    EXTRACT(WEEK FROM '2024-01-30') AS week_number,
    EXTRACT(DAYOFYEAR FROM '2024-01-30') AS day_of_year;
    EXTRACT(HOUR FROM '2024-01-30 14:25:45') AS hour_part,
    EXTRACT(MINUTE FROM '2024-01-30 14:25:45') AS minute_part,
    EXTRACT(SECOND FROM '2024-01-30 14:25:45') AS second_part;
    EXTRACT(YEAR FROM NOW()) AS current_year;
```
syntax:

```sql
EXTRACT(unit FROM INTERVAL 'X value')
```
```sql
SELECT 
    EXTRACT(YEAR FROM INTERVAL '5 years 3 months') AS years_part,
    EXTRACT(MONTH FROM INTERVAL '5 years 3 months') AS months_part;
```

## convert date to timestamp
:: operator is shorthand for the CAST() function, which converts a value from one data type to another.
### with default time 
```sql
SELECT CAST('2024-01-30' AS DATETIME) AS timestamp_value;
```
```sql
SELECT CONVERT('2024-01-30', DATETIME) AS timestamp_value;
```
### Adding specific time manually

append a specific time to a DATE
```sql
SELECT CONCAT(date_column, ' 14:30:00')::timestamp AS timestamp_value
```

# String

## concat

Rule: concat not-null values

Syntax:

```sql
CONCAT(string1, string2, ..., string 
```
### concat_ws

```sql
SELECT CONCAT_WS('-', '2024', '01', '30') AS formatted_date;
```
### group_concat

Syntax:
```sql
GROUP_CONCAT([DISTINCT] expression
             [ORDER BY expression [ASC | DESC]]
             [SEPARATOR string_separator])
             # default separator is comma
```
```sql
SELECT
    user_no,
    GROUP_CONCAT( DISTINCT role_name ORDER BY role_id desc ) AS role_name
FROM
    report_user_role_info 
GROUP BY
    user_no;
```
## Extract substring

### left(), right()
extract a specific number of characters from a string.
syntax:
```sql
LEFT(string, length)
RIGHT(string, length)
```
``` sql
 LEFT(description, 50 - 
    -- Subtract the position of the first whitespace character
    position(
      ' ' IN REVERSE(LEFT(description, 50))
    )
  ) 
```
### substring()
syntax:
```sql
SUBSTRING(string, start_position, length)
# if length is omitted, the function returns the substring from the start position to the end of the string.
```
or 
```sql
SUBSTRING(string FROM start_position [FOR length])
```
```sql
SELECT SUBSTRING('Hello World' FROM 1 FOR 5);  
-- Output: 'Hello' (Extracts 5 characters starting from position 1)
```
```sql
SELECT name, CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS formatted_name
FROM employees;
```
```sql
SELECT SUBSTRING('user@example.com', INSTR('user@example.com', '@') + 1) AS domain;
## output: example.com
```
### substring_index()
extract substring before a specific number of delimiter from a string
```sql
SUBSTRING_INDEX(string, delimiter, count)
```
```sql
SELECT SUBSTRING_INDEX('www.example.com', '.', 2) AS result;
### www.example
SELECT SUBSTRING_INDEX('www.example.com', '.', -1) AS result;
### com
```
## position 

### position()
syntax:
```sql
POSITION(substring IN string)
# returns the position of the first occurrence of the substring
```
```sql
SELECT POSITION('SQL' IN 'MySQL Database');  -- Output: 3
```
### instr()
returns the index of the substring
syntax:
```sql
INSTR(string, substring)
```
```sql
SELECT INSTR('Hello, World!', 'World') AS position;
# output: 8
```
## trim()  ltrim() rtrim()

```sql
SELECT TRIM('   MySQL   ');  
-- Output: 'MySQL'  (Both leading and trailing spaces removed)
SELECT LTRIM('   MySQL');  
-- Output: 'MySQL'  (Leading spaces removed)

SELECT RTRIM('   MySQL   ');  
-- Output: '   MySQL'  (Trailing spaces removed)
```
## lpad() rpad()
syntax:
```sql
LPAD(string, length, pad_string)
#string: The original string.
#length: The total length of the final padded string.
#pad_string: The characters used for padding.
#string will be padded with a space by default
```
```sql
SELECT LPAD('MySQL', 10, '*');  
-- Output: '*****MySQL'  (Pads with `*` to make it 10 characters long)
```

## Others

### upper() lower()

```sql
select upper(email)
from customer;
```
```sql
select lower(title)
from film;
```
### replace()
```sql
select replace(description, 'a astouding','an astouding')as description
from film;
```
### reverse()

```sql
select title,
       reverse(title)
from film;       
```
### char_length()
returns the number of characters in a string
```sql
SELECT CHAR_LENGTH('Hello World');  
-- Output: 11
```
# MODIFY RECORD

## insert record

```sql
insert into films
     values('yojimbo',2016, 'drama')
```

插入记录的方式汇总：

- 普通插入（全字段）：INSERT INTO table_name VALUES (value1, value2, ...)
- 普通插入（限定字段）：INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...)
- 多条一次性插入：INSERT INTO table_name (column1, column2, ...) VALUES (value1_1, value1_2, ...), (value2_1, value2_2, ...), ...
- 主键若没有则插入，若存在则忽略 insert ignore into
- 从另一个表导入：INSERT INTO table_name SELECT * FROM table_name2 [WHERE key=value]
- 带更新的插入：REPLACE INTO table_name VALUES (value1, value2, ...) （注意这种原理是检测到主键或唯一性索引键重复就删除原记录后重新插入）

==自增主键可直接设置为NULL或0或DEFAULT==:

```sql
REPLACE INTO examination_info VALUES(NULL, 9003, "SQL", "hard", 90, "2021-01-01 00:00:00");
```

## delete & truncate record

- 根据条件删除：

  ```sql
  DELETE FROM tb_name [WHERE options] [ [ ORDER BY fields ] LIMIT n ]
  ```

- 全部删除（表清空，包含自增计数器重置）：TRUNCATE tb_name ==`TRUNCATE` 是 SQL 中的一个命令，用于快速删除表中的所有行，并重置任何自增计数器（如自增主键）。==

1. **清空数据**：`TRUNCATE` 会删除表中的所有数据，但不会删除表本身。
2. **重置自增计数器**：在大多数数据库系统中，==`TRUNCATE` 会重置自增计数器，使其从 1 开始。==但是，这个行为可能因数据库系统而异。
3. **不可恢复**：与 `DELETE` 操作不同，`TRUNCATE` 操作是不可恢复的，一旦执行，表中的数据将永久丢失。

```sql
DELETE FROM examination_info WHERE exam_id=9003;
INSERT INTO examination_info (exam_id, tag, difficulty, duration, release_time) VALUES
 (9003, "SQL", "hard", 90, "2021-01-01 00:00:00")
```

## update record

- 根据限定条件更新record

```sql
update exam_record
set submit_time = '2099-01-01 00:00:00', score = 0
where date(start_time) < '2021-09-01' and score is null;
```

+ 根据已有值替换：UPDATE table_name SET key1=replace(key1, '查找内容', '替换成内容') [WHERE column_name3=value3]

```sql
update examination_info
set tag = replace (tag, 'PYTHON', 'Python');
```

```sql
update examination_info
set tag = replace (tag, 'PYTHON', 'Python')
where tag like '%PYTHON%';
```

此外，`WHERE` 子句中的 `LIKE "%PYTHON%"` 确保只有包含 'PYTHON' 子串的记录会被更新。这样，即使 `REPLACE` 函数可以直接使用 'PYTHON' 作为参数，也只会对那些满足条件的记录进行操作。这种使用方式不仅可用于整体替换，还能做子串替换，例如要实现将 `tag` 中所有的 'PYTHON' 替换为 'Python'（如 CPYTHON => CPython），可写作上述 SQL 语句。

# MODIFY TABLE

## create table

- 1.1 直接创建表：

```sql
CREATE TABLE[IF NOT EXISTS] tb_name -- 不存在才创建，存在就跳过
(column_name1 data_type1 -- 列名和类型必选
 [ PRIMARY KEY -- 可选的约束，主键
 | FOREIGN KEY -- 外键，引用其他表的键值
 | AUTO_INCREMENT -- 自增ID
 | COMMENT comment -- 列注释（评论）
 | DEFAULT default_value -- 默认值
 | UNIQUE -- 唯一性约束，不允许两条记录该列值相同
 | NOT NULL -- 该列非空
 ])
 [CHARACTER SET charset] -- 字符集编码
 [COLLATE collate_value] -- 列排序和比较时的规则（是否区分大小写等）
```

- 1.2 从另一张表复制表结构创建表： `CREATE TABLE tb_name LIKE tb_name_old`
- 1.3 从另一张表的查询结果创建表： `CREATE TABLE tb_name AS SELECT * FROM tb_name_old WHERE options`

## update table

- 2.1 修改表：`ALTER TABLE 表名 修改选项` 。选项集合：

```sql
alter table name1
{ ADD COLUMN <列名> <类型>[first/after <列名>] -- 增加列
| CHANGE COLUMN <旧列名> <新列名> <新列类型> -- 修改列名或类型
| MODIFY COLUMN <列名> <类型> -- 修改列类型{ DEFAULT <默认值> | DROP DEFAULT } -- 修改/删除 列的默认值 添加或移除 NOT NULL
| DROP COLUMN <列名> -- 删除列
| RENAME TO <新表名> -- 修改表名
| CHARACTER SET <字符集名> -- 修改字符集
| COLLATE <校对规则名> } -- 修改校对规则（比较和排序时用到）
|ADD CONSTRAINT FOREIGN KEY (column1)REFERENCES table 1(column2);
```

==alter column & modify column区别素？？？==

Alter column for postgresql, modify column for mysql

```sql
alter table actor ADD COLUMN create_date datetime NOT NULL default '2020-10-01 00:00:00' AFTER last_updates
```
### 修改列的数据类型和添加no tnull：

```sql
ALTER TABLE employees
MODIFY COLUMN salary DECIMAL(10, 2) NOT NULL;
==需要指定列类型
```

### 修改列的默认值：

```sql
ALTER TABLE employees
MODIFY COLUMN salary INT DEFAULT 4000;
==需要指定列类型
```
### 调整列的位置（在 MySQL 中特有
```sql
ALTER TABLE employees
MODIFY COLUMN salary INT AFTER emp_name;
==需要指定列类型
```
### 创建外键约束

```sql
ALTER TABLE audit
ADD CONSTRAINT FOREIGN KEY (emp_no)
REFERENCES employees_test(id);
```

**创建外键语句结构：**

ALTER TABLE <表名>

ADD CONSTRAINT FOREIGN KEY **(**<列名>**)**

REFERENCES <关联表>**（**关联列**）**

## delete table

- 3.1 删除表：`DROP TABLE [IF EXISTS] 表名1 [ ,表名2]`

# INDEX

## create index

- 1.1 create方式创建索引：

```sql
CREATE
[UNIQUE -- 唯一索引
| FULLTEXT -- 全文索引] 
INDEX index_name ON table_name -- 不指定唯一或全文时默认普通索引
(column1[(length) [DESC|ASC]] [,column2,...]) -- 可以对多列建立组合索引 

```

```sql
create index idx_duration on examination_info(duration);
== 表名后面不能有空格
create unique index uniq_idx_exam_id on examination_info(exam_id);
create fulltext index full_idx_tag on examination_info(tag);
```

- 1.2 alter方式创建索引：`ALTER TABLE tb_name ADD [UNIQUE | FULLTEXT] [INDEX] index_content(content)`
## drop index

- 2.1 drop方式删除索引：`DROP INDEX <索引名> ON <表名>`

- 2.2 alter方式删除索引：`ALTER TABLE <表名> DROP INDEX <索引名>`

## force index
```sql
SELECT * 
FROM salaries FORCE INDEX (idx_emp_no) 
WHERE emp_no = 10005;
```

# VIEW

## create view

### **1. 创建视图**

假设有一张员工表 `employees`：

```sql
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary INT,
    department VARCHAR(50)
);
```

我们可以创建一个视图 `high_salary_employees`，用于显示薪资大于 5000 的员工：

```sql
CREATE VIEW high_salary_employees AS
SELECT emp_no, first_name, last_name, salary
FROM employees
WHERE salary > 5000;
```

### **2. 查询视图**

创建后，可以像查询表一样查询视图：

```sql
SELECT * FROM high_salary_employees;
```

## drop view

```sql
drop view if exists high_salary_employees1, high_salary_employees12, high_salary_employees13
```

**![image-20241202085224420](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202085224420.png)**

== the cascade parameter indicates both should be dropped

## redefining a view

**![image-20241202085427175](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202085427175.png)**

## alter a view

**![image-20241202085637832](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202085637832.png)**

# materialized view

![image-20241202094925464](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202094925464.png)

```sql
Refresh materialized view  genre_count;

SELECT * FROM genre_count;
```

## TRIGGER

```sql
create trigger triggerName      
    after/before/        // 触发时间 trigger_time
    insert/update/delete // 监视事件 trigger_event
    on table_name        // 监视地点 table
    for each row         // 这句话在mysql中是固定的
    begin
    sql语句(insert/update/delete);             // 触发事件  trigger_stmt 注意这里要有分号
    end;

```

```sql
CREATE TRIGGER audit_log
AFTER INSERT ON employees_test
FOR EACH ROW
BEGIN
    INSERT INTO audit (EMP_no, NAME) 
    VALUES (NEW.ID, NEW.NAME);
END;
==new表示新被插入的数据
```

# full text search

### to_tsvector(column_name)@@to_tsquery('keywords')

```sql
== Perform a full-text search on the title column for the word elf.
SELECT title, description
FROM film
-- Convert the title to a tsvector and match it against the tsquery 
WHERE to_tsvector(title) @@ to_tsquery('elf');
```

## AUTO_INCREMENT

在 SQL 中，自增 ID（AUTO_INCREMENT）是一种特殊的列属性，用于自动为新记录生成唯一的数字标识符。这种属性通常用于主键列，以确保每条记录都有一个唯一的标识符。自增 ID 在插入新记录时自动增加，无需手动指定值。

以下是一些关于 SQL 自增 ID 的关键点：

1. **定义自增列**：在创建表时，可以指定某个列作为自增列。例如，在 MySQL 中，可以这样定义：

   sql

   ```sql
   CREATE TABLE users (
       id INT NOT NULL AUTO_INCREMENT,
       username VARCHAR(50) NOT NULL,
       PRIMARY KEY (id)
   );
   ```

   在这个例子中，`id` 列被定义为自增列，并且是表的主键。

   

2. **插入记录**：当插入新记录时，如果未指定自增列的值，数据库将自动为其分配下一个可用的数值。

   sql

   ```sql
   INSERT INTO users (username) VALUES ('newuser');
   ```

   在这个例子中，`id` 列的值将自动生成。

   3. 自增列的限制：自增列必须是整数类型（例如 INT、SMALLINT 等），并且表中只能有一个自增列。

   4. 重置自增列

      您可以使用 `ALTER TABLE` 语句来重置自增列的初始值。例如，如果您想要将 `examination_info` 表的 `exam_id` 列的自增值重置为 1，您可以使用以下命令：

      sql

      ```sql
      ALTER TABLE examination_info AUTO_INCREMENT = 1;
      ```

      请注意，这将影响表中的所有自增列，而不仅仅是 `exam_id` 列。

## create type user defined data type as enum('','','')

## database design

#### conceptual diagram logic schema

### fact table dimension table

![image-20241202201548350](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202201548350.png)





## data design

### oltp and olap

**![image-20241128160901738](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241128160901738.png)**

**![image-20241128160755916](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241128160755916.png)**

### etl and elt

**![image-20241128164134057](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241128164134057.png)**

### data modeling

**![image-20241128165035919](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241128165035919.png)**

**![image-20241128170652838](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241128170652838.png)**

### 3nf normalization

## database view

Not all the views could be updated or inserted, just use views for read-only purposes

```sql
create view view_name as 
  select * from table;
  == check the views of the database
  select*
  from information_schema.views
  where table_schema NOT IN ('pg_catalog', 'information_schema')
  ==check the views  created by you and excluede the system views
```

### Grant to revoke from

```sql
grant update, insert on rating to public
revoke update, insert on department from db_users;
```
## create role

**![image-20241202100057170](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202100057170.png)**

` create role marta login`

Created means ability to create databases

`alter role admin createrole;`

change the ability of admin to create a role also

### grant or revoke privileges 

![image-20241202100351848](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202100351848.png)

### user role and group role

![image-20241202100538927](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202100538927.png)

```sql
revoke data_analytist from alex;
```

## database partitioning

### vertical partitioning, split columns

![image-20241202101933988](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202101933988.png)

### horizontal partitioning

  ![image-20241202102509888](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202102509888.png) 

**![image-20241202102754563](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241202102754563.png)**

## data integration

 
