use strict;
use KOTH::Card;
use KOTH::CardPile;
package KOTH::CardStack;

    our @ISA = ('KOTH::CardPile');
sub removeCard{
    my($self) = @_;
    my @newcardset = $self->{_cardseq};
    my $newcard = shift @newcardset;
    $self->{_cardseq} = @newcardset;
    return $newcard;
}
1;
package main;
my $stack1 = new KOTH::CardStack();
my $card1 = new KOTH::Card('5', 'H');
my $card2 = new KOTH::Card('2', 'H');
my $card3 = new KOTH::Card('3', 'H');
my $card4 = new KOTH::Card('4', 'H');
$stack1->addCard($card1);
$stack1->addCard($card2);
$stack1->addCard($card4);
$stack1->addCard($card3);
#stack1->shuffleDeck();
my $topcard = $stack1->removeCard();
print $stack1->{_cardseq};
#print $topcard->getRank();

