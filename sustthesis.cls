%%
%% sustthesis.cls
%% SUST Thesis Class
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sustthesis}
  [2026/07/07 v1.0 SUSTech Thesis Class]

%------------------------------------------------
% 选项处理
%------------------------------------------------
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{ctexbook}
}

\ProcessOptions\relax

%------------------------------------------------
% 加载基础类
%------------------------------------------------
\LoadClass[
  UTF8,
  a4paper,
  oneside,
  openright,
  zihao=-4
]{ctexbook}

% 英文字体
\setmainfont{Times New Roman}

% 中文正文字体：宋体 SimSun
\setCJKmainfont{SimSun}[
  Path = fonts/,
  AutoFakeBold = true,
  AutoFakeSlant = true
]

\setlength{\baselineskip}{20pt}

\ctexset{
  chapter = {
    format     = \raggedright\bfseries\zihao{3},
    beforeskip = \baselineskip,
    afterskip  = \baselineskip,
    name = {},
    number = \arabic{chapter},
    aftername = \hspace{0.5em}
  },
  section = {
    format     = \raggedright\bfseries\zihao{4},
    beforeskip = 0.5\baselineskip,
    afterskip  = 0.5\baselineskip,
    name = {},
    aftername = \hspace{0.5em}
  },
  subsection = {
    format     = \raggedright\bfseries\zihao{-4},
    beforeskip = 0pt,
    afterskip  = 0pt,
    name = {},
    aftername = \hspace{0.5em}
  }
}
%------------------------------------------------
% 加载宏包
%------------------------------------------------
\RequirePackage{geometry}
\geometry{
  left   = 2.8cm,
  right  = 2.1cm,
  top    = 3cm,
  bottom = 2.8cm
}


\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{amsmath,amssymb}
\RequirePackage{booktabs}
\RequirePackage{caption}

\PassOptionsToPackage{
  linktoc            = all,
  bookmarksdepth     = 2,
  bookmarksnumbered  = true,
  bookmarksopen      = true,
  bookmarksopenlevel = 1,
  bookmarksdepth     = 3,
  unicode            = true,
  psdextra           = true,
  breaklinks         = true,
  plainpages         = false,
  pdfdisplaydoctitle = true,
  hidelinks,
}{hyperref}
\RequirePackage{hyperref}

\RequirePackage[sort]{natbib}
\RequirePackage[sort&compress]{gbt7714}
\bibliographystyle{gbt7714-numerical}

\RequirePackage{kvsetkeys}
\RequirePackage{kvdefinekeys}

\RequirePackage{kvsetkeys}
\RequirePackage{kvdefinekeys}

\makeatletter

\newcommand\sustsetup[1]{%
  \let\sust@setup@hook\@empty
  \kvsetkeys{sust}{#1}%
  \sust@setup@hook
}

\newcommand\sust@addto@setup@hook[1]{%
  \g@addto@macro\sust@setup@hook{#1}%
}

\define@key{sust}{title}{%
  \def\sust@title{#1}%
}

\define@key{sust}{author}{%
  \def\sust@author{#1}%
}

\define@key{sust}{language}{%
  \def\sust@language{#1}%
  \sust@addto@setup@hook{%
  }%
}

% 默认值
\def\sust@title{}
\def\sust@author{}
\def\sust@language{chinese}


\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
}

\renewcommand\maketitle{%
  \cleardoublepage
  \thispagestyle{empty}%
  \begingroup
    \begin{center}
      \zihao{-0}硕士学位论文
    \end{center}
  \endgroup
  \begingroup
    \begin{center}
      \zihao{3}\sust@title
    \end{center}
  \endgroup
}


\newcommand{\sust@error}[1]{%
  \PackageError{sust}{#1}{}
}

\newcommand{\sust@pdfbookmark}[2]{%
  \pdfbookmark[#1]{#2}{#2}
}

\newcommand{\sust@phantomsection}{%
  \phantomsection
}

\NewDocumentCommand\sust@chapter{s o m o}{%
  \IfBooleanF{#1}{%
    \sust@error{You have to use the star form: \string\sust@chapter*}%
  }%
  % \if@openright\cleardoublepage\else\clearpage\fi%
  \IfValueTF{#2}{%
    \ifthenelse{\equal{#2}{}}{%
      \sust@pdfbookmark{0}{#3}%
    }{%
      \sust@phantomsection
      \addcontentsline{toc}{chapter}{#2}%
    }%
  }{%
    \sust@phantomsection
    \addcontentsline{toc}{chapter}{#3}%
  }%
  \chapter*{#3}%
  \IfValueTF{#4}{%
    \ifthenelse{\equal{#4}{}}{%
      \@mkboth{}{}%
    }{%
      \@mkboth{#4}{#4}%
    }%
  }{%
    \@mkboth{#3}{#3}%
  }%
}
\newenvironment{abstract}{%
  \begingroup
    \ctexset{
      chapter= {
        format  = \centering,
        break   = {}
      }
    }
    \sust@chapter*{摘\quad 要}%
  \endgroup
}{%
  \par
  \null\par
  \textsf{关键词：}%
  \clearpage
}


\newenvironment{abstract*}{%
    % \begingroup
    \sust@chapter*{Abstract}%
    % \endgroup
}{%
  \par
  \null\par
  \textsf{KERWORD:}%
}

\makeatother


\pdfstringdefDisableCommands{%
  \let\\\relax
  \let\quad\relax
  \let\qquad\relax
  \let\hspace\@gobble
}%


\endinput