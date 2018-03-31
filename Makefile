
.default: all

SOURCES = \
48J1.abc 48J2.abc 48J3.abc 48J4.abc \
48P1.abc \
H1.abc H2.abc H3.abc H4.abc H5.abc H6.abc \
J1.abc J2.abc J3.abc J4.abc J5.abc J6.abc J7.abc J8.abc \
M1.abc M2.abc M3.abc \
P1.abc P2.abc P3.abc P4.abc P5.abc P6.abc P7.abc P8.abc P9.abc P10.abc \
R1.abc R2.abc R3.abc R4.abc \
S1.abc S2.abc S3.abc S4.abc S5.abc S6.abc S7.abc S8.abc S9.abc \
SJ1.abc \
W1.abc W2.abc W3.abc

PLAIN_PDFS = $(patsubst %.abc,pdf/%.pdf,$(SOURCES))
BFLAT_PDFS = $(patsubst %.abc,pdf/%_Bb.pdf,$(SOURCES))
EFLAT_PDFS = $(patsubst %.abc,pdf/%_Eb.pdf,$(SOURCES))
EFLATHI_PDFS = $(patsubst %.abc,pdf/%_EbHi.pdf,$(SOURCES))

%.show:
	@echo $($*)


pdf/%.pdf: build/%.ps
	ps2pdf $< $@

build/%.ps: %.abc
	abcm2ps -F page.fmt -O $@ $<

build/%_Bb.ps: build/%_Bb.abc
	abcm2ps -F page.fmt -O $@ $<

build/%_Eb.ps: build/%_Eb.abc
	abcm2ps -F page.fmt -O $@ $<

build/%_EbHi.ps: build/%_EbHi.abc
	abcm2ps -F page.fmt -O $@ $<

build/%_Bass.ps: build/%_Eb.abc
	abcm2ps -F page.fmt -O $@ $<

build/%_Bb.abc: %.abc
	echo '%%transpose 2' > $@
	sed 's/^\(\%\%text .*\)\((.*)\)/\1[Bb] \2/g' < $< >>$@

build/%_Eb.abc: %.abc
	echo '%%transpose -3' > $@
	sed 's/^\(\%\%text .*\)\((.*)\)/\1[Eb] \2/g' < $< >>$@

build/%_EbHi.abc: %.abc
	echo '%%transpose 9' > $@
	sed 's/^\(\%\%text .*\)\((.*)\)/\1[EbHi] \2/g' < $< >>$@

#build/%_Bass.abc: %.abc
#	echo '%%transpose 2' > $@
#	sed 's/^\(\%\%text .*\)\((.*)\)/\1[Bb] \2/g' < $< >>$@



all: $(PLAIN_PDFS) $(BFLAT_PDFS) $(EFLAT_PDFS) $(EFLATHI_PDFS)

.PHONY: all

