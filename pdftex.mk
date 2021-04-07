# Find the absolute path to this makefile.
# This is designed to be included from elsewhere,
# and to reference the local packages and classes.
PDFTEX_RELPATH=$(shell echo "$(MAKEFILE_LIST)" | grep -oE '\S+pdftex.mk')
PDFTEX_DIR=$(dir $(abspath $(PDFTEX_RELPATH)))

# TeX-to-PDF program. 'TEX' is taken for TeX-to-DVI.
PDFTEX=pdflatex

# Wildcard expressions for cleaning up after pdflatex
PDFTEX_CLEAN_PATHS=*.aux *.pdf *.log

# User-defined options for latex.
# Override before including this file to change it.
PDFTEX_USER_FLAGS=

# Mode for running PDFTEX
# Override to change.
PDFTEX_MODE=nonstopmode

# Search paths for the classes and packages included here.
PDFTEX_USER_PATH=

PDFTEX_PATH_LOCAL=.//
PDFTEX_PATH_TEMPLATE=$(PDFTEX_DIR){classes,packages}
PDFTEX_PATH_INTERNAL=$(PDFTEX_PATH_LOCAL);$(PDFTEX_PATH_TEMPLATE)
PDFTEX_PATH=$(if $(PDFTEX_USER_PATH),$(PDFTEX_PATH_INTERNAL);$(PDFTEX_USER_PATH),$(PDFTEX_PATH_INTERNAL))

PDFTEX_FLAGS_INTERNAL=-interaction=$(PDFTEX_MODE) -cnf-line='TEXMFDOTDIR = $(PDFTEX_PATH)'

PDFTEX_FLAGS=$(if $(PDFTEX_USER_FLAGS),$(PDFTEX_FLAGS_INTERNAL) $(PDFTEX_USER_FLAGS),$(PDFTEX_FLAGS_INTERNAL))

vpath %.tex src/tex


.SECONDARY : %.aux
%.aux : %.tex
	@echo "Computing Xrefs"
	@echo "***************"
	$(PDFTEX) -draft $(PDFTEX_FLAGS) $<
	mv $(patsubst %.aux,%.log,$@) $(patsubst %.aux,%.aux.log,$@)

%.pdf : %.tex %.aux
	@echo "Building PDF"
	@echo "************"
	$(PDFTEX) $(PDFTEX_FLAGS) $<

.PHONY : clean-pdftex
clean-pdftex :
	rm -f $(PDFTEX_CLEAN_PATHS)

.PHONY : help-pdftex
help-pdftex :
	@cat $(PDFTEX_DIR)/usage.txt
