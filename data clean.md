![image-20250207154817914](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250207154817914.png)

![image-20250207154854050](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250207154854050.png)

# SQL
## standarlize date format

Manipulate the null date

break the individual columns into severals, address, city, state

for categorical column, check if there is unproper records, y, n, YES

extra space in string for columns

```sql
SELECT COLUMN_NAME, 
       LENGTH(COLUMN_NAME) AS actual_length,
       LENGTH(TRIM(COLUMN_NAME)) AS trimmed_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bank-full' AND TABLE_SCHEMA = 'bank_marketing'
HAVING actual_length <> trimmed_length;
```
Detect outliers
```sql
WITH percentiles AS (
    SELECT 
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY age) AS Q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY age) AS Q3
    FROM bank_marketing.`bank-full`
)
SELECT * FROM bank_marketing.`bank-full`
WHERE age < (SELECT Q1 - 1.5 * (Q3 - Q1) FROM percentiles)
   OR age > (SELECT Q3 + 1.5 * (Q3 - Q1) FROM percentiles);
```

# conceptualize
Spend 30 minutes to an hour understanding the database
## grain, measures,  dimensions
1. what's the grain of the table, aka what does each row in this dataset represent?
2. what are the quantitative values and the qualitative values, and which ones have the mostbusiness relevance for the ask.
3. measures, or quantitative values absolutely need proper number formatting for calculations, and qualitative values need to have consistent categories for segmentation
##  critical & non critical columns
1. which columns need to be high quality (80% complete or accurate) for this analysis? 
2. which columns are less important, or not important at all?
##  definitions of the critical columns
1. for the columns that are important, what does each one mean?
## Conclusion for conception part
This dataset represents sales data, where every single record represents a transaction. The most important columns are the sales columns and the data columns. And there's also supplementary information about the product, customer demographics and marketing information. 
The data spans from 2019 to 2024.

# locate solvable issues
## formate, consistency, duplicates
make the most important columns usable and move on to the analysis
# evaluate unsolvable issues
## missing values, non-logical data
### calculate the magnitude(% impacted) of the issue
if most records (>70%) are missing or nonlogical, column is likely unusable. Find another source or not use the column at all.
if few records(<10%) are missing or nonlogical, can likely keep data as is and caveat it later.
if in the middle, make a judgment depending on how critical that column is.
### solutions
1. leave the data as is
2. impute the data with the mean, median or another reference point/dataset
3. exclude the data from analysis
The most important is to discuss with the team to choose the right decision
## Conclusion
document the thought process and record the severity of how many records this actually applied to.
About 10% of delivery timestamps were missing, and also 5% of the currency information was missing. However, there are not critical to this analysis, so they were left as is. For the 3% of refund dates that showed up as being before the sales day, they were actually excluded from the analysis, so as to not bias the data.
# angument
##  calculated fields
add supplementary information from another source
what should i add to this data analysis, can i find those columns on my own, either by calculating them or bringing them in from an external source. 

I augmented the dataset by adding in the time to deliver, the time to ship, and the time to refund as well as regional information so that we could better segment the sales and refunds trends and also understand the data at another geographic dimension.
# note and document
## create a change log

the magnitue and the severity of the issues
issue id, issue description, tables, issue type, resolved, resolution notes

