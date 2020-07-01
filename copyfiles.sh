
perldir=$1

[ -d "$perldir" ] || { echo "usage: perldir" ; exit 1; }

for f in $(cat filelist.txt) ; do
  [ -f "$f" ] || continue
  rm -f "$f"
  cp $perldir/$f .
done
