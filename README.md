The kgame package adds the following:
 - A simulated Deck
 - A simulated Hand
 - A simulated Discard

functions:

DRAW x - Draws x cards from your deck. If your deck is empty, it shuffles your discard and puts it in your deck, emptying your discard.

DISCARD x - Discards x card
DISCARD ALL - Discards all your cards.
BUY x - takes x from the ground, and adds it to your discard
TAKE x - takes x from the ground, and adds it to your hand.
SHOWHAND - echos the cards currently in your hand.
TRASH x - Removes the card from your hand, but does not discard it. (Trashes it)
SHUFFLE - Shuffles your discard into your deck.
