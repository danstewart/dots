package ConfigBuilder;

use strict;
use warnings;

sub new {
	my ($class, @args) = @_;

	my $self = { _config => {} };

	return bless $self, $class;
}

# Pushes data into the config
sub push {
	my ($self, $data, $from_inc) = @_;

	if (not $data or ref $data ne 'HASH') {
		return;
	}

	foreach my $key (keys %$data) {
		if ($from_inc && exists $self->{_config}->{$key}) {
			# If we're loading an &include then don't overwrite anything
			next;
		}

		$self->{_config}->{$key} = $data->{$key};
	}
}

# Gets the built config
sub get {
	my ($self) = @_;
	return $self->{_config};
}

1;
