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
    module_name => "Alien::ZMQ",
    dist_version_from => "lib/Alien/ZMQ.pm",
    dist_abstract => "find and install libzmq, the core zeromq library",
    share_dir => "share",
);
$builder->notes('zmq-version', '3.2.4');
$builder->notes('zmq-sha1', '08303259f08edd1faeac2e256f5be3899377135e');

$builder->create_build_script;
