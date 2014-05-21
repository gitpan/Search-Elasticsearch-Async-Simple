package Search::Elasticsearch::Role::Client::Async::Simple;

use Moo::Role;

use namespace::clean;

with 'Search::Elasticsearch::Role::Client';


sub perform_request {
	my $self = shift();
	my $cb   = pop();

	my $req = $self->parse_request(@_);

	$self->transport->perform_request($req, $cb);

	return;
}


1;


__END__

=head1 NAME

Search::Elasticsearch::Role::Client::Async::Simple - Provides common functionality for asynchronous client implementations

=head1 DESCRIPTION

See L<Search::Elasticsearch::Role::Client> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
