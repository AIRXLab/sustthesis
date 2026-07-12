%%
%% sustthesis.cls
%% SUST Thesis Class
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sustthesis}
  [2026/07/07 v1.0 SUSTech Thesis Class]


\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}

\SetupKeyvalOptions{
  family=sust,
  prefix=sust@,
  setkeys=\kvsetkeys
}

\let\sust@setup@hook\@empty

\newcommand\sustsetup[1]{%
  \let\sust@setup@hook\@empty
  \kvsetkeys{sust}{#1}%
  \sust@setup@hook
}

\newcommand\sust@define@key[1]{%
  \kvsetkeys{sust@key}{#1}%
}

\kv@set@family@handler{sust@key}{%
  \@namedef{sust@#1@@name}{#1}%
  \def\sust@@default{}%
  \def\sust@@choices{}%

  \kv@define@key{sust@value}{name}{%
    \@namedef{sust@#1@@name}{##1}%
  }%

  \@namedef{sust@#1@@check}{}%
  \@namedef{sust@#1@@code}{}%

  \kv@define@key{sust@value}{choices}{%
    \def\sust@@choices{##1}%
    \@namedef{sust@#1@@reset}{}%

    \@namedef{sust@#1@@check}{%
      \@ifundefined{%
        ifsust@\@nameuse{sust@#1@@name}@%
        \@nameuse{sust@\@nameuse{sust@#1@@name}}%
      }{%
        \sust@error{%
          Invalid value
          "#1 = \@nameuse{sust@\@nameuse{sust@#1@@name}}"%
        }%
      }{}%

      \@nameuse{sust@#1@@reset}%

      \@nameuse{%
        sust@\@nameuse{sust@#1@@name}@%
        \@nameuse{sust@\@nameuse{sust@#1@@name}}true%
      }%
    }%
  }%

  \kv@define@key{sust@value}{default}{%
    \def\sust@@default{##1}%
  }%

  \kvsetkeys{sust@value}{#2}%

  \@namedef{sust@\@nameuse{sust@#1@@name}}{}%

  \kv@set@family@handler{sust@choice}{%
    \ifx\sust@@default\@empty
      \def\sust@@default{##1}%
    \fi

    \expandafter\newif
      \csname
        ifsust@\@nameuse{sust@#1@@name}@##1%
      \endcsname

    \expandafter\g@addto@macro
      \csname sust@#1@@reset\endcsname{%
        \@nameuse{%
          sust@\@nameuse{sust@#1@@name}@##1false%
        }%
      }%
  }%

  \kvsetkeys@expandafter{sust@choice}{\sust@@choices}%

  \expandafter\let
    \csname sust@\@nameuse{sust@#1@@name}\endcsname
    \sust@@default

  \expandafter\ifx
    \csname sust@\@nameuse{sust@#1@@name}\endcsname
    \@empty
  \else
    \@nameuse{sust@#1@@check}%
  \fi

  \kv@define@key{sust}{#1}{%
    \@namedef{sust@\@nameuse{sust@#1@@name}}{##1}%
    \@nameuse{sust@#1@@check}%
    \@nameuse{sust@#1@@code}%
  }%
}

\newcommand\sust@option@hook[2]{%
  \expandafter\g@addto@macro
    \csname sust@#1@@code\endcsname{#2}%
}

\sust@define@key{
  degree = {
    choices = {
      bachelor,
      master,
      doctor,
      postdoc,
    },
    default = doctor,
  }
}

\sust@define@key{
  title = {
    default = {标题},
  },
  title* = {
    default = {Title},
    name    = title@en,
  },
  author = {
    default = {姓名},
  },
  author* = {
    default = {Name of author},
    name    = author@en,
  },
}


\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*

\LoadClass[UTF8, a4paper, zihao=-4,scheme=plain]{ctexbook}

\raggedbottom
% 英文字体
\setmainfont{Times New Roman}

% 中文正文字体：宋体 SimSun
\setCJKmainfont{SimSun}[
  Path = fonts/,
  AutoFakeBold = true,
  AutoFakeSlant = true
]

\setCJKfamilyfont{zhkai}{KaiTi}[
  Path = fonts/,
  AutoFakeBold=2
]

\ctexset{%
  chapter = {
    nameformat   = {},
    numberformat = {},
    titleformat  = {},
    fixskip      = true,
    afterindent  = true,
    lofskip      = 0pt,
    lotskip      = 0pt,
  },
  section = {
    afterindent  = true,
  },
  subsection = {
    afterindent  = true,
  },
  subsubsection = {
    afterindent  = true,
  },
  paragraph/afterindent = true,
  subparagraph/afterindent = true,
}

\renewcommand\normalsize{%
  \fontsize{12pt}{20pt}\selectfont
}




\ifsust@degree@bachelor
  \ctexset{
    chapter = {
      format     = \centering\heiti\zihao{3},
      titleformat ={},
      beforeskip = 20pt,
      afterskip  = 20pt,
      name = {},
      numberformat= \normalfont,
      number = \arabic{chapter},
      aftername = \hspace{0.5em},
    },
    section = {
      format     = \raggedright\heiti\zihao{4},
      beforeskip = 0.5\baselineskip,
      afterskip  = 0.5\baselineskip,
      name = {},
      numberformat= \normalfont,
      aftername = \hspace{0.5em}
    },
    subsection = {
      format     = \raggedright\heiti\zihao{-4},
      beforeskip = 0.5\baselineskip,
      afterskip  = 0.5\baselineskip,
      name = {},
      numberformat= \normalfont,
      aftername = \hspace{0.5em}
    }
  }
\else
  \ctexset{
    chapter = {
      format = \raggedright\bfseries\fontsize{16pt}{20pt}\selectfont,
      beforeskip = 20pt,
      afterskip  = 20pt,
      name = {},
      numberformat= \normalfont,
      number = \arabic{chapter},
      aftername = \hspace{0.5em},
    },
    section = {
      format     = \raggedright\bfseries\fontsize{14pt}{20pt}\selectfont,
      beforeskip = 10pt,
      afterskip  = 10pt,
      name = {},
      numberformat= \normalfont,
      % number = \arabic{chapter},
      aftername = \hspace{0.5em},
    },
    subsection = {
      format     = \raggedright\bfseries\fontsize{12pt}{20pt}\selectfont,
      beforeskip = \z@,
      afterskip  = \z@,
      name = {},
      numberformat= \normalfont,
      % number = \arabic{chapter},
      aftername = \hspace{0.5em},
    }
  }
\fi

%------------------------------------------------
% 加载宏包
%------------------------------------------------
\RequirePackage{geometry}

\ifsust@degree@bachelor
\geometry{
  left   = 2.8cm,
  right  = 2.2cm,
  top    = 2.8cm,
  headheight=0.53cm,
  headsep=0.77cm,
  bottom = 2.2cm
}
\else
\geometry{
  top=3.0cm,
  bottom=2.8cm,
  left=2.8cm,
  right=2.1cm,
  headheight=14pt,
}
\fi

\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{amsmath,amssymb}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{titletoc}
\RequirePackage{fancyhdr}
\RequirePackage{filehook}
\RequirePackage{pdfpages}



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

\RequirePackage{tabularx}
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{%
  \fancyhf{} 
  \fancyhead{}
  \fancyfoot{}
  \fancyhead[CE]{\zihao{-5}毕业设计（论文）题目}%
  \fancyhead[CO]{\zihao{-5}陕西科技大学毕业论文（设计说明书）}
  \fancyfoot[C]{\zihao{5}\thepage}

  \renewcommand{\headrule}{%
        \hrule height 0.5pt
        \vskip 1pt
        \hrule height 0.5pt
  }
}

\def\ps@chapter{}
\ctexset{chapter/pagestyle = chapter}

\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
  \pagestyle{empty}
}

\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{plain}
}

% cover, title
\renewcommand\maketitle{%
  \cleardoublepage
  \pagestyle{empty}%
  
  \begingroup
    \begin{center}
      \includegraphics[width=9.8cm]{assets/sust-title.png}
      \vspace{\baselineskip}

      \zihao{-1}\heiti 毕\hspace{0.5em}业\hspace{0.5em}设\hspace{0.5em}计
      \vspace{\baselineskip}

      \includegraphics[width=4cm]{assets/sust-logo.png}
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
  \if@openright\cleardoublepage\else\clearpage\fi%
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

\newbox\sust@stretch@box
\newcommand\sust@stretch[2]{%
  \sbox\sust@stretch@box{#2}%
  \ifdim \wd\sust@stretch@box < #1\relax
    \begingroup
      \ifLuaTeX
        \ltjsetparameter{kanjiskip = {0pt plus 2filll}}%
      \else
        \renewcommand\CJKglue{\hspace{0pt plus 2filll}}%
      \fi
      \makebox[#1][l]{#2}%
    \endgroup
  \else
    \box\sust@stretch@box
  \fi
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
        titleformat = \sust@stretch{2.5em},
        break   = {},
        beforeskip = 0pt,
        afterindent = true
      }
    }
    \let\clearpage\relax
    \let\cleardoublepage\relax
    \sust@chapter*{摘要}%
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
    \ctexset{
      chapter= {
        format  = \centering\zihao{-2}\bfseries,
        break   = {},
        beforeskip = 0pt,
        afterindent = true
      }
    }
    \begin{center}
      \zihao{-2}\bfseries TITLE
    \end{center}
    \let\clearpage\relax
    \let\cleardoublepage\relax
    \sust@chapter*{ABSTRACT}%
  \endgroup
}{%
  \par
  \vspace{0.5em}
  \noindent
  {\bfseries Key words:} SUST, XI'AN
  \clearpage
}

\RequirePackage{notoccite}
\def\contentsname{目录}
\renewcommand\tableofcontents{
  \begingroup
  \ctexset{chapter/titleformat = \centering\sust@stretch{2.5em}}%
  \sust@chapter*[]{\contentsname}
  \@starttoc{toc}%
  \endgroup
}

\newcommand\sust@leaders{%
  \space
  \titlerule*[4bp]{%
    {\bfseries\textperiodcentered}%
  }%
  \nobreak
}

\contentsmargin{\z@}
\titlecontents{chapter}
  [0em]
  {\normalfont\zihao{-4}}
  {\thecontentslabel\space}
  {}
  {\sust@leaders\thecontentspage}

\titlecontents{section}
  [2em]
  {}
  {\thecontentslabel\space}
  {}
  {\sust@leaders\thecontentspage}

\titlecontents{subsection}
  [4em]
  {}
  {\thecontentslabel\space}
  {}
  {\sust@leaders\thecontentspage}

\pdfstringdefDisableCommands{%
  \let\\\relax
  \let\quad\relax
  \let\qquad\relax
  \let\hspace\@gobble
}%


\endinput