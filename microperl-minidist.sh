
minidir="$1"

[ -n "$minidir" ] || minidir=microperl-mini

rm -rf "$minidir"
mkdir "$minidir"


for f in *.h *.c ; do
  [ -f "$f" ] || continue
  bf=$(basename $f)
  perl ./minify.pl "$f" > $minidir/$bf
done

for f in uconfig.sh Makefile.SH config_h.SH Makefile; do
  [ -f "$f" ] || continue
  cp "$f" $minidir
done

today=$(date "+%F")


for d in ${minidir}_${today} ${minidir}_LATEST; do

   echo rm -rf "$d"
   rm -rf "$d"

   echo rm -f "$d".tar.gz
   rm -f "$d".tar.gz

   rm -f "$d".zip
   echo rm -f "$d".zip

   cp -r ${minidir} "$d"

   echo tar cfz "$d.tar.gz" "$d" 

   tar cfz "$d.tar.gz" "$d" 
   zip -qq "$d".zip -r "$d"
 done
