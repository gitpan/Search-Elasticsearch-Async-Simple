package Search::Elasticsearch::Role::Cxn::Async::Simple;

use Moo::Role;

use namespace::clean;

with 'Search::Elasticsearch::Role::Cxn';


sub pings_ok {
	my ($self, $cb) = @_;

	my $log = $self->logger;

	$log->infof('Pinging [%s]', $self->stringify)
		if $log->is_info;
	$self->perform_request(
		{
			method  => 'HEAD',
			path    => '/',
			timeout => $self->ping_timeout,
		},
		sub {
			if (@_) {
				$log->infof('Marking [%s] as live', $self->stringify)
					if $log->is_info;
				$self->mark_live();
				$cb->(1);
			}
			else {
				$log->debug($@)
					if $log->is_debug;
				$self->mark_dead();
				$cb->();
			}
		}
	);

	return;
}

sub sniff {
	my ($self, $cb) = @_;

	my $log = $self->logger;

	$log->infof('Sniffing [%s]', $self->stringify)
		if $log->is_info;
	$self->perform_request(
		{
			method  => 'GET',
			path    => '/_nodes/' . $self->protocol,
			qs      => {timeout => 1000 * $self->sniff_timeout},
			timeout => $self->sniff_request_timeout,
		},
		sub {
			if (@_) {
				$cb->($_[1]->{nodes});
			}
			else {
				$log->debug($@)
					if $log->is_debug;
				$cb->();
			}
		}
	);

	return;
}


1;


__END__

=head1 NAME

Search::Elasticsearch::Role::Cxn::Async::Simple - Provides common functionality for asynchronous connection implementations

=head1 DESCRIPTION

See L<Search::Elasticsearch::Role::Cxn> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
