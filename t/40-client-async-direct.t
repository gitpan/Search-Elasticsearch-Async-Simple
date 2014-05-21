#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	require Search::Elasticsearch::Async::Simple;
	use_ok 'Search::Elasticsearch::Client::Async::Simple::Direct';
}


done_testing;
