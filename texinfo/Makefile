
texi_argument = --no-split --force --no-warn

sicp.info: sicp.texi
	texi2any $(texi-argument) -o $@ $<

sicp.html: sicp.texi
	texi2any --html $(texi_argument) -o $@ $<

sicp.pdf: sicp.texi
	texi2any --pdf $(texi_argument) -o $@ $<
