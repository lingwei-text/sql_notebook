# VARIABLES 

`height = 1.79`

## TYPE
### functionality has diferent behavior on diferent types of variables

 `type(height) output:float`

+ int 

  ```python
  print(4+5)
  output: 9
  ```

+ str  represents string

  ```python
  print('ab'+'cd')
  output: 'abcd'
  ```

+ boo represents booleans   

  ==True or False don't need parentheses==

  ```python
  z = True 
  print(type (z))
  output: bool
  ```

+ List 

# PYTHON LIST

Is a type of variables. List store variables, list may contain variables and strings.

## list type 

+ `fam = [1.79, 1.66, 1.68, 1.65]`

+ List can contain any type and diferent type in one list `fam = ['dad', 1.79, 'mom',1.66,'emma', 1.68,'elsa', 1.65]`

### list of list

+ list can contain list in itself witch is subsetting list

  ```python
  fam2 = [
  ['dad',1.79 ],
  ['mom',1.66],
  ['emma', 1.68],
  ['elsa', 1.65]
  ]
  print(type(fam2))
  output : list
  ```

```python
hall = 11.25
kit = 18.0
liv = 20.0
bed = 10.75
bath = 9.50

# Adapt list areas
areas = ["hallway", hall, "kitchen", kit, "living room", liv, "bedroom", bed, "bathroom", bath]
```

=="hallway" is string need quotation marks, hall is a variable, no quotation is needed==

## Access information of list

### index

for select single element from a list

`print(fam[6])`

`print(fam[-1])`

#### slicing 

for select multiple elements from a list

==空值取到表头或者表尾，数字不包括==

### access information of list of list
```python
house = [["hallway", 11.25],
         ["kitchen", 18.0],
         ["living room", 20.0],
         ["bedroom", 10.75],
         ["bathroom", 9.50]]

# Subset the house list
house[-1][1]
```
```python
house = ["cat", "dog", "bird"]
result = house[-1][1]  # 取最后一个字符串 "bird" 的第二个字符
print(result)  # 输出: "i"
```

`areas_copy = areas[:]`  =  `areas_copy = list(areas)`


## manipulate list or list of list 


### 1. Modify a Single Element

   ```python
   my_list = [1, 2, 3, 4, 5]
   my_list[2] = 10  # Change the element at index 2
   print(my_list)  # Output: [1, 2, 10, 4, 5]
   
   nested_list = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
   nested_list[1][2] = 100  # Change the third element of the second inner list
   print(nested_list)  # Output: [[1, 2, 3], [4, 5, 100], [7, 8, 9]]
   ```

### 2. Modify Multiple Elements with Slicing

   ```python
   my_list = [1, 2, 3, 4, 5]
   my_list[1:4] = [20, 30, 40]  # Replace elements at indices 1, 2, and 3
   print(my_list)  # Output: [1, 20, 30, 40, 5]
   
   ```

### 3. Replace a Range with a Different-Sized List

   ```python
   # Replace with a larger list
   my_list = [1, 2, 3, 4, 5]
   my_list[1:3] = [20, 30, 40, 50]
   print(my_list)  # Output: [1, 20, 30, 40, 50, 4, 5]
   
   # Replace with a smaller list
   my_list = [1, 2, 3, 4, 5]
   my_list[1:4] = [100]
   print(my_list)  # Output: [1, 100, 5]
   
   ```

### 4. Add New Elements to a List

   ```python
   1. my_list = [1, 2, 3]
   my_list.append(4)  # Add an element at the end
   print(my_list)  # Output: [1, 2, 3, 4]
   
   2. my_list.extend([5, 6])  # Add multiple elements at the end
   print(my_list)  # Output: [1, 2, 3, 4, 5, 6]
   
   3. new_list = my_list + [7] # create a new variable
   print(new_list) # output:[1, 2, 3, 4, 5, 6,7]
   ```

### 6. Remove Elements

   ```python
   # Remove by index
   #1. 
   my_list = [1, 2, 3, 4]
   my_list.pop(2)  # Remove the element at index 2
   print(my_list)  # Output: [1, 2, 4]
   
   # 2. 
   my_list = [1, 2, 3, 4]
   del my_list[1] # Remove the element at index 1
   print(my_list)  # Output: [1, 3, 4]
   
   areas = ["hallway", 11.25, "kitchen", 18.0,
           "chill zone", 20.0, "bedroom", 10.75,
            "bathroom", 10.50, "poolhouse", 24.5,
            "garage", 15.45]
   
   # Delete the poolhouse items from the list
   del areas[10:12]
   
   # Remove by value
   my_list = [1, 2, 3, 4]
   my_list.remove(3)  # Remove the first occurrence of 3
   print(my_list)  # Output: [1, 2, 4]
   ```

# FUNCTION 
type()
max(int1,int2) 取int1,和int2的最大值
round( number,decimals)  round() to output integer四舍五入
len()
sort(iterable, reverse = False)排序功能， false asc， True desc
str(), int(), bool() , float(),list()  switch between data types.

# METHOD

**![image-20241219190753694](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241219190753694.png)**

`string_name.capitalize()`
`string.replace(original content ,new content )`
`string_name.upper()`

`list_name.index()` find the index of a particular value
`list_name.count()`计算某个值出现了多少次
`list.append()`
`list.pop()` pop()内是index值，不是list表里面的值
`list.remove()` 移除object_name第一个 ()里面的值
`list.reverse()`reverse the order of the list

## methods change the object
everything = object
fam.append('me')
fam.append(1,79)

## upper
.upper() used for individual strings
The .str accessor is a special bridge that allows you to apply string methods like .upper() to each element in the Series automatically.

```python
Series.str.upper()
```
```python
my_string = 'hello'
print(my_string.upper())  # Output: 'HELLO'
```

# Numpy
##  1D lumpy array

### np.array()

np.array() only contain one datatype
np.array()is a new data type which means it has itself methods or function

Advantage compare to the list: calculations over entire array.两个array间的运算

### selection of data
#### Index and slicing
bmi[2]
bmi[2:]
#### Boolean
bmi[bmi >23] 里面的bmi>23 输出boolean值，外面的bmi[]只筛选true

and or not
+ and:  ture and true = true; false and false = false

+ or: true or false = true; 

+ not: not true = false, not false = true

  np.logical_and( , ),  np.logical_or( , ),  np.logical_not( ) 括号内只有一个条件

if, else, elif
值输出一个结果，如果两个条件都满足，只返回第一个条件对应的输出内容
if condition:
  expression
elif condition:
  expression
else:
  expression
expression一定要空两格才能生效， if condition后一定要加：

## 2D Numpy  Arrays

###  from 1d numpy array to 2d numpy array
```python
import numpy as np

# Create two 1D NumPy arrays
arr1 = np.array([1, 2, 3])
arr2 = np.array([4, 5, 6])
2d_array = np.array([arr1,arr2])
```

### shape
shape is an attribute not a method, list of list could be transferred to the 2d dumpy array, each list is one row.

2d np.array has rectangular data structure

print(np_array1.shape)
shape means the number of rows and the number of elements/columns in an array, for example : 
```python
import numpy as np

# Create a 2D NumPy array
np_array1 = np.array([[1, 2, 3], 
                      [4, 5, 6], 
                      [7, 8, 9], 
                      [10, 11, 12]])

# Get the shape
print(np_array1.shape)
```
```python
(4, 3)# 4 rows 3 columns
```
### subsetting of data 2 methods

```python
# Create a 2D NumPy array
np_2d = np.array([[1, 2, 3], 
                  [4, 5, 6], 
                  [7, 8, 9]])

# Access element in the 0th row, 2nd column
print(np_2d[0][2])  # Step-by-step method
print(np_2d[0, 2])  # NumPy-style direct access
print(np_2d[:,:1])
```
```python
3
3
[1,2]
[4,5]
[7,8]
```
==[ , ]不能只有一个数字，要包括行和列。==

## Statistics of numpy array

