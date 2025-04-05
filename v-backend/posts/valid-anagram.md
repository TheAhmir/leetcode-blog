---
title: Valid Anagram
tags:
  - #242
  - Easy
  - LeetCode
  - Multiple Solutions
summary: Give two strings s and t, return true if t is an anagram of s, and false otherwise.
createdat: 2025-04-04
slug: 075efcca-96b5-4411-b0ae-50465dcd2db6
---

# LeetCode #2401

> **Difficulty:** Medium\
> **Link:** [LeetCode – Valid Anagram](https://leetcode.com/problems/valid-anagram/)

---

## Note

_Anagram_: A word or phrase formed by reordering the letters of another word or phrase, such as _satin_ to _stain_.

### Example 1:

**Input**: s = "anagram", t = "nagaram"
**Output**: true

**Input**: s = "rat", t = "car"
**Output**: false

---

"Valid Anagrams" is an interesting problem, because of it's many possible acceptable solutions. To begin, the question requires that we confirm 2 requirements are met between 2 strings:

- they consist of the same letters
- each letter appears the same amount of times

It can also be understood that the strings must be the same length to satisfy these constraints -- even if both strings contain the same letters, if the length of the strings are not the same, each letter can not appear the same amount of times. I'll go over 4 uniquely interesting solutions using the Python programming language now.

## Solution 1: Counter

This solution is perhaps the simplest. Python has a very convenient class called Counter. By casting each string to a Counter, we can effectively get the counts of each letter in each string.. now we just have to compare them. This is rather is because the Counter class also has a powerful feature in that it supports comparisons between objects. This essentially means that we can simply return `Counter(x) == Counter(y)`, allowing for an awesome single line solution to determining is 2 strings are anagrams.

```python
def isAnagram(self, s: str, t: str) -> bool:
    return Counter(s) == Counter(t)
```

However, this solution obscures whats actually happening to determine whether the requirements are met, leaving question of how the counts are gathers and how they are compared to one another. By simply casting them to a new type and comparing, we aren't left with much more than knowledge of a convenient class in Python. Moreover, while many other programming languages have similar functions/classes, many don't perform the exact same calculations as Python's Counter, meaning we couldn't replicate this solution this way using other languages and without knowing how the calculations were made, we're back at square one.

## Solution 2: sorted

Next, we have a solution that is very similar to using Counted, but using a simpler method alongside particular knowledge of this problem's constraints. Python also has a unique method called sorted(). This method essentially places casts the string as a list and sorts the list in lexicographical order (i.e. from a - z). This allows us to derive a fun solution using what we know about the problem and lists. First, for 2 lists to be equal, the values at each index must be the same and the lists must be the same length. Using an understanding of the constraints, we know that 2 strings containing the same letter but with different amounts of each letter cannot be anagrams ('soak' and 'soaks' are not anagrams). Therefore, by comparing the 2 lists of sorted letters we get a cool solution that can be written as a coveted one liner.

```python
def isAnagram(self, s: str, t: str) -> bool:
    return sorted(s) == sorted(t)`
```

This solution allows us to apply the functionality of lists, unicode values (the score that gives a value to a letter and allows us to sort each string), and a deeper level of understanding of the particular problem to come up with a pretty cool solution. Moreover, although other languages might not have this specific function, most have the ability to cast a string to a list and most can then sort a list of characters. We're now able to translate the solution using other tools. However, this is still rather abstract. sorted() performs 2 separate operations under the hood (placing the strings in a list and sorting that list).

## Solution 3: count

Both previous solutions hide a lot of what we are doing to solve this problem; however, through exploring what they are doing to allow for acceptable solutions we can determine what steps must be take to solve it more manually. We can either count each letter of each word and then compare the counts or sort the strings in lexicographical order and compare them from there. Going forward we'll be looking primarily at counting each letter as this operation feels more intuitive to the question at hand. To manually count each letter we can use the aptly named count() function available in almost every language. This function essentially counts a value in an iterable and returns the count. To make for an efficient solution, we might consider looping through one string and check if the count of each letter is equal the the count of that letter in the other string. Wait. What if the other string has more characters. In this case, by just looping through one string, we might actually miss the additional letter in the other string if they aren't present in the first string. If s = 'a' and t = 'ab', by looping through s, we find that both s and t have 1 'a', but that's the last letter in s. The loop ends with us outputting `true` when the strings are not anagrams. To address we can go back to exactly why solution 2 worked -- because strings of different length can not be anagram. This means we just have to add a check that the lengths of the strings are equal. In this case, if they are of equal length and any letters are different, we'll know because the counts of each letter don't match and if the lengths are not equal we know that either letters aren't the same or the counts don't match -- in both cases we can return false.

```python
def isAnagram(self, s: str, t: str) -> bool:
    if len(s) != len(t):
        return False
    for i in s:
        if s.count(i) != t.count(i):
            return False
    return True
```

Now it's getting interesting. Using this solution we are able to effectively solve the problem by utilizing universally available functions and are able to come up with and address possible edge cases not address by the initial idea. However, the solution might be considered computationally expenses. Although we only implement one loop, we also use the count() function to count the number of occurrences of each letter. In order to get this number, the computer must do another loop through each letter keeping track of the count. Because we have our loop and 2 count() functions for each letter, we essentially loop through each letter **2 times for _each_ letter in the first string** while calculating the count for the letter in each word. This could be considered a lot of overhead for this solution.

## Solution 4: Dictionary

I might be biased, but this solution is my favorite. Through the discussion of the previous solutions, we already understand the problem and how a solution might be obtained. We just want to count and compare each letter while make sure to catch the case in which the strings are of different length. To do all of this we can use the dictionary data structure (a structure in which we map a specific key to a specific value). By using a dictionary, we can accomplish the task by mapping each letter to it's frequency. That is for each letter in a string place the letter a key pointed to 1 or add 1 to the value if the key,value pair is already present. If we then loop through the other string and subtract 1 or set the value to -1 for each letter seen, every value should be zero if both strings contain the same number of each letter. Moreover, if any letter doesn't exist in one string, it's associated value will either be 1 or -1. After looping through each string, we then just have to check if every value in the list is 0 or not.

```python
def isAnagram(self, s: str, t: str) -> bool:
    counts = {}

    for i in s:
        counts[i] = counts.get(i, 0) + 1 # set the value of i in keys to i + 1 or 0 + 1 if i isn't present
    
    for i in t:
        counts[i] = counts.get(i, 0) - 1
        if counts[i] == -1: # early exit if a value doesn't exist or if a letter has appear more times than in s
            return False
    
    for i in counts.values():
        if i != 0:
            return False

    return True
```

This solution allows us to look at each value of each string just once and catch even catch most cases early if both strings are not anagrams. Accomplishing the solution this way also allow us to have complete control and understanding of the calculations being made, limiting them to just what is needed to solve the problem at hand.

---

## Final Thoughts

It really is a cool problem! We're able to take the solution from very abstract to very concrete and are able to visualize how we got to implementing the solution ourselves! By the final solution we end up using a data structure that was likely used under the hood in the first solution. This problem showcases how we can take a problem, identify requirements or constraints to consider, examine the steps needed and the edge cases to take into account to solve, and program an effective and understandable solution minimizing unnecessary or redundant tasks. It's amazing how we're able to break down the problem to build multiple working solutions using various methods!
