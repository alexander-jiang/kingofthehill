# King of the Hill
A 5-player trick-taking card game.

## Classes:
- **Card**:
    - Represents a single card
    - Properties:
        - *rank* and *suit*, the rank and suit of the card, respectively, as one-character strings (e.g. "J" and "H" for the Jack of Hearts)
    - Subroutines:
        - *identical*, returns 1 if the given card and this card have the same rank and suit and 0 otherwise
        - *sameRank*, returns 1 if the given card and this card have the same rank and 0 otherwise
        - *sameSuit*, returns 1 if the given card and this card have the same suit and 0 otherwise
    - Note: The black joker and red joker have rank and suit "~" and "B" and "~" and "R" respectively
- **CardPile**:
    - Represents an ordered sequence of cards
    - Subroutines:
        - *new*, creates an empty sequence of cards
        - *card_exists*, returns 1 if the specified card is in the CardPile and 0 otherwise
        - *remove_card*, removes a specified card from the CardPile and returns a reference to a new Card (if the card is in the CardPile)
        - *add_card*, adds a specified card to the CardPile
        - *shuffle*, randomly shuffles the cards in the CardPile
- **Hand** (inherits from **CardPile**):
    - Represents a CardPile that maintains a "sorted" order for cards by adding new cards in the correct location
    - Subroutines:
        - *new*, creates an empty Hand of cards
        - *sortHand*, [private helper] "sorts" this Hand so that the cards are in descending order of strength (strongest first, weakest last)
        - *addCard*, adds a specified card to the Hand in the correct position so that the resulting Hand is "sorted"
        - *numCards*, number of cards [necessary?]
- **CardStack** (inherits from **CardPile**):
    - Represents a stack (LIFO) of cards
    - Subroutines:
        - *new*, creates an empty stack of cards
        - *addCard*, adds the specified card to the top of the stack of cards
        - *removeCard*, removes the card at the top of the stack of cards
- **Player**:
    - Represents a player in the game
    - Properties:
        - *hand*, the Hand of cards that the player holds (and that other players cannot see);
        - *name*, the player's name
    - Subroutines:
        - *new*, creates a new player with a name and an empty hand
- **Trick**:
    - Represents a single trick, or hand, in the game, where each player gets one turn
    - Properties:
        - *round*, the round that this trick belongs to [necessary?]
        - *cards*, a sequence of ordered pairs of a player and the card(s) that that player played, in order from first to last player to act
        - *leadingPlayer*, the starting player of the round that the first card is dealt to
        - *trickSuit*, the suit of the cards that led the trick
        - *trickType*, the number of cards that led the trick (whether a single card or an identical pair of cards led the trick)
    - Subroutines:
        - *trickPoints*, the point value of the trick
        - *trickWinner*, the player who won the trick
