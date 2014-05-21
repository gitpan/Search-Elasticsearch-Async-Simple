package Search::Elasticsearch::Cxn::Async::Simple::AEHTTP;

use Moo;

use AnyEvent::HTTP qw(http_request);

use namespace::clean;

with 'Search::Elasticsearch::Role::Cxn::Async::Simple',
     'Search::Elasticsearch::Role::Cxn::HTTP',
     'Search::Elasticsearch::Role::Is_Async';


sub perform_request {
	my ($self, $pars, $cb) = @_;

	my $uri  = $self->build_uri($pars);
	my $meth = $pars->{method};

	http_request(
		$meth   => $uri,
		timeout => $pars->{timeout} || $self->request_timeout,
		headers => {
			'Content-Type' => $pars->{mime_type},
			%{$self->default_headers},
		},
		body    => $pars->{data},
		sub {
			my ($code, $res);

			eval {
				($code, $res) = $self->process_response(
					$pars,
					delete($_[1]{Status}),
					delete($_[1]{Reason}),
					$_[0],
					$_[1],
				);
			};

			return $cb->($code, $res) unless $@;

			$self->logger->error($@);
			$cb->();
		}
	);

	return;
}

sub error_from_text {
	return 'Timeout' if $_[2] =~ /timed out/;
	return 'Cxn'     if $_[1] >= 590;
	return 'Request';
}


1;


__END__

=head1 NAME

Search::Elasticsearch::Cxn::Async::Simple::AEHTTP - An asynchronous connection implementation which uses AnyEvent::HTTP

=head1 DESCRIPTION

Provides the default asynchronous HTTP connection class and is based on
L<AnyEvent::HTTP>. The AEHTTP backend is fast, uses pure Perl, support proxies
and HTTPS and provides persistent connections.

=head1 AUTHOR

Denis Ibaev C<dionys@cpan.org>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
