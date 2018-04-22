%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TMR Main File: resume.tex
% Author: Marina Rose "Mars" Geldard
% http://github.com/TheMartianLife/

% Available for others' use under:
% The MIT License (https://opensource.org/licenses/MIT)

% Last Updated: 22/04/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TheMartianReport}[2018 Project Documentation LaTeX class]

% SET UP PAPER DIMENSIONS
\LoadClass[10pt, a4paper]{article}
\RequirePackage[top=0.7in, bottom=1.25in, left=1in, right=1in]{geometry}

% LOAD SOME STUFF IT NEEDS
\RequirePackage{graphicx}
\RequirePackage{parskip}
\RequirePackage{tocloft}
\RequirePackage{xparse}
\RequirePackage{fancyhdr}
\RequirePackage[table]{xcolor}
\RequirePackage{wrapfig}
\RequirePackage[round, sort, comma]{natbib}
\RequirePackage[hidelinks]{hyperref}

% CHANGE FONTS
\renewcommand{\sfdefault}{phv}
\renewcommand{\familydefault}{\sfdefault}

% GET INFORMATION FROM USER
\newcommand{\imagefolder}[1]{\def\@imagefolder{#1}}
\newcommand{\revision}[1]{\def\@revision{#1}}
\newcommand{\project}[1]{\def\@project{#1}}
\newcommand{\logo}[1]{\def\@logo{#1}}
\newcommand{\footertext}[2]{\def\@lfooter{#1} \def\@rfooter{#2}}
\newcommand{\nofootertext}{\def\@lfooter{} \def\@rfooter{}}
\newcommand{\imageref}[1]{\def\@imageref{#1}}

% SET DEFAULT VALUES OTHERWISE
\title{Concept Document}
\author{}
\project{}
\imagefolder{.}
\revision{Revision 1.0}
\bibliographystyle{abbrvnat}
\def\@lfooter{\@title}
\def\@rfooter{\@author}
\imageref{}

% TABLEOFCONTENTS STYLING
\cftpagenumbersoff{subsection}
\cftsetindents{subsection}{0em}{2.5em}

% MAKE TITLE PAGE
\AtBeginDocument{\pagestyle{fancyplain}\titlepage}
\renewcommand{\titlepage}{%
	\thispagestyle{title}
	\begin{flushleft}	
	{\fontsize{48}{45}\selectfont\textbf{\MakeUppercase{\@title}}\par}
	\Large\@author
	\vspace{12pt}\linebreak
	\textbf{\Huge\@project}
	\vspace{12pt}\linebreak	
	\ifdefined\@logo
		\edef\tmp{\noexpand\includegraphics[width=0.3\textwidth]{\@imagefolder/\@logo}}\tmp
	\fi	
	\linebreak\vfill	
	\end{flushleft}
	
	\begin{centering}
	\parbox{0.98\linewidth}{\@starttoc{toc}}
	\vspace{10pt}\linebreak	
	\end{centering}\pagebreak
	\rule{\textwidth}{4pt}
}

% HEADER/FOOTER STYLE
\fancypagestyle{title}{%
	\renewcommand{\headrulewidth}{3.5pt}
	\fancyhf{}
	\lhead{\rule[-2ex]{0pt}{2ex}\textbf{\@revision}}
	\rhead{\rule[-2ex]{0pt}{2ex}\textbf{\@date}}
}

\renewcommand{\headrulewidth}{0pt}
\fancyhead[RE,RO]{}
\fancyhead[LE,LO]{}
\lfoot{\footnotesize\MakeUppercase\@lfooter}
\cfoot{\footnotesize\thepage}
\rfoot{\footnotesize\MakeUppercase\@rfooter}


% NUMBERING OPTIONS
\newif\ifsectionnumbers
\newcommand{\sectionnumbers}{%
	\sectionnumberstrue
}

\newif\ifsubsectionnumbers
\newcommand{\subsectionnumbers}{%
	\subsectionnumberstrue
}

\newif\ifresetnumbering
\NewDocumentCommand{\resetnumbering}{g g}{%
	\def\@nextsectionnumber{1}
	\def\@nextpagenumber{1}
	\IfNoValueF{#1}{%
		\if\relax\detokenize{#1}\relax
			% empty parameter, don't change
		\else
			\def\@nextsectionnumber{#1}
		\fi
	}
	\IfNoValueF{#2}{%
		\if\relax\detokenize{#2}\relax
			% empty parameter, don't change
		\else
			\def\@nextpagenumber{#2}
		\fi
	}
	\resetnumberingtrue
}

% SECTION HEADING STYLE
\RenewDocumentCommand{\section}{s m g}{%
	\begin{flushleft}
	\pagebreak
	\IfNoValueF{#3}{%
		\includegraphics[width=\textwidth]{\@imagefolder/#3}
		\linebreak
	}
	\rule{\textwidth}{4pt}
	\vspace{0pt}\linebreak
	\IfBooleanF{#1}{%
		\stepcounter{section}
	    \ifresetnumbering
	    	\setcounter{section}{\@nextsectionnumber}
	    	\setcounter{page}{\@nextpagenumber}
	    	\resetnumberingfalse
	    \fi
		\ifsectionnumbers
			\textbf{\Huge\arabic{section}~}
		\fi
		\addcontentsline{toc}{section}{#2}%
	}%
	\textbf{\Huge#2}
	\vspace{1em}
	\end{flushleft}
}

% HEADING STYLES
\renewcommand{\subsection}[1]{%
	\begin{flushleft}
	\stepcounter{subsection}
	\vspace{12pt}
	\ifsectionnumbers
		\textbf{\Large\arabic{section}.\arabic{subsection}~}
	\fi
	\ifsubsectionnumbers
		\textbf{\Large\arabic{subsection}~}
	\fi	
	\textbf{\Large\MakeUppercase{#1}}
	\addcontentsline{toc}{subsection}{#1}
	\vspace{0pt}
	\end{flushleft}
}

\renewcommand{\subsubsection}[1]{%
	\begin{flushleft}
	\stepcounter{subsubsection}
	\vspace{12pt}
	\ifsubsectionnumbers
		\textbf{\large\arabic{subsection}.\arabic{subsubsection}~}
	\fi
	\textbf{\large#1}
	\end{flushleft}
}

\newcommand{\subsubsubsection}[1]{%
	\begin{flushleft}
	\vspace{12pt}
	\textbf{-- #1}
	\end{flushleft}
}

\newcommand{\subsubsubsubsection}[1]{%
	\begin{flushleft}
	\vspace{12pt}
	\textbf{---- #1}
	\end{flushleft}
}

\newcommand{\subsubsubsubsubsection}[1]{%
	\begin{flushleft}
	\vspace{12pt}
	\MakeUppercase{#1}
	\end{flushleft}
}

\newcommand{\subsubsubsubsubsubsection}[1]{%
	\begin{flushleft}
	\vspace{12pt}
	\MakeUppercase{-- #1}
	\end{flushleft}
}

\newcommand{\subsubsubsubsubsubsubsection}[1]{%
	\begin{flushleft}
	\vspace{12pt}
	\MakeUppercase{---- #1}
	\end{flushleft}
}

% DRAFTING OPTIONS
\newif\ifdrafting
\newcommand{\drafting}{%
	\draftingtrue
}
\newcommand{\temp}[1]{%
	\ifdrafting
		\textit{\color{blue}#1}
	\fi
}

\newcommand{\crit}[1]{%
	\ifdrafting
		\textit{\color{red}#1}
	\fi
}

% LINK TEXT
\definecolor{linkblue}{RGB}{0, 69, 217}
\NewDocumentCommand{\link}{m g}{%
	\IfNoValueTF{#2}{
		\href{#1}{\color{linkblue}#1}%
	}{%
		\href{#1}{\color{linkblue}#2}%
	}%
}

% IMAGES
\AtEndDocument{\vfill\textit{\@imageref}}
\NewDocumentCommand{\image}{m m g}{%
	\begin{figure}[h]
	\begin{center}
		\includegraphics[width=#1\textwidth]{\@imagefolder/#2}
		\IfNoValueF{#3}{
			\caption{\label{img:#2} #3}
		}
	\end{center}
	\end{figure}
}

% TIP BOXES
\renewcommand{\arraystretch}{1.5}
\NewDocumentCommand{\tipbox}{s m m}{%
	\IfBooleanTF{#1}{%
		\begin{wrapfigure}{r}{0.33\textwidth}
			\begin{tabular}{|p{0.3\textwidth}|}
				\cellcolor{black}
				\textbf{\textcolor{white}{#2}}\\
				\textit{#3}\\\hline
			\end{tabular}
		\end{wrapfigure}
	}{%
		\begin{figure}[h]
			\centering
			\begin{tabular}{|p{0.3\textwidth}|}
				\cellcolor{black}
				\textbf{\textcolor{white}{#2}}\\
				\textit{#3}\\\hline
			\end{tabular}
		\end{figure}
	}
}

% NICE LISTS
\newenvironment{nicelist}[1]{%
	\parindent1em
	\textbf{#1}
    \begin{itemize}
    }
    {\end{itemize}
    }
    
% NICE ENUMS
\newenvironment{niceenum}[1]{%
	\parindent1em
	\textbf{#1}
    \begin{enumerate}
    }
    {\end{enumerate}
    }
    
% BE HELPFUL
\newcommand{\printhelp}{%
	\clearpage
	\textbf{\Huge Welcome to TheMartianReport!}\\
	
	\underline{Commands for before the \textbackslash begin\{document\}}\\

	OVERWRITE OR IGNORE AND HAVE THESE DEFAULTS:
	
		\textbf{\textbackslash title\{Concept Document\}}
		
		\textbf{\textbackslash author\{\}}
		
		\textbf{\textbackslash project\{\}}
		
		\textbf{\textbackslash imagefolder\{.\}}
		
		\textbf{\textbackslash revision\{Revision 1.0\}}
		
		\textbf{\textbackslash footertext\{\textbackslash @title\}\{\textbackslash @author\}}
		
		\textbf{\textbackslash imageref\{\}}
		
		\textbf{\textbackslash bibliographystyle\{abbrvnat\}}\\
	
	OPTIONAL TO DEFINE AND CHANGE VISUALS:
	
		\textbf{\textbackslash logo\{logo.png\}} \% PUTS LOGO ON FRONT PAGE IF GIVEN
		
		\textbf{\textbackslash nofootertext} \% MAKES FOOTER ONLY PAGE NUMBER
		
		\textbf{\textbackslash footertext\{\}\{\}} \% CHANGES FOOTER TEXT TO GIVEN TEXT
		
		\textbf{\textbackslash sectionnumbers} \% SHOWS NUMBERS IN SECTION AND SUBSECTION HEADINGS \textbf{OR}
		
		\textbf{\textbackslash subsectionnumbers} \% SHOWS NUMBERS IN SUBSECTION AND SUBSUBSECTION HEADINGS\\
	
	\underline{Commands for within the document}\\
	
	OVERWRITTEN NORMAL COMMANDS:
	
		\textbf{\textbackslash section\{Section Heading\}} \% AS NORMAL
		
		\textbf{\textbackslash section\{Section Heading\}\{imagename.png\}} \% FINDS IMAGE IN \textbackslash imagefolder AND MAKES HEADER IMAGE\\
	
	NEW BITS AND PIECES:
	
		\textbf{\textbackslash temp\{Text to turn blue and italic for drafting\}} \% ONLY SHOWS IF \textbackslash drafting IN PREAMBLE
		
		\textbf{\textbackslash crit\{Text to turn red and italic for drafting\}} \% ONLY SHOWS IF \textbackslash drafting IN PREAMBLE
		
		\textbf{\textbackslash link \{linkaddress.com\}\{Text to display\}} \% SAME AS HREF BUT WITH CUSTOM STYLING. IF NOT GIVEN, 2nd PARAMETER DEFAULTS TO FIRST (DISPLAYS URL AS CLICKABLE TEXT)
		
		\textbf{\textbackslash image\{0.5\}\{image\_filename.png\}\{Optional extra parameter for figure caption text\}} \% FIRST PARAMETER IS IMAGE WIDTH AS DECIMAL OF \textbackslash textwidth \& IF GIVEN, 3rd PARAMETER WILL INCLUDE \textbackslash label\{img:image\_filename.png\} COMMAND SO YOU CAN \textbackslash ref IT

		\textbf{\textbackslash begin\{nicelist\}\{List Title\}...\textbackslash end\{nicelist\}} \% SAME AS ITEMIZE BUT WITH A TITLE

		\textbf{\textbackslash begin\{niceenum\}\{Enum Title\}... \textbackslash end\{niceenum\}} \% SAME AS ENUMERATE BUT WITH A TITLE

		\textbf{\textbackslash tipbox\{Box Title\}\{Text that goes in box can be as long as you like.\}} \% USE STAR OPTION TO WRAP TEXT IF YOU KNOW A PARAGRAPH COMES AFTER IT\\
	
	Enjoy!\pagebreak
}
