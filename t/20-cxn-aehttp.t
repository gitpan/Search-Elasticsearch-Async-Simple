#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;


BEGIN {
	use_ok 'Search::Elasticsearch::Cxn::Async::Simple::AEHTTP';
}


done_testing;