```python
print(np_baseball+updated)
# calculation of 2 numpy arrays
# element-wise calculation
```
`np.mean(variable1[ , ])` get the average number, if the variable 1 is a 2d numpy array
`np.median(variable1[ , ])`get the median number
`np.corrcoef(variable1[ :, 0], variable1[:, 1])`
`np.std(variable1[ , ])`
`np.random.normal()` simulate data 
`np.column_stack(variable1, variable2)`把横向的list变成纵向的列

##  Simulate data


![image-20250102185012746](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250102185012746.png)

![image-20250102185224995](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250102185224995.png)

```python
# Import numpy and set seed
import numpy as np
np.random.seed(123)
# to make sure everytime the output random number is the same

# Use randint() to simulate a dice
print(np.random.randint(1,7))
# Use randint() again
print(np.random.randint(1,7))
```

```python
import numpy as np

print(np.random.randint(1, 7))  # Different result each time
print(np.random.randint(1, 7))  # Different result each time

```

![image-20250102190934230](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250102190934230.png)



```python
import numpy as np 
np.random.seed(123)
tails = [0]
for x in range (10):
    coin = np.random.randint(0,2)
    tails.append(tails[x] + coin )
```

# VISULIZATION - Matplotlib
```python
import matplotlib.pyplot as plt
```
## Plot type

`plt.plot(year, pop) plt.show()` 折线图 
`plt.scatter(life_exp, gdp, s= pop) plt.show()` 点图，相比折线图没有连线，不会给观众造成误导
s stands for size, the dot size will be changed adopted to the size of the population
`plt.hist(x, bins=3) plt.show()`数据分布图。用于查看数据(x  )集中在哪个区间 check the distribution of the values.  plt.hist(x) bins = 10 by default
**![image-20241220160120881](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241220160120881.png)**
`plt.clf()` cleans it up again so you can start afresh.

## Customize plot

`plt.xscale('log')`把x轴的值承指数性分布
![image-20250107115658200](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250107115658200.png)
![image-20250107115345457](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250107115345457.png)`plt.title('World Population Projections')`
`plt.xlabel('year')`
`plt.ylabel('population')`
`plt.yticks([0,2,4,6,8,10]，['0','2B','4B','6B','8B','10B'])`
The plt.yticks() function requires== two arguments== to set custom labels:
==Tick positions==: A list of numeric positions where the labels should be placed.
==Tick labels==: A list of strings corresponding to the tick positions.

```python
plt.text(1550, 71, 'India')
plt.text(5700, 80, 'China')
plt.grid(True) 有没有网格线
```

# DICTIONARIES

A new type of data in Python 
key value pairs are in{}
keys should be unique and immutable objects(不可变对象)float, string, int. 
list could be updated (reference: manipulate list) which is cannot be a key
`europe = {'spain':'madrid', 'france':'paris', 'germany':'berlin', 'norway':'oslo' }`

## Methods 
`europe.keys()`retrieve the keys 
`europe['norway']` retrieve the value from a key ==variable1['key_name']==because here the key is just an element of the dictionary so {} is not suitable here.

## manipulate dictionary

1. Create a Dictionary

   ```python
   # Creating a dictionary
   my_dict = {"name": "Alice", "age": 25, "city": "New York"}
   ```
2. Access Dictionary Values
   ```python
   # Access a value by its key
   print(my_dict["name"])  # Output: Alice
   ```

3. Add or Update
```python
# Add a new pair
my_dict["country"] = "USA"
print(my_dict)  # Output: {'name': 'Alice', 'age': 25, 'city': 'New York', 'country': 'USA'}

# Update an existing value
my_dict["age"] = 30
print(my_dict)  # Output: {'name': 'Alice', 'age': 30, 'city': 'New York', 'country': 'USA'}
```
4. Delete
```python
# Remove a key-value pair using del
del(my_dict["city"]) or del my_dict["city"]
print(my_dict)  # Output: {'name': 'Alice', 'age': 30, 'country': 'USA'}

# Remove and return an item using pop()
age = my_dict.pop("age")
print(age)  # Output: 30
# It returns only the value of the removed key, not the entire dictionary.
print(my_dict)  # Output: {'name': 'Alice', 'country': 'USA'}

# Clear all items
my_dict.clear()
print(my_dict)  # Output: {}
```

5. check if the key is true
```python
# Definition of dictionary
europe = {'spain':'madrid', 'france':'paris', 'germany':'berlin', 'norway':'oslo' }

# Add italy to europe
europe['italy'] = 'rome'

# Print out italy in europe
print('italy'in europe)
```
![image-20241220184332131](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241220184332131.png)
## dictionaries of dictionaries
```python
# Dictionary of dictionaries
europe = { 'spain': { 'capital':'madrid', 'population':46.77 },
           'france': { 'capital':'paris', 'population':66.03 },
           'germany': { 'capital':'berlin', 'population':80.62 },
           'norway': { 'capital':'oslo', 'population':5.084 } }

# Print out the capital of France
print(europe['france']['capital'])

# Create sub-dictionary data
data ={'capital': 'rome', 'population': 59.83}

# Add data to europe under key 'italy'
europe['italy'] = data

# Print europe
print(europe)
```

# PANDAS
Revolution from dictionaries to dataframe
key in the dict is the labels of the column, **values** can be any type

![image-20250107221846168](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250107221846168.png)

pandas is much more advanced than 2d numpy array cause there could be variable datatype in pandas.
## Create dataframe

### By rows
```python
# Create a list of dictionaries with new data
avocados_list = [
    {'date': '2019-11-03', 'small_sold': 10376832, 'large_sold': 7835071},
    {'date': '2019-11-10', 'small_sold': 10717154, 'large_sold': 8561348},
]

# Convert list into DataFrame
avocados_2019 = pd.DataFrame(avocados_list)

# Print the new DataFrame
print(avocados_2019)
```
### By columns
```python
# Create a dictionary of lists with new data
avocados_dict = {
  "date": ['2019-11-17', '2019-12-01'],
  "small_sold": [10859987, 9291631],
  "large_sold": [7674135, 6238096]
}

# Convert dictionary into DataFrame
avocados_2019 = pd.DataFrame(avocados_dict)

# Print the new DataFrame
print(avocados_2019)
```
## Read csv and save

`pd.DataFrame(dict)` create a dataframe
`pd.read_csv('path/to/brics.csv', index_col=0)`
`variable.index`更改row lable

```python
new_dogs.to_csv('new_dogs_with_bmi.csv')
```

```python
row_labels = ['US', 'AUS', 'JPN', 'IN', 'RU', 'MOR', 'EG']
# Specify row labels of cars
cars.index = row_labels
```
## Info of dataframe

```python
print(dog.head())# display the first rows of the data
print(dog.info())# display the column name, data type, missing data
print(dog.shape)# diplay the number of rows and columns
print(dog.describe())# display the summary statistic data
# 3 component of dataframe
print(dog.values)# display values in 2d numpy array
print(dog.columns)# display the lable of columns
print(dog.index)# display row number or row name
```
### index
Transform value to index make the filter much easier
```python
dog_ind = dog.set_index('name')# while the index is not settled
dog_ind.reset_index(drop = True) #Use drop=False if you want to keep the original index as a column (e.g., for further analysis or exporting).
# Use drop=True if you want to completely discard the index and just work with the data.
```
Double index lable
```python
dog_ind2 = dog.set_index(['breed', 'color'])# color是breed子集 nested array
dog_ind2.loc[[('Laborador', 'brown'), ('chiwawa','white')]]
```

## Sort and Selection of data

### Sort

#### sort by values
```python
dog.sort_values('weight_kg', ascending = False)
dog.sort_values(['weight_kg', 'height_com'], ascending = [False,True])  
```
#### sort by index
```python
dog.sort_index(level = ['breed','color'], ascending = True # or False)
```

### selection of data
#### square brackets 

Limitation: cannot select specific rows and columns simultaneously. 
traits: 
 rows: selection for rows is always dataframe. 
 columns: single brackets is series, double brackets is dataframe

