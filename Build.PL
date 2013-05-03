use v5.10.1;
use warnings FATAL => 'all';
use strict;

use lib 'inc';
use File::Path qw/make_path/;
use My::Build;

# prevent warnings about missing share directory
make_path("share");

my $builder = My::Build->new(
    ##{ $plugin->get_prereqs ##}
    ##{ $plugin->get_default(qw/dist_name license dist_abstract/) ##}
    ##{ $plugin->get_default(qw/dist_author/) ##}
    dist_version_from => "lib/Alien/ZMQ.pm",
    share_dir => "share",
);
$builder->notes('zmq-version', '3.2.3');
$builder->notes('zmq-sha1', '6857a3a0e908eca58f7c0f90e2ba4695f6700957');

$builder->create_build_script;
