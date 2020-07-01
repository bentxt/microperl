Microperl
========

filelist.txt: all the .c and .h files
copyfiles.sh <dir with Perl sources>: copies files acc. to fileslist.

microperl-minidist.sh [optional alternate dir for microperl-mini]: wrapper for
minify.pl: code minifier

This can be cleaned with `make microclean`

Copying: Lisence acc. to Perl

from perl-5.7.0/README.micro:
microperl is supposed to be able a really minimal perl, even more
minimal than miniperl.  No Configure is needed to build microperl,
on the other hand this means that interfaces between Perl and your
operating system are left very -- minimal.

All this is experimental.  If you don't know what to do with microperl
you probably shouldn't.
