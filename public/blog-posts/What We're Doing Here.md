---
tags:
  - TheBeginning
  - LeetFrog
Summary: Venting and figuring it out.
CreatedAt: 2025-02-04T22:46:00
Title: 2375 - Construct Smallest Number From DI String
slug: ec2de42e32729cba4a75
---

# 2375. Constuct Smallest Number From DI String

## Pre-thoughts

check if all values are I or D. then i can just return an ordered or reverse-order list on 1 -> n+1

## First attempt

My first idea was to iterate though each index and use the last (highest) number was used for each 'D'.

This doesn't work because the question specifies that we return the number that is the smallest.

`"123948765" > "123549876"`

## Second attempt

Take into account that the result needed to be the smallest possible result that satisfies these conditions, I had a change of thought to create a new list of append the number of consecutive times a value is shown.

`["I", "I", "I", "D", "I", "D", "D", "D"] == ["3I", "1D", "1I", "3D"]`

I would then take a list of 1 -> n+1 and split it into 2 lists, increasing and decreasing. then I would loop through the original list and build an answer by taking the smallest x number of values from the associated sub-list based on the subscript "I" or "D".

I believe this would be a valid approach, however, I decided not to go through with it as I felt it's computational efficiency was low and that this solution would exceed LeetCode's time limit.

## Third attempt (watch a video)

After watch a video of the solution, I found that using a stack was a great method to accomplish what I wanted to in my 2nd attempt. By introducing a stack and popping everything each time an "I" is seen, we can have achieve exactly what I was hoping to do in my brainstorm.
