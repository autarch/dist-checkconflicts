#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Fatal;
use lib 't/lib/02';

{
    use_ok('Foo::Conflicts::Good');
    is_deeply(
        [ Foo::Conflicts::Good->calculate_conflicts ],
        [],
        "correct versions for all conflicts",
    );
    is(
        exception { Foo::Conflicts::Good->check_conflicts },
        undef,
        "no conflict error"
    );
}

{
    use_ok('Foo::Conflicts::Bad');
    is_deeply(
        [ Foo::Conflicts::Bad->calculate_conflicts ],
        [
            { package => 'Foo',      installed => '0.02', required => '0.03' },
            { package => 'Foo::Two', installed => '0.02', required => '0.02' },
        ],
        "correct versions for all conflicts",
    );
    is(
        exception { Foo::Conflicts::Bad->check_conflicts },
        "Conflicts detected for Foo::Conflicts::Bad:\n  Foo is version 0.02, but must be greater than version 0.03\n  Foo::Two is version 0.02, but must be greater than version 0.02\n",
        "correct conflict error"
    );
}

{
    use_ok('Bar::Conflicts::Good');
    is_deeply(
        [ Bar::Conflicts::Good->calculate_conflicts ],
        [],
        "correct versions for all conflicts",
    );
    is(
        exception { Bar::Conflicts::Good->check_conflicts },
        undef,
        "no conflict error"
    );
}

{
    use_ok('Bar::Conflicts::Bad');
    is_deeply(
        [ Bar::Conflicts::Bad->calculate_conflicts ],
        [
            { package => 'Bar',      installed => '0.02', required => '0.03' },
            { package => 'Bar::Two', installed => '0.02', required => '0.02' },
        ],
        "correct versions for all conflicts",
    );
    is(
        exception { Bar::Conflicts::Bad->check_conflicts },
        "Conflicts detected for Bar::Conflicts::Bad:\n  Bar is version 0.02, but must be greater than version 0.03\n  Bar::Two is version 0.02, but must be greater than version 0.02\n",
        "correct conflict error"
    );
}

done_testing;
