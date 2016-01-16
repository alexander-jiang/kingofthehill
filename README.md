# kingofthehill
A 5-player trick-based card game.

Classes:
- **Card**:
    - Represents a single card
    - Properties:
        - _rank_ and _suit_, the rank and suit of the card, respectively, as one-character strings (e.g. "J" and "H" for the Jack of Hearts)
    - Note: The black joker and red joker have rank and suit "~" and "B" and "~" and "R" respectively
- **Player**:
    - Represents a player
    - Properties:
        - _cards_, the set of cards that the player holds (and that only the player can see);
        - _name_, the player's name
- **Trick**:
    - Represents a single trick, or hand, in the game, where each player gets one turn
    - Properties: _cards_, a sequence of pairs of a player and the card or cards that that player played, in order from first player to act to last player to act;
- **Game**:
    - Responsible for the setup before each round (e.g. shuffling cards) and tracking the ranks of players across rounds
- **Actions**:
    - Responsible for prompting player input (e.g. time limits on player actions, etc.) and processing players' inputs
- **Graphics**:
    - Responsible for displaying the graphical user interface (GUI)
- **Rules**:
    - Responsible for enforcing rules (e.g. preventing players from reneging, which means playing a card from a suit other than the leading suit of a trick if the player has a card of the leading suit, etc.).
    - Note: this class needs to be able to see players' cards to enforce rules
