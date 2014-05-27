#!/usr/bin/env perl

use strict;
use warnings;

use AnyEvent ();
use DDP;
use Search::Elasticsearch::Async::Simple ();


my $e = Search::Elasticsearch::Async::Simple->new;
my $c = AnyEvent->condvar;

$e->cluster->health(sub { $c->send(@_) });
p($c->recv());
