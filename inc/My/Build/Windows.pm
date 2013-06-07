package My::Build::Windows;

use warnings FATAL => 'all';
use strict;

use Config;
use File::Spec::Functions qw/catdir/;
use My::Util;

use base 'My::Build';

sub probe_zeromq {
    # probing on windows is not supported
}

sub install_zeromq {
    my $self = shift;

    my $version = $self->notes('zmq-version');
    my ($archive, $sha1);
    # check of this is a 32-bit or 64-bit perl
    if ($Config{ptrsize} == 8) {
        $archive = $self->notes('zmq-win64-dist');
        $sha1    = $self->notes('zmq-win64-sha1');
    } else {
        $archive = $self->notes('zmq-win32-dist');
        $sha1    = $self->notes('zmq-win32-sha1');
    }

    print "Downloading libzmq $version installer from miru.hk...\n";
    My::Util::download($archive, "setup.exe");
    $self->add_to_cleanup('setup.exe');

    print "Verifying...\n";
    My::Util::verify("setup.exe", $sha1);

    my $prefix = catdir($self->install_destination("lib"), qw/auto share dist Alien-ZMQ/);
    my $basedir = $self->base_dir;
    my $destdir = catdir($basedir, "share");
    $self->add_to_cleanup($destdir);

    print "Installing...\n";
    system(qw|setup.exe /S|, "/D=$destdir") == 0 or die "Failed to install libzmq";

    (
        inc_version => $version,
        lib_version => $version,
        inc_dir     => catdir($prefix, "include"),
        lib_dir     => catdir($prefix, "lib"),
    );
}

1;
