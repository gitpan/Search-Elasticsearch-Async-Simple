package Search::Elasticsearch::CxnPool::Async::Simple::Sniff;

use Moo;

use Search::Elasticsearch::Util qw(new_error);

use namespace::clean;

with 'Search::Elasticsearch::Role::CxnPool::Sniff',
     'Search::Elasticsearch::Role::Is_Async';


sub next_cxn {
	my ($self, $cb) = @_;

	if ($self->next_sniff <= time()) {
		$self->sniff(sub {
			$self->_next_cxn($cb);
		});
	}
	else {
		$self->_next_cxn($cb);
	}

	return;
}

sub _next_cxn {
	my ($self, $cb) = @_;

	my $cxns = $self->cxns;
	my $cnt  = @$cxns;

	while (0 < $cnt--) {
		my $cxn = $cxns->[$self->next_cxn_num];

		return $cb->($cxn) if $cxn->is_live;
	}

	local $@ = new_error('NoNodes', 'No nodes are available: [' . $self->cxns_seeds_str . ']');

	$cb->();
}

sub sniff {
	my ($self, $cb) = @_;

	my $cxns = $self->cxns;
	my (%seen, @skip);

	my $sub; $sub = sub {
		my $cnt = @$cxns;
		my $fnd;

		if ($cnt > keys(%seen)) {
			while ($cnt--) {
				my $cxn = $cxns->[$self->next_cxn_num];

				next if $seen{$cxn}++;

				if ($cxn->is_dead) {
					push(@skip, $cxn);
				}
				else {
					return $self->sniff_cxn($cxn, sub {
						return $cb->() if $_[0];
						$cxn->mark_dead();
						$sub->();
					});
				}
			}
		}

		if (my $cxn = shift(@skip)) {
			return $self->sniff_cxn($cxn, sub {
				return $cb->() if $_[0];
				$sub->();
			});
		}

		$self->logger->infof('No live nodes available. Trying seed nodes.');
		$self->_sniff_seed_nodes($cb);
	};

	$sub->();

	return;
}

sub _sniff_seed_nodes {
	my ($self, $cb) = @_;

	my $idx = 0;

	my $sub; $sub = sub {
		my $nods = $self->seed_nodes;

		return $cb->() if $idx >= @$nods;

		my $cxn = $self->cxn_factory->new_cxn($nods->[$idx++]);

		$self->sniff_cxn($cxn, sub {
			return $cb->() if $_[0];
			$sub->();
		});
	};

	$sub->();

	return;
}

sub sniff_cxn {
	my ($self, $cxn, $cb) = @_;

	$cxn->sniff(sub {
		$cb->($self->parse_sniff($cxn->protocol, $_[0]));
	});

	return;
}


1;


__END__

=head1 NAME

Search::Elasticsearch::CxnPool::Async::Simple::Sniff - An asynchronous connection pool for connecting to a local cluster with a dynamic node list

=head1 DESCRIPTION

See L<Search::Elasticsearch::CxnPool::Sniff> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
