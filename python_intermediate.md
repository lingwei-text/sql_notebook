# Iterable
An iterable is any object you can loop over with a for loop.
✅ Common examples of iterables:

1. list → [1, 2, 3]
2. str → "hello"
3. tuple → (1, 2, 3)
4. dict → {"a": 1, "b": 2} (looping over keys)
5. set → {1, 2, 3}
6. range() → range(5)
7. Anything that implements __iter__() under the hood

# Input

## calculator apply to string

1. ```Python
   print(f'{friend1}{friend2}')
   print(friend1+friend2) # concactate strings
   ```

## Lower case， uppercase, capitaliz

```Python
name = input()
print(name.lower())
print(name.upper())
print(name.title())
```

## Delete spaces

###### .strip() --- 删除两边空格

###### .lstrip() --- 删除左边空格

###### .rstrip() --- 删除右边空格

###### .replace(" ","") --- 删除所有空格

###### .split() --- 先切分，"".join() --- 再拼接

```Python
name = input()
print(name.strip())
print(name.rstrip())
print(name.lstrip())
```

## Duplicated output

```Python
a = input()
print(a*100)
```

# Slice

切片是指对操作的对象截取其中一部分的操作。字符串、元组、列表都能切片

# List

## create a list

### split()

The `split()` method splits a string into a list.
You can specify the separator, default separator is any whitespace.

```python
string.split(separator, maxsplit)
```
```python
txt = "hello, my name is Peter, I am 26 years old"
x = txt.split(", ")
print(x)
# output: ['hello', 'my name is Peter', 'I am 26 years old']
# every time, there is ", ", generate 2 values in the list
```
```python
txt = "apple#banana#cherry#orange"
x = txt.split("#")
print(x)
['apple', 'banana', 'cherry', 'orange']
```
```Python
name = input().split()
name_list = list(name) # no need list(), string.split() already created a list
print(name_list)
```
```python
name = input().split()
print(type(name))
# output:<class 'list'>
```
### list()
```python
num_list = list(input())
print(list)
# output: ['3', ' ', '5', ' ', '6', ' ', '9', ' ', '1', '0', ' ', '6', ' ', '2']
```
`list()` can take **any iterable** and turn it into a **list**.

| Type          | Example                   | What `list()` does                                   |
| ------------- | ------------------------- | ---------------------------------------------------- |
| **String**    | `"hello"`                 | `['h', 'e', 'l', 'l', 'o']`                          |
| **Tuple**     | `(1, 2, 3)`               | `[1, 2, 3]`                                          |
| **Set**       | `{1, 2, 3}`               | `[1, 2, 3]` (unordered)                              |
| **Range**     | `range(5)`                | `[0, 1, 2, 3, 4]`                                    |
| **Map**       | `map(int, ["1","2"])`     | `[1, 2]`                                             |
| **Dict**      | `{"a": 1, "b": 2}`        | `['a', 'b']` (keys only, unless otherwise specified) |
| **Generator** | `(x*x for x in range(3))` | `[0, 1, 4]`                                          |

## map()

```python
map(function, iterable)
```

iterable: A sequence (like a list) of items that the function will be applied to.

```Python
num = input().split()
print(list(map(int,num)))
```

#### int()

`int()` expects a **single value** (like a string or a number), **not an iterable**.

```python
int(["1", "2", "3"])  
# TypeError: int() argument must be a string, a bytes-like object or a number, not 'list'
```

#### iterators

function only loop the sequence once, common iterators:

1. map()
2. zip()
3. filter()

```python
num_list = map(int, input().split())
# this map function doesn't store number list in the num_list,  you're storing a map object, which is a one-time-use iterator.
# so be careful, any time you need to use num_list second time, it doesn't work!
```



## len()

The `len()` function returns the **number of items**:

- In a **list**, it returns how many elements are in the list.
- When applied to an **individual item (like a string)**, it returns the length of that item.

## Add items in list

append()

```Python
names = input().split()
print(names.append('Allen'))
```

insert(index, values)

```Python
names = input().split()
names.insert(0,'Allen')
print(names)
```

## Delete item in list

.pop(), delete the last value of the list by default

```Python
company_list = input().split()
company_list.pop(0)
print(company_list)
```

.pop(0)

```Python
queue = [1, 2, 3, 4, 5]
queue.pop(0)
print(queue)
queue.pop(0)
print(queue)
num = int(input())
queue.append(num)
print(queue)
```

.remove()

