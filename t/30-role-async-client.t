#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Client::Async::Simple';
}

BEGIN {
	package My::Client;

	use Moo;

	with 'Search::Elasticsearch::Role::Client::Async::Simple';

	sub parse_request {}
}

BEGIN {
	package My::Transport;

	use Moo;
	use Test::More;

	sub perform_request {
		ok 3 == @_;
		is ref($_[2]), 'CODE';

		$_[2]->();
	}
}

my $obj = My::Client->new(logger => undef, transport => My::Transport->new);

ok $obj->can('perform_request');

my $val;

$obj->perform_request(sub { $val = 1; });
ok $val == 1;


done_testing;
