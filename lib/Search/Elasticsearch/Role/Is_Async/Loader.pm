package
	Search::Elasticsearch::Role::Is_Async::Loader; # Hidden.

# Loads fake Search::Elasticsearch::Role::Is_Async module if distro
# Search::Elasticsearch::Async not installed.

use strictures;

use Module::Runtime qw(require_module);

use namespace::clean;


BEGIN {
	eval {
		require_module('Search::Elasticsearch::Role::Is_Async');
	};
	if ($@) {
		require_module('Search::Elasticsearch::Role::Is_Async::Fake');
	}
}


1;
