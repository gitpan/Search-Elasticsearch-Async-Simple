package Search::Elasticsearch::Role::Client::Async::Simple::Direct;

use Moo::Role;

use Package::Stash ();

use namespace::clean;

with 'Search::Elasticsearch::Role::Client::Async::Simple';
with 'Search::Elasticsearch::Role::Client::Direct';


sub _install_api {
	my ($cls, $grp) = @_;

	my $defs = $cls->api;
	my $pkg  = Package::Stash->new($cls);

	my $re = $grp ? qr/$grp\./ : qr//;

	for my $act (keys(%$defs)) {
		my ($name) = $act =~ /^$re([^.]+)$/;

		next unless $name;
		next if $pkg->has_symbol('&' . $name);

		my %def = (name => $name, %{$defs->{$act}});

		$pkg->add_symbol(
			'&' . $name => sub {
				shift()->perform_request(\%def, @_);
				return;
			}
		);
	}
}


1;


__END__

=head1 NAME

Search::Elasticsearch::Role::Client::Async::Simple::Direct - Provides request parsing for asynchronous Direct client implementations

=head1 DESCRIPTION

See L<Search::Elasticsearch::Role::Client::Direct> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
