package My::Util;

use warnings FATAL => 'all';
use strict;

use Digest::SHA qw/sha1_hex/;
use LWP::Simple qw/getstore RC_OK/;

sub download {
    my ($uri, $filename) = @_;
    getstore($uri, $filename) == RC_OK or die "Failed to download from $uri";
}

sub verify {
    my ($filepath, $sha1) = @_;

    my $sha1sum = Digest::SHA->new;
    open my $FILE, '<', $filepath or die "Can't open $filepath: $!";
    binmode $FILE;
    $sha1sum->addfile($FILE);
    close $FILE;
    $sha1sum->hexdigest eq $sha1 or die "Checksum mismatch for $filepath";
}

1;
