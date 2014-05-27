#!/usr/bin/env perl

use strict;
use warnings;

use AnyEvent ();
use DDP;
use Future ();
use Search::Elasticsearch::Async::Simple ();


my $e = Search::Elasticsearch::Async::Simple->new;
my $c = AnyEvent->condvar;
my $f = Future->new;

$e->cluster->health(sub { $f->done(@_) });
$f->on_done(sub { $c->send(@_) });
p($c->recv());
