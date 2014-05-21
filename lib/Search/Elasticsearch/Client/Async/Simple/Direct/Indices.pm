package Search::Elasticsearch::Client::Async::Simple::Direct::Indices;

use Moo;

extends 'Search::Elasticsearch::Client::Direct::Indices';
with    'Search::Elasticsearch::Role::API';
with    'Search::Elasticsearch::Role::Client::Async::Simple::Direct';


__PACKAGE__->_install_api('indices');


1;


__END__

=head1 NAME

Search::Elasticsearch::Client::Async::Simple::Direct::Indices - An asynchronous client for running index-level requests

=head1 DESCRIPTION

See L<Search::Elasticsearch::Client::Direct::Index> for the main documentation.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
