# [[#8] Best Scrabble Opening](http://puzzlenode.com/puzzles/8-best-scrabble-opening)

_This puzzle was contributed by Alberto Fernández-Capel and published on May 15, 2011_

# Best Scrabble Opening

In this puzzle you will try to find the best first move in a Scrabble-like game. You will be given:

- A set of lettered tiles. Each tile have a letter and a value. If two tiles have the same letter, they will have the same value.
- A dictionary of the words you can use. Be careful, because not all the words in the dictionary will be compatible with your tiles.
- A board divided into squares. Each square will have an associated multiplication factor.

You can form words anywhere you want on the board, but they should read from left to right or from top to bottom. When forming a word, your points are calculated by multiplying the value of each letter by the value of the square in the board.

## Problem

Your task is to find the best opening word and its position on the board.

## Example

### Input

Given the following scrabble.json input file:

```
{
  "board": [
      "1 1 1 1 1 1 1 1 1 1 1 1",
      "1 1 1 2 1 2 1 1 1 1 1 1",
      "1 2 1 1 1 3 1 1 1 1 2 1",
      "2 1 1 1 1 1 1 1 1 2 2 1",
      "1 1 1 2 1 1 1 1 1 1 1 1",
      "1 1 1 1 1 1 2 1 1 1 2 1",
      "1 1 1 1 1 1 1 1 2 1 1 1",
      "1 1 1 1 1 1 1 1 1 1 1 2",
      "1 1 1 1 1 1 1 1 1 1 1 1"
  ],
  "dictionary": [
    "gyre",
    "gimble",
    "wabe",
    "mimsy",
    "borogoves",
    "raths",
    "outgrabe",
    "jabberwock",
    "jubjub",
    "shun",
    "frumious",
    "bandersnatch",
    "vorpal",
    "manxome",
    "foe",
    "tumtum",
    "uffish",
    "whiffling",
    "tulgey",
    "burbled",
    "galumphing",
    "frabjous",
    "callooh",
    "callay",
    "chortled",
    "brillig",
    "slithy",
    "toves",
    "gyre",
    "gimble",
    "mome"
  ],
  "tiles": [
    "i4",
    "w5",
    "g6",
    "f7",
    "s2",
    "e1",
    "l3",
    "h8",
    "n1",
    "f7",
    "b8",
    "r12",
    "u3",
    "g6",
    "i4",
    "q9",
    "o3",
    "d2",
    "s2",
    "f7"
  ]
}
```

### Output

Your program should find the opening move that generates the most points. The output should be the board with the letters placed in the appropriate position, like this:

```
1 1 1 1 1 1 1 1 1 1 1 1
1 1 1 2 1 2 1 1 1 1 1 1
1 2 w h i f f l i n g 1
2 1 1 1 1 1 1 1 1 2 2 1
1 1 1 2 1 1 1 1 1 1 1 1
1 1 1 1 1 1 2 1 1 1 2 1
1 1 1 1 1 1 1 1 2 1 1 1
1 1 1 1 1 1 1 1 1 1 1 2
1 1 1 1 1 1 1 1 1 1 1 1
```