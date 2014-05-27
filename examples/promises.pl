#!/usr/bin/env perl

use strict;
use warnings;

use AnyEvent ();
use DDP;
use Promises qw(deferred);
use Search::Elasticsearch::Async::Simple ();


my $e = Search::Elasticsearch::Async::Simple->new;
my $c = AnyEvent->condvar;
my $d = deferred();

$e->cluster->health(sub { $d->resolve(@_) });
$d->promise()->then(sub { $c->send(@_) });
p($c->recv());
