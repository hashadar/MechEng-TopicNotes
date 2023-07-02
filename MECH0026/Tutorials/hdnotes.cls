\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hdnotes}[2023/06/29 hdnotes Custom Class]
\LoadClass[11pt,a4paper]{report}

%% Margins and page sizing
\RequirePackage{calc}
\RequirePackage[includeheadfoot]{geometry}

\setlength{\hoffset}{0mm}
\setlength{\oddsidemargin}{20mm-1in}
\setlength{\textwidth}{\paperwidth - 20mm-20mm}
\setlength{\marginparsep}{100mm}
\setlength{\marginparwidth}{0mm}

\setlength{\voffset}{0mm}
\setlength{\topmargin}{10mm-1in}
\setlength{\headheight}{12mm}
\setlength{\headsep}{20mm-10mm-12pt}
\setlength{\textheight}{\paperheight-20mm-25mm}
\setlength{\footskip}{10mm}

%% Definitions

\makeatletter
\newcommand{\setmodulecode}[1]{\def\@modulecode{#1}}
\newcommand{\setmodulename}[1]{\def\@modulename{#1}}
\newcommand{\setauthorname}[1]{\def\@authorname{#1}}
\newcommand{\setcoordinatorname}[1]{\def\@coordinatorname{#1}}
\newcommand{\mytitle}{\@modulecode\ Tutorial Questions}
\newcommand{\myauthor}{\@authorname}
\newcommand{\mymodulename}{\@modulecode\ \@modulename}
\newcommand{\myprof}{\@coordinatorname}
\makeatother

\setmodulecode{MECH0026}
\setmodulename{Elasticity and Plasticity}
\setauthorname{HD}
\setcoordinatorname{Dr. Eral Bele}

%% Packages
\RequirePackage{adjustbox}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{booktabs}
\RequirePackage{chngpage}
\RequirePackage{color}
\RequirePackage{commath}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{float}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage[utf8]{inputenc}
\RequirePackage{listings}
\RequirePackage{longtable}
\RequirePackage{multirow}
\RequirePackage[numbers]{natbib}
\RequirePackage{parskip}
\RequirePackage[font=itshape]{quoting}
\RequirePackage{siunitx}
\RequirePackage{stfloats}
\RequirePackage{tabularx}
\RequirePackage{times}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{wrapfig}
\RequirePackage[table,xcdraw]{xcolor}

\hypersetup{
  colorlinks=true,
  linkcolor=black,
  filecolor=teal,
  urlcolor=teal,
  citecolor=teal,
  pdftitle={\mytitle},
  pdfauthor={\myauthor},
}

\renewcommand\bibname{References}
\RequirePackage{lineno}
%%%%%%%%%%%%   Header and Footer  %%%%%%%%%%%%%
\pagestyle{fancy}
\fancypagestyle{plain}{%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyhf{}%
  \fancyfoot[L]{\myauthor}
  \fancyfoot[R]{ \bf\thepage\ \rm }
}

\AtBeginDocument{
  \input{Title/title.tex}
  \fancyhf{}
  \fancyhead[L]{\mymodulename}
  \fancyfoot[L]{\myauthor}
  \fancyfoot[R]{ \bf\thepage\ \rm }%
  \newpage
  \pagenumbering{roman}
  \tableofcontents
  \newpage
  \listoffigures
  \listoftables
  \newpage
  \pagenumbering{arabic}
}
\endinput
