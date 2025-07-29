# parentheses

```sql
SELECT prod_id, prod_price, (0.9 * prod_price) AS sale_price
FROM Products;
```

==(0.9 * prod_price)==有数字最好放括号里

# <=

不超过10美元 price<=10 确定界限有没有等号

```sql
SELECT order_num
FROM OrderItems
GROUP BY order_num
HAVING SUM(quantity)>=100
ORDER BY order_num ASC;
```

group by用having进行筛选，其位置在group by之后。

# 区别汇总和单一订单

OrderItems表代表订单信息，包括字段：订单号order_num和item_price商品售出价格、quantity商品数量。

| order_num | item_price | quantity |
| --------- | ---------- | -------- |
| a1        | 10         | 105      |
| a2        | 1          | 1100     |
| a2        | 1          | 200      |
| a4        | 2          | 1121     |
| a5        | 5          | 10       |
| a2        | 1          | 19       |
| a7        | 7          | 5        |

【问题】编写 SQL 语句，根据订单号聚合，返回订单总价不小于1000 的所有订单号，最后的结果按订单号进行升序排序。

【示例结果】

| order_num | total_price |
| --------- | ----------- |
| a1        | 1050        |
| a2        | 1319        |
| a4        | 2242        |

```sql
==正确答案
select order_num, sum(item_price*quantity) as total_price
from OrderItems
group by order_num
having sum(item_price*quantity)>=1000
order by order_num
== 第一次答案
select order_num, (item_price*quantity) as total_price
from OrderItems
group by order_num
having (item_price*quantity)>=1000
order by order_num
# having 需要筛选聚合函数表达式，没有group by的列都要用聚合函数
# 汇总需要用sum
==解析： 每个 order_num 可能对应多个不同的 item_price 和 quantity 值，所以 (item_price * quantity) 并不是一个确定的值。
你需要在 SELECT 子句中使用聚合函数来计算每个 order_num 的总价格，然后在 HAVING 子句中过滤这些聚合结果。
```

# 相关子查询

1. ==相关子查询==牛客sql应知应会94题。我们需要一个顾客 ID 列表，其中包含他们已订购的总金额。

OrderItems表代表订单信息，OrderItems表有订单号：order_num和商品售出价格：item_price、商品数量：quantity。

