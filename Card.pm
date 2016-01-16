use strict;

package KOTH::Card;
use Scalar::Util 'blessed';

# creates a new card
sub new
{
    my $class = shift;
    my $self = {
        _rank => shift,
        _suit => shift,
    };
    #print $class."\n";
    bless $self, $class;
    return $self;
}

# gets the rank of the card
sub getRank {
    my($self) = @_;
    return $self->{_rank};
}

# gets the suit of the card
sub getSuit {
    my($self) = @_;
    return $self->{_suit};
}

# returns 1 if the card is identical to arg1, returns 0 otherwise
sub identical {
    my $self = $_[0];
    my $other = $_[1];
    if (blessed($other) eq "Card" and
        $self->{_rank} eq $other->{_rank} and
        $self->{_suit} eq $other->{_suit}) {
        return 1;
    }
    else {
        return 0;
    }
}

# returns 1 if the card has the same suit as arg1, returns 0 otherwise
sub sameSuit {
    my $self = $_[0];
    my $other = $_[1];
    if (blessed($other) eq "Card" and
        $self->{_suit} eq $other->{_suit}) {
        return 1;
    }
    else {
        return 0;
    }
}

# returns 1 if the card has the same rank as arg1, returns 0 otherwise
sub sameRank {
    my $self = $_[0];
    my $other = $_[1];
    if (blessed($other) eq "Card" and
        $self->{_rank} eq $other->{_rank}) {
        return 1;
    }
    else {
        return 0;
    }
}

1;
