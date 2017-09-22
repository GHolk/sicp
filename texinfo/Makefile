
texi_argument = --no-split --force --no-warn

info_path_list = $(subst :, ,$(INFOPATH))
target_info_path = $(lastword $(info_path_list))

sicp.info: sicp.texi
	texi2any $(texi_argument) -o $@ $<

install: sicp.info
ifdef INFOPATH
	cp $< $(target_info_path)
	cd $(target_info_path) && install-info sicp.info dir
else
$(error environment INFOPATH does not exist)
endif

sicp.html: sicp.texi
	texi2any --html $(texi_argument) -o $@ $<

sicp.pdf: sicp.texi
	texi2any --pdf $(texi_argument) -o $@ $<

.PHONY: install
