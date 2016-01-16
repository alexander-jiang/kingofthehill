use strict;

package Card;
sub new
{
    my $class = shift;
    my $self = {
        _rank => shift,
        _suit => shift,
    };
    #print "$self->{_rank}";
    bless $self, $class;
    return $self;
}
sub getRank {
    my($self) = @_;
    return $self->{_rank};
}
sub getSuit {
    my($self) = @_;
    return $self->{_suit};
}
1;