For rows: ==only support slicing== don't support only one index
For columns: [['column_name1', 'column_name2']] to select data in dataframe
![image-20250102163748560](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250102163748560.png)

#### loc & iloc

Limitation: 
    1. 选column的时候，必须写rows。可以单独选rows，不选column

Traits: 
    1. single brackets is series, double brackets is dataframe
        2.loc including the last elements of slicing, iloc not just like slicing of list

##### how to select double index
```python
dog.loc[[('Laborador', 'brown'):('chihuahua','white')], 'height_cm':'weight_kg']
```
##### slicing the parcial data for Date
```python
dog=dog.set_index('birth_of_date').sort_index()
dog.loc['2012':'2014']
```

+ loc(label-based) 
+ iloc(index-based)

![image-20241222134150194](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241222134150194.png)

![image-20241222134300472](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20241222134300472.png)

### Filter pandas DataFrames

only filter the true observations
`sel = cars[cars['drives_right']]`
`car_maniac = cars[cars['cars_per_cap']>500]`
最里面的[]用于筛选列，在两个[]筛选true值
`medium = cars[np.logical_and(cars['cars_per_cap']<=500, cars['cars_per_cap']>=300)]`

#### filter by strings
```python
# Filter for rows where region is Mountain
mountain_reg = homelessness[homelessness['region']=='Mountain']

# See the result
print(mountain_reg)
```
#### filter  by numeric
```python
# Filter for rows where family_members is less than 1000 
# and region is Pacific
fam_lt_1k_pac = homelessness[homelessness['family_members']<1000]

# See the result
print(fam_lt_1k_pac)
```
```python
# Get the worldwide mean temp by year
mean_temp_by_year = temp_by_country_city_vs_year.mean(axis = 'index')
print(mean_temp_by_year)

# Filter for the year that had the highest mean temp
print(mean_temp_by_year[mean_temp_by_year == mean_temp_by_year.max()])

# Get the mean temp by city
mean_temp_by_city = temp_by_country_city_vs_year.mean(axis = 'columns')
print(mean_temp_by_city)

# Filter for the city that had the lowest mean temp
print(mean_temp_by_city[mean_temp_by_city == mean_temp_by_city.min()])
```

#### filter by multiple atrributes

```python
# The Mojave Desert states
canu = ["California", "Arizona", "Nevada", "Utah"]

# Filter for rows in the Mojave Desert states
mojave_homelessness = homelessness[homelessness['state'].isin(canu)]

# See the result
print(mojave_homelessness)
```

#### filter by multiple conditions
```python
# Filter for rows where family_members is less than 1000 
# and region is Pacific
fam_lt_1k_pac = homelessness[(homelessness['family_members']<1000)& (homelessness['region']=='Pacific')]

or # by using np.logical_and()
import numpy as np
fam_lt_1k_pac = homelessness[np.logical_and(homelessness['region']=='Pacific',homelessness['family_members']<1000)]

# See the result
print(fam_lt_1k_pac)
```
#### filter by query.()
##### by values
similar to where in sql

```python
stocks.query('nike >90 and|or  disney is <140')
```
```python
stocks_long.query('stock =="disney" or (stock =="nike" and close <90)')
```
##### by index
```python
# Pivot data so gdp_per_capita, where index is date and columns is country
gdp_pivot = gdp_pop.pivot_table('gdp_per_capita', 'date', 'country')

# Select dates equal to or greater than 1991-01-01
recent_gdp_pop = gdp_pivot.query('date >="1991-01-01"')
```

## Generate new columns

```python
# Add a year column to temperatures
temperatures['year'] =temperatures['date'].dt.year
```

```python
# Add total col as sum of individuals and family_members
homelessness['total']=homelessness['individuals']+homelessness['family_members']

# Add p_homeless col as proportion of total homeless population to the state population
homelessness['p_homeless']=homelessness['total']/homelessness['state_pop']

# See the result
print(homelessness)
```

```python
# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Use .apply(str.upper)
cars['COUNTRY']=cars['country'].apply(str.upper)
print(cars)
```

## Aggregation data

```python
dogs['height_cm'].mean(axis = 'column')# calculate statistics across the rows 
dogs['height_cm'].median()
dogs['height_cm'].mode()
dogs['height_cm'].min()
dogs['height_cm'].max()
dogs['height_cm'].sum()
dogs['height_cm'].std()
dogs['height_cm'].var()
dogs['height_cm'].quantile()
```
### .agg()
```python
DataFrame.groupby(columns).agg(aggregation_rules)
```
aggregation_rules 可以是：
一个聚合函数（例如：'sum', 'count', 'mean'）。
一个函数名字符串列表（例如：['mean', 'std']）。
一个字典，指定每列使用的聚合方式（例如：{'column1': 'mean', 'column2': 'sum'}）。

```python
# Merge licenses and zip_demo, on zip; and merge the wards on ward
licenses_zip_ward = licenses.merge(zip_demo, on = 'zip')\
            			.merge(wards, on = 'ward')

# Print the results by alderman and show median income
print(licenses_zip_ward.groupby('alderman').agg({'income':'median'}))
```

```python
# Import NumPy and create custom IQR function
import numpy as np
def iqr(column):
    return column.quantile(0.75) - column.quantile(0.25)

# Update to print IQR and median of temperature_c, fuel_price_usd_per_l, & unemployment
print(sales[["temperature_c", "fuel_price_usd_per_l", "unemployment"]].agg([iqr, np.median]))
```
### .cumsum(), cummin(), .cummax(), .cumprod()
```python
# Sort sales_1_1 by date
sales_1_1 = sales_1_1.sort_values('date')

# Get the cumulative sum of weekly_sales, add as cum_weekly_sales col
sales_1_1['cum_weekly_sales'] = sales_1_1['weekly_sales'].cumsum()

# Get the cumulative max of weekly_sales, add as cum_max_sales col
sales_1_1['cum_max_sales']=sales_1_1['weekly_sales'].cummax()# 距某日为止，最高值

# See the columns you calculated
print(sales_1_1[["date", "weekly_sales", "cum_weekly_sales", "cum_max_sales"]])
```
```python
output:
             date  weekly_sales  cum_weekly_sales  cum_max_sales
    0  2010-02-05      24924.50          24924.50       24924.50
    1  2010-03-05      21827.90          46752.40       24924.50
    2  2010-04-02      57258.43         104010.83       57258.43
    3  2010-05-07      17413.94         121424.77       57258.43
    4  2010-06-04      17558.09         138982.86       57258.43
    5  2010-07-02      16333.14         155316.00       57258.43
    6  2010-08-06      17508.41         172824.41       57258.43
    7  2010-09-03      16241.78         189066.19       57258.43
    8  2010-10-01      20094.19         209160.38       57258.43
    9  2010-11-05      34238.88         243399.26       57258.43
    10 2010-12-03      22517.56         265916.82       57258.43
    11 2011-01-07      15984.24         281901.06       57258.43
```
## Distinct
```python
unique_dog = dog_visits.drop_duplicates(subset =['name','breed'])
```
## Count
```python
# Count the number of stores of each type
store_counts = store_types['type'].value_counts()
print(store_counts)
```
### Count percentage
```python
# Get the proportion of stores of each type
store_props = store_types['type'].value_counts(normalize= True)
print(store_props)
```
### Count & sort
```python
# Get the proportion of stores in each department and sort
dept_props_sorted = store_depts['department'].value_counts(sort=True, normalize=True) # default sort = True descending order. sort = False, no sorting is performed
print(dept_props_sorted)
```
## Groupby
### groupby index keys
```python
# Concatenate the tables and add keys
inv_jul_thr_sep = pd.concat([inv_jul, inv_aug, inv_sep], 
                            keys=['7Jul', '8Aug', '9Sep'])
print(inv_jul_thr_sep.head())                            

# Group the invoices by the index keys and find avg of the total column
avg_inv_by_month = inv_jul_thr_sep.groupby(level=0).agg({'total':'mean'})
```
### groupby columns
```python
dogs.groupby('color')['weight_kg'].mean()
dogs.groupby('color')['weight_kg'].agg([min, max, sum])
dogs.groupby(['color','breed'])['weight_kg'].agg([min, max, np.mean, np.median])
dogs.groupby(['color','breed'])[['weight_kg','height_cm']].agg([min, max, sum])
```

