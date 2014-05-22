#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use B ();


BEGIN {
	use_ok 'Search::Elasticsearch::Role::Client::Async::Simple::Direct';
}

BEGIN {
	package My::Client;

	use Moo;

	with 'Search::Elasticsearch::Role::Client::Async::Simple::Direct';
}

ok (My::Client->can('_install_api'));
is exporter('My::Client::_install_api'), 'Search::Elasticsearch::Role::Client::Async::Simple::Direct';

ok (My::Client->can('perform_request'));
is exporter('My::Client::perform_request'), 'Search::Elasticsearch::Role::Client::Async::Simple';


done_testing;


sub exporter {
	no strict 'refs';
	return B::svref_2object(\&{$_[0]})->GV->STASH->NAME;
}
