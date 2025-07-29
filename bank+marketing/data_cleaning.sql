-- change the table name according to the mysql naming conventions
ALTER TABLE bank_marketing.`bank-full`
RENAME TO bank_marketing.`bank_full`;

SELECT * FROM bank_marketing.`bank_full`;

-- Add primary key to the table

SHOW KEYS FROM bank_marketing.`bank_full` WHERE Key_name = 'PRIMARY';
ALTER TABLE bank_marketing.`bank_full` ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE bank_marketing.`bank_full` MODIFY COLUMN id INT FIRST;
SELECT * FROM bank_marketing.`bank_full`;

-- check is there is extra space in the columns

SELECT COLUMN_NAME, 
       LENGTH(COLUMN_NAME) AS actual_length,
       LENGTH(TRIM(COLUMN_NAME)) AS trimmed_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bank_full' AND TABLE_SCHEMA = 'bank_marketing'
HAVING actual_length <> trimmed_length;

-- find outliers in the age column, create a new column is_outlier to faciliate the future analysis for outliers

ALTER TABLE bank_marketing.`bank_full`
ADD COLUMN is_outlier TINYINT DEFAULT 0;

WITH Quartiles AS (
    SELECT
        MAX(CASE WHEN row_num = CEIL(total_rows * 0.25) THEN age END) AS Q1,
        MAX(CASE WHEN row_num = CEIL(total_rows * 0.75) THEN age END) AS Q3
    FROM (
        SELECT
            age,
            ROW_NUMBER() OVER (ORDER BY age) AS row_num,
            COUNT(*) OVER () AS total_rows
        FROM bank_marketing.`bank_full`
    ) AS OrderedData
)
update bank_marketing.`bank_full`
set is_outlier = 1
WHERE age < (SELECT Q1 - 1.5 * (Q3 - Q1) FROM Quartiles)
   OR age > (SELECT Q3 + 1.5 * (Q3 - Q1) FROM Quartiles);
-- Remove the period after "admin" in the "job" column

SET SQL_SAFE_UPDATES = 0;
update bank_marketing.`bank_full`
set job = replace(job, 'admin.', 'admin')
where job like 'admin.';
SELECT distinct job FROM bank_marketing.`bank_full`;

--  Check the consistency of the categorical columns.

SELECT distinct marital FROM bank_marketing.`bank_full`;
select distinct education from bank_marketing.`bank_full`;
select distinct housing
from  bank_marketing.`bank_full`;
select distinct loan
from  bank_marketing.`bank_full`;
select distinct  contact
from  bank_marketing.`bank_full`;
select distinct   poutcome
from  bank_marketing.`bank_full`;

-- change housing to house_loan
alter table bank_marketing.`bank_full`
change column housing house_loan text,
change column loan personal_loan text;

-- change the column name and data type for column default

UPDATE bank_marketing.`bank_full`
SET `default` = CASE
    WHEN `default` = 'yes' THEN 1
    WHEN `default` = 'no' THEN 0
    ELSE `default`
END;
ALTER TABLE bank_marketing.`bank_full`
CHANGE COLUMN `default` `credit_status` boolean;
SELECT distinct credit_status FROM bank_marketing.`bank_full`;
select * from bank_marketing.`bank_full`
order by balance asc;
-- change the records in the contact column
update bank_marketing.`bank_full`
set contact = 'mobile phone'
where contact = 'cellular';

update bank_marketing.`bank_full`
set contact = 'fix phone'
where contact = 'telephone';


-- combin the column day and month, since there is lacking data of year, and we cannot see the trend through time. Here i will simply set the year = 2010
alter table bank_marketing.`bank_full`
add column full_date date after contact;

update bank_marketing.`bank_full`
set full_date = cast(concat('2010-',
  case when month = 'jan' THEN '01'
       when month = 'feb' THEN '02'
       when month = 'mar' ThEN '03'
       when month = 'apr' then '04'
       when month = 'may' then '05'
       when month = 'jun' then '06'
       when month = 'jul' then '07'
	   WHEN month = 'Aug' THEN '08'
	   WHEN month = 'Sep' THEN '09'
	   WHEN month = 'Oct' THEN '10'
	   WHEN month = 'Nov' THEN '11'
	   WHEN month = 'Dec' THEN '12'
  END,'-', lpad(day,2,'0')) as date) ;
  
  select * from bank_marketing.`bank_full`;
  
  -- change duration from seconds to mins
  alter table bank_marketing.`bank_full`
  change column duration duration_mins int;
  
  update bank_marketing.`bank_full`
  set duration_mins = round(duration_mins/60,2);
  select * from bank_marketing.`bank_full`;
  
  -- change the campaign to reachout_times for the reachout_times in this campaign
  alter table bank_marketing.`bank_full`
  change column campaign reachout_times int;
  
  select * from bank_marketing.`bank_full`
  order by pdays desc;
  
-- change the unproper column name 
alter table bank_marketing.`bank_full`
change column pdays last_campaign_gap int,
change column previous before_reachout_times int,
change column poutcome previous_outcome text,
change column y campaign_outcome text;

select * from bank_marketing.`bank_full`;

-- check if there is abnormal data. according to the variables table, if the duration is 0 means failed to reach out the client and the outcome was failed also

update bank_marketing.`bank_full`
set campaign_outcome = 'no' 
where duration_mins = 0;

SELECT count(*)
FROM bank_marketing.`bank_full`
WHERE age IS NULL OR job IS NULL or marital is null or education is null or credit_status is null or balance is null or house_loan is null or personal_loan is null or contact is null or full_date is null or day is null or month is null or duration_mins is null or reachout_times is null or last_campaign_gap is null or before_reachout_times is null or previous_outcome is null or campaign_outcome is null or is_outlier is null;







