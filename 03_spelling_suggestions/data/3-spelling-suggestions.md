# [[#3] Spelling suggestions](http://puzzlenode.com/puzzles/3-spelling-suggestions)

_This puzzle was contributed by Carol Nichols and published on March 15, 2011_

*UPDATE: There were some issues with the input and solution data for this problem. Please re-download the input file and resubmit if you were having problems before.*

If you type the misspelling "cemetary" into a search engine today, you're likely to get a response that is something like "Did you mean cemetery?"

One way that you could write a program to offer spelling corrections of search queries is to keep a dictionary of valid words. When given a search query that is not a valid word, the program would find the best suggestion from the dictionary. In order to account for additions, deletions, and substitutions of letters, the metric for deciding on the best valid word could be the word that has the longest common sub-sequence of letters with the search query.

The longest common sub-sequence between two strings is the longest sequence of characters that appear in both strings in the same order (but not necessarily consecutively). For example, if the two strings are "numm" and "nom", the longest common subsequence between the two is "nm", of length 2.

If "numm" was our search query and the dictionary consisted of "nom" and "numb", the suggestion that would be best to make using the longest common sub-sequence as our metric would be "numb", since it has common sub-sequence of "num" (which is longer than "nm").

## Problem 

Given a misspelled search query and two candidate dictionary words, return the candidate dictionary word that has the longest common sub-sequence with the search query word.

## Input

The first line of the input file contains an integer T specifying the number of test cases. Each test case is preceded by a blank line.

The first line of each test case will be the misspelled search query. The next two lines will be the two dictionary words under consideration to be returned as the suggested correct spelling.


## Output

For each test case output a single line with the dictionary word that has the longest common sub-sequence with the search query word.


## Example

Input:

    2

    remimance
    remembrance
    reminiscence

    inndietlly
    immediately
    incidentally

Output:

    remembrance
    incidentally

You can use the sample files from this example to test your program before submitting an answer for the real dataset for this problem.