\ProvidesClass{robinthesisdraft}

% This class is used to format thesis chapters in draft form.
% Later in the process, the chapters will be stripped of their
% preambles, have \chapter headings added, and be \include'd
% in a master file. This file will use a related class, probably
% based on book.cls.

\newif\ifrobin@useminion\robin@useminiontrue
\DeclareOption{nominion}{\robin@useminionfalse}
\ProcessOptions

\LoadClass[a4paper]{article}
\RequirePackage{amssymb} % Must be loaded before Minion Pro
\ifrobin@useminion
    \RequirePackage[medfamily,opticals]{MinionPro}
    %\RequirePackage{microtype}
\fi

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
\makeatletter
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
\makeatother
