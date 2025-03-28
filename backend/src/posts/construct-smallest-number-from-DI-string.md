---
title: Construct Smallest Number From DI String
tags:
  - '#2375'
  - Medium
  - LeetCode
summary: Backtracking using stack.
createdat: 2025-03-19T12-01-44
slug: fd532465-8242-4ec5-869b-80212b21e28b
---

# Construct Smallest Number From DI String – LeetCode #2375

> **Difficulty:** Medium\
> **Link:** [LeetCode – Construct Smallest Number From DI String](https://leetcode.com/problems/construct-smallest-number-from-di-string/)

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

## 🧮 Code – Python

```python
class Solution:
  def smallestNumber(self, pattern: str) -> str:

    uniques = set(list(pattern))

    if len(uniques) == 1:
      if list(uniques)[0] == 'I':
        return "".join([str(i) for i in range(1, len(pattern) + 2)])
      else:
        return "".join([str(i) for i in range(len(pattern) + 1, 0, -1)])

    res = ""
    stack = []

    for i in range(len(pattern) + 1):
      stack.append(i + 1)

      if i == len(pattern) or pattern[i] == 'I':
        while stack:
          res += str(stack.pop())

    return res
```

---

## Proof

![Solution](/post-images/construct-smallest-number-from-DI-string.png)
