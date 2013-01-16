#!perl

use warnings;
use strict;

use Test::More tests => 8;

BEGIN {
    use_ok 'Alien::ZMQ';
}

ok Alien::ZMQ::inc_version, "include version number";
ok Alien::ZMQ::lib_version, "library version number";
ok Alien::ZMQ::inc_dir,     "include directory path";
ok Alien::ZMQ::inc_dir,     "library directory path";

like Alien::ZMQ::cflags, qr/-I\S+/, "cflags has -I";
like Alien::ZMQ::libs,   qr/-L\S+/, "libs has -L";
like Alien::ZMQ::libs,   qr/-lzmq/, "libs has -lzmq";

