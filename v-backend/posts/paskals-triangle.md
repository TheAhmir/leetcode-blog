---
title: Pascal's Triangle
tags:
  - #118
  - Easy
  - LeetCode
summary: Given an integer 'numRows', return the first numRows of Pascal's triangle.
createdat: 2025-04-08
slug: 1b9429aa-c55d-444d-b568-ac6bf4135433
---

# LeetCode #118

> **Difficulty:** Easy\
> **Link:** [LeetCode – Pascal's Triangle](https://leetcode.com/problems/pascals-triangle/)

---

## Problem

- Given an integer `numRows`, return the first numRows of **Pascal's triangle**.

- In **Pascal's triangle**, each number is the sum of the two numbers directly above it as shown.

![Pascal's Triangle](https://res.cloudinary.com/practicaldev/image/fetch/s--WQWBZdNR--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/j5g94tika3ej65xu6coy.png)

### Examples

```
Input: numRows = 5
Output: [[1], [1,1], [1,2,1], [1,3,3,1], [1,4,6,4,1]]
```

```
Input: numRows = 1
Output: [[1]]
```

**Constraints**

- `1 <= numRows <= 30`

---

## Introduction

Pascal is a triangular arrangement of numbers in which each number is the sum of it's 2 parents located directly above it. This effectively means that we can generate each row from the row before it. The single constraint is that the first row is as well as the left and right sides of the triangle consist entirely of 1s.

## Approach

To start, we understand that we'll have to loop through a range at least as large as the height of the triangle given.

```python
for row in range(numRows):
    ...
```

We also know that we'll have to keep track of both the final resulting triangle the current row we're generating and the last row that we will be generating from. At the end of each loop, we should have built the current row, so we can append it to the final result and set it as our previous row for the next iteration.

```python
ret = [] # result to be returned
prev_row = []
for row in range(numRows):
    cur_row = []
    ...
    ret.append(cur_row) # current will have been filled by this point
    prev_row = cur_row # set prev_row for next iteration
```

Now we have to consider the base case -- `numRows` is 1 or 0. Conveniently, our for loop won't be executed if the `numRows` is 0, so that's one piece handled. From the examples given, we also know that if `numRows` is 1, we add only the first row to our result, leaving us with `[[1]]`. This information as well as knowing that the left and rights sides of the triangle must be 1s enables us to just add a one to the current row being generated at the beginning of each loop. Then, if we aren't the first row (aka prev_row has a length greater than 0) we begin and necessary calculations.

```python
ret = []
prev_row = []
for row in range(numRows):
    cur_row = []
    cur_row.append(1)
    if len(prev_row) > 0:
        ...
    ret.append(cur_row)
    prev_row = cur_row
```

Alright, we can finally get to the logic calculating the values from previous rows. For the first calculated value, the value is retrieved by adding the first and second values of the previous row, then the next calculated value is retrieved by adding the 3rd and 4th values of the previous row. This pattern is very similar to a sliding window, in which we look a "window" of values at a time, in this case 2.

With this in mind, we can just start tracking the index of the first value in the previous row that will be used to get the number we'll add to our current array. Since we're starting with the first value of the previous row we can initialize the index at 0. We can then use a while loop to stop after we've calculated the last 2 values in the previous row and added the result to our current row. Because we always use both the index value and the value after it, we also have to make sure that we stop on the index before the last index of the previous row, ensuring we don't hit an error for trying to access a value past the end of the row.

- don't forget to increment the index, so the we keep walking through the previous row and don't fall into an infinite loop.

```python
ret = []
prev_row = []
for row in range(numRows):
    cur_row = []
    cur_row.append(1)
    if len(prev_row) > 0:
        index = 0
        while index < len(prev_row) - 1:
            ...
            index += 1 # we've reached the end of the loop
    ret.append(cur_row)
    prev_row = cur_row
```

Almost there. We can add the calculated value to the current row in one simple step.

```python
ret = []
prev_row = []
for row in range(numRows):
    cur_row = []
    cur_row.append(1)
    if len(prev_row) > 0:
        index = 0
        while index < len(prev_row) - 1:
            cur_row.append(prev_row[index] + prev_row[index + 1])
            index += 1 
    ret.append(cur_row)
    prev_row = cur_row
```

There we have it. We've calculated each row using the previous one. There is just one problem here. As we said at the beginning each of the rows start **and end** with a 1. This means that after all the calculations, we have to add a zero. This follows the constraints that we've laid out as well as ensures that the next row is generated correctly (this 1 will be used in the final calculated value of the next row).

```python
def generate(self, numRows: int) -> List[List[int]]:
    ret = []
    prev_row = []
    for row in range(numRows):
        cur_row = []
        cur_row.append(1)
        if len(prev_row) > 0:
            index = 0
            while index < len(prev_row) - 1:
                cur_row.append(prev_row[index] + prev_row[index + 1])
                index += 1
            cur_row.append(1) # add a 1 at the end
        ret.append(cur_row)
        prev_row = cur_row
    return ret
```

We've done it!

## Solution

```python
def generate(self, numRows: int) -> List[List[int]]:
    ret = []
    prev_row = []

    for row in range(numRows):
        cur_row = []
        cur_row.append(1)

        if len(prev_row) > 0:
            index = 0
            while index < len(prev_row) - 1:
                cur_row.append(prev_row[index] + prev_row[index + 1])
                index += 1
            cur_row.append(1)

        ret.append(cur_row)
        prev_row = cur_row
    return ret
```

We've just built a simple Pascal's triangle of any height programmatically! This problem was fun because, we're able to steadily build upon our solution with each iteration. It showcases the ability to break a problem down into simple steps that, when put together, accomplishes a goal.
