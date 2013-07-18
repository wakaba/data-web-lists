use strict;
use warnings;

my $Data = {};

my $scheme;
open my $file, '<', 'src/url-schemes.txt' or die "$0: url-schemes.txt: $!";
while (<$file>) {
  if (/^\s*#/) {
    next;
  } elsif (/^(.*):\s*$/) {
    $scheme = $1;
    $scheme =~ s/%([0-9A-Fa-f]{2})/pack 'C', hex $1/ge;
    $scheme =~ tr/A-Z/a-z/;
    if ($Data->{$scheme}) {
      die "Duplicate URL scheme: |$scheme|\n";
    }
    $Data->{$scheme} = {props => {}};
  } elsif (/^\s+([\w-]+)\s*$/) {
    $Data->{$scheme}->{props}->{$1} = 1;
  } elsif (/\S/) {
    die "Broken data: $_";
  }
}

use JSON;
open my $json_file, '>', 'json/url-schemes.json' or die "$0: url-schemes.json: $!";
print $json_file JSON->new->canonical->pretty->encode($Data);
close $json_file;
