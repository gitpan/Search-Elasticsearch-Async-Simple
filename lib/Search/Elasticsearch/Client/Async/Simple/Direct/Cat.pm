package Search::Elasticsearch::Client::Async::Simple::Direct::Cat;

use Moo;

use Search::Elasticsearch::Util qw(parse_params);

use namespace::clean;

extends 'Search::Elasticsearch::Client::Direct::Cat';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Client::Async::Simple::Direct';


__PACKAGE__->_install_api('cat');


sub help {
	my $cb = pop();
	my ($self, $pars) = parse_params(@_);

	$pars->{help} = 1;

	my $defn = $self->api->{'cat.help'};

	$self->perform_request($defn, $pars, $cb);

	return;
}


1;


__END__

=head1 NAME

Search::Elasticsearch::Client::Async::Simple::Direct::Cat - An asynchronous client for running cat debugging requests

=head1 DESCRIPTION

See L<Search::Elasticsearch::Client::Direct::Cat> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
