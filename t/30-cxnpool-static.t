#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::CxnPool::Async::Simple::Static';
}


done_testing;
