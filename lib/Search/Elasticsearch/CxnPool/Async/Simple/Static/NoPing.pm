package Search::Elasticsearch::CxnPool::Async::Simple::Static::NoPing;

use Moo;

use Search::Elasticsearch::Util qw(new_error);

use namespace::clean;

with 'Search::Elasticsearch::Role::CxnPool::Static::NoPing',
     'Search::Elasticsearch::Role::Is_Async';


sub next_cxn {
	my ($self, $cb) = @_;

	my $cxns = $self->cxns;
	my $cnt  = @$cxns;
	my $dead = $self->_dead_cxns;

	while ($cnt--) {
		my $cxn = $cxns->[$self->next_cxn_num];

		return $cb->($cxn) if $cxn->is_live || $cxn->next_ping < time();

		push(@$dead, $cxn) unless grep { $_ eq $cxn } @$dead;
	}

	if (@$dead && $self->retries <= $self->max_retries) {
		$_->force_ping for @$dead;

		return $cb->(shift(@$dead));
	}

	local $@ = new_error('NoNodes', 'No nodes are available: [' . $self->cxns_str . ']');

	$cb->();

	return;
}


1;


__END__

=head1 NAME

Search::Elasticsearch::CxnPool::Async::Simple::Static::NoPing - An asynchronous connection pool for connecting to a remote cluster without the ability to ping

=head1 DESCRIPTION

See L<Search::Elasticsearch::CxnPool::Static::NoPing> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
