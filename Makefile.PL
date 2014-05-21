#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker;


WriteMakefile(
	NAME             => 'Search::Elasticsearch::Async::Simple',
	AUTHOR           => 'Denis Ibaev <dionys@cpan.org>',
	VERSION_FROM     => 'lib/Search/Elasticsearch/Async/Simple.pm',
	ABSTRACT_FROM    => 'lib/Search/Elasticsearch/Async/Simple.pm',
	LICENSE          => 'perl',
	MIN_PERL_VERSION => '5.8.0',
	BUILD_REQUIRES   => {
		'Test::More'            => 0,
	},
	PREREQ_PM        => {
		'namespace::clean'      => 0,
		'AnyEvent::HTTP'        => 0,
		'Moo'                   => 0,
		'Package::Stash'        => 0,
		'Search::Elasticsearch' => '1.10',
		'Time::HiRes'           => 0,
	},
	META_MERGE       => {
		resources => {
			license     => 'http://dev.perl.org/licenses/',
			repository  => 'http://github.com/dionys/search-elasticsearch-async',
			bugtracker  => 'http://github.com/dionys/search-elasticsearch-async/issues',
		},
		no_index  => {directory => ['t']},
	},
	dist             => {COMPRESS => 'gzip -9f', SUFFIX => 'gz'},
	clean            => {FILES => 'Search-Elasticsearch-Async-Simple-*'},
	test             => {TESTS => 't/*.t'},
);
