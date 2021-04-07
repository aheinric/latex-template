# Default target:  Build all PDFs.
# - If you have more than one PDF to build, list them all.
# - Each PDF in this list must correspond to a '.tex' file in 'src/'.
.PHONY : all
all : example.pdf

# Run the compiler once, only producing the '.aux' file.
# This is useful for debugging, since building a PDF
# invokes the compiler twice, cluttering the output.
.PHONY : draft
draft : example.aux

# Clear any compiler artifacts from this project.
# Includes PDFs, '.aux' files, and logs.
# (Don't save any external PDFS into a project.)
.PHONY : clean
clean : clean-pdftex

# Display the help text for the template.
# I tried writing a man page, but gave up in abject frustration.
.PHONY : help
help : usage-pdftex

include ~/Projects/latex-template/pdftex.mk