## Pivot table
```python
dogs.pivot_table(values = 'weight_kg', index = 'color', columns = 'bread', aggfunc = [np.median, np.mean], fill_value = 0, margins = True)# default aggfuncn is output mean value, margins = True to output mean values
```
## .melt()
this method is opposite to pivot table, reframe the table to long format
```python
social_fin.melt(id_vars = ['financial', 'company']，# the columns to be maintained
                           value_var['2018', '2017']，# column变value想要保留的值
                           var_name = 'year', value_name = 'dollars'
                           )
```

## Visulization
### .plot () for bar, line, scatter

```python
price_diffs.plot(y=['close_jpm', 'close_wells', 'close_bac'])
plt.show()
```
3 lines, x axis is the index, python treat 3 y axis as 3 separate lists, so there is 3 lines
```python
avg_weight_by_breed.plot(kind = 'bar', title = 'Mean Weight by Dog Breed', x = 'breed', y = 'mean_weight', rot = 45, alpha = 0.7)
plt.legend =()
# rot = 45 rotate x label 45degrees 
plt.show
```
### .hist()
```python
# Modify bins to 20
avocados[avocados["type"] == "conventional"]["avg_price"].hist(alpha=0.5, bins =20)

# Modify bins to 20
avocados[avocados["type"] == "organic"]["avg_price"].hist(alpha=0.5, bins = 20)

# Add a legend
plt.legend(["conventional", "organic"])

# Show the plot
plt.show()
```
#### Customize bins
```python
# Create a histogram of restaurant_groups and show plot
restaurant_groups['group_size'].hist(bins =[2, 3, 4, 5, 6])

plt.show()
```

## Missing Values

### Check the missing values
```python
dogs['weight_kg'].isnull()
dogs.isna().any()# if there is any nan in each column
dogs.isna().sum()# count the total number of nan values
dogs.isna().sum().plot(kind ='bar')
plt.show()
```
### Remove missing values

```python
dogs.dropna()
```
### Replace NAN with 0

```python
dogs.fillna(0)
```
### Fill with the proceeding values 

```python
pd.merge_ordered(aapl, mcd, 
                 on = 'date',
                 suffixes = ('_aapl', 'mcd'),
                 fill_method = 'ffill')
```

## Merge tables horizontally

### Merge on columns

#### Inner Join
##### Merge 1 table

```python
wards_census=wards.merge(census, on = 'ward', suffixes=('_ward','_cen'))
# the order is from left table to the right table
```
##### Merge multiple tables
```python
# Merge the ridership, cal, and stations tables
ridership_cal_stations = ridership.merge(cal, on=['year','month','day'])\
            				.merge(stations, on = 'station_id')
```

#### outer join
##### left outer join
```python
wards_census=wards.merge(census, left_on = 'ward',right_on = 'ward_id', suffixes=('_ward','_cen'), how = 'left')
```
##### merge_asof
similar to left join, but match on the nearest key column. right table value is smaller ou equal to the left table values  
![image-20250113144416228](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250113144416228.png)
```python
pd.merge_asof(visa, ibm, on = 'date_time', suffixes = ('_visa', '_ibm'),
              direction = 'forward'|'backward'|'nearest')
```

```python
# Merge gdp and recession on date using merge_asof()
gdp_recession = pd.merge_asof(gdp, recession, on ='date')
print(gdp_recession.head())

# Create a list based on the row value of gdp_recession['econ_status']
is_recession = []
for s in gdp_recession['econ_status']:
    if s=='recession':
        is_recession.append('r') 
    else:
        is_recession.append('g')
print(is_recession)

# Plot a bar chart of gdp_recession
gdp_recession.plot(kind='bar', y='gdp', x='date', color=is_recession, rot=90)
plt.show()
```

##### right outer join
```python
wards_census=wards.merge(census, left_on = 'ward',right_on = 'ward_id', suffixes=('_ward','_cen'), how = 'right')
```
##### Full outer join
返回左表和右表中所有行
```python
# Merge iron_1_actors to iron_2_actors on id with outer join using suffixes
iron_1_and_2 = iron_1_actors.merge(iron_2_actors,
                                     how = 'outer',
                                     on ='id',
                                     suffixes=['_1', '_2'])
print(iron_1_and_2.head())                                 

# Create an index that returns true if name_1 or name_2 are null
m = ((iron_1_and_2['name_1'].isnull()) | 
     (iron_1_and_2['name_2'].isnull()))

# Print the first few rows of iron_1_and_2
print(iron_1_and_2[m].head())
```
##### merge_ordered()
like outer join, but the values are sorted
```python
# Use merge_ordered() to merge gdp and sp500, and forward fill missing values
gdp_sp500 = pd.merge_ordered(gdp, sp500, left_on='year', right_on='date', 
                             how='left',  fill_method='ffill')

# Subset the gdp and returns columns
gdp_returns = gdp_sp500[['gdp', 'returns']]

# Print gdp_returns correlation
print (gdp_returns.corr())
```
#### self join
self join could be inner join, only return the observation not null, or left table, with nan value
```python
# Merge sequels and financials on index id
sequels_fin = sequels.merge(financials, on='id', how='left')

# Self merge with suffixes as inner join with left on sequel and right on id
orig_seq = sequels_fin.merge(sequels_fin, how='inner', left_on='sequel', 
                             right_on='id', right_index=True,
                             suffixes=('_org','_seq'))

# Add calculation to subtract revenue_org from revenue_seq 
orig_seq['diff'] = orig_seq['revenue_seq'] - orig_seq['revenue_org']

# Select the title_org, title_seq, and diff 
titles_diff = orig_seq[['title_org','title_seq','diff']]

# Print the first rows of the sorted titles_diff
print(titles_diff.sort_values('diff', ascending = False).head())
```

### Merge on indexes

#### set an index
```python
movies = pd.read_csv('tmdb_movies.csv', index_col = ['id'])
```
### Filtering joins
#### semi join
只保留左表，左表primary key在右表出现 inner join
```python
print(non_mus_tcks.head())
print(top_invoices.head())
print(genres.head())

# 寻找左右两表都有的行
tracks_invoices = non_mus_tcks.merge(top_invoices, on = 'tid')

# 用原表与⬆️表对比，找到，只在右表出现过的左表里的行
top_tracks = non_mus_tcks[non_mus_tcks['tid'].isin(tracks_invoices['tid'])]

# Group the top_tracks by gid and count the tid rows
cnt_by_gid = top_tracks.groupby('gid',as_index=False).agg({'tid':'count'})
                                 # as_index=False，pandas 会将分组键作为普通列保留在结果中 groupby(['gid'])默认gid变成index

# Merge the genres table to cnt_by_gid on gid and print
print(cnt_by_gid.merge(genres, on = 'gid'))
```

#### Anti join
只保留左表，左表primary key==没有在右表==出现 left join

indicator = True tell the source of observations from which tables

```python
# Merge employees and top_cust
empl_cust = employees.merge(top_cust, on='srid', 
                                 how='left', indicator=True)

# Select the srid column where _merge is left_only
srid_list = empl_cust.loc[empl_cust['_merge'] == 'left_only', 'srid']
print(srid_list)
# empl_cust.loc[<condition>, 'srid']
# Select rows where the <condition> is True (i.e., empl_cust['_merge'] == 'left_only').

# Get employees not working with top customers
print(employees[employees['srid'].isin(srid_list)])
```

