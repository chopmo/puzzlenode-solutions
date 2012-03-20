# [[#4] Robots vs. Lasers](http://puzzlenode.com/puzzles/4-robots-vs-lasers)

_This puzzle was contributed by Gregory Brown and published on March 15, 2011_

The Robot Decommissioning Factory is not one of the Industrial Power's most pleasant facilities. This may have something to do with the fact that it is essentially nothing more than a place where robots load themselves onto conveyor belts and then get blown to bits by a series of high powered lasers. Others say that it is because the factory cafeteria serves absolutely horrible roast beef sandwiches each day for lunch, but since that's true of all Industrial Powers facilities, most tend to be skeptical of this alternative explanation. In any case, the robots and lasers are the more interesting part of the story, and deserve more attention than the sandwiches.

The process for decommissioning an Industrial Powers robot is relatively straightforward, in the way that most evil plans are. When a robot is remotely marked by the Administration for decommissioning, the robot immediately stops what it is doing and reports to the Robot Decommissioning Factory. After entering through the main bay doors on the front side of the factory, the robot finds the nearest entrance to a conveyor belt and then runs a small analysis program. This program determines the positions of all the lasers that are mounted on the conveyor and then selects the direction to move the conveyor which will maximize the damage done to the robot. This process is then repeated as many times as necessary until the robot has been successfully turned into scrap metal.

When left undisturbed, this procedure works flawlessly. Industrial Powers has worked out the exact number of redundant conveyors and laser arrays necessary to ensure that no robot can make it out of the factory without being decommissioned, even though a few get within inches of the factory exit on occasion due to the rare laser malfunction on earlier conveyors. Unfortunately for Industrial Powers, the procedure will soon be disturbed by a disgruntled hacker named Hannah who got fed up with eating the horrible roast beef sandwiches they've been cooking up.

Hannah was one of the original programmers who wrote the deconstruction procedure for Industrial Powers. Because of her role in the project, she knows that the general algorithm for the procedure looks something like this:

* Note that the conveyor belt moves one click at a time; lasers on the north side fire on even clicks, and lasers on the south side fire on odd clicks.

* Get the positions of all lasers mounted on the north side of the conveyor, all lasers mounted on the
  south side of the conveyor, and the starting position of the robot on the conveyor belt.

* Determine how many times the robot would get hit by a laser if it heads west, and how many times it would get hit if it heads east. Choose east if it's the more damaging direction, and choose west otherwise (even if the damage is equal in both directions).

Choking down her last bite of the unbearable roast beef sandwich, Hannah chuckles when she ponders what would happen if she made a tiny change to the deconstruction procedure, inverting it to pick the least damaging direction instead. But rather than doing the dirty work herself, she has decided to delegate the task to you, her trusty sidekick. While she claims that deploying this change will serve as a selfless act of sacrifice for Robot Freedom, you know that she's secretly just in it for the lulz. Of course, that doesn't stop you from rising to the challenge anyway.

## Problem

Write a program that will minimize rather than maximize the damage done to the robots in the Robot Decommissioning Factory by choosing the direction to send the conveyor belt that results in the least amount of laser hits.

## Input

Upon entering the factory, the robot is given a text file which outlines the whole factory floor, and where it will enter each conveyor belt. In the file, each conveyor layout is separated by a blank line. `X` represents the robot, `|` represents a laser, and both `#` and `-` are just placeholders that show how many clicks apart things are in the layout.

    #|#|#|##
    ---X----
    ###||###

    ##|#|#|#
    ----X---
    ###||###

    ##|#|#|#
    ----X---
    ###|||##

## Output

The robot is responsible for issuing simple commands to the conveyor controller once it has reached its starting position. These commands are listed one per line, one for each conveyor.

    GO WEST
    GO EAST
    GO WEST

## Example

Given a conveyor such as the one shown below, we need to compute which direction will minimize the damage done to the robot.

    #|#|#|##
    ---X----
    ###||###

Suppose we decide to go west. Then on click 0, the north side laser will shoot our robot because it's an even click. On click 1, there is no laser to the south, the robot does not get hit. On click 2, there is a laser to the north and it's an even click so it fires, now our robot has been hit twice. On click 3, there is nothing to the south, and on click 4 the robot exits the conveyor. That means the cost of going west is getting hit twice.

Suppose we go east instead. The robot gets hit on click 0 by the north side laser. Now on click 1, there is a laser to the south and the robot gets a second hit. On click 2, there is a laser to the north which brings the count up to three hits. This already exceeds the damage done by heading to the west, so the right command for minimizing the damage done by this conveyor is GO WEST.

If you look at the two remaining conveyors from the Input and Output examples, you'll see on conveyor 2, the map is inverted and so it's best to GO EAST instead. But the third conveyor results in getting hit 3 times regardless of whether the robot goes east or west, so according to the original algorithm, the right action is to GO WEST by default.

You can use this example scenario to test your program before submitting your answers for the real data set.