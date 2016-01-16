use strict;
use KOTH::Player;
use KOTH::CardStack;
use KOTH::Hand;

package KOTH::Round;

sub new {
    my $class = shift;    
    my $self = {
        _deal_order => shift, #hash must be scalars!!!
        _is_first_round => shift,
        _trump_rank => shift,
        _trump_suit => "",
        _koth => undef,
        _dead_hand => undef,
        _called_card => undef,
        _defenders => [],
        _player_points => {}
    };
    bless $self, $class;
    return $self;
}

sub startRound {
    my $self = $_[0];
    # construct the stack of two 54-card decks to draw from
    my $drawStack = new KOTH::CardStack();
    my $numDecks = 2;
    my @ranks = qw(2 3 4 5 6 7 8 9 T J Q K A);
    my @suits = qw(C D H S);
    my $i = 1;
    while ($i <= $numDecks) {
        foreach my $rank (@ranks) {
            foreach my $suit (@suits) {
                $drawStack->addCard(new KOTH::Card($rank, $suit));
            }
        }
        $drawStack->addCard(new KOTH::Card("~", "R"));
        $drawStack->addCard(new KOTH::Card("~", "B"));
        $i++;
    }
    print "decks constructed! shuffling...\n";
    $drawStack->shuffleDeck();
    
    # deal cards to players
    print "done shuffling! now dealing...\n";
    my @dealOrder = $self->{_deal_order};
    my $numPlayers = @dealOrder;
    for (my $numCards = 1; $numCards <= 20; $numCards++) {
        for (my $i = 0; $i < $numPlayers; $i++) {
            my $cardRef = $drawStack->removeCard();
            my $player = $dealOrder[$i];
            $player->{_hand}->addCard($cardRef);
        }   
    }
    
    foreach my $player (@dealOrder) {
        print "name: " . $player->{_name} . "\n";
        print "hand: " . $player->{_hand}->printCards() . "\n";
    }
}

package Main;
my @dealOrder = (
    new KOTH::Player("Alex", new KOTH::Hand()),
    new KOTH::Player("Bane", new KOTH::Hand()),
    new KOTH::Player("Cina", new KOTH::Hand()),
    new KOTH::Player("Davi", new KOTH::Hand()),
    new KOTH::Player("Earl", new KOTH::Hand())
);

my $round = new KOTH::Round(@dealOrder, 1, "2");
$round->startRound();


1;