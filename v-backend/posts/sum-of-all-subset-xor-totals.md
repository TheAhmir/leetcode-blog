---
title: Sum of All Subset XOR Totals
tags:
  - #1863
  - Easy
  - LeetCode
  - Recursion
  - DFS
summary: Given an array of numbers, return the sum of all XOR totals for every subset of nums.
createdat: 2025-04-05
slug: 1585219d-52b0-47cb-90a6-2ba5d40c4bdb
---

# LeetCode #1863

> **Difficulty:** Easy\
> **Link:** [LeetCode – Sum of All Subset XOR Totals](https://leetcode.com/problems/sum-of-all-subset-xor-totals/)

---

# Problem

The **XOR total** of an array is defined as the bitwise `XOR` of **all its elements**, or `0` if the array is **empty**.

- For example, the **XOR total** of the array `[2, 5, 6]` is `2 XOR 5 XOR 6 == 1`

Given an array `nums`, return _the **sum** of all **XOR totals** for every **subset** of `nums`_.

**Note:** Subsets with the **same** elements should be counted multiple times.

An array `a` is a **subset** of an array `b` if `a` can be obtained from `b` by deleting some (possible zero) elements of `b`.

### Examples

```
Input: nums = [1,3]
Output: 6
Explanation: The 4 subsets of [1, 3] are:
    - The empty subset has an XOR total of 0
    - [1] has an XOR total of 1.
    - [3] has an XOR total of 3.
    - [1, 3] has an XOR total of 1 XOR 3 = 2.

    0 + 1 + 3 + 2 = 6
```

```
Input: nums = [5, 1, 6]
Output: 28
Explanation: The 8 subsets of [5, 1, 6] are:
    - The empty subset has an XOR total of 0.
    - [5] has an XOR total of 5.
    - [1] has an XOR total of 1.
    - [6] has an XOR total of 6.
    - [5, 1] has an XOR total of 5 XOR 1 = 4.
    - [5, 6] has an XOR total of 5 XOR 6 = 3.
    - [1, 6] has an XOR total of 1 XOR 6 = 7. 
    - [5, 1, 6] has an XOR total of 5 XOR 1 XOR 6 = 2.

    0 + 5 + 1 + 6 + 4 + 3 + 7 + 2 = 28
```

```
Input: nums = [3, 4, 5, 6, 7, 8]
Output: 480
Explanation: The sum of all XOR totals for every subset is 480.
```

---

## Introduction

Although this problem is categorized as easy, the thought process to solve it is deceptively complex. While this problem tasks us with finding the sum of total xor of each subset of a list, the more difficult part is actually programming a way to look at each individual subset. We are't able to do a simple loop or use a sliding window to retrieve every possible subset. Instead, the solution is found in utilizing recursion (calling a function within itself) and depth first search (a powerful algorithm to iterate through a data structure).

### Approach

To begin solving, we first have to understand how we will be able iterate through every possible subset of a list. This is what we can use depth first search (DFS) for. DFS is an algorithm designed to walk through a structure to the deepest level before backtracking and going down another path. But, what does all that even mean?

We have to think in a rather tricky way -- as a tree of strings. We visualize a tree where each branch represents either containing or not containing a letter.

```
subsets of [5, 1, 6] are [5], [1], [6], [5, 1], [5, 6], [1, 6] and [5, 1, 6]

tree:
                |-[]
          |-[]--|
          |     |-[6]
    |-[]--|     
    |     |      |-[]
    |     |-[1]--|
    |            |-[6]
[]--|
    |            |-[] 
    |      |-[]--|
    |      |     |-[6]
    |      |
    |-[5]--|
           |      |-[]
           |-[1]--| 
                  |-[6]
```

Here we create 2 branches as the first 'level' where we split into different paths, one containing 5 and one without 5. We continue this for each following value. This essentially creates every possible path or string we can create with this list of numbers, including identical subsets that contain the same values in different positions. Pretty cool right?

But how do we code this. We can actually use another cool technique called recursion. By recalling our function at each step both with and without each value, we can walk through each subset. When we reach the end of a path (the end of the list), we add the subset to a list of subset. Then we can just perform xor on value element to get each subsets "total xor".

**Note:** 0 XOR any number = that number

## Solution 1: Brute Force

The brute force method of solving this problem is exactly what we discussed earlier. To implement this, we first create a new function to allow us to dynamically add each subset to a list of subsets and keep track of where each process is currently at in the list, recalling the function with and without each value as we go. Once we've found every possible subset, we can then loop through each subset to accumulate that subsets 'total xor' and add that value to our overall total. And there we have it! The sum total xor for every subset in a list.

```python
def subsetXORSum(self, nums: List[int]) -> int:
    def recurse(nums, index, cur_subset, list_of_subsets):
        if index == len(nums):
            list_of_subsets.append(cur_subset[:])
            return
        else:
            cur_subset.append(nums[index])
            recurse(nums, index + 1, cur_subset, list_of_subsets)
            cur_subset.pop()
            recurse(nums, index + 1, cur_subset, list_of_subsets)

    all_subsets = []
    recurse(nums, 0, [], all_subsets)
    total = 0
    for i in all_subsets:
        subset_total = 0
        for value in i:
            subset_total = subset_total ^ value
        
        total += subset_total
    return total
```

Now I'm not sure if I would call it an easy solution to find, but it definitely is an amazing concept. But we can go even further. We actually don't need to gather every subset explicitly.

## Solution 2: More Optimized DFS with XOR Accumulation

Now that we know how to recurse through every subset, we can skip adding them to list and just calculate their total xor at each step. This is done by keeping track of the total as recurse and adding to it each time we go down a path including the value. This makes for a much cleaner solution too.

```python
def subsetXORSum(self, nums: List[int]) -> int:
    def dfs(index, total):
        if index == len(nums):
            return total

        next_index = index + 1

        including = dfs(next_index, total ^ nums[index])  
        excluding = dfs(next_index, total)

        return including + excluding

    return dfs(0, 0)
```

It's crazy home many calculations we can do with so little code. As I said at the beginning, it really is deceptive to call this an easy question. Although, this solution doesn't help my case. By utilizing recursion to perform depth first search and optimizing our solution to minimize needed space and calculations, we're able to come up with a beautiful solution to aggregate calculations of every possible subset of a list -- showcasing how algorithms and data structures can be really useful to solve complex tasks efficiently.
