# Alex H's Handy LaTeX Template

LaTeX is a wonderful language for building documents,
but it's a pain to configure correctly.

This project provides the following help:

- A `make` module that manages building documents into PDFs.
- LaTeX classes and packages that capture much annoying setup.
- An example of how to use these resources.

## Prerequisites

This project is tested on Mac OS X and Ubuntu,
but can likely work on any linux-like environment.

The following programs need to be available on your command path:

- `make`
- `pdflatex`

Annoyingly, the process for installing both of these varies wildly between platforms.

### `make`

Please google this yourself.  There are much better resources on-line than anything I can provide.

### `pdflatex`

`pdflatex` is a (very, very) small part of the TeX distribution.
Installing the entire distribution is usually overkill;
where possible, I've tried to contrast the minimal requirements for `pdflatex`
against those for the entire TeX ecosystem.

For more complete instructions, see the official documentation at

`https://tug.org/texlive/`

#### GNU Linux

The official `texlive` documentation gives instructions
for manually installing the TeX distribution.
However, most Linux distributions can download all or part of TeX
from packages.

- **Fedora (dnf):** 
  - Minimal: `texlive-scheme-basic`
  - Full: `texlive-scheme-full`
- **CentOS 7 & 8 (yum):**
  - Minimal: `texlive-scheme-basic`
  - Full: Unknown; CentOS only has a subset of the `texlive` packages available for other distros.
- **Ubuntu, Debian (apt):** 
  - Minimal: `texlive-latex-extra`
  - Full: `texlive-full`

#### Mac OS X

There's a Mac-specific port of the TeX distribution called 'MacTeX'.
Instructions and downloads are available at

`https://tug.org/mactex`

MacTeX comes with its own distribution manager,
which you can use to customize which bits of TeX you want installed.
Unfortunately, I've never used this feature.

#### Windows, MinGW, Cygwin

No idea.  I've never tried installing TeX on a Windows machine.

## Using this Template

This template doesn't really have any moving parts, so installing and using it is pretty simple:

1. Clone this repository
2. Copy the `example/` directory to create a new project.
3. Make sure that your `Makefile` uses the correct path when including `pdftex.mk` 
4. Alter the prerequisite lists of the targets in your `Makefile` to match the documents you want to build.

If you want to customize step 2, `example/` contains more details on what this template requires from a project.
