#! /usr/bin/perl

package Player;
use Hand;

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