`value` must match an **existing element** in the list.

If your list is made of:

- Strings → pass a string.
- Numbers → pass a number.
- Objects → pass a matching object.

```Python
com = input().split()
com.remove(com[0])
print(com)
```

## Sort the list

Sort method, change the order in-place, no new variable needed

```Python
name = input().split
name.sort(reverse = True)
print(name)
```

Sorted function

Doesn't change in-place, needs a variable

```Python
name = input().split()
new_name = sorted(name)
print(new_name)
```

## Reverse the list

```Python
num = [3, 5, 9, 0, 1, 9, 0, 3]
num.reverse()
print(num)
```

## Create a list of list

```Go
name = ['Niumei', 'YOLO', 'Niu Ke Le', 'Mona'] 
food = ['pizza', 'fish', 'potato', 'beef']
number = [3,6,0,3]
friends = [] # 定义空列表
friends.append(name)
friends.append(food)
friends.append(number)
print(friends)
```

## change the type

Function for list

```Python
x, y = map(int, input().split())
```

##

```Python
age_list = list(map(int, input().split()))
total = 0
for x in age_list:
    total= total + x
len_list = len(age_list)
avg = round(total/ len_list, 1)
print(total,avg)
input().split()  →  ['20', '30', '40']  # a list of strings

map(int, ['20', '30', '40']) → an object that gives 20, 30, 40 as integers

list(map(int, ['20', '30', '40'])) → [20, 30, 40]
```

## List of list

Loop the row

```Python
list_of_list = [[1,2,3],[4,5,6],[7,8,9]]
n = int(input())
output = list_of_list *n
print(output)
* output
[
 [1, 2, 3],
 [4, 5, 6],
 [7, 8, 9],
 [1, 2, 3],
 [4, 5, 6],
 [7, 8, 9]
]
```

Loop the element in the row

```Python
list_of_list = [[1,2,3],[4,5,6],[7,8,9]]
new_list = []
n = int(input())
for row in list_of_list:
    new_row = [i*n for i in row]
    new_list.append(new_row)
print(new_list)
*output
[[2, 4, 6], [8, 10, 12], [14, 16, 18]]    
```

# If

if boolean: # boolean is true

else:# boolean is false

```Python
x = bool(input())
if x == True:   
    print("Hello World!")
else:   
    print("Erros!")
```

# Print

## Contains variables

```Python
print(f 'content {variable} content')
print(f'content {x} content')
print(f""" first line
second line
3rd line""")
```

## Sep, end

By default , the end of print is '/n' means next line. With end = ' ', can make the print() in the next line move to the same line. 

Loading Sheets. Please try again after it's finished.

```Python
for i in range (1, 16):
    if i == 13:
        continue
    else:
        print(i, end = " ")
       
* output
1,2,3,...etc        
```

# Range

range(start, stop, step)

```Python
my_list=[]
for  i in range(0,20,2):  
    my_list.append(i)
    print(i)
```

# While loop

Condition while True: 编程true的条件

```Python
food_list = ['apple', 'ice cream', 'watermelon', 'chips', 'hotdogs', 'hotpot']
while len(food_list)>0: 
    food_list.pop()
    print(food_list)
```

# Tuple

## Create a tuple

```Python
n = input()
m = input()
t = (n,m)
print(t)
```

## Modify a tuple

```Python
entry_form = ('Niuniu','Niumei')
print(entry_form)
try: 
    entry_form[1] = 'Niukele'
except TypeError:
    print('The entry form cannot be modified!')
   
try:
    # code that might raise an error
except ErrorType:
    # what to do if that error happens
```

## Increase the length of the tuple

num3 = num_tuple+add_tuple

```Python
num_tuple = (1, 2, 3, 4, 5)
print(num_tuple)
print(len(num_tuple))
add_tuple = (6, 7, 8, 9, 10)
num3 = num_tuple+add_tuple
print(num3)
print(len(num3))
#创建一个元祖记录数字1-5
num1 =tuple(range(1,6))
print(num1)
print(len(num1))
#创建一个元祖记录数字6-10
num2 = tuple(range(6,11))
#连接元祖
num3 = num1 + num2
print(num3)
print(len(num3))
```

# Strip vs split

strip() = trim()

split(), split string with comma, space, etc

# IN

Equal to IN sql, 属于元组的一部分

```Python
secret_tuple = ('Tom', 'Tony', 'Allen', 'Cydin', 'Lucy', 'Anna')
print(secret_tuple)
niuniu_name = input()

if niuniu_name in secret_tuple:
    print('congratulations!')
else:
    print('What a pity!')
```

