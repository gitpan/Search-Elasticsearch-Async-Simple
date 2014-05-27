#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use Module::Runtime qw(module_notional_filename);


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Is_Async::Fake';
}

ok exists($INC{module_notional_filename('Search::Elasticsearch::Role::Is_Async')});


done_testing;