## Concatenate vertically
### multi tables with same columns
```python
pd.concat([tracks_master, tracks_ride, tracks_st], 
          ingore_index = True)
```
```python
pd.concat([tracks_master, tracks_ride, tracks_st], 
          ingore_index = True,
          keys = ['jan', 'Feb', 'Mar'])
# if you want to set keys, ignore_index = True is not allowed
```
### multi tables with variable columns
#### outer join
concat()includes all columns from diferent tables by default
```python
pd.concat([tracks_master, tracks_ride, tracks_st], 
        sort = True ,# sort the columns' name alphabeticaly
        ingore_index = True,
        keys = ['jan', 'Feb', 'Mar'])
```
#### iner join
sort = True  doesn't work for inner join
```python
pd.concat([tracks_master, tracks_ride, tracks_st], 
        join = 'inner',# default is 'outer'
        ingore_index = True,
        keys = ['jan', 'Feb', 'Mar'])
```

## Verifying integrity
### For merging
```python
.merge(validate = 'one_to_one'|'one_to_many')
```
### For concatate
```python
.concat(verify_integrity = True)# check if there is duplicate index, the default is False, which return with duplicate values
```

# SEABORN

## Axis subplot 
```python
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
df = pd.read_csv('maculinity.csv')
sns.countplot( x = 'how_masculine', data = df)
sns.scatterplot(x=gdp, y=phones)
plt.show()
```
## Adding third variable

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

hue_colors = {'yes':'black', 'no': 'red'}

tips = sns.load_dataset('tips')
sns.scatterplot(x = 'total_bill',
                y = 'tip',
                hue = 'smoker', # by addinga color to add a new variable
                paletter = hue_colors,# dictionary 给变量自定义颜色
                hue_order = ['yes', 'no']# modify the legend order, list
                data = tips)
plt.show()
```
![image-20250114103119978](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250114103119978.png)
## facetGrid plot
### relplot.()
relplot() for scatter or line plot
relplot() display the result of subset

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

hue_colors = {'yes':'black', 'no': 'red'}

tips = sns.load_dataset('tips')
sns.relplot(
                x = 'total_bill',
                y = 'tip',
                kind = 'scatter'
                col = 'smoker'，
                col_wrap= 2， # 一行放几张表
                col_order = ['Thur', 'Fri', 'Sat', 'Sun']
                row = 'time', # col横向，row竖向展示,两个变量互相结合，四种结果
                paletter = hue_colors,# dictionary 给变量自定义颜色
                hue_order = ['yes', 'no']# modify the legend order, list
                data = tips)
plt.show()
```
###  customize scatter plot
style, size, hue, alpha 
```python
# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt
import seaborn as sns

# Create a scatter plot of acceleration vs. mpg
sns.relplot(
    kind = 'scatter',
    x = 'acceleration',
    y = 'mpg',
    data = mpg,
    style = 'origin',
    hue = 'origin'
)
# Show plot
plt.show()
```
### line plot
differenciation with scatter plot, each poin of scatter plot is a unique observation
line plot display the same thing over time
kind = 'line' ci = 'sd'
```python
# Make the shaded area show the standard deviation
sns.relplot(x="model_year", y="mpg",
            data=mpg, kind="line", ci = 'sd')# for standard deviation

# Show plot
plt.show()
```
```python
# Import Matplotlib and Seaborn
import matplotlib.pyplot as plt
import seaborn as sns

# Add markers and make each line have the same style
sns.relplot(x="model_year", y="horsepower", 
            data=mpg, kind="line", 
            ci=None, style="origin", 
            hue="origin",
            markers = True,# point
            dashes = False)# solid line

# Show plot
plt.show()
```
## .catplot()
bar plot shows the confidence intervals  by default
```python
# List of categories from lowest to highest
category_order = ["<2 hours", 
                  "2 to 5 hours", 
                  "5 to 10 hours", 
                  ">10 hours"]

# Turn off the confidence intervals
sns.catplot(x="study_time", y="G3",
            data=student_data,
            kind="bar",
            order=category_order,
            ci = None)
# Show plot
plt.show()
```
### box plot
sym = ' ' omit outliers, whis = 2.0, whis = [5,95]
```python
# Create a box plot with subgroups and omit the outliers
sns.catplot(
    x = 'internet',
    y = 'G3',
    data = student_data,
    kind = 'box',
    hue = 'location',
    sym = ''
)

# Show plot
plt.show()
```
### Point plot
join = False 
estimator = median import numpy 
median is useful to deal with dataset where there is lots of outliers

```python
# Import median function from numpy
from numpy import median

# Plot the median number of absences instead of the mean
sns.catplot(x="romantic", y="absences",
			data=student_data,
            kind="point",
            hue="school",
            ci=None,
            estimator = median)

# Show plot
plt.show()
```
## Customize seaborn plot
### style, palette, context
```python
sns.set_style(white|dark|whitegrid|darkgrid|ticks)
sns.set_palette()# diverging paletter and sequential palette
sns.set_context('paper'|'notebook'|'talk'|'poster')# set the size of text from small to big
```
### title and axis labels

![image-20250114184255623](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250114184255623.png)

```python
# Create scatter plot
g = sns.relplot(x="weight", 
                y="horsepower", 
                data=mpg,
                kind="scatter")

# Add a title "Car Weight vs. Horsepower"
g.fig.suptitle("Car Weight vs. Horsepower")# For main title, only for fig
g.set_title('new_title', y = 1.03)|
g.set_title('This is {col_name}')# title in each chart, for axes subplot also
g.set( xlabel = 'New X Label',
       ylabel = "New Y Label")
plt.xticks(rotation = 90)# rotate ticks

# Show plot
plt.show()
```


















# COMPARISON OPERATOR

## Operators: >, <, ==, >=, <=, !=
## Boolean operators and or not 
### numpy boolean function
np.logical_and(), np.logical_or(), np.logical_not()
## Conditional statements
if, elif, else
==第一个条件满足，就输出结果，不会进行第二个条件运算==
## Pandas comparison
== only works for series==
pandas works on numpy, numpy boolean operators works for pandas series also
```python
# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Import numpy, you'll need this
import numpy as np

# Create medium: observations with cars_per_cap between 100 and 500
medium= cars[np.logical_and(cars['cars_per_cap']>=100,cars['cars_per_cap']<=500 )]

# Print medium
print(medium)
```

# LOOP

## While loop 
while condition:
  expression
```python
while offset != 0 :
    print("correcting...")
    if offset >0 :
      offset = offset - 1
    else : 
      offset = offset + 1    
    print(offset)
```
## for loop 
### iterate list
```python
# areas list
areas = [11.25, 18.0, 20.0, 10.75, 9.50]

# Code the for loop
for a in areas:
    print(a)
```
### iterate 1d numpy array
```python
import numpy as np

# Create a 1D NumPy array
arr = np.array([10, 20, 30, 40, 50])

# Iterate through the array
for element in arr:
    print(f"Element: {element}")
```
### iterate 2d numpy array
```python
import numpy as np

# Create a 2D NumPy array
arr_2d = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
for x in arr_2d:
    print(x)
# output: 
#[1, 2, 3]
#[4, 5, 6]
#[7, 8, 9]
```
### iterate elemens in the list of list
Write a for loop that goes through each sublist of house and prints out the x is y sqm, where x is the name of the room and y is the area of the room.
```python
# house list of lists
house = [["hallway", 11.25], 
         ["kitchen", 18.0], 
         ["living room", 20.0], 
         ["bedroom", 10.75], 
         ["bathroom", 9.50]]
         
# Build a for loop from scratch
for h in house:
    print('the'+' '+h[0] +' '+'is'+' '+str(h[1])+' '+'sqm')
    # h[0]is the first element of each sublist, h[1]is the second element of each sublist
```
### iterate elements of 2d numpy array- nditer(var) function
```python
for var in np.nditer(np_baseball):
    print(var)
```
### iterate list with index
fam = [1.73, 1.68, 1.71, 1.89]
```python
for x, y in enumerate(fam) :# x是index数字，y是value
    print("person " + str(x) + ": " + str(y))
```
### iterate numpy array with index
```python
import numpy as np

# Create a 1D NumPy array
arr = np.array([10, 20, 30, 40, 50])
for idx, val in enumerate(arr):
    print(f"Index: {idx}, Value: {val}")
```
### iterate dictionaries- item()method

