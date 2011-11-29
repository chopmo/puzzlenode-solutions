Solution overview
=================
The following is a brief description of how the code works, with important concepts emphasized. 

A game consists of a number of *turns*. Each of Lil's turns has *signals* associated with it. A turn may be *unresolved*, meaning that is has signals associated with it. Any turn may be asked for its *resolutions*. For a turn with no associated signals, this is simply [self], for a turn with 3 signals, there will be 3 resolutions. 

Each turn consists of a number of *actions*, for example "+5C:Shady". A signal is simply an array of actions. 

A *table* is responsible for keeping track of the players' *hands*, the cards in *transit* (ie. being passed between players) and the *discards*. The table can *apply* a resolved turn to itself, returning an updated table or nil if the turn was invalid. 

The way the puzzle is actually solved is like this: 

 1. Find the valid signal combination
-------------------------------------
This is done by applying all turn resolutions recursively to the table, looking for a valid path of signals all the way through the game. For each turn, we try all resolutions one by one, each of which attempts will try all resolutions of the next turn etc. Most turns have no signals so they only have one resolution. 

This happens in Simulation#apply_turn

 2. Detecting valid turn applications
-------------------------------------
In order to find a "valid" path through the signals, we simply keep going until some turn resolution doesn't make sense. When that happens, the recursion descibed above will bactrack and try a different path. 

When applying a turn, the table
- Moves cards around between hands, transit and discards according to the actions
- Ignores unresolved actions (eg. "+??:Lil")
- Checks that a card is not introduced into the game twice (I expected there to be more checks, but this actually seems to cover it)

Notes
=====
I found this problem really tricky. It took me hundreds of kilometers on the motorway to finally break it :-)
Also, a good dose of TDD helped a lot on this one as well. 

I think the code has turned out somewhat readable, and I have added a few comments to the top of most files. 

A few general notes: 
- I don't use the "round" concept for anything. A game consists of a number of turns. 
- Any player's turn may have associated actions, not just Lil's
- In fact, I don't distinguish between the players at all in the simulation
- The table distinguishes between the discard pile and cards in transit. This is not strictly necessary, but I think it improves readability. 

These choices make my code more generic, but they may also stand in
the way of some clever shortcuts. Because obviously I'm not using all
information given in the puzzle text.

Instead I'm simply running the simulation, recursively checking which
"turn resolutions" (turn + signal) prove valid all the way to the end
of the game.