- **Round**:
    - Responsible for setting up before each round (e.g. shuffling cards) and transitioning from drawing phase to playing phase
    - Properties:
        - *game*, the game that this round belongs to
        - *koth*, the "king of the hill" for this round
        - *trumpRank*, the trump rank of this round (determined from starting player's rank)
        - *trumpSuit*, the trump suit of this round (determined after drawing phase)
        - *startingPlayer*, the starting player of the round that the first card is dealt to
        - *dealRate*, rate at which cards are dealt in the drawing phase (about one card every 2 seconds)
        - *deadHand*, the hand of eight cards that the KotH keeps face-down until the end of the round
        - *calledCard*, the card that the KotH of the round calls. when this card is played, the player who played it becomes the KotH's teammate
        - *defenders*, a list of players on the defending team (initially only has the KotH, but updated to include the KotH's teammate, if applicable)
        - *playerPoints*, a mapping of the players to their points earned in this round
    - Subroutines:
        - *new*, starts a new round with a given starting player and a flag marking if it's the first round (if it is the first round, then the KotH is the player who declares the trump suit).
        - *dealCards*, shuffles the draw CardStack containing two 54-card decks and deals one card to each player counter-clockwise at the rate specified by *dealRate*
        - [how to let the player declare trump suit???]
- **Game**:
    - Responsible for tracking player positions relative to each other, and tracking the ranks of players across rounds
    - Properties:
        - *currentRound*, a reference to a Round object
        - *playerRanks*, a mapping of the players to their ranks
    - Subroutines:
        - *new*, starts a new game if given a list of five players with different names, otherwise throws error. randomly seats the five players and thus randomly chooses the first player to begin the game. initializes scoresheet to track each player's score.
        - *fixNumRounds*, ends the game after the specified number of rounds have been completed after the current round (specifying 0 ends the game after the end of the current round) [necessary?]
- **Actions**:
    - Responsible for prompting player input (e.g. time limits on player actions, etc.) and processing players' inputs
- **Graphics**:
    - Responsible for displaying the graphical user interface (GUI)
- **Rules**:
    - Responsible for enforcing rules (e.g. preventing players from reneging, which means playing a card from a suit other than the leading suit of a trick if the player has a card of the leading suit, etc.).
    - Note: this class needs to be able to see players' cardsets to enforce rules

## Gameplay Actions:
1. Create five new *Players* with unique names (e.g. Ali, Bob, Cat, Dan, Eve).
2. Create a new *Game* with the five *Players*, each starting at rank 2 (tracked in *playerRanks*).
3. Choose a seating order for the five *Players* that will be fixed for the rest of the *Game*.
4. All players acknowledge readiness for a *Round* to begin.
5. Create a new *Round* with one of the five *Players* assigned as the first player to deal to, and a new *CardStack* containing two 54-card decks is shuffled.
6. Is this the first *Round*?
    - If yes, then the *trumpRank* for this *Round* is 2, but the KotH for this *Round* hasn't been determined.
    - If no, then the *trumpRank* for this *Round* is the current rank of the given first player (who is also the KotH for this *Round*, who should be added to *defenders* and noted as such in *koth*).
7. For each of the 20 cards dealt to each *Player* (starting with *startingPlayer*, proceeding in counter-clockwise order):
    - If the card has the *sameRank* as the *trumpRank*, that *Player* has the ability to "declare" that suit as the *trumpSuit*.
    - If the *trumpSuit* has been "declared" already, only *Players* with an *identical* pair of cards with rank equal to the *trumpRank* have the ability to "declare" that suit as the *trumpSuit*. (same player can declare twice?)
8. If the *trumpSuit* hasn't been declared yet wait for a few seconds (about 3 seconds?), and then ask, is this the first *Round*?
    - If yes, choose a random suit as the *trumpSuit* and choose a random player as the KotH of this *Round* (and add him or her to *defenders* and note as such in *koth*).
    - If no, then *startingPlayer* (the KotH) of this *Round* has a few seconds (about 5 seconds?) to choose a suit as the *trumpSuit*. If a *trumpSuit* still hasn't been declared, a random suit will be chosen as the *trumpSuit*.
9. The remaining eight cards in the *CardStack* are added to the KotH's *Hand*.
10. KotH has about a minute (too long?) to remove any eight cards from his or her *Hand* and add those eight to the *deadHand*. If the time elapses, random cards are removed from the KotH's hand and added to the *deadHand* until the *deadHand* contains eight cards.
11. KotH has about 15 seconds (too short?) to call a card as the *CalledCard*. If the time elapses, the KotH will not be able to enlist any of the remaining players as his or her teammate.
12. All players acknowledge readiness for a *Trick* to begin (*trumpSuit* and *trumpRank* should be made clear).
13. If this is the first trick of the round, create a new *Trick* with the KotH as the *leadingPlayer*. Otherwise, create a new *Trick* with the previous *trickWinner* as the *leadingPlayer*.
14. For each *Player* to act (starting with *leadingPlayer*, proceeding in counter-clockwise order):
    - The *Player* to act has about 10 seconds to confirm the cards to be played (cannot be taken back once played).
    - If *Player* is the *leadingPlayer*, any single card or *identical* pair of cards is a "valid" play and sets the *trickSuit* and the *trickType*.
    - Otherwise, if *Player* to act has any cards "satisfying" the *trickType* and *trickSuit* requirements in his or her hand, the *Player* must choose from those combinations. Otherwise, the *Player* must only satisfy the *trickType* requirement (aka playing the same number of cards that were played to lead the trick).
    - After *Player* has played, check if *calledCard* is defined and whether *Player* has played the *calledCard*. If both are true, add the *Player* to *defenders* and set *CalledCard* to an undefined value.
15. After each *Player* has acted once, the *Trick* has ended. The *trickPoints* are calculated and awarded to the *trickWinner* (tracked in *playerPoints*).
16. If the *trickWinner*'s *Hand* is not empty, go back to step 13. Otherwise, continue to step 17.
17. For each *Player* not in *defenders*, his or her points (from *playerPoints*) are added to the *challengeScore*.
18. If the *trickWinner* is not in *defenders*, two times the "point value" of the cards in *deadHand* are added to the *challengeScore*.
19. If *challengeScore* < 80: If KotH has a teammate in *defenders*, teammate is KotH in next round. Otherwise, current KotH is KotH in next round. Additionally:
    - If *challengeScore* == 0: each *Player* in *defenders* has rank incremented by 3.
    - If 0 < *challengeScore* =< 40: each *Player* in *defenders* has rank incremented by 2.
    - If 40 < *challengeScore*: each *Player* in *defenders* has rank incremented by 1.
20. Otherwise (if *challengeScore* >= 80): next player in counter-clockwise order from KotH who is not in *defenders* is KotH in next round. Additionally:
    - If 120 =< *challengeScore* < 160: each *Player* not in *defenders* has rank incremented by 1.
    - If 160 =< *challengeScore* < 200: each *Player* not in *defenders* has rank incremented by 2.
    - If 200 =< *challengeScore*: each *Player* not in *defenders* has rank incremented by 3.