```python
# Definition of dictionary
europe = {'spain':'madrid', 'france':'paris', 'germany':'berlin',
          'norway':'oslo', 'italy':'rome', 'poland':'warsaw', 'austria':'vienna' }
          
# Iterate over europe
for k, v in europe.items():
    print('the'+' '+'capital'+' '+'of'+' '+k+' '+'is'+' '+v)
```
### iterate pandas - iterrows method
#### select observations in panda series
```python
# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Iterate over rows of cars
for x,y in cars.iterrows():
    print(x)
    print(y)
```
```python

output:
    US # output x which is lable
    cars_per_cap              809
    country         United States
    drives_right             True
    Name: US, dtype: object
    # output values with column name
    AUS
    cars_per_cap          731
    country         Australia
    drives_right        False
    Name: AUS, dtype: object
```
#### select variables from panda series
```python
# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Adapt for loop
for lab, row in cars.iterrows():
    print(lab+':'+' '+ str(row['cars_per_cap']))
```
#### create a new column in the panda series
```python
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Code for loop that adds COUNTRY column
for x in cars.iterrows():
    cars['COUNTRY']=cars['country'].str.upper()# .str把cars['country']转换成str.接着才能在每一个str上应用upper()
# Print cars
print(cars)
```
# Monte Carlo simulations
## Random generator
```python
np.random.seed(1,2,3)
np.random.rand()
np.random.randint(0，2)#只输出整数0 or 1，不包括2
# 有seed，不管任何时候结果都是和第一次一样的
```
```python
# NumPy is imported, seed is set

# Starting step
step = 50

# Roll the dice
dice = np.random.randint(1,7)

# Finish the control construct
if dice == 1 or dice== 2:
    step = step-1
elif dice >=3 and dice<=5:
    step = step +1
else:
    step = step+np.random.randint(1,7) # 需要重新掷骰子，dice已有是6，这里需要一个新的值，不能用dice直接代替，不然规则就是6号直接走六步
# Print out dice and step
print(dice)
print(step)
```
## Random path
```python
# NumPy is imported, seed is set

# Initialize random_walk
random_walk = [0]

# Complete the ___
for x in range(100) :
    # Set step: last element in random_walk
    step = random_walk[-1]

    # Roll the dice
    dice = np.random.randint(1,7)

    # Determine next step
    if dice == 1 or dice == 2:
        step = max(0,step -1)
    elif dice >=3 and dice <=5:
        step = step +1
    else:
        step = step +np.random.randint(1,7)
    # append next_step to random_walk
    random_walk.append(step)
    
# Print random_walk
print(random_walk)

# Import matplotlib.pyplot as plt
import matplotlib.pyplot as plt

# Plot random_walk
plt.plot(random_walk)
# Show the plot
plt.show()
```
## Distribution
After 1000 times of random walk, we can see the distribution of the last value and do some statistic works.

```python
# numpy and matplotlib imported, seed set

# Simulate random walk 500 times
all_walks = []
for i in range(500) :
    random_walk = [0]
    for x in range(100) :
        step = random_walk[-1]
        dice = np.random.randint(1,7)
        if dice <= 2:
            step = max(0, step - 1)
        elif dice <= 5:
            step = step + 1
        else:
            step = step + np.random.randint(1,7)
        if np.random.rand() <= 0.001 :
            step = 0
        random_walk.append(step)
    all_walks.append(random_walk)

# Create and plot np_aw_t
np_aw_t = np.transpose(np.array(all_walks))

# Select last row from np_aw_t: ends
ends = np_aw_t[-1,:]

# Plot histogram of ends, display plot
plt.hist(ends)
plt.show()
# the ratio of end with steps more than 60
true_value = ends[ends>=60]
print(true_value.size/500)
```
# Data Analysis

## Exploratory of data 

```python
print(books.head(5))
print(books.info()) 
print(books.dtypes)
print(books.describe())
print(books['category'].value_counts()) # types of categorical values
sns.histplot( x = '2021', data = books, binswidth = 1)# numerical data 
```

## Data validation

### update datatypes

```python
books['year']= books['years'].astype(int)
```

Types of data: int, float, str, dict, list, bool

### validate categorical data

```python
books['genre'].isin(['Fiction', 'Not Fiction'])
# isin( series or data frame)
# return bool data
~books['genre'].isin(['Fiction', 'Not Fiction'])
# reverse the results, if the value is in the series, the result is False
books[books['genre'].isin(['Fiction', 'Not Fiction'])]
# return with the dataframe instead of bool
```

### Validate numerical data 

```python
books.select_dtypes('number')
books['year'].min()
books['year'].max()
sns.boxplot( x = 'year', y = 'genre', data = books)
```

## Data Summarization

```python
books.groupby('genre').mean()
books.groupby('genre').min()
books.groupby('genre').max()
books.groupby('genre').count()
books.groupby('genre').std()
books.groupby('genre').var()
books.groupby('genre').median()

```

### .agg()

```python
books.agg(['mean', 'std'])# only applys to numerical columns
books.agg({'rating':['mean', 'std'], 'year': ['median']})

books.groupby('genre').agg(
mean_rating = ('rating', 'mean'),
std_rating = ('rating', 'std'))
```

### Visualize categorical summaries 

```python
sns.barplot(data = books, x = 'genre', y = 'rating')
# give the mean value of the quantatative variable auto
plt.show()
```

## Addressing missing data

### Checking the missing values 

```python
print(salaries.isna().sum())
```

### Strategies for addressing missing data

![image-20250123175515940](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250123175515940.png)



#### drop 

```python
threshold = len(salaries)*0.05 # calculate the maximum number for missing number in each columns
cols_to_drop = salaries.columns[salaries.isna().sum()<= threshold]
salaries.dropna(subset = cols_to_drop, inplace = True)# inplace means to update the dataframe
```

#### Imputing a summary statistic 

```python
cols_with_missing_values = salaries.columns[salaries.isna().sum()>0]
for col in cols_with_missing_values[:-1]:
  # using silicing to exclue the last col
    salaries[col].fillna(salaries[col].mode()[0])
    # there could be multiple mode
```

##### Imputing by sub-group

  ```python
  salaries.dict = salaries.groupby('experience')['Salary_USD'].median().to_dict()
  salaries['Salary_USD'] = salaries['Salary_USD'].fillna(salaries['experience'].map(salaries.dict))
  ```

## Analyze categorical data

```python
print(salaries.select_dtypes('object').head())
# check the frequency of the data 
print(salaries['designation'].value_counts())
# count the number of unique job titles
print(salaries['designation'].nunique())
```

### Convert categorical data

Find the data with specific strings  

```python
pandas.series.str.contains()
# To search a column for a specific string or multiple string 
salaries['designation'].str.contains('scientist')
salaries['designation'].str.contains('scientist|AI')# no space
# to search the strings with the iniciation of data
salaries['designation'].str.contains('^data')
```
1. Create job titles that we want to find

```python
job_categories=['Data Scientice', 'Data Analyst']
```
2. Create variable for filter the string 
```python
data_science = 'Data Scientist|NLP'
data_analyst = 'Analyst|Analytics'
```
4. Create a list for str.contain()
```python
conditions = [
(salaries['Designation'.str.contains(data_science)]),
(salaries['Designation'.str.contains(data_analyst)])
]
```
5. Create new job_category column
```python
salaries['job_category'] = np.select (conditions, job_categories, default = 'Other')
# 只要condition为 True，就会自动选择对应索引的 choice 值。这是 np.select() 的核心逻辑之一：条件和选择值的索引是一一对应的。
# If neither condition is satisfied, the default value 'Other' will be assigned.
```
```python
# Create conditions for values in flight_categories to be created
conditions = [
    (planes["Duration"].str.contains(short_flights)),
    (planes["Duration"].str.contains(medium_flights)),
    (planes["Duration"].str.contains(long_flights))
]

# Apply the conditions list to the flight_categories
planes["Duration_Category"] = np.select(conditions, 
                                        flight_categories,
                                        default="Extreme duration")

# Plot the counts of each category
sns.countplot(data=planes, x="Duration_Category")
plt.show()
```

