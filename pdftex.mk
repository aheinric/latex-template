# Find the absolute path to this makefile.
# This is designed to be included from elsewhere,
# and to reference the local packages and classes.
PDFTEX_RELPATH=$(shell echo "$(MAKEFILE_LIST)" | grep -oE '\S+pdftex.mk')
PDFTEX_DIR=$(dir $(abspath $(PDFTEX_RELPATH)))

# TeX-to-PDF program. 'TEX' is taken for TeX-to-DVI.
PDFTEX=pdflatex

# Wildcard expressions for cleaning up after pdflatex
PDFTEX_CLEAN_PATHS=*.aux *.pdf *.log

# Search paths for classes and packages.

# NOTE: pdftex uses its own path convention.
#     - Entries are separated by ';'
#     - Ending a path with '//' includes all subdirectories, recursively.
#     - A path part of the form '{a,...,n}' will duplicate the current entry, once for each item in the list.

# User-defined path entries.
# Override before including this file.
PDFTEX_USER_PATH=

# Default search directories
# Includes all files in your project, and all classes and packages defined here.
PDFTEX_PATH_LOCAL=.//
PDFTEX_PATH_TEMPLATE=$(PDFTEX_DIR){classes,packages}
PDFTEX_PATH_INTERNAL=$(PDFTEX_PATH_LOCAL);$(PDFTEX_PATH_TEMPLATE)

PDFTEX_PATH=$(if $(PDFTEX_USER_PATH),$(PDFTEX_PATH_INTERNAL);$(PDFTEX_USER_PATH),$(PDFTEX_PATH_INTERNAL))

# Compiler options

# User-defined options for the compiler.
# Override before including this file.
PDFTEX_USER_FLAGS=

# Interaction Mode for running PDFTEX
#
# This determines how LaTeX handles errors.
# Depending on this mode, the compiler reacts to errrors
# in one of the following ways:
# - Abort compilation.
# - Ask the user for help.
# - Do nothing, and keep trying to process the file.
#
# There are two broad categories of error;
# each mode will treat all errors of a given category the same.
# The catgories are as follows:
# - The compiler can't find a file.
# - The compiler has a problem parsing or evaluating code.
#
# Options are as follows:
# - errorstopmode:  Asks about all errors.
# - scrollmode: 		Passes code errors, asks about missing files.
# - nonstopmode:		Passes code errors, aborts on missing files.
# - batchmode:			Passes code errors, aborts on missing files.  Doesn't log anything.
#
# By default, this variable is set to 'nonstopmode'.
# This is the closest mode to a software compiler;
# it will log all code errors, so you can address more than one bug at a time.
# If you'd prefer one of the other modes, you can override this variable.
PDFTEX_MODE=nonstopmode

# Default options for the compiler:
# - Set interaction mode based on PDFTEX_MODE
# - Set the local search path (via the configuration variable 'TEXMFDOTDIR')
PDFTEX_FLAGS_INTERNAL=-interaction=$(PDFTEX_MODE) -cnf-line='TEXMFDOTDIR = $(PDFTEX_PATH)'

PDFTEX_FLAGS=$(if $(PDFTEX_USER_FLAGS),$(PDFTEX_FLAGS_INTERNAL) $(PDFTEX_USER_FLAGS),$(PDFTEX_FLAGS_INTERNAL))

# Compiler rules
#
# Because the LaTeX compiler manages its own dependencies,
# it only needs the root-level '.tex' file to build the document.

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
