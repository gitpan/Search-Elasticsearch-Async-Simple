#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use B ();


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Client::Async::Simple::Direct';
}

BEGIN {
	package Local::Client;

	use Moo;

	with 'Search::Elasticsearch::Role::Client::Async::Simple::Direct';
}

ok (Local::Client->can('_install_api'));
is exporter('Local::Client::_install_api'), 'Search::Elasticsearch::Role::Client::Async::Simple::Direct';

ok (Local::Client->can('perform_request'));
is exporter('Local::Client::perform_request'), 'Search::Elasticsearch::Role::Client::Async::Simple';


done_testing;


sub exporter {
	no strict 'refs';
	return B::svref_2object(\&{$_[0]})->GV->STASH->NAME;
}
