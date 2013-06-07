package My::Build;

use warnings FATAL => 'all';
use strict;

use File::Spec::Functions qw/catfile/;

use base 'Module::Build';

sub ACTION_code {
    my $self = shift;

    $self->SUPER::ACTION_code;

    return if -e 'build-zeromq';
    $self->add_to_cleanup('build-zeromq');

    my %args = $self->args;
    my %vars;

    $self->have_c_compiler or die "C compiler not found";

    unless (exists $args{'zmq-skip-probe'}) {
        print "Probing...\n";
        %vars = $self->probe_zeromq;
    }

    if ($vars{inc_version} && $vars{lib_version} && $vars{inc_dir} && $vars{lib_dir}) {
        print "Found libzmq $vars{lib_version}; skipping installation\n";
    } else {
        print "libzmq not found; building from source...\n";
        %vars = $self->install_zeromq;
    }

    # write vars to ZMQ.pm
    my $module = catfile qw/blib lib Alien ZMQ.pm/;
    open my $LIB, '<', $module or die "Cannot read module";
    my $lib = do { local $/; <$LIB> };
    close $LIB;
    $lib =~ s/^sub inc_dir.*$/sub inc_dir { "$vars{inc_dir}" }/m;
    $lib =~ s/^sub lib_dir.*$/sub lib_dir { "$vars{lib_dir}" }/m;
    $lib =~ s/^sub inc_version.*$/sub inc_version { v$vars{inc_version} }/m;
    $lib =~ s/^sub lib_version.*$/sub lib_version { v$vars{lib_version} }/m;
    my @stats = stat $module;
    chmod 0644, $module;
    open $LIB, '>', $module or die "Cannot write config to module";
    print $LIB $lib;
    close $LIB;
    chmod $stats[2], $module;

    open my $TARGET, '>', "build-zeromq";
    print $TARGET time, "\n";
    close $TARGET;
}

sub probe_zeromq {
    die "Subclasses of " . __PACKAGE__ . " must override";
}

sub install_zeromq {
    die "Subclasses of " . __PACKAGE__ . " must override";
}

1;
