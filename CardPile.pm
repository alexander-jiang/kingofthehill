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
        $idxcard = @{$self->{_cardseq}}[$index];
        if($index >= scalar(@{$self->{_cardseq}})) {
            print "failed\n";
            return undef;
        }
    }
    splice(@{$self->{_cardseq}}, $index, 1);
    return $icard; 
}
sub shuffleDeck{ #don't shuffle an empty cardpile or cardstack
    my($self) = @_;
    #my @newcardseq = $self->{_cardseq};
    my $idx = scalar(@{$self->{_cardseq}});
    #print $idx;
    while ( --$idx )
    {
        my $jdx = int rand( $idx+1 );
        #foreach my $caird (@{$self->{_cardseq}}){
        #    print $caird->getRank . $caird->getSuit . " "; 
        #}
        my $idxcard = @{$self->{_cardseq}}[$idx];
        my $jdxcard = @{$self->{_cardseq}}[$jdx];
        @{$self->{_cardseq}}[$idx] = $jdxcard;
        @{$self->{_cardseq}}[$jdx] = $idxcard;
        #print "\n"
    }
    #$self->{_cardseq} = @newcardseq;
    #print "end shuffle\n";
    return $self;
}
1;
#package Derp;
##my $card1 = new KOTH::Card('1', 'H');
##my $card2 = new KOTH::Card('2', 'H');
##my $card3 = new KOTH::Card('3', 'H');
##my $card4 = new KOTH::Card('4', 'H');
#my $cardpil = new KOTH::CardPile();
##$cardpil->addCard($card1);
##$cardpil->addCard($card2);
##$cardpil->addCard($card3);
##$cardpil->addCard($card4);
#my @suits = ('H', 'D', 'C', 'S');
#my @ranks = (1...10, 'J', 'K', 'Q');
#foreach my $csuit (@suits){
#    foreach my $crank (@ranks){
#        my $ncard = new KOTH::Card($crank, $csuit);
#        $cardpil->addCard($ncard);
#    }
#}
#$cardpil->shuffleDeck();



