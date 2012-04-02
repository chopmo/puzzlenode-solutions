# [[#7] Blue Hawaii](http://puzzlenode.com/puzzles/7-blue-hawaii)

_This puzzle was contributed by Andrea Singh and published on May 15, 2011_

Blue Hawaii
=================

The newly opened Aloha Property Management company manages several vacation rentals in Hawaii. To speed up their response to customer inquiries, they have commissioned you to write a program to calculate the the total cost of each of their various rental units given a requested reservation period.

The rental units each have fixed and variable costs, both of which have to be taken into account when processing the inquiries. More specifically: 
 
1) Some units have seasonal rates (e.g. a winter rate and a summer rate)

2) An optional cleaning fee

3) A Transient Accommodation Sales Tax of 4.11416%


The Problem
-------------

Your task is to write a program that parses a list of rentals in `json` format and prints out the names of the rental units along with their total cost for a particular reservation period.

The Input
-----------

You will be given a `vacation_rentals.json` file containing the pertinent information for each of the different rental units. The rate attribute reflects the nightly cost. The beginning and ending date of a season, as well as the number of seasons in a year, are arbitrary.

Below is a snippet from this file outlining the details of three rental units - two with seasonal rates and one without:

    [{"name":"Fern Grove Lodge","seasons":
        [{"one":{"start":"05-06","end":"05-13","rate":"$137"}},
        {"two":{"start":"05-14","end":"04-30","rate":"$220"}}],
        "cleaning fee":"$98"},
    {"name":"Paradise Inn","rate":"$250","cleaning fee":"$120"},
    {"name":"Honu's Hideaway","seasons":
        [{"one":{"start":"02-01","end":"07-31","rate":"$165"}},
        {"two":{"start":"08-01","end":"01-31","rate":"$187"}}]}]
      
Another text file specifies the desired reservation period:

    2011/05/07 - 2011/05/20
      
The Output
-----------

For each rental, output a single line with the name of the rental, followed by a colon and the total cost in US Dollars. For example:

    Sea View Villa: $2545.98
    Lelani Breeze: $1245.67

Be sure to format your currency correctly, for example write $1234.50, not $1234.5. 
  
Notes
-----------------------

As a first step, seeing that a given rental can have different seasonal rates, you'd need to determine which seasons the reservation overlaps. In other words, the cost calculation needs to account for the fact that the nightly rate can vary over the span of the reservation. 

For example, Fern Grove Lodge defines two rental seasons:

    {"one":{"start":"05-06","end":"05-13","rate":"$137"}},
    {"two":{"start":"05-14","end":"04-30","rate":"$220"}}
            
Given the following reservation period,

    2011/05/07 - 2011/05/20
        
the booking would fall into two different seasons. 

Remember that the rate is nightly, with the check-in time being at 3pm in the afternoon and the check-out time around 11am in the morning. So for the 7 nights from May 7th to the morning of May 14th, the nightly rate of $137 would apply. The last 6 nights are in the next season (with the clients checking out in the morning of May 20) and would cost $220 per night. The total base rental cost then would be:

  
    (7 x $137) + (6 x $220) = $2279.00

Once the base rental cost has been calculated, the (optional) cleaning fee has to be added and the Sales Tax applied to the entire amount. So the total cost that would need to be returned for the reservation in this unit would be: 

    ($2279.00 + $98) x 1.0411416 = $2474.79

For the sake of simplicity, we can assume that the seasons all abut each other, don't overlap and don't have gaps between them.

Good luck!