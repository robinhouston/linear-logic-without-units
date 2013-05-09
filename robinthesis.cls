\ProvidesClass{robinthesis}

% This class is used to format either the whole thesis
% or individual chapters.

\newif\ifrobin@useminion\robin@useminiontrue
\newif\ifrobin@usemyriad\robin@usemyriadfalse
\DeclareOption{nominion}{\robin@useminionfalse}
\DeclareOption{myriad}  {\robin@useminionfalse\robin@usemyriadtrue}
\DeclareOption{12pt}    {\PassOptionsToClass{12pt}{book}}
\ProcessOptions

\PassOptionsToClass{a4paper}{book}
\LoadClass{book}
\RequirePackage{amssymb} % Must be loaded before Minion Pro
\ifrobin@useminion
    \RequirePackage[medfamily,opticals]{MinionPro}
    \RequirePackage{microtype}
\else\ifrobin@usemyriad
    \RequirePackage[medfamily]{MyriadPro}
\fi\fi
\RequirePackage{tikz,prooftree,braids,setspace}

\RequirePackage{xr-hyper}
\RequirePackage[breaklinks]{hyperref}


% Ha ha ha ha, DEK, you wacky guy!
\frenchspacing
\parskip=0pt\parindent=1em
\raggedbottom

% Reduce the top margin to 21mm (compensating for the default inch
% that dvips adds for some inscrutable reason of its own).
\topmargin=-1in \advance\topmargin by 11mm
\headheight=3mm\headsep=3mm%\footskip=0pt
\textheight=2\columnwidth

% Use a more compact and attractive title layout
\newbox\robin@tempbox
\def\@maketitle{%
        \sbox\robin@tempbox{\large\@author\ \textperiodcentered\ \@date}%
        \parskip0pt%\newpage\null
        \begin{center}\let \footnote=\thanks
          {\LARGE \@title \par}%
          \vskip 1em%
          \ifdim\wd\robin@tempbox<\textwidth
            \hbox to\textwidth{\hss\box\robin@tempbox\hss}%
          \else
            \large
            \begin{tabular}[t]{c}
              \@author \\[1ex] \small\@date
            \end{tabular}
          \fi
        \end{center}\par\vskip1em}


\RequirePackage{robincs,thesisdefs}
\newif\ifthesischapteronly\thesischapteronlytrue

