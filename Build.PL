use warnings FATAL => 'all';
use strict;

use lib 'inc';
use File::Path qw/make_path/;

my %platforms = (
    MSWin32 => 'Windows',
);
my $build = 'My::Build::' . ($platforms{$^O} || 'Unix');
eval "require $build" or die "Require '$build' failed: $@";

# prevent warnings about missing share directory
make_path("share");

my $builder = $build->new(
    ##{ $plugin->get_prereqs ##}
    ##{ $plugin->get_default(qw/dist_name license dist_abstract/) ##}
    ##{ $plugin->get_default(qw/dist_author/) ##}
    dist_version_from => "lib/Alien/ZMQ.pm",
    share_dir => "share",
);
$builder->notes('zmq-version', '3.2.3');
$builder->notes('zmq-sha1', '6857a3a0e908eca58f7c0f90e2ba4695f6700957');

$builder->notes('zmq-win32-dist', 'http://miru.hk/archive/ZeroMQ-3.2.3~miru1.0-x86.exe');
$builder->notes('zmq-win32-sha1', 'a26b405695454c98904709924e40e2902738dddd');
$builder->notes('zmq-win64-dist', 'http://miru.hk/archive/ZeroMQ-3.2.3~miru1.0-x64.exe');
$builder->notes('zmq-win64-sha1', '1de71d1dea5084308a6ca00593484b8145d7d582');

$builder->create_build_script;
