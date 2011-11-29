Solution overview
=================
The following is a brief description of how the code works, with important concepts emphasized. 

A game consists of a number of *turns*. Each of Lil's turns has *signals* associated with it. A turn may be *unresolved*, meaning that is has signals associated with it. Any turn may be asked for its list of *resolutions*. For a turn with no associated signals, this is simply [self]. For a turn with 3 signals, there will be 3 resolutions. 

Each turn consists of a number of *actions* (eg. "+5C:Shady") and a possibly empty list of signals. A signal is itself an array of actions. 

A *table* is responsible for keeping track of the players' *hands*, the cards in *transit* (ie. being passed between players) and the *discards*. The table can *apply* a resolved turn to itself, returning an updated table or nil if the turn was invalid. 

There are a few supporting classes
* *Simulation* contains the actual recursive algorithm described below
* *Puzzle* generates the required output format
* *ActionParser* and *TurnParser* translates the input format to instances of the model classes
* The file *solver.rb* is the entry point and is responsible for file I/O

The way the puzzle is actually solved has two main parts. 

1 Find a valid combination of signals
-------------------------------------
This is done by trying to apply all turn resolutions recursively to the table, looking for a valid path of resolutions all the way through the game. For each turn, the resolutions are tried one by one, each of which attempts will recursively try all resolutions of the next turn. This happens in Simulation#apply_turn. 

Most turns have no signals so they only have one resolution. 

2 Detecting valid turn applications
-----------------------------------
In order to determine whether a turn resolution is "valid", we simply try to apply it to the table. 

When applying a turn, the table
* Checks that a card is not introduced into the game twice (I expected there to be more checks, but this actually seems to cover it)
* Moves cards around between hands, transit and discards according to the actions
* Ignores unresolved actions (eg. "+??:Lil")

Table#apply! is where this is done. 

Notes
=====
I found this puzzle really tricky. It took me hundreds of kilometers on the motorway to finally break it :-)
Also, a good dose of TDD helped a lot on this one as well. 

I think the code has turned out somewhat readable, and I have added a few comments to the top of most files. 

A few general notes: 
* I don't use the "round" concept for anything. A game consists of a number of turns. 
* Any player's turn may have associated actions, not just Lil's
* In fact, I don't distinguish between the players at all in the simulation
* The table distinguishes between the discard pile and cards in transit. This is not strictly necessary, but I think it improves readability. 

These choices make my code more generic, but they may also stand in
the way of some clever shortcuts. Because obviously I'm not using all
information given in the puzzle text.

Instead I'm simply running the simulation, recursively checking which
"turn resolutions" (turn + signal) prove valid all the way to the end
of the game.