\def\robin@externalchapter#1#2{{\def\@currentlabel{[#1]}%
	\ifx\ifHy@implicit\@undefined
		\label{ch:#1}%
	\else\ifHy@implicit
		\label{ch:#1}}%
	\externaldocument[#1:]{#2}%
	\fi\fi}
\def\articlestyle{
 %
 % This code is copied from book.cls:
\global\def\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext####1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}####1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  }%
  %%
  % This is from bk10.clo:
  \setlength\@tempdima        {\paperwidth}
  \addtolength\@tempdima      {-\textwidth}
  \setlength\oddsidemargin    {.5\@tempdima}
  \addtolength\oddsidemargin  {-1in}
  \setlength\marginparwidth   {.5\@tempdima}
  \addtolength\marginparwidth {-\marginparsep}
  \addtolength\marginparwidth {-0.4in}
  \setlength\evensidemargin  {\oddsidemargin}
  \@settopoint\oddsidemargin
  \@settopoint\evensidemargin
  \@settopoint\marginparwidth
  %
  \global\setlength\oddsidemargin{\oddsidemargin}
  \global\setlength\evensidemargin{\evensidemargin}
  \global\setlength\marginparwidth{\marginparwidth}
  %%
  % From book.cls again:
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark####1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            \@chapapp\ \thechapter. \ %
          \fi
        \fi
        ####1}}}}%
}

\newcommand\thesisstyle{
  \global\addtolength\topmargin{10mm}
  \global\addtolength\textheight{-30mm}
  %
  \setlength\@tempdima        {\paperwidth}
  \addtolength\@tempdima      {-\textwidth}
  \setlength\oddsidemargin    {.5\@tempdima}
  \addtolength\oddsidemargin  {-1in}
  \setlength\marginparwidth   {.5\@tempdima}
  \addtolength\marginparwidth {-\marginparsep}
  \addtolength\marginparwidth {-0.4in}
  \setlength\evensidemargin   {\oddsidemargin}
  \addtolength\oddsidemargin  {12mm}
  \addtolength\evensidemargin {-12mm}
  \@settopoint\oddsidemargin
  \@settopoint\evensidemargin
  \@settopoint\marginparwidth
  %
  \global\setlength\oddsidemargin{\oddsidemargin}
  \global\setlength\evensidemargin{\evensidemargin}
  \global\setlength\marginparwidth{\marginparwidth}
  %
  \onehalfspacing
  %
  \def\ps@plain{
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil}%
    \def\@oddhead {\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble}
  %
  \renewcommand\maketitle{
  \begin{titlepage}
        \null\vskip1in%
        \begin{center}
                \Huge\expandafter{\@title}
        \end{center}
        \vfill
        \begin{center}
                A thesis submitted to the University of Manchester\\
                for the degree of Doctor of Philosophy\\
                in the Faculty of Engineering and Physical Sciences
        \end{center}
        \vfill
        \begin{center}
                \number\the\year
        \end{center}
        \vfill
        \begin{center}
                %\normalfont By\\
                \@author\\
                School of Computer Science
        \end{center}\vskip.5in
    \end{titlepage}}
}

% The following is swiped from muthesis.cls:
\def\prefacesection#1{{%
	\@openrightfalse
	\chapter*{#1}
	\addcontentsline{toc}{chapter}{#1}}}

\def\declpage{%
\prefacesection{Declaration}
	\begin{center}
	\begin{minipage}{4in}
		\parindent=0pt
		No portion of the work referred to in this thesis has been
		submitted in support of an application for another degree or
		qualification of this or any other university or other
		institute of learning.
		\par
	\end{minipage}%
	\end{center}%
	\vfill}

\def\copyrightpage{%
\prefacesection{Copyright}

The author of this thesis (including any appendices and/or schedules to
this thesis) owns any copyright in it (the ``Copyright'') and he has given
The University of Manchester the right to use such Copyright for any
administrative, promotional, educational and/or teaching purposes.

Copies of this
thesis, either in full or in extracts, may be made \textbf{only} in
accordance with the regulations of the
John Rylands University Library of Manchester. Details of these regulations
may be obtained from the Librarian. This page must form part of any such copies made.

The ownership of any patents, designs, trade marks and any and all other
intellectual property rights except for the Copyright (the ``Intellectual
Property Rights'') and any reproductions of copyright works, for example
graphs and tables (``Reproductions''), which may be described in this
thesis, may not be owned by the author and may be owned by third parties.
Such Intellectual Property Rights and Reproductions cannot and must not
be made available for use without the prior written consent of the
owner(s) of the relevant Intellectual Property Rights and/or Reproductions.

Further information on the conditions under which disclosures and
exploitation may take place is available from the Head of the
School of Computer Science (or the Vice-President) and the Dean of the
Faculty of Life Sciences, for Faculty of Life Sciences candidates.

\vfill\newpage}


\let\robin@reallyequation = \equation

\def\refchapter#1{\robin@reallyref{ch:#1}}

\def\eatbracketsandarg[#1]#2{}
\newenvironment{thesis}{%
	\thesischapteronlyfalse
	\thesisstyle
	\global\newcommand\chref[2]{\robin@reallyref{##1:##2}}
	\begingroup\document % The definition of \document starts with \endgroup
	\let\robin@reallyref\ref
	\let\robin@reallylabel\label
	\def\documentclass{\@ifnextchar[{\eatbracketsandarg}{\eatbracketsandarg[]}}
}{%
	\let\url\@undefined % If \url is as defined by the hyperref package, the bibliography breaks
	\bibliography{cs}
	%
	\def\@checkend##1{}
	\global\let\really@@end\@@end
	\def\@@end{\endgroup\really@@end}
	\enddocument%
}

\newenvironment{thesischapter}[2]{%
	\ifthesischapteronly
		\articlestyle
		\title{#2}%
		\document
		\global\let\robin@reallylabel\label
		\global\let\robin@reallyref\ref
		\robin@externalchapter{Bicats}{bicats}%
		\robin@externalchapter{Cayley}{cayley}%
		\robin@externalchapter{Language}{internal-language}%
		\robin@externalchapter{Intro}{intro}%
		\robin@externalchapter{MonBicats}{mon-bicats}%
		\robin@externalchapter{Promon}{promonoidal}%
		\robin@externalchapter{Pseudomonoids}{pseudomonoids}%
		\robin@externalchapter{Coh}{some-coherence}%
		\robin@externalchapter{SemiCC}{semicc/semi-compact-closed}%
		\global\def\chref##1##2{[##1]\robin@reallyref{##1:##2}}%
		\maketitle
	\else
		\chapter{#2}\robin@reallylabel{ch:#1}
		\def\label##1{\@bsphack
		  \protected@write\@auxout{}%
		         {\string\newlabel{#1:##1}{{\@currentlabel}{\thepage}{\string\relax}{}{}}}%
		  \@esphack}
		\def\ref##1{\robin@reallyref{#1:##1}}%
		% \def\pageref##1{\Hy@safe@activestrue\expandafter\@setref\csname r@#1:##1\endcsname
		% 	\@secondoffive{#1:##1}\Hy@safe@activesfalse}
		\def\rot@label##1{\@bsphack
		  \r@protected@write\@auxout{}%
		         {\string\newlabel{#1:##1}{{\@currentlabel}{\therpage}{\string\relax}{}{}}}%
		  \@esphack}%
		\def\equation{\robin@reallyequation
		  \def\label####1{\@bsphack
		  \protected@write\@auxout{}%
		         {\string\newlabel{#1:####1}{{\@currentlabel}{\thepage}{\string\relax}{}{}}}%
		  \@esphack}}
	\fi%
}{%
	\ifthesischapteronly
		\bibliography{cs}
		\def\@checkend##1{}
		\enddocument
	\fi}
