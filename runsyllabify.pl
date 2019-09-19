#!/usr/bin/perl
use FindBin;
use lib $FindBin::Bin;

use strict;
use Encode;
use syllabify_burmese;

my $input_folder = "input";
my $output_folder = "output";

while (<"$input_folder/*">) {
  my $currF = $_;
  my ($fileName) = /\/(.*)/;
  print qq($fileName\n);
  local $/;
  open IN, "$currF" or die "can't read";
  my $foo = <IN>;
  close IN;
  $foo = Encode::decode_utf8($foo);     # from bytes to UTF8 encoding
  $foo = syllabify($foo);               # syllabify 
  $foo = Encode::encode_utf8($foo);     # back to bytes
  open OUT, ">$output_folder/$fileName" or die;
  print OUT $foo;
  close OUT;
}
