\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{easyarticle}

% NOTE: Only option-parsing should happen in this gap.
% Specifically, titlesec clashes with the default LaTeX class if loaded first.

\LoadClass{article}         % Load the class to override.

\RequirePackage{amsmath}    % Includes rules for formatting math.
\RequirePackage{amssymb}    % Includes every freaky symbol you can think of.
\RequirePackage{fancyhdr}   % Includes rules for formatting headers
\RequirePackage{lastpage}   % Includes macros for getting the last page.
\RequirePackage{titlesec}   % Includes functions for formatting headers.

\RequirePackage{docinfo}    % Local package with doc-specific info.

% NOTE: Documentation says this should be the last import in the preamble.
% This probably screws with things if I import extra stuff.
\RequirePackage{subfiles}   % Allows you to break one document into several.


% Set margins to save paper.
\oddsidemargin0cm
\topmargin-2cm 
\textwidth16.5cm
\textheight23.5cm

% Following is an example of how to set up a header format.
% For papers, LaTeX allows for five levels of outline,
% each defined by a command:
% 1.          \section
% 1.1.        \subsection
% 1.1.1.      \subsubsection
% 1.1.1.1.    \paragraph
% 1.1.1.1.1.  \subparagraph

% Set up section header format.
\titleformat      % Command to start defining a format.
{\section}        % Header class to format.
[hang]            % Paragraph shape for heading.  These get annoying.
{\bfseries\Large} % Formatting for label
{\thesection.}    % Pattern for label.
{0.5em}           % Horizontal Separation between label and name
{                 % Code to execute before writing the name.
                  %Nothing to do for this example
}
[                 % Code to execute after.
  \vspace{-0.75em}           % Take back a bit of space.
  \rule{\textwidth}{0.3pt}  % Draw a line under the section title.
]

% Configure the fancyhdr package.
\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt plus 1pt}

% Helper function to write page numbers as current/total
% Note: This has hecking caveats if there are multiple numbering schemes.
\newcommand{\pagenumvtot}{\thepage/\pageref{LastPage}}

% Define the header and footer data.
\pagestyle{fancyplain}
\fancyhf{}                                        % Null the header/footer config.
\fancyhead[L]{\fancyplain{}{\doctitle}}           % Put the title on the top-left.
\fancyhead[C]{\fancyplain{}{\docmark}}            % Put the document marking in the top-center.
\fancyfoot[L]{\fancyplain{}{\docdate}}            % Put the document date on the top-right.
\fancyfoot[C]{\fancyplain{}{\docmark}}            % Put the document marking in the bottom-center.
\fancyfoot[R]{\fancyplain{}{\pagenumvtot}}        % Put the page number in the bottom-center.

