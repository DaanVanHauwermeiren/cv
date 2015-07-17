\ProvidesClass{stvhoey-cv}[2015/07/15 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}


%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}
\definecolor{yellow}{HTML}{F5D157}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{yellow}{gray}  
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}

\newfontfamily\bodyfont[]{Roboto}
\newfontfamily\thinfont[]{Roboto Condensed}
\newfontfamily\headingfont[]{Roboto Condensed Bold}

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor]{Roboto}

\setmathfont{Asana-Math} %XITS Math

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}

\newcommand{\rolefont}{%
  \fontsize{14pt}{24pt}\selectfont%
  \thinfont%
  \color{white}%
}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\thinfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}


%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        blue\or%
        red\or%
        orange\or%
        green\or%
        yellow\or%
        purple\else%
        headercolor\fi%
    } #1#2#3%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  \par\vspace{\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{\parskip}
}

%\renewcommand{\subsection}[2]{
%  \par\vspace{.5\parskip}%
%  \Large\headingfont\color{headercolor} #2%
%  \par\vspace{.25\parskip}%
%}
\renewcommand\subsection{%
  \@startsection{subsection}{2}{0pt}{0.5ex \@plus 1ex \@minus .2ex}{.3ex\vspace{0.1ex}}{\headingfont\Large\bfseries}}

\pagestyle{empty}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\setlength{\parsep}{6pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
  
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  #1&\parbox[t]{11.8cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{\parsep}%
  }\\}
\newcommand{\shortentry}[3]{%
  #1&\parbox[t]{11.8cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\vspace{\parsep}% \parsep
  }\\}

%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{4.2}(0.9, 4.33)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

\newenvironment{aside2}{%
  \let\oldsection\section % save the definition under other name
  \renewcommand{\section}[1]{%
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}%
  }
  \let\oldsubsection\subsection
  \renewcommand{\subsection}[1]{%
    \vspace{0.2cm}{\large\headingfont\color{headercolor} ##1}%
  }
  \newcommand{\devitem}[2]{\vspace{0.3ex}%
  ##1\\%
  {\footnotesize\addfontfeature{Color=lightgray} ##2}
  }
  \begin{textblock}{4.2}(0.9, 1.5)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
  \let\subsection\oldsubsection  
}

%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[style=verbose, maxnames=99, sorting=ydnt]{biblatex}
\setlength{\bibhang}{0pt}
\usepackage{multicol}

\DeclareFieldFormat[article]{title}{#1\par}
\DeclareFieldFormat[inproceedings]{title}{#1\par}
\DeclareFieldFormat[misc]{title}{#1\par}
\DeclareFieldFormat[report]{title}{#1\par}
%\renewbibmacro{<name>}{<instructions>}

    \renewbibmacro*{journal+issuetitle}{%
      \usebibmacro{journal}%
      \setunit*{\addcomma\space}%
      \iffieldundef{series}%
        {}%
        {\newunit%
         \printfield{series}%
         \setunit{\addspace}}%
      \usebibmacro{volume+number+eid}%
      \newunit}

\DeclareBibliographyDriver{article}{%
  \printfield{title}%
  \newblock
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \usebibmacro{journal+issuetitle}%
    \setunit{\addcomma\space}%
    \printfield{pages}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \newunit%
  }%
  \par\vspace{0.3\baselineskip}%
}

\DeclareBibliographyDriver{inproceedings}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}%
    \printfield{booktitle}%
    \setunit{\space}%  
    	\usebibmacro{byeditor+others}%
    \newunit%
    \printlist{location}%
    \setunit{\addcomma\space}%
    \usebibmacro{date}%    
    \newunit%
  }%
  \par\vspace{0.3\baselineskip}%
}

\DeclareBibliographyDriver{misc}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printfield{book title}%
    \setunit*{\addcomma\space}%
    \printfield{note}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
  }%
  \par\vspace{0.3\baselineskip}%
}

\DeclareBibliographyDriver{report}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
%  \par
%  {%
%  \footnotesize\addfontfeature{Color=lightgray}%
%  \setunit{\space}%    
%  {in collaboration with \printfield{type}}%
%  }  
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}%
    {%
    \itshape%
    \printlist{institution}%
    }%
    \setunit{\addcomma\space}%
    \printlist{location}%    
    \setunit{\addcomma\space}%
    \printfield{year}%
    \newunit%
  }%
  \par\vspace{0.3\baselineskip}%
}

\DeclareNameFormat{author}{%
  \small\addfontfeature{Color=lightgray}%
  \ifblank{#3}{}{#3\space}#1%
  \ifthenelse{\value{listcount}<\value{liststop}}
    {\addcomma\space}
    {}%
}

\newcommand{\printbibsection}[2]{
  \begin{refsection}
    \nocite{*}
    \printbibliography[sorting=chronological, type={#1}, title={#2}, heading=subbibliography]
  \end{refsection}
}

\DeclareSortingScheme{chronological}{
  \sort[direction=descending]{\field{year}}
  \sort[direction=descending]{\field{month}}
}



%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm,top=2cm,right=1.5cm,bottom=2.5cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}