![img](https://uploadfiles.nowcoder.com/images/20241104/0_1730709293453/A4AC046D4A007FA9669242AF79E32B01)
Orders表订单号：order_num、顾客id：cust_id

![img](https://uploadfiles.nowcoder.com/images/20241104/0_1730709309569/72CD304B563DDB362EE01E3B5FEE9288)

 【问题】

编写 SQL语句，返回顾客 ID（Orders 表中的 cust_id），并使用子查询返回total_ordered 以便返回每个顾客的订单总金额，将结果按金额从大到小排序。

```sql
select cust_id, (select sum(item_price*quantity)
                 from OrderItems oi 
                 where oi.order_num IN (select order_num # OUTERQUERY返回用户id， 最里面subquery查询该用户id的所有订单号，中间的query累加这些订单号的金额
                                        from Orders o2 
                                        where o2.cust_id = o1.cust_id)) as total_ordered
from Orders o1
order by total_ordered desc;

```
2. 找出每个客户的订单号，条件是该订单的总金额大于该客户所有订单的平均总金额。

1. Orders 表
存储订单的基本信息：

字段名	数据类型	描述
order_num	INT	订单号（主键）
customer_id	INT	客户ID
order_date	DATE	订单日期
2. OrderItems 表
存储每个订单的商品信息：

字段名	数据类型	描述
order_num	INT	订单号（外键）
item_id	INT	商品ID
item_price	DECIMAL(10, 2)	商品价格
quantity	INT	商品数量
category_id	INT	商品类别ID
```sql
# 思路
select customer_id, order_num
from Orders o1
# 该订单总金额
select sum(item_price*quantity)
from OrderItems oi
where o1.order_num = oi.order_num
# 该客户所有订单的平均金额
select avg(order_amount)
from (select sum(item_price*quantity) as order_amount
       from OrderItems
       where order_num IN (select order_num
                           from Orders o2 where o2.customer_id = o1.customer_id)
group by order_num)
```
```sql
select customer_id, order_num
from Orders o1
where (select sum(item_price*quantity)
       from OrderItems oi
       where o1.order_num = oi.order_num)> (select avg(order_amount)
                                            from (select              sum(item_price*quantity) as order_amount
                                                  from OrderItems
                                                  where order_num IN (select order_num from Orders o2 where o2.customer_id = o1.customer_id )
                                                  group by order_num
                                                  ) as t1);
```
# UNION

1. 表OrderItems包含订单产品信息，字段prod_id代表产品id、quantity代表产品数量

| prod_id | quantity |
| ------- | -------- |
| a0001   | 105      |
| a0002   | 100      |
| a0002   | 200      |
| a0013   | 1121     |
| a0003   | 10       |
| a0003   | 19       |
| a0003   | 5        |
| BNBG    | 10002    |

【问题】

将两个 SELECT 语句结合起来，以便从 OrderItems表中检索产品 id（prod_id）和 quantity。其中，一个 SELECT 语句筛选出数量为 100 的行，另一个 SELECT 语句筛选出 id 以 BNBG 开头的产品，最后按产品 id 对结果进行升序排序。

   ```sql
   SELECT prod_id, quantity
   FROM OrderItems
   WHERE quantity = 100
   UNION
   SELECT prod_id, quantity
   FROM OrderItems
   WHERE prod_id LIKE 'BNBG%'
   ORDER BY prod_id ASC;
   ```
==union去重，union all不去重==
==UNION 会先将所有子查询的结果合并，再处理排序==子查询语句中不能使用orderby,只能在union查询最后使用。

2. 现有牛客职位信息表 ，请查询职位城市在北京的job_id和company_id，与职位工资高于100000的job_id和company_id，二者合并输出==不去重==，查询返回结果名称和顺序为job_id|company_id

```sql
SELECT job_id, company_id
FROM job_info
WHERE job_city = '北京'
UNION ALL 
SELECT job_id, company_id
FROM job_info
WHERE salary > 100000;
```

==UNION去重，union all保留所有不去重==

# Order by

==在 `ORDER BY` 子句中，`CASE` 表达式可以用来根据条件动态调整查询结果的排序规则。==

牛客顾客购买信息表`customers_info`，请按城市对客户进行排序,如果城市为空，则按国家排序，返回全部字段

![img](https://uploadfiles.nowcoder.com/images/20220816/0_1660618848686/F8BAD4BF0D08CAA5EC5E3E28353944E4)

```sql
select *
from customers_info
order by case when city is not null then city else country end
```

# Count()

11. 牛客顾客购买信息表`customers_info`

    按年龄给客户分群（age_group 分为 '20以下' ，'20-50' ， '50以上'，'未填写' 四个群体）,并计算各群体人数并命名为 user_count

![img](https://uploadfiles.nowcoder.com/images/20220816/0_1660618848686/F8BAD4BF0D08CAA5EC5E3E28353944E4)

```sql
== 错误答案：
SELECT
    CASE
        when age is null then '未填写'
        WHEN age < 20 then '20以下'
        when age between 20 and 50  then '20-50'
        WHEN age > 50 then '50以上'
    END as age_group,
    count(age) as user_count
from
    customers_info
group by age_group
# the answer is not correct, cause count only calculate the not null value
== 正确答案
SELECT
    CASE
        when age is null then '未填写' # 建议让sql优先捕获空值
        WHEN age < 20 then '20以下'
        when age between 20 and 50  then '20-50'
        WHEN age > 50 then '50以上'
    END as age_group,
    count(*) as user_count
from
    customers_info
group by age_group
```

==count()不能选有空值的列，会出现计算遗漏，要选择primary key==

# 计算前两名

现有牛客刷题表`questions_pass_record`，请查询每天刷题通过数最多的前二名用户id和刷题数，输出按照日期升序排序，查询返回结果名称和顺序为

```sql
date|user_id|pass_count
```

![img](https://uploadfiles.nowcoder.com/images/20220824/0_1661353149773/3BC2E4B36624EAD34C1A5A35AE46AF1C)

```sql
select
    date,
    user_id,
    pass_count
from
    (
        select
            date,
            user_id,
            pass_count,
            dense_rank() over (
                partition by
                    date
                order by
                    pass_count desc
            ) as rank_num
        from
            questions_pass_record
    )as filter_table
WHERE rank_num <= 2
order by date;
```
` dense_rank()over(partition by date==同一天为一组数据order by pass_count desc==在同一组数据内根据count进行排序)` 

# 时间函数

牛客购买点击表user_ad_click_time, 支付成功表`user_payment_time`，输出在5min内完成点击并购买的用户ID(倒排），查询返回结果名称和顺序为
    
```sql

uid
```

![img](https://uploadfiles.nowcoder.com/images/20220818/0_1660805577532/2F578617ED872BA563168EDA5931CCB9)user_ad_click_time

user_payment_time

![img](https://uploadfiles.nowcoder.com/images/20220818/0_1660805999427/1F295BB48B40374BA82130626BC4445A)

```sql
select p.user_id as uid
from user_ad_click_time as c
inner join user_payment_time as p
on c.trace_id = p.trace_id and c.user_id = p.user_id
where p.pay_time <= date_add(c.click_time, interval 5 minute)
order by uid desc;
```

```sql
select p.user_id as uid, pay_time, click_time
from user_ad_click_time as c
inner join user_payment_time as p
on c.trace_id = p.trace_id and c.user_id = p.user_id
where timestampdiff(minute, c.click_time, p.pay_time)  <5
order by uid desc;
```

==由于 `TIMESTAMPDIFF()` 函数是减法操作，即第二个参数减去第一个参数==

# 匹配文本

```sql
select *
from attendance
where comment regexp '^(是)'
```
## 1. 匹配唯一字段
```sql
select *
from scatter_table
where name regexp 'pattern'
# 返回任何name列中有pattern字段的行
```
```sql
## 2.行开头匹配唯一字段
sql
select *
from employee
where comment regexp '^pattern'
# 返回任何comment开头有pattern的行
```

## 3. 行开头匹配多个字段
```sql
sql
select * 
from employee
where name regexp '^(Annie|Binnie|Cinnie)'
# |分管符是或的意思
```


## 4. 行末尾匹配多个字段
```sql
select *
from employee
where name regexp '(y|z|x)$'
```

## 5. 匹配任意字符
```sql
select *
from employee
where name regexp '[A-Za-z]'
# 只要名字内有字母的不管大写小写都返回
```

## 6. 匹配任意数字
```sql
select *
from employee
where telephone regexp '[0-9]'
# 只要 telephone列有数字的都返回
```

## 7. 模糊匹配之值不知道是什么，确定只有一个字符
```sql
select *
from 
where name regexp '.nnie'
# 可以是 annie, bnnie, cnnie,1nnie
```

## 8. 模糊匹配之中间值0个或多个
```sql
select *
from employee
where telephone regexp '10*08129'
# *匹配0 0次或多次 1008129 或者1000000008129
```

## 9. 模糊匹配之中间值是一个或者0个
```sql
select *
from employee
where telephone regexp '800?08129'
# ?匹配前一个字符0次或一次 80008129或者800008129
```

## 10 模糊匹配之中间值是1个或多个
```sql
select *
from employee
where telephone regexp '80+08129'
# 匹配0 1个或者多个 80008129 或者8000008129
```


每日访问记录为表格 user_visit_log，用户id已去重，请输出日活与每日次日留存率。 

![img](https://uploadfiles.nowcoder.com/images/20220824/0_1661354614154/D7A7FFDB62DC310A6A10EBEAACD9999C)

```sql
visit_date|dau|next_day_per
```

```sql
select a.visit_date,count(a.id) as dau, count(b.id)/count(a.id) as next_day_per
from user_visit_log a 
left join user_visit_log b
on a.id=b.id and timestampdiff(day, a.visit_date, b.visit_date) 
== 相当于在a表基础上通过a,b交集或者交集条件做一张表b，再根据表ab里的值进行计算
group by a.visit_date
```

16. 牛客后台会记录每个用户的试卷作答记录到exam_record表，现在有两个用户的作答记录详情如下：

    - 用户1001在2021年9月1日晚上10点11分12秒开始作答试卷9001，并在50分钟后提交，得了90分；
    - 用户1002在2021年9月4日上午7点1分2秒开始作答试卷9002，并在10分钟后退出了平台。

    试卷作答记录表exam_record中，表已建好，其结构如下，请用一条语句将这两条记录插入表中。

    | Filed       | Type       | Null | Key  | Extra          | Default | Comment  |
    | ----------- | ---------- | ---- | ---- | -------------- | ------- | -------- |
    | id          | int(11)    | NO   | PRI  | auto_increment | (NULL)  | 自增ID   |
    | uid         | int(11)    | NO   |      |                | (NULL)  | 用户ID   |
    | exam_id     | int(11)    | NO   |      |                | (NULL)  | 试卷ID   |
    | start_time  | datetime   | NO   |      |                | (NULL)  | 开始时间 |
    | submit_time | datetime   | YES  |      |                | (NULL)  | 提交时间 |
    | score       | tinyint(4) | YES  |      |                | (NULL)  |          |

    该题最后会通过执行SELECT uid, exam_id, start_time, submit_time, score FROM exam_record;来对比结果

    ```sql
    insert into exam_record (uid, exam_id, start_time, submit_time, score )value ('1001', '9001', '2021-09-01 22:11:12', date_add('2021-09-01 22:11:12', interval 50 minute), '90' ), ('1002', '9002', '2021-09-04 07:01:02', null, null)
    ```

    ==插入两条信息中间用comma相连两个括号==

    ==ta b le()放入插入records的column name==

    ==不要人工计算时间，用date_add==

    17. 现在有一套ID为9003的高难度SQL试卷，时长为一个半小时，请你将 2021-01-01 00:00:00 作为发布时间插入到试题信息表examination_info（其表结构如下图），不管该ID试卷是否存在，都要插入成功，请尝试插入它。

        试题信息表examination_info：
    
        | Filed        | Type        | Null | Key  | Extra          | Default | Comment      |
        | ------------ | ----------- | ---- | ---- | -------------- | ------- | ------------ |
        | id           | int(11)     | NO   | PRI  | auto_increment | (NULL)  | 自增ID       |
        | exam_id      | int(11)     | NO   | UNI  |                | (NULL)  | 试卷ID       |
        | tag          | varchar(32) | YES  |      |                | (NULL)  | 类别标签     |
        | difficulty   | varchar(8)  | YES  |      |                | (NULL)  | 难度         |
        | duration     | int(11)     | NO   |      |                | (NULL)  | 时长(分钟数) |
        | release_time | datetime    | YES  |      |                | (NULL)  | 发布时间     |

```sql
replace into examination_info
values ('0', '9003', 'SQL', 'hard', '90', ' 2021-01-01 00:00:00')
```

18. 现有一张试卷作答记录表exam_record，其中包含多年来的用户作答试卷记录，结构如下表：

    **作答记录表exam_record：**

    start_time是试卷开始时间

    submit_time 是交卷时间，即结束时间，如果未完成的话，则为空

    | Filed       | Type       | Null | Key  | Extra          | Default | Comment  |
    | ----------- | ---------- | ---- | ---- | -------------- | ------- | -------- |
    | id          | int(11)    | NO   | PRI  | auto_increment | (NULL)  | 自增ID   |
    | uid         | int(11)    | NO   |      |                | (NULL)  | 用户ID   |
    | exam_id     | int(11)    | NO   |      |                | (NULL)  | 试卷ID   |
    | start_time  | datetime   | NO   |      |                | (NULL)  | 开始时间 |
    | submit_time | datetime   | YES  |      |                | (NULL)  | 提交时间 |
    | score       | tinyint(4) | YES  |      |                | (NULL)  | 得分     |

请删除exam_record表中未完成作答或作答时间小于5分钟整的记录中，开始作答时间最早的3条记录。

```sql
delete from exam_record
where submit_time is null or timestampdiff(minute, start_time, submit_time ) < 5
order by start_time asc
limit 3;
```

19. 牛客的运营同学想要查看大家在SQL类别中高难度试卷的得分情况。

    请你帮她从exam_record数据表中计算所有用户完成SQL类别高难度试卷得分的截断平均值（去掉一个最大值和一个最小值后的平均值）。

    示例数据：examination_info（exam_id试卷ID, tag试卷类别, difficulty试卷难度, duration考试时长, release_time发布时间）

    | id   | exam_id | tag  | difficulty | duration | release_time        |
    | ---- | ------- | ---- | ---------- | -------- | ------------------- |
    | 1    | 9001    | SQL  | hard       | 60       | 2020-01-01 10:00:00 |
    | 2    | 9002    | 算法 | medium     | 80       | 2020-08-02 10:00:00 |

    示例数据：exam_record（uid用户ID, exam_id试卷ID, start_time开始作答时间, submit_time交卷时间, score得分）

    | id   | uid  | exam_id | start_time          | submit_time         | score  |
    | ---- | ---- | ------- | ------------------- | ------------------- | ------ |
    | 1    | 1001 | 9001    | 2020-01-02 09:01:01 | 2020-01-02 09:21:01 | 80     |
    | 2    | 1001 | 9001    | 2021-05-02 10:01:01 | 2021-05-02 10:30:01 | 81     |
    | 3    | 1001 | 9001    | 2021-06-02 19:01:01 | 2021-06-02 19:31:01 | 84     |
    | 4    | 1001 | 9002    | 2021-09-05 19:01:01 | 2021-09-05 19:40:01 | 89     |
    | 5    | 1001 | 9001    | 2021-09-02 12:01:01 | (NULL)              | (NULL) |
    | 6    | 1001 | 9002    | 2021-09-01 12:01:01 | (NULL)              | (NULL) |
    | 7    | 1002 | 9002    | 2021-02-02 19:01:01 | 2021-02-02 19:30:01 | 87     |
    | 8    | 1002 | 9001    | 2021-05-05 18:01:01 | 2021-05-05 18:59:02 | 90     |
    | 9    | 1003 | 9001    | 2021-09-07 12:01:01 | 2021-09-07 10:31:01 | 50     |
    | 10   | 1004 | 9001    | 2021-09-06 10:01:01 | (NULL)              | (NULL) |

```sql
select
    tag,
    difficulty, round(avg(score), 1)
from
    exam_record r
    left join examination_info i on i.exam_id = r.exam_id
where tag = 'SQL' and difficulty = 'hard' and 
    score <> (
        select
            max(score)
        from
            exam_record r
            left join examination_info i on i.exam_id = r.exam_id
        where
            tag = 'SQL'
            and difficulty = 'hard'
    )
    and score <> (
        select
            min(score)
        from
            exam_record r
            left join examination_info i on i.exam_id = r.exam_id
        where
            tag = 'SQL'
            and difficulty = 'hard'
    )
    group by tag, difficulty;


```

20. 用户在牛客试卷作答区作答记录存储在表exam_record中，内容如下：

    exam_record表（uid用户ID, exam_id试卷ID, start_time开始作答时间, submit_time交卷时间, score得分）

    ![img](https://uploadfiles.nowcoder.com/images/20211215/59_1639542518750/C816D42207807A76D1590E1D6378A8D0)

    请计算2021年每个月里试卷作答区用户平均月活跃天数avg_active_days和月度活跃人数mau，上面数据的示例输出如下：

    ![img](https://uploadfiles.nowcoder.com/images/20210924/385183_1632469288293/41EED76D675E52B63ED8574541FE8F24)

    解释：2021年7月有2人活跃，共活跃了3天（1001活跃1天，1002活跃2天），平均活跃天数1.5；2021年9月有4人活跃，共活跃了5天，平均活跃天数1.25，结果保留2位小数。

    注：此处活跃指有交卷行为。

    solution 1:

```sql
    with
        a as (
            select
                extract(
                    month
                    from
                        start_time
                ) as month,
                uid,
                count(
                    distinct extract(
                        day
                        from
                            start_time
                    )
                ) as days
            from
                exam_record
            where
                extract(
                    year
                    from
                        start_time
                ) = 2021 and submit_time is not null
            group by
                month,
                uid
        )
    
        select concat('20210',month), round(sum(days)/count(uid),2) as avg_active_days, count(distinct uid) as mau
        from a 
        group by month
```
solution 2:

```sql
    select date_format(start_time, '%Y%m') as month, round(count(distinct uid, date_format(start_time, '%y%m%d'))/count(distinct uid),2) as avg_active_days, count(distinct uid) as mau
    from exam_record
    where extract(year from start_time) = 2021 and submit_time is not null
    group by month 
    == count(distinct uid, date_format(start_time, '%y%m%d')这个函数计算的是 uid 和 DATE_FORMAT(start_time, '%y%m%d') 组合的唯一值的数量。
```

21. 从听歌流水中找到18-25岁用户在2022年每个月播放次数top 3的周杰伦的歌曲

key words: 18/25， 2022， monthly, top3, 周杰伦
        
思路：monthly, find the top3 songs不是单一值所以用windows function rank(), where limit age, year, singer, , limit 3;
        
1. 先计算monthly song_id, song_name, count(song_id) 
        

where 
(age between 18 and 25)
        
​                    and year (fdate) = '2022'
        
​                    and singer_name = '周杰伦'
        
 group by
        
​                    month,
        
​                    song_id,
        
​                    song_name
        
​                order by
        
​                    count(song_id) desc
        
表a计算歌曲播放量
        

2. 根据上述表格windows function row_number rank歌曲播放量为表b
3. 根据表b，用where ranking<=3进行filter

==windows function doesn't support count() in its order by clause== you should create a table with group by to count() first, then use windows function to rank.

Where clause doesn't support filter windows function, you should create another outer query to filter ranking.

难点： 排序要在哪里加

# 统计相同的值有几个

在 SQL 中，如果要统计每个日期下有多少个数值（例如某列的值），可以通过 `GROUP BY` 和聚合函数 `COUNT()` 来实现 示例数据

假设我们有一张名为 `records` 的表，数据如下：

| id   | record_date | value |
| ---- | ----------- | ----- |
| 1    | 2023-12-01  | A     |
| 2    | 2023-12-01  | B     |
| 3    | 2023-12-01  | A     |
| 4    | 2023-12-02  | C     |
| 5    | 2023-12-02  | A     |
| 6    | 2023-12-03  | B     |
| 7    | 2023-12-03  | B     |

我们希望统计每个日期（`record_date`）中每个不同 `value` 的数量。

```sql
SELECT 
    record_date,
    value,
    COUNT(*) AS value_count
FROM records
GROUP BY record_date, value
ORDER BY record_date, value;
```

### 查询结果

运行上述查询后，结果如下：

| record_date | value | value_count |
| ----------- | ----- | ----------- |
| 2023-12-01  | A     | 2           |
| 2023-12-01  | B     | 1           |
| 2023-12-02  | A     | 1           |
| 2023-12-02  | C     | 1           |
| 2023-12-03  | B     | 2           |

### 逻辑说明

1. **`GROUP BY`**
   - 按 `record_date` 和 `value` 对数据进行分组。
   - 确保每个日期和每个唯一 `value` 是一组。
2. **`COUNT(\*)`**
   - ==对每组中的记录数进行统计，即相同日期和数值出现的次数。==
3. **`ORDER BY`**（可选）
   - 按日期和数值排序，方便阅读结果。

# 连续登录问题

## 解题思路

根据日期进行升序排号，连续登录情况下日期-排号天得到的新日期是一样的

1月1号2号连续登录，减去序号1、2天，新日期都是12月31号；1月4567号同理。

+ 涉及 ` row_number()over(partition by uid order by ymd)`为日期进行升序排号
+ ` date_sub(ymd, interval num day)`得到新日期
  + 拓展：`date_add(ymd, interval num day)`
+ 计算相同sub_date数值，就能得出来连续登录天数



![image-20241212111127470](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241212111127470.png)

## 例题

你正在搭建一个用户活跃度的画像，其中一个与活跃度相关的特征是“最长连续登录天数”， 请用SQL实现“2023年1月1日-2023年1月31日每个用户最长的连续登录天数”

输入：

```sql
drop table if exists tb_dau;
create table `tb_dau` (
    `fdate` date,
    `user_id` int
);
insert into tb_dau(fdate, user_id)
values 
('2023-01-01', 10000),
('2023-01-02', 10000),
('2023-01-04', 10000);
```

输出：

```sql
user_id|max_consec_days
10000|2
```

说明：

```sql
id为10000的用户在1月1日及1月2日连续登录2日，1月4日登录1日，故最长连续登录天数为2日
```

```sql
with t1 as (select user_id, fdate, date_sub(fdate, interval row_number()over(partition by user_id order by fdate asc)day) as new_date
from tb_dau
where fdate between '2023-01-01' and '2023-01-31')

, t2 as (select user_id, count(*) as cont
from t1
group by user_id, new_date)

select user_id, max(cont) as max_consec_days
from t2
group by user_id;
```

# 0.77 转化为77%

假设有一张表 `numbers`，其中包含小数值：

| value  |
| ------ |
| 0.6667 |
| 0.1234 |
| 0.5    |

+ Solution 1

```sql
select (value*100||'%') as percentage
from numbers
```

+ solution 2

```sql
select concat(value*100,'%') as percentage
```

+ 拓展保留小数点2位

```sql
select concat(round(value*100,2),'%')
```

# datediff() vs timestampdiff()

` DATEDIFF(date1, date2)` 

`TIMESTAMPDIFF(unit, datetime1, datetime2)`

```sql
SELECT TIMESTAMPDIFF(DAY, '2023-12-10 08:00:00', '2023-12-15 20:00:00') AS day_diff,
       TIMESTAMPDIFF(HOUR, '2023-12-10 08:00:00', '2023-12-15 20:00:00') AS hour_diff;

```

## 精确计算小时数

`timestampdiff(minute,first_clockin, last_clockin)/60 `

# 统计array内的值出现次数

某公司员工培训信息数据如下：

员工培训信息表cultivate_tb(info_id-信息id,staff_id-员工id,course-培训课程)，如下所示：

注：该公司共开设了三门课程，员工可自愿原则性培训0-3项，每项课程每人可培训1次。

![img](https://uploadfiles.nowcoder.com/images/20220325/397036_1648216131633/42053E9A3A0CAAC141054FCECBD9B1B8)

问题：请统计该公司所有课程参加培训人次？

```sql
with t1 as (select info_id, staff_id, if(course like '%1%', 1, 0) as course1, if(course like '%2%', 1, 0) as course2, if(course like '%3%', 1, 0) as course3
from cultivate_tb)

select (sum(course1)+ sum(course2)+ sum(course3)) as staff_nums
from t1
```

` sum(course1+ course2 + course3)`计算多个列的和

思路： 通过扩列，sum（）计算不含null的总数

# 最晚入职员工

有一个员工employees表简况如下:

![img](https://uploadfiles.nowcoder.com/images/20241115/0_1731654019387/9B698DE02774A26DB44508A2D391BBAC)

请你查找employees里最晚入职员工的所有信息，以上例子输出如下:

![img](https://uploadfiles.nowcoder.com/images/20241115/0_1731654029340/EAC23531A90FBC15E7DED516FD38F926)

思路： 最晚入职的人可能有多个，用最晚入职日期筛选employees里最晚入职员工

```sql
select emp_no, birth_date, first_name, last_name, gender, hire_date
from employees
where hire_date in (select max(hire_date)
from employees);
```

# 找到排名第X的员工信息

有一个员工employees表简况如下:

| emp_no | birth_date | first_name | last_name | gender | hire_date  |
| ------ | ---------- | ---------- | --------- | ------ | ---------- |
| 10001  | 1953-09-02 | Georgi     | Facello   | M      | 1986-06-26 |
| 10002  | 1964-06-02 | Bezalel    | Simmel    | F      | 1985-11-21 |
| 10003  | 1959-12-03 | Parto      | Bamford   | M      | 1986-08-28 |
| 10004  | 1954-05-01 | Christian  | Koblick   | M      | 1986-12-01 |

请你查找employees里入职员工时间升序排名的情况下倒数第三的员工所有信息，以上例子输出如下:

| emp_no | birth_date | first_name | last_name | gender | hire_date  |
| ------ | ---------- | ---------- | --------- | ------ | ---------- |
| 10001  | 1953-09-02 | Georgi     | Facello   | M      | 1986-06-26 |

注意：可能会存在同一个日期入职的员工，所以入职员工时间排名倒数第三的员工可能不止一个,存在多个员工的情况按照emp_no升序排列。

Solution1:

`ROW_NUMBER()`：为每一行按照排序规则分配一个唯一的排名。

`ORDER BY column_name DESC`：将数据按降序排列，这样倒数第三个值就是排名第 3 的值。

`WHERE row_num = 3`：提取倒数第三个值。

Solution 2:

`ORDER BY column_name DESC`：数据按降序排列。

`LIMIT 1 OFFSET 2`：跳过前 2 个值（倒数第 1 和第 2），然后取 1 个值（倒数第 3）。

==适用于已知入职时间倒数第三位只有一个员工，不推荐用法==

```sql
with t1 as (select emp_no, birth_date, first_name, last_name, gender, hire_date, dense_rank()over(order by hire_date desc) as num
from employees)

select emp_no, birth_date, first_name, last_name, gender, hire_date
from t1
where num = 3。
```

# 找偶数/奇数

思路：可以使用 SQL 的取模运算符 (`MOD` 或 `%`)，检查 `emp_no` 除以 2 的余数是否为 1。

```sql
WHERE emp_no % 2 = 0;
WHERE emp_no % 2 = 1;
```

```sql
WHERE MOD(emp_no, 2) = 1;
WHERE MOD(emp_no, 2) = 0;
```

# on vs where 

left join where筛选条件 如果某些 `t1` 记录没有匹配的 `t2` 记录，这些记录会被过滤掉。

left join on匹配且筛选条件，条件不成立或者没有匹配的值， t2` 的所有列会被填充为 `NULL

# 若没有则插入，若存在则忽略

```sql
insert ignore into actor values (``'3'``, ``'WD'``, ``'GUINESS'``, ``'2006-02-15 12:34:33'``)
```

==replace into：若没有则正常插入，若存在则先删除后插入==

# 要查询某个月有多少天

solution 1: last_day()

```sql
SELECT DAY(LAST_DAY('2024-02-01')) AS days_in_month;
```

solution 2: 动态计算当前月的天数

```sql
SELECT DAY(LAST_DAY(CURDATE())) AS days_in_current_month;
```

# 通过(')连接起来

将employees表中的所有员工的last_name和first_name通过(')连接起来。

```sql
select concat(last_name, "'", first_name)
from employees
```

==需要用double quotes==

# 查找字符串中逗号出现的次数**

思路：用字符串长度-去掉逗号后的字符串长度 = 逗号个数

现有strings表如下：

id指序列号；

string列中存放的是字符串，且字符串中仅包含数字、字母和逗号类型的字符。

| id   | string                              |
| ---- | ----------------------------------- |
| 123  | 10,A,B,C,DA,B,C,D,E,FA,11,B,C,D,E,G |

```sql
select id,  (char_length(string) - char_length(replace(string, ',',''))) as cnt
from strings
```

+ char_length() vs length()

  | 函数              | 返回值             | 适用场景                                     |
  | ----------------- | ------------------ | -------------------------------------------- |
  | **LENGTH()**      | 字符串的==字节数== | 需要知道字符串的==存储大小==（如多字节编码） |
  | **CHAR_LENGTH()** | 字符串的==字符数== | 需要知道字符串中的==实际字符数量==           |

|   str   | byte_length | char_length |
| :-----: | ----------- | ----------- |
| `hello` | 5           | 5           |
| `你好`  | 6           | 2           |
|   `🌟`   | 4           | 1           |

# 分页查询

在 MySQL 中，可以使用 `LIMIT` 和 `OFFSET` 实现分页查询。

在 MySQL 中，可以使用 `LIMIT` 和 `OFFSET` 实现分页查询。以下是返回 **第 2 页数据，每页 5 行** 的 SQL 查询：

```sql
sql


复制代码
SELECT *
FROM employees
LIMIT 5 OFFSET 5;
```

### **通用公式**

对于分页查询，可以使用以下公式：

```sql
SELECT *
FROM employees
LIMIT page_size OFFSET (page_number - 1) * page_size;
```

- **`page_size`**: 每页显示的行数（这里是 5）。
- **`page_number`**: 页码（这里是第 2 页）。

分页查询employees表，每5行一页，返回第2页的数据
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));

```sql
select *
from employees
limit 5 offset 5;
```

# EXIST 查找

使用含有关键字exists查找未分配具体部门的员工的所有信息。
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));

CREATE TABLE `dept_emp` (
`emp_no` int(11) NOT NULL,
`dept_no` char(4) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
输出格式:

| emp_no | birth_date | first_name | last_name | gender | hire_date  |
| :----- | :--------- | :--------- | :-------- | :----- | :--------- |
| 10011  | 1953-11-07 | Mary       | Sluis     | F      | 1990-01-22 |

```sql
select *
from employees e
where not exist (select 1 from dept_emp d where e.emp_no = d.emp_no);
```

# 计算中位数位置

## 思路

+ 中位数位置计算公式

总数为基数，中位数位置 = （总数+1）/ 2

总数为偶数，中位数位置 = [总数/2，总数/2 +1]

+ 如何得知总数奇偶

  case when mod(总数,2) =1 then 基数 else 偶数 end as 奇偶

## 拓展函数floor() sum(1)

Floor()小于等于x的最大值

牛客每次考试完，都会有一个成绩表(grade)，如下:

| id   | job  | score |
| ---- | ---- | ----- |
| 1    | C++  | 11001 |
| 2    | C++  | 11000 |
| 3    | C++  | 9000  |
| 4    | JAVA | 12000 |
| 5    | JAVA | 13000 |
| 6    | B    | 12000 |
| 7    | B    | 11000 |
| 8    | B    | 9999  |

第1行表示用户id为1的用户选择了C++岗位并且考了11001分

第8行表示用户id为8的用户选择了B语言岗位并且考了9999分

请你写一个sql语句查询各个岗位分数升序排列之后的中位数位置的范围，并且按job升序排序，结果如下:

| job  | start | end  |
| ---- | ----- | ---- |
| B    | 2     | 2    |
| C++  | 2     | 2    |
| Java | 1     | 2    |

解释:

第1行表示C++岗位的中位数位置范围为[2,2]，也就是2。因为C++岗位总共3个人，是奇数，所以中位数位置为2是正确的(即位置为2的10000是中位数)

第2行表示Java岗位的中位数位置范围为[1,2]。因为Java岗位总共2个人，是偶数，所以要知道中位数，需要知道2个位置的数字，而因为只有2个人，所以中位数位置为[1,2]是正确的(即需要知道位置为1的12000与位置为2的13000才能计算出中位数为12500)

第3行表示前端岗位的中位数位置范围为[2,2]，也就是2。因为B语言岗位总共3个人，是奇数，所以中位数位置为2是正确的(即位置为2的11000是中位数)

solution 1:

```sql
select job,floor(sum(1)+1/2) as start, floor((sum(1)+2)/2) as end
from grade
group by job
```

Solution 2:

```sql
select job, case when mod(total_id,2) = 1 then round((total_id + 1)/2,0) else round((total_id)/2,0) END as start, case when mod(total_id,2) = 1 then round((total_id + 1)/2,0) else round((total_id)/2,0)+1 END as end
from (select job, count(id) as total_id
from grade
group by job) as t1
group by job
order by job
```



# 找到中位数
TM小哥和FH小妹在牛客大学若干年后成立了牛客SQL班，班的每个人的综合成绩用A,B,C,D,E表示，90分以上都是A，80~90分都是B，70~80分为C，60~70为D，E为60分以下
假设每个名次最多1个人，比如有2个A，那么必定有1个A是第1名，有1个A是第2名(综合成绩同分也会按照某一门的成绩分先后)。
每次SQL考试完之后，老师会将班级成绩表展示给同学看。
现在有班级成绩表(class_grade)如下:
grade	number
A	2
D	1
C	2
B	2
第1行表示成绩为A的学生有2个
.......
最后1行表示成绩为B的学生有2个

请你写出一个SQL查询，如果一个学生知道了自己综合成绩以后，最差是排第几名? 结果按照grade升序排序，以上例子查询如下:
grade
t_rank
A	2
B	4
C	6
D	7

```sql
with t1 as (select grade, sum(number)over(order by grade) as t_rank, sum(number)over(order by grade desc) as r_d, sum(number)over() as cnt_total
from class_grade)

select grade
from t1
where t_rank >=cnt_total/2 and r_d >= cnt_total/2
```

思路：

**中位数是在序列中使得正序和逆序累计均大于等于序列总数一半的值**。

```sql
A: 2个，B: 3个，C: 5个，D: 2个
A A B B B C C C C C D D
```

#### 步骤 1: 确定总数一半

- 序列总数是 **12**，一半是 **6**。

#### 步骤 2: 计算正序和逆序累计值

- **正序累计和**：
  - A: 2 → 累计和到 2，不满足条件。
  - B: 5 → 累计和到 5，不满足条件。
  - C: 10 → 累计和到 10，满足条件。
  - D: 12 → 累计和到 12，满足条件。
- **逆序累计和**：
  - D: 2 → 累计和到 2，不满足条件。
  - C: 7 → 累计和到 7，满足条件。
  - B: 10 → 累计和到 10，满足条件。
  - A: 12 → 累计和到 12，满足条件。

#### 步骤 3: 判断中位数

- **正序累计 ≥ 6 的部分**：`10, 12`，即 `C, D`。
- **逆序累计 ≥ 6 的部分**：`7, 10, 12`，即 `A, B, C`。
- **正序和逆序累计的交集**：`C`。

因此，中位数是 **C**。

```sql
with t1 as (select distinct music_id, music_name
from follow
left join music_likes l on l.user_id = follower_id
left join music on music.id = l.music_id
where follow.user_id = 1 and music_name not in(select music_name from 
(select follow.user_id, music_name from follow left join music_likes l on l.user_id = follow.user_id  left join music on music.id = l.music_id where follow.user_id = 1) t1)
order by music_id asc)

select music_name
from t1
order by music_id asc;
```
# 分母为0时返回结果为0

```sql
nullif(x,y) #x = y时，结果为null
coalesce(expression1, expression2, expression3) # 返回第一个不是null的值
```
```sql
coalesce(nomerator/nullif(denominator,0),0)
# 如果分母为0， nullif()返回null值,除法等式返回null值，coalesce返回第二个值，0
```
# 新注册用户次日留存率
描述
牛客每天有很多人登录，请你统计一下牛客每个日期新用户的次日留存率。
有一个登录(login)记录表，简况如下:
id
user_id	client_id
date
1	2	1	2020-10-12
2	3	2	2020-10-12
3	1	2	2020-10-12
4	2	2	2020-10-13
5	1	2	2020-10-13
6	3	1	2020-10-14
7	4	1	2020-10-14
8	4	1	2020-10-15
第1行表示user_id为2的用户在2020-10-12使用了客户端id为1的设备登录了牛客网，因为是第1次登录，所以是新用户
......
第4行表示user_id为2的用户在2020-10-13使用了客户端id为2的设备登录了牛客网，因为是第2次登录，所以是老用户
......
最后1行表示user_id为4的用户在2020-10-15使用了客户端id为1的设备登录了牛客网，因为是第2次登录，所以是老用户

请你写出一个sql语句查询每个日期新用户的次日留存率，结果保留小数点后面3位数(3位之后的四舍五入)，并且查询结果按照日期升序排序，上面的例子查询结果如下:
date
p
2020-10-12
0.667
2020-10-13
0.000
2020-10-14
1.000
2020-10-15
0.000

```sql
with t1 as (select user_id, min(date) as first_date 
from login
group by user_id )
# 用于观察用户注册日期
, t2 as (select first_date, user_id, count(user_id)over(partition by first_date) as denominator
from t1
where d_rank = 1)
# 查询第一天注册日期对应的新注册用户人数

, t3 as (select distinct t1.user_id , t1.first_date, login.date as second_date, count(t1.user_id)over(partition by t1.date) as no
from t1
inner join login on t1.user_id = login. user_id and datediff(login.date, t1.first_date) = 1)# 筛选注册后第二天登录的用户

# 确定第二天登录的新注册用户人数

select distinct l.date, round(coalesce(no/nullif(denominator,0),0),3) as p
from login l
left join t2 on l.date=t2.date
left join t3 on l.date = t3.first
order by date asc;
```
# 具体区分时间数据形式
timestamp 包括日期和时间 timestampdif只能应用于带时间和日期的数据，date or time时间形式均不能应用。
关于date数据的计算，可以用string syntax实现

在牛客实习广场有很多公司开放职位给同学们投递，同学投递完就会把简历信息存到数据库里。

现在有简历信息表(resume_info)，部分信息简况如下:

| id   | job    | date       | num  |
| ---- | ------ | ---------- | ---- |
| 1    | C++    | 2025-01-02 | 53   |
| 2    | Python | 2025-01-02 | 23   |
| 3    | Java   | 2025-01-02 | 12   |
| 4    | C++    | 2025-01-03 | 54   |
| 5    | Python | 2025-01-03 | 43   |
| 6    | Java   | 2025-01-03 | 41   |
| 7    | Java   | 2025-02-03 | 24   |
| 8    | C++    | 2025-02-03 | 23   |
| 9    | Python | 2025-02-03 | 34   |
| 10   | Java   | 2025-02-04 | 42   |
| 11   | C++    | 2025-02-04 | 45   |
| 12   | Python | 2025-02-04 | 59   |
| 13   | C++    | 2026-01-04 | 230  |
| 14   | Java   | 2026-01-04 | 764  |
| 15   | Python | 2026-01-04 | 644  |
| 16   | C++    | 2026-01-06 | 240  |
| 17   | Java   | 2026-01-06 | 714  |
| 18   | Python | 2026-01-06 | 624  |
| 19   | C++    | 2026-01-04 | 260  |
| 20   | Java   | 2026-02-14 | 721  |
| 21   | Python | 2026-02-14 | 321  |
| 22   | C++    | 2026-02-14 | 134  |
| 23   | Java   | 2026-02-24 | 928  |
| 24   | Python | 2026-02-24 | 525  |
| 25   | C++    | 2027-02-06 | 231  |

第1行表示，在2025年1月2号，C++岗位收到了53封简历

......

最后1行表示，在2027年2月6号，C++岗位收到了231封简历

请你写出SQL语句查询在2025年投递简历的每个岗位，每一个月内收到简历的数目，和对应的2026年的同一个月同岗位，收到简历的数目，最后的结果先按first_year_mon月份降序，再按job降序排序显示，以上例子查询结果如下:

| job    | first_year_mon | first_year_cnt | second_year_mon | second_year_cnt |
| ------ | -------------- | -------------- | --------------- | --------------- |
| Python | 2025-02        | 93             | 2026-02         | 846             |
| Java   | 2025-02        | 66             | 2026-02         | 1649            |
| C++    | 2025-02        | 68             | 2026-02         | 394             |
| Python | 2025-01        | 66             | 2026-01         | 1268            |
| Java   | 2025-01        | 53             | 2026-01         | 1478            |
| C++    | 2025-01        | 107            | 2026-01         | 470             |

```sql
with t1 as (select
    job,
    date_format (date, '%Y-%m') as first_year_mon,
    sum(num) as first_year_cnt
from
    resume_info
where
    year (date) = 2025
group by
    job,
    date_format (date, '%Y-%m')
)# 2025年各个职位投递简历总数
, t2 as (select
    job,
    date_format (date, '%Y-%m') as second_year_mon,
    sum(num) as second_year_cnt
from
    resume_info
where
    year (date) = 2026
group by
    job,
    date_format (date, '%Y-%m')
)# 2026年各个职位投递简历总数
    select   t1.job,
     first_year_mon,
     first_year_cnt,
    second_year_mon,
    second_year_cnt
    from t1
    left join t2
   on t2.job = t1.job and right(second_year_mon,2) = right(first_year_mon,2)
   order by first_year_mon desc, job desc;
   # 将25年和26年数据通过职位以及年限相差为1组合成最后的结果

```

# 1. 窗口函数
```sql
function_name(expression) OVER (
    [PARTITION BY partition_column(s)] 
    [ORDER BY order_column(s) [ASC | DESC]] 
    [frame_clause]
)
```
## 排名类
用于对数据排名或编号：

ROW_NUMBER(): 按指定顺序为每行生成唯一编号。
RANK(): 按排序字段排名，存在并列时跳过排名。
DENSE_RANK(): 与 RANK() 类似，但不跳过排名。
NTILE(n): 将数据分为 n 个桶，返回每行的桶编号。

```sql
SELECT 
    employee_id,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    RANK() OVER (ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;
```

## 2. 聚合类函数
用于在窗口内计算累积值：
SUM(), AVG(), COUNT(), MIN(), MAX()

```sql
SELECT 
    employee_id,
    salary,
    SUM(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS running_total,
    AVG(salary) OVER (PARTITION BY department_id) AS avg_salary
FROM employees;
```
## 3. 值检索函数
获取窗口内特定行的值：

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
## 4. 差值类函数
用于比较窗口内当前行和其他行的值：

LAG(): 返回窗口内当前行的前 n 行的值。
LEAD(): 返回窗口内当前行的后 n 行的值。

```sql
SELECT 
    employee_id,
    salary,
    LAG(salary, 1) OVER (PARTITION BY department_id ORDER BY employee_id) AS previous_salary,
    LEAD(salary, 1) OVER (PARTITION BY department_id ORDER BY employee_id) AS next_salary
FROM employees;
```
## 5. Frame Clause
**`ROWS BETWEEN`**：基于行的偏移，适用于行数严格定义的场景，如移动平均、前后 N 行的累计和。

**`RANGE BETWEEN`**：基于值范围，适用于逻辑分组的计算，如同一日期或同一数值范围的累计和

==如果存在重复值，且需要将它们视为一个整体，优先使用 `RANGE BETWEEN`。==
Range between

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
order by sale_date,按日期生序进行滚动累加，rangebetween确定相同日期的值相加得到当日总销售额
所以，RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 定义了一个窗口，它包括从第一行到当前行的所有行（按排序顺序排列）。与 ROWS 不同，RANGE 是基于 值的范围，而不是基于行数的范围。
由于 RANGE 基于值范围，它认为所有的 2024-01-01 记录属于同一个范围（尽管有多行），所以它们的 amount 会累加，累计和为 300（即 100 + 200）。

# 不确定日期的次日留存率
描述
题目：现在运营想要查看用户在某天刷题后第二天还会再来刷题的留存率。请你取出相应数据。

示例：question_practice_detail
id	device_id	question_id	result	date
1	2138	111	wrong	2021-05-03
2	3214	112	wrong	2021-05-09
3	3214	113	wrong	2021-06-15
4	6543	111	right	2021-08-13
5	2315	115	right	2021-08-13
6	2315	116	right	2021-08-14
7	2315	117	wrong	2021-08-15
8	3214	112	wrong	2021-05-09
9	3214	113	wrong	2021-08-15
10	6543	111	right	2021-08-13
11	2315	115	right	2021-08-13
12	2315	116	right	2021-08-14
13	2315	117	wrong	2021-08-15
14	3214	112	wrong	2021-08-16
15	3214	113	wrong	2021-08-18
16	6543	111	right	2021-08-13

根据示例，你的查询应返回以下结果：
avg_ret
0.3000
```sql
# 留存率 = 次日来刷题用户总数/当天刷题用户总数
# 没有确定具体日期，count(distinct device_id, date)，不需要用group by

select count(distinct q2.device_id, q2.date)/count(distinct q1.device_id, q1.date) as avg_ret
from question_practice_detail q1
left join question_practice_detail q2 on q2.device_id = q1.device_id and datediff(q2.date, q1.date)= 1
```
# 计算周末出勤时间
假设数据
假设表 attendance 数据如下，包含多个员工的多次登录和登出记录
备注，同个员工一天有多个登录和登出时间。：

emp_id	timestamp
1	2023-12-30 08:00:00
1	2023-12-30 17:00:00
2	2023-12-30 09:00:00
2	2023-12-30 18:00:00
1	2023-12-31 08:30:00
1	2023-12-31 16:30:00

## solution1: 

自链接，separate timestamp to login_time and logout_time

```sql
with t1 as (
 select 
  emp_id, 
  timestamp, 
  dayofweek(timestamp) as day_of_week,
  row_number()over(partition by emp_id,
  dayofweek(timestamp)order by timestamp) as rn
 from 
  attendance
 where 
  dayofweek(timestamp) in (1,7)
), 
# show the day of week of the timesheet and 
# filter the timesheet for weekends, give the everyday login and log out time a rank
t2 as (
  select 
  t1.emp_id, 
  t1.day_of_week, 
  t1.timestamp as login_time, 
  t2.timestamp as logout_time
from t1
left join t1 as t2 
  on t2.emp_id = t1.emp_id and t2.rn = t1.rn+1
where t1.rn % 2 = 1
)
# separate timestamp to login and logout time
select 
emp_id, 
sum(timestampdiff(hour, login_time, logout_time)) as total_hours
from t2
group by emp_id
# calculate the total weekend working hours.
```
题目：计算员工周末工作时间，前提是：每天只有一次登录和登出时间
solution2:
```sql
with t1 as (
select emp_id, 
  timestamp,
  dayofweek(timestamp)as day_of_week
from attendance
where dayofweek(timestamp)in(1,7)
),
# only select the timesheet for weekends
t2 as (
select 
  emp_id, 
  day_of_week, 
  timestamp as login_time, 
  lead(timestamp)over(partition by emp_id, day_of_week order by timestamp)as logout_time
from t1
)
# separate timestamp to login and logout time
select 
emp_id, 
sum(timestampdiff(hour, login_time, logout_time))as total_hours
from t2
where logout_time is not null
group by emp_id
```
题目：计算员工周末工作时间，前提是：每天只有一次登录和登出时间
solution2:
solution 3:
```sql
with t1 as (
select 
emp_id,  
date(timestamp) as work_date # 多周数据， day_of_week会重复，work_date确保每天最早登录登出数据的精确性。此处构建层级为登录/登出时间>工作日期>总工作小时
dayofweek(timestamp) as day_of_week, 
MIN(timestamp) as login_time # 最小登录时间为登录时间
MAX(timestamp) as logout_time # 最大登录时间为登出时间
from attendance
where dayofweek(timestamp) IN (1,7)# 限定周末工作表
group by emp_id, work_date, day_of_week
)
select
 emp_id,
 sum(timestampdiff(hour, login_time, logout_time)) as total_hours
from t1
```

# 连接元素
https://www.nowcoder.com/practice/46cb7a33f7204f3ba7f6536d2fc04286?tpId=240&tqId=2183007&ru=/exam/oj&qru=/ta/sql-advanced/question-ranking&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSQL%25E7%25AF%2587%26topicId%3D240
现有试卷作答记录表exam_record（uid用户ID, exam_id试卷ID, start_time开始作答时间, submit_time交卷时间, score得分），示例数据如下：

![image-20250126202728576](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250126202728576.png)

还有一张试卷信息表examination_info（exam_id试卷ID, tag试卷类别, difficulty试卷难度, duration考试时长, release_time发布时间），示例数据如下：

![image-20250126202747067](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250126202747067.png)

```sql
select uid,
sum(if(submit_time is null, 1,0))as incomplete_cnt,
sum(if(submit_time is not null, 1, 0)) as complete_cnt, 
group_concat(distinct concat(date(start_time),':',tag) order by start_time asc separator';') as detail
from exam_record er 
left join examination_info ei on ei.exam_id = er.exam_id
where year(start_time) = 2021
group by uid
having  incomplete_cnt > 1 AND complete_cnt >= 1 AND incomplete_cnt < 5
order by incomplete_cnt desc
```
Concat横向合并， 把两个column内容合并，group_concat纵向合并，适用于groupby
## Note
1. group_concat 
```sql
group_concat(col1 order by col1 separator',')
# 中间无逗号， 需要separator提示词来放置分隔元素的符号
```
group_concat纵向合并，最后只输出一个值，只能用于groupby
2. concat 
```sql
concat(col1, ',', col2)
```
concat横向合并， 把两个column内容合并
3. if
```sql
if(condition, value if true, value if false)
# condition could be > = is null....
```
4. Comparison
sql doesn't support 1<incomplete_cnt<=5
correct writing:
```sql
where incomplete_cnt >1 and incomplete_cnt<=5
```

# 自定义列
https://www.nowcoder.com/practice/203d0aed8928429a8978185d9a03babc?tpId=240&tqId=2183297&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSQL%25E7%25AF%2587%26topicId%3D240
现有试卷作答记录表exam_record（uid用户ID, exam_id试卷ID, start_time开始作答时间, submit_time交卷时间, score得分）：
![image-20250218142042885](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250218142042885.png)
题目练习表practice_record（uid用户ID, question_id题目ID, submit_time提交时间, score得分）：
![image-20250218142055718](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250218142055718.png)
请统计每个题目和每份试卷被作答的人数和次数，分别按照"试卷"和"题目"的uv & pv降序显示，示例数据结果输出如下：
![image-20250218142108256](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250218142108256.png)
```sql
with t1 as (
select exam_id as tid, count(distinct uid) as uv, count(start_time) as pv, 'exam' as type
from exam_record
group by tid
union all
select question_id as tid, count(distinct uid) as uv, count(score) as pv, 'question' as type
from practice_record
group by tid
)
select tid, uv, pv
from t1
order by type asc, uv desc, pv desc;
```







