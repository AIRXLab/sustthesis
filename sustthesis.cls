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

\setCJKfamilyfont{zhkai}{KaiTi}[
  AutoFakeBold=2
]

\setlength{\baselineskip}{20pt}

\ctexset{
  chapter = {
    format     = \raggedright\bfseries\zihao{3},
    beforeskip = \baselineskip,
    afterskip  = \baselineskip,
    name = {},
    number = \arabic{chapter},
    aftername = \hspace{0.5em},
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
  right  = 2.2cm,
  top    = 2.8cm,
  bottom = 2.2cm
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

% key, default value
\def\sust@title{本科毕业设计题目}
\def\sust@author{}
\def\sust@language{chinese}


\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
}

\RequirePackage{tabularx}

% cover, title
\renewcommand\maketitle{%
  \cleardoublepage
  \thispagestyle{empty}%
  
  \begingroup
    \begin{center}
      \includegraphics[width=9.8cm]{sust-title.png}
      \vspace{\baselineskip}

      \zihao{-1}\heiti 毕\hspace{0.5em}业\hspace{0.5em}设\hspace{0.5em}计
      \vspace{\baselineskip}

      \includegraphics[width=4cm]{sust-logo.png}
    \end{center}
  \endgroup
  \begingroup
    \begin{center}
      \zihao{2}\vspace{\baselineskip}
      \heiti 题目：\zihao{-2}\kaishu\underline{\makebox[17em][c]\sust@title}
      \vspace{4\baselineskip}
    \end{center}
  \endgroup
  
  \begingroup
    \begin{center}\zihao{4}\bfseries
      \renewcommand\arraystretch{1.3}
      \begin{tabularx}{17em}{@{}r@{：}X@{}}
        \makebox[4em][s]{学\hfill 生} & \kaishu\bfseries \underline{\makebox[12em][c]{秦二某}}\\
        \makebox[4em][s]{学\hfill 号} & \kaishu\underline{\makebox[12em][c]{202600001}} \\
        \makebox[4em][s]{学\hfill 院} & \kaishu\underline{\makebox[12em][c]{电子信息与人工智能学院}} \\
        \makebox[4em][s]{专\hfill 业} & \kaishu\underline{\makebox[12em][c]{计算机科学与技术}} \\
        \makebox[4em][s]{指导教师}     & \kaishu\underline{\makebox[12em][c]{秦大某}} \\
      \end{tabularx}
    \end{center}
  \endgroup
  \begingroup
   \setlength{\parskip}{0.5\baselineskip}
    \linespread{1.5}
    \begin{center}\zihao{4}\bfseries
      \makebox[3em][c]{2026}年\makebox[1.5em][c]{6}月\makebox[1.5em][c]{21}日
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
    \begin{center}
      \zihao{3}\heiti 设计（论文）题目
    \end{center}
  \endgroup
  \begingroup
    \ctexset{
      chapter= {
        format  = \centering\zihao{4}\heiti,
        break   = {},
        beforeskip = 0pt,
        afterindent = true
      }
    }
    \sust@chapter*{摘\quad 要}%
  \endgroup
}{%
  \par
  \vspace{0.5em}
  \noindent
  {\zihao{-4}\heiti 关键词：}陕西科技大学，本科生%
  \clearpage
}


\newenvironment{abstract*}{%
  \begingroup
    \begin{center}
      \zihao{-2}\bfseries TITLE
    \end{center}
  \endgroup
  \begingroup
    \ctexset{
      chapter= {
        format  = \centering\zihao{-2}\bfseries,
        break   = {},
        beforeskip = 0pt,
        afterindent = true
      }
    }
    \sust@chapter*{ABSTRACT}%
  \endgroup
}{%
  \par
  \vspace{0.5em}
  \noindent
  {\bfseries Key words:} SUST, XI'AN
}

\makeatother


\pdfstringdefDisableCommands{%
  \let\\\relax
  \let\quad\relax
  \let\qquad\relax
  \let\hspace\@gobble
}%


\endinput