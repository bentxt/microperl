CC = cc
LD = $(CC)
DEFINES = -DPERL_CORE -DPERL_MICRO -Os
CFLAGS = $(DEFINES)
LIBS = -lm
_O = .o

all:	clean microperl

O = uav$(_O) udeb$(_O) udoio$(_O) udoop$(_O) udump$(_O) \
	uglobals$(_O) ugv$(_O) uhv$(_O) \
	umg$(_O) uperlmain$(_O) uop$(_O) \
	uperl$(_O) uperlio$(_O) uperly$(_O) upp$(_O) \
	upp_ctl$(_O) upp_hot$(_O) upp_sys$(_O) \
	uregcomp$(_O) uregexec$(_O) urun$(_O) \
	uscope$(_O) usv$(_O) utaint$(_O) utoke$(_O) \
	uuniversal$(_O) uutf8$(_O) uutil$(_O) uperlapi$(_O)

microperl:	$(O)
	$(LD) -o $@ $(O) $(LIBS)

H = av.h uconfig.h cop.h cv.h embed.h embedvar.h form.h gv.h handy.h \
	hv.h intrpvar.h iperlsys.h mg.h op.h opcode.h opnames.h patchlevel.h \
	perl.h perlsdio.h perlvars.h perly.h pp.h pp_proto.h proto.h \
	regexp.h scope.h sv.h thrdvar.h thread.h unixish.h utf8.h util.h \
	warnings.h

HE = $(H) EXTERN.h

clean:
	-rm -f $(O) microperl

distclean:	clean
	-rm -f uconfig.h

uconfig.h:	uconfig.sh config_h.SH
	CONFIG_SH=uconfig.sh CONFIG_H=uconfig.h sh ./config_h.SH

uav$(_O):	$(HE) av.c
	$(CC) -c -o $@ $(CFLAGS) av.c

udeb$(_O):	$(HE) deb.c
	$(CC) -c -o $@ $(CFLAGS) deb.c

udoio$(_O):	$(HE) doio.c
	$(CC) -c -o $@ $(CFLAGS) doio.c

udoop$(_O):	$(HE) doop.c
	$(CC) -c -o $@ $(CFLAGS) doop.c

udump$(_O):	$(HE) dump.c regcomp.h regnodes.h
	$(CC) -c -o $@ $(CFLAGS) dump.c

uglobals$(_O):	$(H) globals.c INTERN.h perlapi.h
	$(CC) -c -o $@ $(CFLAGS) globals.c

ugv$(_O):	$(HE) gv.c
	$(CC) -c -o $@ $(CFLAGS) gv.c

uhv$(_O):	$(HE) hv.c
	$(CC) -c -o $@ $(CFLAGS) hv.c

umg$(_O):	$(HE) mg.c
	$(CC) -c -o $@ $(CFLAGS) mg.c

uperlmain$(_O):	$(HE) miniperlmain.c
	$(CC) -c -o $@ $(CFLAGS) miniperlmain.c

uop$(_O):	$(HE) op.c keywords.h
	$(CC) -c -o $@ $(CFLAGS) op.c

uperl$(_O):	$(HE) perl.c
	$(CC) -c -o $@ $(CFLAGS) perl.c

uperlio$(_O):	$(HE) perlio.c
	$(CC) -c -o $@ $(CFLAGS) perlio.c

uperly$(_O):	$(HE) perly.c
	$(CC) -c -o $@ $(CFLAGS) perly.c

upp$(_O):	$(HE) pp.c
	$(CC) -c -o $@ $(CFLAGS) pp.c

upp_ctl$(_O):	$(HE) pp_ctl.c
	$(CC) -c -o $@ $(CFLAGS) pp_ctl.c

upp_hot$(_O):	$(HE) pp_hot.c
	$(CC) -c -o $@ $(CFLAGS) pp_hot.c

upp_sys$(_O):	$(HE) pp_sys.c
	$(CC) -c -o $@ $(CFLAGS) pp_sys.c

uregcomp$(_O):	$(HE) regcomp.c regcomp.h regnodes.h INTERN.h
	$(CC) -c -o $@ $(CFLAGS) regcomp.c

uregexec$(_O):	$(HE) regexec.c regcomp.h regnodes.h
	$(CC) -c -o $@ $(CFLAGS) regexec.c

urun$(_O):	$(HE) run.c
	$(CC) -c -o $@ $(CFLAGS) run.c

uscope$(_O):	$(HE) scope.c
	$(CC) -c -o $@ $(CFLAGS) scope.c

usv$(_O):	$(HE) sv.c
	$(CC) -c -o $@ $(CFLAGS) sv.c

utaint$(_O):	$(HE) taint.c
	$(CC) -c -o $@ $(CFLAGS) taint.c

utoke$(_O):	$(HE) toke.c keywords.h
	$(CC) -c -o $@ $(CFLAGS) toke.c

uuniversal$(_O):	$(HE) universal.c objXSUB.h XSUB.h
	$(CC) -c -o $@ $(CFLAGS) universal.c

uutf8$(_O):	$(HE) utf8.c
	$(CC) -c -o $@ $(CFLAGS) utf8.c

uutil$(_O):	$(HE) util.c
	$(CC) -c -o $@ $(CFLAGS) util.c

uperlapi$(_O):	$(HE) perlapi.c perlapi.h
	$(CC) -c -o $@ $(CFLAGS) perlapi.c

microclean:
	find . -type d -exec rm -rf {} \;
	rm -f *.tar.gz
	rm -f *.zip
