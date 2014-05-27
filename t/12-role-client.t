#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Client::Async::Simple';
}

BEGIN {
	package Local::Client;

	use Moo;

	with 'Search::Elasticsearch::Role::Client::Async::Simple';

	sub parse_request {}
}

BEGIN {
	package Local::Transport;

	use Moo;
	use Test::More;

	sub perform_request {
		ok 3 == @_;
		is ref($_[2]), 'CODE';

		$_[2]->();
	}
}

my $obj = Local::Client->new(logger => undef, transport => Local::Transport->new);

ok $obj->can('perform_request');

my $val;

$obj->perform_request(sub { $val = 'foo'; });
is $val, 'foo';


done_testing;
