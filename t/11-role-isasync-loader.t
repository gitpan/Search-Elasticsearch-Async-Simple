#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use Module::Runtime qw(module_notional_filename require_module);


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Is_Async::Loader';
}

my $name = module_notional_filename('Search::Elasticsearch::Role::Is_Async');

ok exists($INC{$name});

my $orig = eval { require_module('Search::Elasticsearch::Async'); };

diag 'Search::Elasticsearch::Async ' . ($orig ? $Search::Elasticsearch::Async::VERSION : 'not') . ' installed';

like $INC{$name}, qr/Is_Async\.pm$/ if $orig;
like $INC{$name}, qr/Fake\.pm$/ unless $orig;


done_testing;
