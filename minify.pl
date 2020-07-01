use File::Copy qw(move);
use strict;
use warnings;

no warnings 'qw';

my $USAGE = "<infile>[outdir]"; 

my $HELP = "Help: Minifies source by removing Whitespace
usage\n
usage: $USAGE\n
infile: mandatory path to infile
[outfile]: optional path to outfile, otherwise print to stdout\n";


die "$HELP" if $ARGV[0] eq '-h';
die "$HELP" if $ARGV[0] eq '--help';

sub usage{ die "usage ($0): $USAGE\n" }

my $infile = $ARGV[0];
my $outfile = $ARGV[1];


usage unless $infile;

die "Err: infile $infile not exist" unless -f $infile;
if($outfile){
   die "Err: outfile $outfile already exist" if -f $outfile;
}

open( my $ifh, '<', $infile ) || die "Err: could not open infile $infile";

my $instr = undef;
my ( @out, @line, @word );
my $lineout;
$lineout = sub {
   if (@word) {
      push @line, join( '', @word, @_ );
      @word = ();
   } else {
      push @line, join( '', @_ );
   }
};

while (<$ifh>) {
   if (/^\s*\#/) {
      push @out, $_;
   } elsif (/^\s*$/) {
      push @out, $_;
   } else {
      my ( $prev, $leadspace ) = ( undef, 1 );
      foreach ( split( '', $_ ) ) {
         if ($instr) {
            if (/\"/) {
               $lineout->($_);
               undef $instr;
               undef $leadspace;
            } else {
               push @word, $_;
            }
         } else {
            if (/\n/) {
               $lineout->($_);
            } elsif (/\,/) {
               $lineout->();
               push @word, $_;
               undef $leadspace;
            } elsif (/\s/) {
               my $w = join( '', @word );
               @word = ();
               if ( grep { 1 if ( $_ eq $w ); } qw|, + - = [ ] ( )| ) {
                  if(@line) {if ( $line[-1] eq ' ' ) { pop @line }}

                  #die fffff => 'xx ' .  $w . 'yyy' ;
                  push @line, $w;
               } else {
                  push @line, $w;
                  if ($leadspace) {
                  } elsif ( $prev eq ' ' ) {
                  } else {
                     push @line, ' ';
                  }
               }
            } elsif (/\"/) {
               $instr = 1;
               $lineout->($_);
               undef $leadspace;
            } else {
               undef $leadspace;
               push @word, $_;
            }
         }
         $prev = $_;
      }
      $lineout->();
      push @out, join( '', @line );
      @line = ();
   }
}
my $o = join( "", @out );

close $ifh;

if($outfile){
   open( my $ofh, '>', $outfile )    || die "Err: could not open outfile $outfile";
   print $ofh $o;
   close $ofh;
}else{
   print $o;
}
@out = ();

