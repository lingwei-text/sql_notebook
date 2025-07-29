# Operators

## Comparison operators

==, >, <, !=, >=, <=

## Logical operators

And, or, not

## Membership operators

in, not in

# If statement

Dataset

```python
import pandas as pd

data = {
    'user_id': [1, 2, 3, 4],
    'country': ['US', 'IN', 'DE', 'US'],
    'purchase_amount': [500, 120, 300, 0]
}

df = pd.DataFrame(data)
```

If statement

```bash
df['high_value'] = df['purchase_amount'].apply(lambda x: 'Yes' if x > 400 else 'No')
```

If elif statement

```python
def categorize_purchase(amount):
    if amount == 0:
        return 'No Purchase'
    elif amount < 200:
        return 'Low'
    elif amount < 400:
        return 'Medium'
    else:
        return 'High'

df['purchase_category'] = df['purchase_amount'].apply(categorize_purchase)
```

Nested if statement

```Python
def label_us_customers(row):
    if row['country'] == 'US':
        if row['purchase_amount'] > 0:
            return 'US Buyer'
        else:
            return 'US - No Purchase'
    else:
        return 'Non-US'

df['user_label'] = df.apply(label_us_customers, axis=1)
```

# For loop

```python
transactions = [
    {"customer": "Tom", "amount": 12000},
    {"customer": "Alice", "amount": 8000},
    {"customer": "Bob", "amount": 15000}
]

for tx in transactions:
    if tx["amount"] > 10000:
        print(f"{tx['customer']} made a high-value transaction.")
```

## Nested for loop

Retrieve all unique pair combinations

```python
customers = ["Tom", "Alice"]
products = ["Phone", "Laptop"]

for customer in customers:
    for product in products:
        print(f"Checking if {customer} bought {product}...")
Checking if Tom bought Phone...
Checking if Tom bought Laptop...
Checking if Alice bought Phone...
Checking if Alice bought Laptop...
```

# While loop

## Break

Even the variable doesn't meet the condition of while loop, it meets the condition of if statement, the iteration will stop.

# Loop vs If

One if statement only filter one variable, one loop could filter one list or one dictionary which means filter several variables

If statement could exist inside of the loop. After entering each variable, the if statement only procede one variable each time.

```Python
row = {"amount": 12000}

if row["amount"] > 10000:
    print("High value transaction")
rows = [
    {"amount": 8000},
    {"amount": 12000},
    {"amount": 4000}
]

for row in rows:
    if row["amount"] > 10000:
        print("High value transaction")
```

# For loop vs while loop

For loop iterate the entire list/dictionary

While loop stops while the variable meets the condition

