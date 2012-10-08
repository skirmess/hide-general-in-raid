
.PHONY: clean tag release

VERSION=5

clean:
	rm -f *~

tag: clean
	cvs tag HideGeneralInRaid-$(VERSION)

release: clean
	( cd ..;							\
		rm -f HideGeneralInRaid-$(VERSION).zip;			\
		find HideGeneralInRaid					\
				-name CVS -prune -o			\
				-name .svn -prune -o			\
				-name Makefile -prune -o		\
				-name '.*.swp' -prune -o		\
				-print					\
		| zip -@ HideGeneralInRaid-$(VERSION).zip;		\
	)	
