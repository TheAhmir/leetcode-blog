---
title: Longest Nice Subarray
tags:
  - '#2401'
  - Medium
  - LeetCode
  - Sliding Window
summary: Return the length of the longest "nice" subarray -> sliding window solution
createdat: 2025-03-18T11:24:13
slug: 02391225-4d0d-4f17-af31-d0d5dec0e679
---

# Longest Nice Subarray – LeetCode #2401

> **Difficulty:** Medium\
> **Link:** [LeetCode – Longest Nice Subarray](https://leetcode.com/problems/longest-nice-subarray/)

---

## Problem

- You are given an array `nums` consisting of **positive** integers.

- We call a subarray of `nums` **nice** if the bitwise **AND** of every pair of elements that are in **different positions in the subarray is equal to `0`.

- Return _the length of the longest nice subarray_.

A **subarray** is a **contiguous** part of an array.

**Note** that subarrays of length `1` are always considered nice.

---

## 🧩 Breakdown

The problem itself over-complicates what is being asked.

- We are given an array of positive integers -> "nums"
- We want to find the longest subarray where the bitwise "AND" (a.k.a the "&" operator) of every pair within the subarray is equal to 0.
  - In other words, for any two elements a and b in the subarray (where a ≠ b) and a & b == 0.

Finally, we **return the length of the longest nice subarray**.

---

## 🧠 Approach

To find the longest subarray that satisfies the criteria, we can handle the case of an an array of length 1 or 0: here we can just return the len of the array.

For all other cases, we can use a sliding window approach: keeping track of the start and end of the current subarray as well as the largest subarray found.

- Initialize helper variables
  - start = the beginning of the array
  - end = the second value of the array
  - res = 1, because any value x "x & x" will equal 0
- Starting at the beginning of the array, we can confirm that the bitwise "AND between every value in the the current subarray (starting as just the first and second value) equals 0.
- Make sure to keep track of current subarray length
- If this is true for all values, we move the end of the subarray to the next value and iterate current subarray count.
- If this in not true update res if the subarray has a greater length.

A neat trick we can use to avoid having to check every pairing within each subarray is checking the sum of the current subarray with the next value. Basically, if "3 & 8 == 0", we can check if "11 & 48 == 0". By checking the sum, we can efficiently confirm that the bitwise of both 3 and 8 equal 0 when compared with 48.

- This technique has a faster runtime than keeping track of the subarray's bitmask and works effectively as a solution to this problem.

> **Complexity:**

- Time: O(n)
- Space: O(1)

---

## 🧮 Code – Python

```python
class Solution:
  def longestNiceSubarray(self, nums: List[int]) -> int:
    size = len(nums)

    if size < 2:
      return size

    start, end, res = 0, 1, 1

    while start < len(nums):
      total = nums[start]
      cur_count = 1

      while end < size and total & nums[end] == 0:
        total += nums[end]
        cur_count += 1
        end += 1

      res = max(res, cur_count)
      start += 1
      end = start + 1

    return res
```

---

## Proof

![Solution](/post-images/longest-nice-subarray.png)
