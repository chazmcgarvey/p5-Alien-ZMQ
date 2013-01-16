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
$builder->notes('zmq-version', '3.2.2');
$builder->notes('zmq-sha1', '0e8734c773b6a757b474c16fc3c517993ba47283');

$builder->create_build_script;
