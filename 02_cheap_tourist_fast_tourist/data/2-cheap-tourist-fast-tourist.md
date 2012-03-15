# [[#2] Cheap tourist, fast tourist](http://puzzlenode.com/puzzles/2-cheap-tourist-fast-tourist)

_This puzzle was contributed by Felipe Doria and published on March 15, 2011_

*UPDATE #1: Previous versions of the solution file for this problem had whitespace issues. Please re-upload if you were having problems before*

*UPDATE #2: Note that in the example below, flight plans are for a single day and may not span across multiple days*

*UPDATE #3: We have discovered that our solution to this problem is invalid. A new solution will be uploaded soon, until then, please hold off on submitting your solution to this problem* 

*UPDATE #4: We have uploaded a revised solution. Please resume submitting answers!*

*UPDATE #5: We have discovered that our solution is non-unique and have updated the description to include rules about how to break ties. Please re-read the problem description and resubmit if needed*

Steve and Jennifer are planning a trip across the country. No airline offers direct flights to their destination, so they are having a hard time choosing the appropriate sequence of flights to take. Steve is quite cheap so he wants the least expensive sequence of flights. Jennifer on the other hand hates spending time in planes and airports so she wants the quickest sequence between their origin and destination.

After a heated discussion they decide that each one will take a different sequence of flights and meet at the destination city's hotel.

Note that even if they are quite picky they are not stupid. If there are two flight sequences that take the same time, Jennifer will pick the cheapest of the two, and if there are two flight sequences that cost the same, Steve will pick the fastest one.

All the flights are scheduled for a single day and both Steve and Jennifer trips should happen within this day (they can't take a multi-day flight).

Problem
-------

Given that Steve and Jennifer want to travel from city A to city Z, find the sequence of flights most suitable for each one. Steve wants the cheapest sequence whereas Jennifer wants the fastest.

Input
-----

The first line of the input file contains an integer specifying the number of test cases. Each test case is preceded by a blank line.

Each test case starts with a single number N giving the number of flights available. Each of the following N lines contains data for one flight in the format "FROM TO DEPARTURE ARRIVAL PRICE", where DEPARTURE is the time that the plane leaves the FROM city, ARRIVAL is the time that the plane reaches the TO city, and PRICE is how much the ticket cost.

Output
------

For each test case output two lines with the information about the sequence of flights chosen in the format "DEPARTURE ARRIVAL PRICE", where DEPARTURE is the time that the first flight leaves city A, ARRIVAL is the time that the last flight reaches city Z and PRICE is the total cost for the trip.

The first line should show info about Steve's sequence and the second about Jennifer's.

Example
-------

### Input

    2

    3
    A B 09:00 10:00 100.00
    B Z 11:30 13:30 100.00
    A Z 10:00 12:00 300.00

    7
    A B 08:00 09:00 50.00
    A B 12:00 13:00 300.00
    A C 14:00 15:30 175.00
    B C 10:00 11:00 75.00
    B Z 15:00 16:30 250.00
    C B 15:45 16:45 50.00
    C Z 16:00 19:00 100.00

### Output

    09:00 13:30 200.00
    10:00 12:00 300.00

    08:00 19:00 225.00
    12:00 16:30 550.00

You can use the sample files from this example to test your program before submitting an answer for the real dataset for this problem.