iterate dataframe
```python
# Filter the DataFrame for object columns
non_numeric = planes.select_dtypes("object")

# Loop through columns
for x in non_numeric.columns:
  
  # Print the number of unique values
  print(f"Number of unique values in {x} column: ", non_numeric[x].nunique())
# The f before the string allows you to embed variables directly inside {}
# [x] accesses the column named x in the DataFrame
```
## Analyze numerical data
### Convert strings to numbers
1. remove comma pd.series.str.replace(',', '')
```python
salaries['salary_in_rupee'] = salaries['salary_in_rupee'].str.replace(',','')
```
2. convert the column to float
```python
salaries['salary_in_rupee'] = salaries['salary_in_rupee'].astype(float)
```
3. create a new column with the updated currency
```python
salaries['salary_in_usd']= salaries['salary_in_rupee']*0.012
```
```python
# Preview the column
print(planes["Duration"].head())

# Remove the string character
planes["Duration"] = planes["Duration"].str.replace("h", "")

# Convert to float data type
planes["Duration"] = planes["Duration"].astype(float)

# Plot a histogram
sns.histplot(data = planes, x = 'Duration')
plt.show()
```

### Adding summary statistics
```python
salaries['std_dev'] = salaries.groupby('experience')['Salary_USD'].transform(lambda x:x.std())
# x stands for ['Salary_USD']
# transform method is a row_wise application, just like windows function in sql
```
```python
# Price standard deviation by Airline
planes["airline_price_st_dev"] = planes.groupby("Airline")["Price"].transform(lambda x: x.std())
print(planes[["Airline", "airline_price_st_dev"]].value_counts())

# Mean Price by Destination
planes["price_destination_mean"] = planes.groupby("Destination")["Price"].____(____ ____: ____.____())
print(planes[["Destination","price_destination_mean"]].value_counts())

# Mean Price by Destination
planes["price_destination_mean"] = planes.groupby("Destination")["Price"].transform(lambda x: x.mean())
print(planes[["Destination","price_destination_mean"]].value_counts())
```
## Outliers

Values > Q3 + 1.5IQR
Values < Q1 - 1.6 IQR
Methods to get iqr
1. scipy.stats iqr()
```python
from scipy.stats import iqr
iqr = iqr(mysleep['total_sleep'])
```
2. quantile()
```python
iqr = salaries['salary_usd'].quantile(0.75)-
salaries['salary_usd'].quantile(0.25)
```

![image-20250124180817761](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250124180817761.png)

```python
# Find the 75th and 25th percentiles
price_seventy_fifth = planes["Price"].quantile(0.75)
price_twenty_fifth = planes["Price"].quantile(0.25)

# Calculate iqr
prices_iqr = price_seventy_fifth - price_twenty_fifth

# Calculate the thresholds
upper = price_seventy_fifth + (1.5 * prices_iqr)
lower = price_twenty_fifth - (1.5 * prices_iqr)

# Subset the data
planes = planes[(planes["Price"] > lower) & (planes["Price"] < upper)]

print(planes["Price"].describe())
```

## Relationships in data 

### Datetime Data

#### Convert to timedata 

```python
# Convert when import data
divorce = pd.read_csv('divorce.csv', parse_dates = ['marriage_date'])
# convert after import
divorce['marriage_date'] = pd.to_datetime(divorce['marriage_date'])
# 组装日期
divorce['marriage_date'] = pd.to_datetime(divorce[
 'month', 'day', 'year'# 顺序不可更改
])
```

#### Extract parts of date

```python
divorce['marriage_month'] = divorce['marriage_date'].dt.month
# dt.day, dt.year, dt.weekday, d t.hour
```

### Correlation with numerical data

Describe the direction and strength of relationship between two variables
can help us predict variables to predict future outcomes
minus results mean one variable increase, the other decrease
positive results mean one increase, the other increase too
It is to measure the linear relationship

value close to 0 means weak relationship, value close to 1 ou -1 means strong relationship
 ```python
 divorce.corr() 
 ```
Visulize the correlation 
```python
sns.heatmap(divorce.corr(), annot = True)
# annot lable the corr in each cell
```
Pairplots 
```python
sns.pairplot( data = divorce, vars = ['income_man', 'income_woman','marriage_duration'])
plt.show()
```
### Correlation with categorical data 
```python
sns.histplot( data = divorce, x = 'marriage_duration', hue = 'education_man', binwidth = 1)
plt.show()
```
```python
sns.kdeplot( data = divorce, x = 'marriage_duration', hue = 'education_man', cut = 0, cumulative = True)
# cut 设定x轴的开始和结束值
plt.show()
```
## Action
### Class frequency
people in each class may have diferent preference
```python
pd.crosstab(planes['source'], planes['destination'], values = planes['price'], aggfunc = 'median')
```
### Assign a new category
```python
labels = ['economy', 'premium economy', 'business class', 'first class']
bins = [0, twenty_fifth, median, seventy_fifth, maximum]
planes['price_category'] = pd.cut(planes['price'], labels = labels, bins = bins
```
```python
# Create salary labels
salary_labels = ["entry", "mid", "senior", "exec"]

# Create the salary ranges list
salary_ranges = [0, twenty_fifth, salaries_median, seventy_fifth, salaries["Salary_USD"].max()]

# Create salary_level
salaries["salary_level"] = pd.cut(salaries["Salary_USD"],
                                  bins=salary_ranges,
                                  labels=salary_labels)

# Plot the count of salary levels at companies of different sizes
sns.countplot(data=salaries, x="Company_Size", hue="salary_level")
plt.show()
```
### Generate hipoheses
1. generate hypothesis or question
2. decise on what statistical test to use






# Statistic

## types of statistics 
Descriptive and inferential statistics
Descriptive: 已有数据的汇总
Inferential：通过当前数据，推测出更大群体的数据
## types of data

![image-20250115113235337](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250115113235337.png)

## Summary statistics
### Measures of center
mean: 
      np.mean(msleep['sleep_total'])
median: 
      np.median(msleep['sleep_total'])
mode: 
      most frequent value in the data 
      ==statistics.mode==(msleep['sleep_total']) 
      for categorical data
Mean is much more sensitve to the outliers than median
median是中间数，不论异常值偏离多大，median都是中间的数字；mean需要所有数相加取平均值，异常值的影响大。
mean适合分析对称性数据，歪斜数据适合使用median，两张图通过histogram展示center位置，及mean， median所处的位置

![image-20250115115551466](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250115115551466.png)

![image-20250115115531266](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250115115531266.png)
### Measures of spread
#### Variance
1. subtract the point from mean value
```python
dists = mysleep['sleep_total']-np.mean(mysleep['sleep_total'])# which is a series
```
2. square each distance
```python
sq_dists = dists **2
```
3. sum squared distance
```python
sum_sq_dists = np.sum(sq_dists)
```
4. divid. by number of data points-1
```python
variance = sum_sq_dists/(83-1)
```
np.var

```python
np.var(mysleep['sleep_total'],ddof =1)
# no ddof =1 means you use full population instead of a sample
# Delta Degrees of Freedom
```
#### standard deviation
是variance的开平方
```python
np.sqrt(np.var(mysleep['sleep_total'],ddof =1))
# sqrt means square root开平方
```
or 
```python
np.std(mysleep['sleep_total'],ddof =1)
```
#### Mean absolute deviation
it uses absolute values to measure dispersion离散, making it more robust to outliers
1. find the mean
2. Calculate Absolute Deviations 绝对值
3. Find the Mean of Absolute Deviations
```python
dists = msleep['sleep_total']-mean(msleep['msleep_total'])
np.mean(np.abs(dists))
# 1. mean(msleep$msleep_total) find the mean
# 2. np.abs(msleep['sleep_total']-mean(msleep$msleep_total)) absolute deviations
# 3. np.mean() Mean of Absolute Deviations 
```
## Quantile
```python
np.quantile(msleep['sleep_total'],0.5)
```
0.5 quantile = median 

