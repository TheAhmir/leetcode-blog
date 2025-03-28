---
title:
tags:
summary:
createdat:
slug:
---

# [Problem Title] – LeetCode #[Number]

> **Difficulty:** Easy | Medium | Hard\
> **Link:** [LeetCode – Problem Title](https://leetcode.com/problems/problem-name/)

---

## 🧩 Problem Summary

Brief description of the problem in your own words.\
Highlight key points, constraints, and edge cases.

> **Example:**\
> Given a list of integers, return the two numbers that sum to a target.

---

## 🧠 Approach

Explain the thought process:

- Brute force idea (optional)
- Optimized strategy
- Why it works
- Time and space complexity

> **Complexity:**

- Time: O(n)
- Space: O(n)

---

## 🧮 Code – [Language Name]

```[language]
// Concise, readable code
function twoSum(nums, target) {
  const map = new Map();
  for (let i = 0; i < nums.length; i++) {
    let complement = target - nums[i];
    if (map.has(complement)) return [map.get(complement), i];
    map.set(nums[i], i);
  }
}
```
