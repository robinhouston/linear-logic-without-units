\ProvidesClass{robincs}
\newif\ifrobin@thesis\robin@thesisfalse
\newif\ifrobin@twocol\robin@twocolfalse
\newif\ifrobin@euler\robin@eulertrue
\def\robin@bibbrackets{round}
\def\basedon#1{
	\DeclareOption{draft}{\PassOptionsToClass{draft}{#1}}
	\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{#1}}
	\DeclareOption{titlepage}{\PassOptionsToClass{titlepage}{#1}}
	\DeclareOption{notitlepage}{\PassOptionsToClass{notitlepage}{#1}}
	\newif\ifrobin@nosize\robin@nosizetrue
	\DeclareOption{10pt}{\robin@nosizefalse}
	\DeclareOption{11pt}{\robin@nosizefalse\PassOptionsToClass{11pt}{#1}}
	\DeclareOption{12pt}{\robin@nosizefalse\PassOptionsToClass{12pt}{#1}}
	\DeclareOption{thesis}{\robin@thesistrue}
	\DeclareOption{noeuler}{\robin@eulerfalse}
	\DeclareOption{twocolumn}{\robin@twocoltrue\PassOptionsToClass{twocolumn}{#1}}
	\DeclareOption{bibround}{\gdef\robin@bibbrackets{round}}
	\DeclareOption{bibsquare}{\gdef\robin@bibbrackets{square}}
	\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{robincs}}
	\ProcessOptions
	%
	\ifrobin@thesis
		\PassOptionsToClass{titlepage}{#1}
		\ifrobin@nosize\PassOptionsToClass{12pt}{#1}\fi
	\else
		\ifrobin@nosize\PassOptionsToClass{11pt}{#1}\fi
	\fi
	\LoadClass[a4paper]{#1}
	\ifrobin@thesis%
		\let\ps@reallyempty\ps@empty%
		\def\ps@empty{}%
		\RequirePackage{setspace}%
		\onehalfspacing
	\fi
	\ifrobin@euler%
	  \RequirePackage{euler}%
	\fi
}
\ifx\robincsbase\undefined
	\basedon{article}
\else
	\basedon{\robincsbase}
\fi
\RequirePackage{robincs}\RequirePackage{url}\RequirePackage[\robin@bibbrackets]{natbib}

\ifrobin@euler%
  % The euler package inserts extra space between a prime mark
  % and the previous letter. Can't think why - it looks really
  % ugly. We reset the definition to the default.
  {\catcode`\'=\active
  \gdef'{^\bgroup\prim@s}}
\fi

% Correct the command names
\let\nonvictorianspacing=\frenchspacing
\let\victorianspacing=\nonfrenchspacing
\let\disableoverzealousverticaljustification=\raggedbottom

\nonvictorianspacing \disableoverzealousverticaljustification

\RequirePackage[TS1, OT1]{fontenc}\RequirePackage{textcomp}
\def\rmdefault{icj}\def\bfdefault{b}%\RequirePackage{euler}

\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    %\fontfamily{ppl}\selectfont
    \ifnum \c@secnumdepth >\m@ne
        \huge\@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \Huge #1\par\nobreak
    \vskip 40\p@
  }}
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont%\fontfamily{ppl}\selectfont
    \interlinepenalty\@M
    \Huge  #1\par\nobreak
    \vskip 40\p@
  }}

\ifrobin@thesis
	\parindent=1.5em
\else
	\parindent=1em
\fi
\ifrobin@twocol\else
	\oddsidemargin-1in \advance\oddsidemargin by 44mm
	\textwidth=122mm  % about 29 picas
\fi
\marginparwidth=26mm\marginparsep=3mm
% 44mm + 122mm + 3mm + 26mm = 195mm, so right gutter = 15mm

\textheight=244mm % tall rectangle, leaving 53mm for t&b margins & heads
\topmargin=-1in \advance\topmargin by 21mm
\headheight=3mm\headsep=3mm%\footskip=0pt
% leaving 27mm at bottom

% suggestions for top/bot (top including appropriate head + headsep):
% 0.  26.5mm/26.5mm		- i.e. 1:1 ratio
% 1.  23mm/30mm
% 2.  17.667mm/35.333mm	- i.e. 1:2 ratio

\newbox\robin@tempbox

\def\@maketitle{%
    \ifrobin@thesis
        \null\vskip1in%
        \begin{center}
                %\fontfamily{ppa}\selectfont
		\Huge\uppercase\expandafter{\@title}
        \end{center}
        \vfill
        \begin{center}
                \sc A thesis submitted to the University of Manchester\\
                for the degree of Master of Science\\
                in the Faculty of Science and Engineering
        \end{center}
        \vfill
        \begin{center}
                \the\year
        \end{center}
        \vfill
        \begin{center}
                {\bf\@author}\\
                Department of Mathematics
        \end{center}\vskip.5in\newpage%
%
    \else%
%
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
	\end{center}\par\vskip1em
\fi}

\@ifundefined{chapter}{\relax}{
	% Stolen (& modified) from report.cls
	\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
		\thispagestyle{empty}%
		\global\@topnum\z@
		\@afterindentfalse
		\secdef\@chapter\@schapter}
}

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\Large}}

\newcounter{sidenote}[page]
\renewcommand\thesidenote{{%
	\edef\sidenotevalue{\arabic{sidenote}}%
	\ifnum\sidenotevalue=1\textonesuperior%
		\else\ifnum\sidenotevalue=2\texttwosuperior%
			\else\ifnum\sidenotevalue=3\textthreesuperior%
				\else\sidenotevalue%
			\fi%
		\fi%
	\fi%
}}

\newcommand\sidenote[1]{%
	\stepcounter{sidenote}%
	\makeatletter%
		\edef\@currentlabel{\arabic{sidenote}}%
	\makeatother%
	\thesidenote\marginpar{\raggedright%
	\raisebox{-1pt}{\thesidenote}\footnotesize~#1}}
\newcommand\marnote[1]{\marginpar{\raggedright\footnotesize#1}}

\pagestyle{myheadings}
\author{Robin Houston}	% Can be over-ridden with another \author


% Some thesis-specific bits, largely nicked from muthesis.cls
\def\thesisprefacesection#1{%
        \chapter*{#1}
        \addcontentsline{toc}{chapter}{#1}}

\newcommand{\thesisdeclaration}{
	\thesisprefacesection{Declaration}
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

\newcommand\thesiscopyrightpage{%
\thesisprefacesection{Copyright Statement}
{\renewcommand\labelenumi{(\theenumi)}
\begin{enumerate}
\item
Copyright in text of this thesis rests with the Author. Copies (by any
process) either in full, or of extracts, may be made {\bf only} in
accordance with instructions given by the Author and lodged in the
John Rylands University Library of Manchester. Details may be obtained
from the Librarian. This page must form part of any such copies made.
Further copies (by any process) of copies made in accordance with such
instructions may not be made without the permission (in writing) of the
Author.

\item
The ownership of any intellectual property rights which may be described
in this thesis is vested in the University of Manchester, subject to
any prior agreement to the contrary, and may not be made available for
use by third parties without the written permission of the University,
which will prescribe the terms and conditions of any such agreement.

\item
Further information on the conditions under which disclosures and
exploitation may take place is available from the Head of the Department
of Mathematics.
\end{enumerate}}
%
\vfill\newpage}
