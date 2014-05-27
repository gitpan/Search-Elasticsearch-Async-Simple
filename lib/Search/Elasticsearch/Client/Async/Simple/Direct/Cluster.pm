package Search::Elasticsearch::Client::Async::Simple::Direct::Cluster;

use Moo;

use namespace::clean;

extends 'Search::Elasticsearch::Client::Direct::Cluster';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Client::Async::Simple::Direct';


__PACKAGE__->_install_api('cluster');


1;


__END__

=head1 NAME

Search::Elasticsearch::Client::Async::Simple::Direct::Cluster - An asynchronous client for running cluster-level requests

=head1 DESCRIPTION

See L<Search::Elasticsearch::Client::Direct::Cluster> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
