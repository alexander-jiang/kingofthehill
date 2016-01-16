use strict;
use KOTH::Card;
use Scalar::Util 'blessed';
package KOTH::CardPile;


sub new
{
    my $class = shift;
    my $aref = [];
    my $self = {
        _cardseq => $aref
    };
    bless $self, $class;
    return $self;
}
sub cardExists{
    my $self = $_[0];
    my $other_card = $_[1];
    foreach my $pile_card (@{$self->{_cardseq}}){
        if ($pile_card->identical($other_card)) {
            return 1;
        }
    return 0;    
    }
}
sub addCard{
    my $self = $_[0];
    my $icard = $_[1];
    push @{$self->{_cardseq}}, $icard;
    #my @newcardseq = @{$self->{_cardseq}};
    #push @newcardseq, $icard;
    #shift @newcardseq; #exists to delete the infinitely nested array that somehow arrived at index 0
    ##my $hopefullycard = $newcardseq[0];
    #$self->{_cardseq} = @newcardseq;
    #print $hopefullycard->getRank();
    #print @{$self->{_cardseq}}[-1]->getRank();
    return $self;
}
sub removeCard{
    my $self = $_[0];
    my $icard = $_[1];
    my $index = 0;
    my $idxcard = @{$self->{_cardseq}}[$index];
    #print Scalar::Util::blessed($idxcard);
    until($idxcard->identical($icard)){
        $index++;
        if($index >= scalar(@{$self->{_cardseq}})) {
            return undef;
        }
    }
    splice(@{$self->{_cardseq}}, $index, 1);
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
package Derp;
my $card1 = new KOTH::Card('1', 'H');
my $card2 = new KOTH::Card('2', 'H');
my $card3 = new KOTH::Card('3', 'H');
my $card4 = new KOTH::Card('4', 'H');
my $cardpil = new KOTH::CardPile();
$cardpil->addCard($card1);
$cardpil->addCard($card2);
$cardpil->addCard($card3);
$cardpil->addCard($card4);
my $card5 = $cardpil->removeCard($card1);
print $card5->getRank();



