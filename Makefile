

build/%.ps: %.abc
	abcm2ps -O $@ $<

pdf/%.pdf: build/%.ps
	ps2pdf $< $@




