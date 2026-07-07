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
  openright
]{ctexbook}

\ctexset{
  chapter = {
    format     = \raggedright\heiti\zihao{3},
    beforeskip = \baselineskip,
    afterskip  = \baselineskip,
    name = {},
    number = \arabic{chapter},
    aftername = \hspace{1em}
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

\makeatother

\endinput