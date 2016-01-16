use strict;
use KOTH::Hand;

package KOTH::Player;

sub new {
    my $class = shift;
    my $self = {
        _name => shift,
        _hand => shift
    };
    bless $self, $class;
    return $self;
}


1;