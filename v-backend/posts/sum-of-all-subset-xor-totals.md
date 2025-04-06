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

## Introduction

## Solution 1: Brute Force

```python
def subsetXORSum(self, nums: List[int]) -> int:
    def recurse(nums, size_index, cur_subset, list_of_subsets):
        if size_index == len(nums):
            list_of_subsets.append(cur_subset[:])
            return
        else:
            cur_subset.append(nums[size_index])
            recurse(nums, size_index + 1, cur_subset, list_of_subsets)
            cur_subset.pop()
            recurse(nums, size_index + 1, cur_subset, list_of_subsets)

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

## Solution 2: More Optimized DFS with XOR Accumulation

```python
def subsetXORSum(self, nums: List[int]) -> int:
    def dfs(index, total):
        if index == len(nums):
            return total
        next_index = index + 1
        return dfs(next_index, total ^ nums[index]) + dfs(next_index, total)

    return dfs(0, 0)
```
