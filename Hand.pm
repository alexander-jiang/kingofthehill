use strict;
use KOTH::Card;
use KOTH::CardPile;
package KOTH::Hand;

    our @ISA = ('KOTH::CardPile');

# TODO private helper that groups cards based on suit and in ascending strength for clarity
sub sortHand {

}

# TODO adds a card to the hand so that the resulting hand is "sorted"
sub addHand {

}

# necessary in this class?
sub numCards {

}

sub printHand {
    my $self = $_[0];
    foreach my $card ($self->{_cardseq}) {
        print $card->getRank() . " of " . $card->getSuit() . " ";
    }
}

1;
