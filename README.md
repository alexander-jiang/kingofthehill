# kingofthehill
A 5-player trick-based card game.

Classes:
- Card: a single card (has a rank and a suit, black joker and red joker have separate suits: black and red?)
- Player: a player (has a list of cards and a name)
- Trick: the cards played in a single trick (and the players that the cards belonged to)
- Game: responsible for setup and processing and prompting player input
- Rules: responsible for enforcing rules (needs to be able to see players' cards)