### Quartiles
```python
np.quantile(msleep['sleep_total'], [0, 0.25, 0.5, 0.75, 1])
```
np.linspace(start, stop, num)
```python
np.quantile(msleep['sleep_total'], np.linspace(0,1,5))# 把0-1分成几个数字，5-1
```
### interquartile range IQR
25% - 75% , height of the box
```python
np.quantile(msleep['sleep_total'], 0.75)-np.quantile(msleep['sleep_total'], 0.25)
```
```python
from scipy.stats import iqr
iqr(msleep['sleep_total'])
```
### outliers 
outliers > Q1 - 1.5*IQR or Q3 +1.5*IQR

msleep['sleep_total'].describe()

在 Python 中，逻辑运算符 `|` 的优先级 **低于比较运算符**（如 `<` 和 `>`）

```python
lower = q1 - 1.5 * iqr
upper = q3 + 1.5 * iqr

# Subset emissions_by_country to find outliers
outliers = emissions_by_country[(emissions_by_country<lower) | (emissions_by_country> upper)]
print(outliers)
```

## Probability 

### Dependent chances

```python
np.random.seed(10)# could be a random number 
sales_count.sample(2)
# 数字代表选了几次的结果，选了两次第一次是brian第二次是claire
```

![image-20250117120234899](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250117120234899.png)

### Independent chances

```python
np.random.seed(10)# could be a random number 
sales_count.sample(5, replace = True)
# 5代表选了5次的结果
# replace means已选的还能继续被选
```



![image-20250117115508982](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250117115508982.png)

## Discrete distributions

Expected value = mean of probability distribution = sum(discrete * prob)

### Uniform distribution

任何事件发生的概率都是一样的，y轴值统一

#### discrete uniform distribution

时间可列举

![image-20250117123241930](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250117123241930.png)

#### Continuous distribution

```python
from scipy.stats import uniform
# The uniform.cdf refers to the
uinform.cdf(7,0,12) value <=7# value, start of the spread, end of the spread
1-uniform.cdf(7,0,12)value >=7
uinform.cdf(7,0,12) value <=7 - uniform.cdf(4,0,12)<=4 value<=7 
```

```python
from scipy.stats import uniform
uniform.rvs(0,5,size =10)# minimum value, max value, number of values
```
Continuous distribution could have other format, instead of uniform:

![image-20250119142847811](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250119142847811.png)

### Binomial distribution

Probability distribution of the number of success in a sequence of independent trials

Expected value = n * p number of trials, probability

根据True概率，制作随机数

Binary outcomes 
0 False 1 True
```python
from scipy.stats import binom
binom.rvs(1,0.5,size = 8)# number of coins, probability of True, times of try, every time is a index
binom.rvs(8,0.5,size = 1) #outcome array([5])total number of heads\
# To calculate the possibility of getting less than or equal to 7 heads
binom.cdf(7,10,0.5)
# To calculate the possibility of getting 7 heads
binom.pmf(7,10,0.5)# number of heads,num trials, prob
```
binom.pmf(k, n, p) : Calculates the probability of exactly k successes.
binom.cdf(k, n, p): Calculates the probability of up to k successes 
### normal distribution

Describe by mean and std, 数据以平均数为中心对称分布

```python
from scipy.stats import norm
# To get the percent of women shorter than 154
norm.cdf(154,161, 7)# value, mean, std, get the prob
# To get the percent of women taller than 154
1- norm.cdf(154,11,7)
# To get what height 90% women are shorter than 
norm.ppf(0.9, 160, 7)# prob, mean, std to get the value
# To get what height 90% women are taller than 
norm.ppf((1-0.9), 160, 7)# prob, mean, std, to get the value
# To generate random number
norm.rvs(160, 7, size = 10)# mean, std, values
```
#### The central limit theorem

the more times you sample, the distribution looks more similar to normal distribution paradigm

This theory apply to sample distribution, standard deviation distribution and also the cat 

##### Sample distribution

is the distribution of the sample mean after 100/1000/10000 trials 

Samples should be random and independent

```python
# Set seed to 104
np.random.seed(104)

sample_means = []
# Loop 100 times
for i in range(100):
  # Take sample of 20 num_users
  samp_20 = amir_deals['num_users'].sample(20, replace=True)
  # Calculate mean of samp_20
  samp_20_mean = np.mean(samp_20)
  # Append samp_20_mean to sample_means
  sample_means.append(samp_20_mean)
  
# Convert to Series and plot histogram
sample_means_series = pd.Series(sample_means)
sample_means_series.hist()
# Show plot
plt.show()
```

```python
# Set seed to 321
np.random.seed(321)

sample_means = []
# Loop 30 times to take 30 means 
# 根据已有数据，预估整个公司所有deals 的平均使用用户
for i in range(30):
  # Take sample of size 20 from num_users col of all_deals with replacement
  cur_sample = all_deals['num_users'].sample(20, replace = True)
  # Take mean of cur_sample
  cur_mean = np.mean(cur_sample)
  # Append cur_mean to sample_means
  sample_means.append(cur_mean)

# Print mean of sample_means
print(np.mean(sample_means))

# Print mean of num_users in amir_deals
# amir订单的平均使用用户与整体公司订单平均使用用户的对比
print(np.mean(amir_deals['num_users']))
```

##### std and sample distribution of proportion

![image-20250120131839162](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250120131839162.png)

该模型可以应用于数据不足的情况，通过sample生成值，根据模型，进行其他值的计算

#### Poisson distribution

Probability of some # of events occurring over a fixed period of time

##### Lambda 

Average number of events per time interval 

```python
from scipy.stats import poisson
# To calculate the possibility of a single value 
poisson.pmf(5,8)# values, average number 
# To To calculate the possibility less than or equal to a single value 
poisson.cdf(5,8)
# To To calculate the possibility higher than a single value
1-poisson.cdf(5,8)
# sample from a poisson distribution
possion.rvs(8, size = 10)# mean
```

![image-20250120134646210](/Users/zhoulingwei/Library/Application Support/typor a-user-images/image-20250120134646210.png)

#### Exponential distribution

![image-20250122172215519](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250122172215519.png)

 ```python
 from scipy.stats import expo
 # calculate the possibility of waiting less than 1 min
 expon.cdf(1,scale = 2)# period, time interval
 # calculate the possibility of waiting more than 1 min
 1-expon.cdf(1,scale = 2)
 ```

## Student's t-distribution

![image-20250122173101270](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250122173101270.png)

## Log-normal distribution

![image-20250122173339406](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250122173339406.png)

 # Correlation

X = independent variable

Y = dependent variable

## Correlation coefficient

![image-20250123123338046](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250123123338046.png)

![image-20250123123537661](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250123123537661.png)
```python
import seaborn as sns
sns.lmplot( x = 'sleep_total', y = 'sleep_rem', data = msleep, ci = None)
```

```python
# To calculate the correlation coefficient
msleep['sleep_total'].corr(msleep['rem_sleep'])
# output 0.75
 
msleep['rem_sleep'].corr(msleep['sleep_total'])
# output 0.75
# the result is the same, change the position of x and y
```
## Correlation caveats
Log transformation
```python
msleep['log_bodywt']= np.log(mysleep['bodywt'])
```
sqare root sqrt()
reciprocal transformation 1/x

![image-20250123131740250](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250123131740250.png)

# Design of experiments

 X对Y的影响有多大

![image-20250123133155307](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250123133155307.png)

## Controlled experiments

![image-20250123133328805](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250123133328805.png)

## Observational studies 

![image-20250123133710327](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250123133710327.png)

## Longitudinal vs.Cross-sectional studies

![image-20250123133851118](/Users/zhoulingwei/Library/Application Support/typora-user-images/image-20250123133851118.png)