# Range

`range()` is a built-in Python function that generates a **sequence of numbers**,

```Python
print(list(range(2, 6)))  # Output: [2, 3, 4, 5]
print(list(range(10, 0, -2)))  # Output: [10, 8, 6, 4, 2]
```

Loading Sheets. Please try again after it's finished.

# Dictionary

## Loop dict in list

 i.get('key')

创建一个依次包含键-值对{'name': 'Niuniu'和'Student ID': 1}的字典my_dict_1，

创建一个依次包含键-值对{'name': 'Niumei'和'Student ID': 2}的字典my_dict_2，

创建一个依次包含键-值对{'name': 'Niu Ke Le'和'Student ID': 3}的字典my_dict_3，

创建一个空列表dict_list，使用append()方法依次将字典my_dict_1、my_dict_2和my_dict_3添加到dict_list里，

使用for循环遍历dict_list，对于遍历到的字典，使用print()语句一行输出类似字符串"Niuniu's student id is 1."的语句以打印对应字典中的内容。

```Python
my_dict_1 = {'name': 'Niuniu','Student ID': 1}
my_dict_2 ={'name': 'Niumei','Student ID': 2}
my_dict_3 = {'name': 'Niu Ke Le','Student ID': 3}
dict_list = []
dict_list.append(my_dict_1)
dict_list.append(my_dict_2)
dict_list.append(my_dict_3)
for i in dict_list:
    
    print(f"{i.get('name')}'s student id is {i.get('Student ID')}.")
```

## sorted()

Correct:

```Python
sorted(cities_dict.items())
cities_dict = {'Beijing': {'Capital': 'China'}, 'Moscow': {'Capital': 'Russia'},'Paris': {'Capital': 'France'}}
for x, y in sorted(cities_dict):
*// print (sorted(cities_dict)) 
output:
['Beijing', 'Moscow', 'Paris']
```

## Value is a list, loop the list

```Python
result_dict = {'Allen': ['red', 'blue', 'yellow'], 'Tom': ['green', 'white', 'blue'], 'Andy': ['black', 'pink']}
for x in sorted(result_dict):
    print(f"{x}'s favorite colors are:")
    for y in result_dict.get(x):
        print(f'{y}')
        ## or
     for y in result_dict[x]:    
         print(f'{y}') 
```

## Create a dictionary from 2 lists

```Python
names = input().split()
languages = input().split()
my_dict = dict(zip(names, languages))
print(my_dict)
```

`zip(keys, values)` pairs each key with its corresponding value.

`dict()` turns the zipped pairs into a dictionary.

## dict.get(x,0)

if x's value exists in the dict, then get the corresponding value. If the key x didn't exist in the dict, give the key a value 0

```python
s= input()
dict = {}
for x in s:
    dict[x] = dict.get(x,0)+1 
    # dict.get(x,0) get the value, so it is a number
    # for the first time, dict.get(x,0) get the value 0, because x doesn't exis in the dictionary, dict.get(x,0)+1 give the value 0+1 = 1 for dict[x] =1
    # for the second time, dict.get(x,0), as x already exists, so it returns the value 1, and 1+1, dict[x] = 2
print(dict)  
```

# try expcept

```python
try:
    # Let's try to run this risky code
    age_str = input("Enter your age: ")
    age = int(age_str)
    print(f"Next year, you will be {age + 1}.")

except:
    # If ANY error happens in the 'try' block, run this code instead of crashing
    print("That was not a valid number. Please run the program again.")

print("---Program finished---")
```

# Built-in functions

ther built-in functions **do loop over the iterable**, but they do it internally, using optimized C-level code — **so it’s fast and compact**.

## float(), int(), list(), dict(), tuple(), set()

## min(), max(), sum()

https://www.nowcoder.com/practice/90c18e8c3a1347ac8a2f40028f959c51?tpId=314&tags=&title=&difficulty=0&judgeStatus=0&rp=0&sourceUrl=%2Fexam%2Foj

```python
nums = input().split()
num_list = list(map(int, nums))
print(max(num_list))
print(min(num_list))
print(sum(num_list))
```

## abs()

absolute绝对值，一直返回正数

```python
num = int(input())
print(abs(num))
```

## ASCII

transfer a letter to number

```python
s = input()
print(ord(s))
# input: a
# output: 97
```

## hex()

