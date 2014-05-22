package Search::Elasticsearch::Async::Simple;

use Moo;

use Search::Elasticsearch 1.10;
use Search::Elasticsearch::Util qw(parse_params);

extends 'Search::Elasticsearch';


our $VERSION = '0.02';


sub new {
	my ($class, $pars) = parse_params(@_);

	return $class->SUPER::new({
		client              => 'Async::Simple::Direct',
		transport           => 'Async::Simple',
		cxn_pool            => 'Async::Simple::Static',
		cxn                 => 'Async::Simple::AEHTTP',
		%$pars,
	});
}


package
	Search::Elasticsearch::Role::Is_Async;

use Moo::Role;

use namespace::clean;


1;


__END__

=head1 NAME

Search::Elasticsearch::Async::Simple - Unofficial asynchronous API for Elasticsearch using callbacks

=head1 SYNOPSIS

    use AnyEvent ();
    use Search::Elasticsearch::Async::Simple ();

    my $es = Search::Elasticsearch::Async::Simple->new;
    my $cv = AE::cv;

    $es->search(
        index => 'site',
        type  => 'post',
        body  => {
            query => {
                match => { title => 'elasticsearch' },
            },
        },
        sub {
            $cv->send(@_);
        }
    );

    my ($res) = $cv->recv();

=head1 DESCRIPTION

Search::Elasticsearch::Async::Simple is the unofficial asynchronous Perl client
for Elasticsearch. Unlike the official L<Search::Elasticsearch::Async> module,
it does not use any library to provide asynchronous interface, only callbacks.

Search::Elasticsearch::Async::Simple builds on L<Search::Elasticsearch>, which
you should see for the main documentation.

All request methods are the same as synchronous methods, but with one exception.
They take one more argument in last position, which value must be the callback
function. This function will be called after the response will be received.

=head1 SEE ALSO

L<Search::Elasticsearch>.

=head1 SUPPORT

=over 4

=item * Repository

L<http://github.com/dionys/search-elasticsearch-async-simple>

=item * Bug tracker

L<http://github.com/dionys/search-elasticsearch-async-simple/issues>

=back

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
