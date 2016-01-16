use strict;
use KOTH::Card;
use List::Util;
package KOTH::CardPile;

sub new
{
    my $class = shift;
    my $self = {
        _cardseq => ()
    };
    bless $self, $class;
    return $self;
}
sub cardExists{
    my $self = $_[0];
    my $other_card = $_[1];
    foreach my $pile_card ($self->_cardseq){
        if ($pile_card->identical($other_card)) {
            return 1;
        }
    return 0;    
    }
}
sub addCard{
    my $self = $_[0];
    my $icard = $_[1];
    my @newcardseq = $self->{_cardseq};
    push @newcardseq, $icard;
    $self->{_cardseq} = @newcardseq;
    return $self;
}
sub removeCard{
    my $self = $_[0];
    my $icard = $_[1];
    my $index = 0;
    my @newcardseq = $self->{_cardseq};
    my $idxcard = $newcardseq[$index];
    until($idxcard->identical($icard)){
        $index++;
        if($index >= scalar(@newcardseq)) {
            return undef;
        }
    }
    splice(@newcardseq, $index, 1);
    $self->{_cardseq} = @newcardseq;
    return $icard; 
}
sub shuffleDeck{
    my($self) = @_;
    my @newcardseq = $self->{_cardseq};
    my $idx = $self->{_cardseq};
    while ( --$idx )
    {
        my $jdx = int rand( $idx+1 );
        @newcardseq[$idx,$jdx] = @newcardseq[$jdx,$idx];
    }
    $self->{_cardseq} = @newcardseq;
    return $self;
}
1;
=block comment because reasons
package Derp;
my $card1 = new KOTH::Card('1', 'H');
my $card2 = new KOTH::Card('2', 'H');
my $card3 = new KOTH::Card('3', 'H');
my $card4 = new KOTH::Card('4', 'H');
my $cardpil = new KOTH::CardPile();
$cardpil->addCard($card1);

my @array = (0...100);
my $i = @array;
while ( --$i )
{
    my $j = int rand( $i+1 );
    @array[$i,$j] = @array[$j,$i];
}
print "@array"
=cut