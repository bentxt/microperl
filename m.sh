rm -rf mini

mkdir mini

for f in * ; do
  [ -f "$f" ] || continue
  bf=$(basename $f)
  case "$bf" in
    *.c)
      python minifier.py $f > mini/$f
      ;;
    *)
      cp $f mini/
      ;;
  esac
done