**hexadecimal string**.十六进制

```python
num = int(input())
print(hex(num))
```

## bin()

二进制

```python
num = int(input())
print(bin(num))
```

## pow()

power = **

```python
num_list = list(map(int, input().split()))
print(num_list[0]**num_list[1])
print(pow(num_list[1], num_list[0]))
```

## round(float,2)

## eval(string)

input is a formula in string, eval() can calculate this string

```python
formula = input()
print(eval(formula))
```

## set(iterable)

Sets are used to store multiple items in a single variable, unlike list, tuple and dictionary, set is unchageable, dupliactes not allowed, unordered

## sorted(iterable)

by default sort in ascending order, if sorted(iterable, reverse), sort in descending order. 

```python
name_list = set(input().split())
print(sorted(name_list))
```

# str.method()

## str.upper() str.lower()

## str.count()

## str.isdigit() str.isalpha() str.isspace()

## str.find()

## str.split()

## str.replace(a,b)

replace a with b

```python
string = input()
print(string.replace("a*", "ab"))
```

## "sep".join(seq)

"sep"分隔符

"seq" iterable, Any iterable object where all the returned values are strings, tuple, dictionary, list, string

```python
myTuple = ("John", "Peter", "Vicky")

x = "#".join(myTuple)

print(x)
# output: John#Peter#Vicky
```

https://www.nowcoder.com/practice/c0c7fa7523ea4651bd56b6cbc8c65c66?tpId=314&tqId=10059749&sourceUrl=%2Fexam%2Foj

join函数：1. 需要指定分隔符2. 指定iterable

```python
list = []
while True:
    a = input()
    if a == "0":
        break
    list.append(a)    
print(" ".join(list))
# output: 
I am NiuNiu
```

# OOP

https://www.nowcoder.com/practice/e5539db11767449ab2fb68ed3c2446d0?tpId=314&tqId=2584238&sourceUrl=%2Fexam%2Foj

描述

牛牛的Python老师为了更好地管理班级，利用一个类Student来管理学生，这个类包含了学生姓名（str）、学号（str）、分数（int）、每次作业等级（list[str]）等信息。请你帮助牛牛的老师实现这样一个类，并定义构造方法实现初始化，定义打印函数实现打印学生的姓名、学号、分数、提交作业的次数、每次作业的等级。

输入描述：

第一行输入字符串表示学生姓名。

第二行输入字符串表示学生学号。

第三行输入整数表示学生得分。

第四行输入多个大写字母表示每次作业等级，用空格间隔。

```python
class Student:
    def __init__(self, name, id, grade, level):
        self.name = name
        self.id = id
        self.grade = grade
        self.level = level
        self.times = len(level.split())
# calculate the len of the list
# Inside the constructor, you can do two things with these inputs: 1. store the attributes 2. create calculated attributes.
# name, id, grade, level are mandatory, but with level, we can get times through len()
    def info(self):
        return(f"{self.name}'s student number is {self.id}, and his grade is {self.grade}. He submitted {self.times} assignments, each with a grade of {self.level}")

        # Above is the structure or blueprint of Student class
name = input()
id = input()
grade = int(input())
level = input()
student1 = Student(name,id,grade,level)# this step assigning values to the object student1
print(student1.info())
# run info function of Student class, as student1 belongs to Student class, so the info() functio can apply to student1 as well
```

## add new attributes

when add new attributes outside the class, the object assign to the object directly impact on the object.

```python
class Employee:
    def __init__(self, name, salary) -> None:
        self.name = name
        self.salary = salary
    def printclass(self):
        try:
            return(f"{self.name}'salary is {self.salary}, and his age is {self.age}")
        except:
            return("Error! No age")
name = input()
salary = int(input())
e = Employee(name, salary)
print(e.printclass())
age = int(input())
e.age = age ## add new attribute to the class as well
print(e.printclass())

```

## setattr()

setattr(object, name, value)

`name`: the **name of the attribute** you want to set — **as a string**. Here, it is `"age"` (a string).

```python
class Employee:
    def __init__(self, name, salary) -> None:
        self.name = name 
        self.salary = salary
    def printclass(self):
        return(f"{self.name}'s salary is {self.salary}, and his age is {self.age}")

name = input()
salary = int(input())
age = int(input())
e = Employee(name, salary)


if hasattr(e,"age"):
    print(e.printclass())
else:
    print("False") 
    setattr(e,"age",age)
    print(e.printclass())
```

# Regular expression





