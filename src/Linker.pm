package Linker;

use strict;
use warnings;
use feature qw{say};

use File::Basename;

use Util qw{script_dir};

sub new {
	my ($class, $config, @args) = @_;

	my $self = {
		_dir    => join('/', script_dir(), 'config'),
		_force  => 0,
		_config => $config,
	};

	return bless $self, $class;
}

sub _attr {
	my ($self, @args) = @_;	

	my $key = pop @args;
	my $val = pop @args;

	if (defined $val) {
		$self->{$key} = $val;
		return $self;
	}

	return $self->{$key};
}

sub force { return _attr(@_, '_force') }
sub test  { return _attr(@_, '_test')  }

sub create {
	my ($self) = @_;

	my $config = $self->{_config};
	foreach my $item (keys %$config) {
		my ($src, $target, $and_then, $no_force);

		if (ref $config->{$item} eq 'HASH') {
			# If src path is absolute
			if ($config->{$item}->{src} && $config->{$item}->{src} =~ m{^/}) {
				$src = $config->{$item}->{src};

			# Else relative or unset
			} else {
				$src = join('/', $self->{_dir}, ($config->{$item}->{src} || $item));
			}

			$target   = $config->{$item}->{target};
			$and_then = $config->{$item}->{andThen};
			$no_force = $config->{$item}->{noForce};

			if ($config->{$item}->{cond}) {
				qx{[ $config->{$item}->{cond} ]};
				next if $?;
			}

		} else {
			$src    = join '/', $self->{_dir}, $item;
			$target = $config->{$item};
		}

		if ($src and $target) {
			my $res = $self->_make_link($src, $target, $no_force);

			# Optional shell command to run after linking
			if ($res == 1 and $and_then) {
				qx{$and_then};
			}
		}
	}
}

sub _make_link {
	my ($self, $src, $target, $no_force) = @_;

	# Replace any standard vars
	$src =~ s{\$HOME}{$ENV{HOME}}g;
	$target =~ s{\$HOME}{$ENV{HOME}}g;

	if (-e $target or -l $target) {
		if (not $self->force) {
			say "WARNING: $target already exists, pass --force to overwrite";
			return 0;
		}

		if ($no_force) {
			return 0;
		}
	}

	my ($name, $path) = fileparse($target);
	if (not -d $path) {
		if ($self->test) {
			say "INFO: Making path '$path'";
		} else {
			require File::Path;
			File::Path::make_path($path);
		}
	}

	if ($self->test) {
		say "INFO: Linking '$src' to '$target'";
	} else {
		symlink($src, zap($target));
	}

	return 1;
}

sub zap {
	my ($file) = @_;

	if ((-e $file or -l $file) and not -d $file) {
		unlink $file;
		return $file;
	}

	require File::Path;
	File::Path::remove_tree($file);
	return $file;
}

1;
