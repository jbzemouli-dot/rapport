
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name : enac_template.cls
% Date : 18/01/2022
% Authors: Alexandre CHABORY V1.0 (alexandre.chabory@enac.fr)
%           Alexandre CHARDIN V2.0 (alexandre.chardin@enac.fr)
%           Alexandre CHABORY V3.0 (alexandre.chabory@enac.fr)

% Description:
%       This class aims to cover most of the needed template at ENAC
%       You will found 5 templates:
%           (1) [project]: ENAC projects for ENAC students 
%           (2) [thesis]: Thesis template for PhD students
%           (3) [report]: Report template for ENAC staff
%           (4) [lecture]: Lecture template for ENAC staff
%           (5) [letter]: Letter template for ENAC staff
%   By default all templates are in English, to switch to french template, add "fr" to the template options. Example: [project,fr]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{enac_template}[18/01/2022 ENAC Template, V3.0]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Options initialization 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption{fr}{\def\fr{1}}

\DeclareOption{project}{\def\project{1}}
\DeclareOption{thesis}{\def\thesis{1}}
\DeclareOption{report}{\def\report{1}}
\DeclareOption{lecture}{\def\lecture{1}}
\DeclareOption{letter}{\def\letter{1}}



\DeclareOption*{
\ClassWarningNoLine{enac_template}{Unknown option `\CurrentOption' specified for 'enac_template' class}
\PackageWarningNoLine{enac_template}{Unknown option `\CurrentOption' specified for 'enac_template' class}
} % If unknown option: warning
\ProcessOptions 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Base class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% If else package
\RequirePackage{ifthen}


\ifthenelse{\NOT \isundefined{\project} \OR \NOT \isundefined{\thesis}  \OR \NOT \isundefined{\lecture}}
{ % If: project or thesis
    \ifthenelse{\NOT \isundefined{\fr} }
    {% If: french option [fr]
        \LoadClass[11pt,a4paper]{book}
    }
    {% Else: 
        \LoadClass[11pt,a4paper]{book}
    }
}
{ % Else: 
    % Do nothing
} 

\ifthenelse{\NOT \isundefined{\report} }
{ % If: report [report]
    \LoadClass[11pt,a4paper]{article}
}
{ % Else: 
    % Do nothing
} 
\ifthenelse{\NOT \isundefined{\letter}}
{ % If: report [report]
    \LoadClass[11pt,a4paper]{article}
}
{ % Else: 
    % Do nothing
} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%-----------------------------------------------------
%                 French packages
%-----------------------------------------------------

\ifthenelse{\NOT\isundefined{\fr}}
{ % If: french option [fr]
    \RequirePackage[french]{babel}
    \RequirePackage{newunicodechar}
    % \RequirePackage[utf8x]{inputenc} % (old package with warnings)
}
{ % Else: NOT french option [en]
    \RequirePackage[english]{babel}
}


%-----------------------------------------------------
%                  Thesis packages
%-----------------------------------------------------

\ifthenelse{\NOT\isundefined{\thesis}}
{ % If thesis option [thesis]
    \NeedsTeXFormat{LaTeX2e}          % Require recent version of LaTeX >= 2011
    \RequirePackage{xkeyval}
    % PACKAGE
    \RequirePackage{lmodern}          % Latin Modern font
    \RequirePackage{color}            % Use color
    \RequirePackage{eso-pic}          % Make background texture (picture and page style)
    \RequirePackage{pgffor}           % Make loop for in LaTeX
    \@ifpackageloaded{geometry}
    { % If : geometry package loaded
        \PassOptionsToPackage{pass}{geometry}
    }
    { % Else : 
        \RequirePackage[pass]{geometry}
    }
    \@ifclassloaded{memoir} {\DisemulatePackage{setspace}} {}
    \RequirePackage{calc}             % Allow use of '-',+','/' ans '*' to make simple lenght computation
    \RequirePackage{etoolbox}         % Need at least for ifstrequal, ifnumgreater (include in mdframed)
    %% Not standard package
    \RequirePackage{shadowtext}       % Allow shadow for text : http://www.tex.ac.uk/CTAN/macros/latex/contrib/shadowtext/ 
}
{ % Else :
    % Do nothing
} 

%-----------------------------------------------------
%           Letter and report packages
%-----------------------------------------------------

\ifthenelse{\NOT\isundefined{\letter} \OR \NOT\isundefined{\report}}
{ % If letter
    \RequirePackage{lastpage}
}
{ % Else
    % Do nothing
}


%-----------------------------------------------------
%               General packages
%-----------------------------------------------------

% Fonts 
%\RequirePackage{cmlgc}
\RequirePackage{ucs}
\RequirePackage[T1]{fontenc}

% Figures
\RequirePackage{graphicx}
\RequirePackage{psfrag}
\RequirePackage{subfig}
\RequirePackage[usenames,dvipsnames]{pstricks}

% Lists 
%\RequirePackage{placeins}		    
\RequirePackage{enumitem}

% Tables
\RequirePackage{tabularx} 
\RequirePackage{multirow}
\RequirePackage{array}
\RequirePackage{diagbox}

% Footer and header 
\RequirePackage{fancyhdr}      

% Equations (special characters, ...)
\RequirePackage{amsfonts}               
\RequirePackage{amsgen}
\RequirePackage{amsbsy}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{bbm}
\RequirePackage{esint}

% To reduce margin
\RequirePackage{fullpage} 

% Acronyms and glossaries
% \RequirePackage[toc]{glossaries}
\RequirePackage[nohyperlinks]{acronym} % show all acronyms listed in references/acronym.tex
% \RequirePackage[nonumberlist,style=listgroup,style=listhypergroup]{glossaries}
\RequirePackage[nonumberlist,style=listgroup]{glossaries}

% Line spacing
\RequirePackage{setspace} 
\RequirePackage{float}  % [H] figure option
\RequirePackage{hyperref} % Interactive summary
\RequirePackage{subfiles} % Folders

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Table of contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setcounter{secnumdepth}{3} % Depth of the sections
\setcounter{tocdepth}{2} % Depth of the table of contents
%% Remark: NO CHAPTER FOR LETTER
\ifthenelse{\NOT\isundefined{\letter} \OR\NOT\isundefined{\report}}
{ % if letter
    % Do nothing
}
{ % else
    \renewcommand{\chaptermark}[1]{\markboth{#1}{}}
}

\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
% Numbering mode of the sub-sections
\renewcommand{\thesubsubsection}{\thesubsection .\arabic{subsubsection}}
% Narrow the space line of the table of contents
\addtocontents{toc}
{
    \protect\setlength{\baselineskip}{1em}
    \protect\setlength{\parskip}{0pt}
}

\tolerance 1414
\hbadness 1414
\emergencystretch 1.5em
\hfuzz 0.3pt
\widowpenalty=10000
\vfuzz \hfuzz
\raggedbottom

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Layout definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Remark: some layout definitions are specific to a template and are modified in the template definition

\setlength{\voffset}{0cm}
\setlength{\topmargin}{-2cm} 
\setlength{\headheight}{2.5cm} 
\setlength{\headsep}{0.5cm} 
\setlength{\textheight}     {24cm} 
\setlength{\footskip}       { 1.2cm} 
\setlength{\oddsidemargin}  { 0cm} 
\setlength{\evensidemargin} { 0cm}
\setlength{\textwidth}      {16cm} 
\setlength{\leftmargin}     { 0.5cm} 
\setlength{\leftmargini}    { 0.5cm} 
\setlength{\leftmarginii}   { 0.5cm}
\setlength{\rightmargin}    { 0.0cm} 
\setlength{\parskip}        { 0.2cm} 
\setlength{\topsep}         { 0.0cm}
\setlength{\partopsep}      { 0.0cm} 
\setlength{\itemsep}        { 0.0cm} 
\setlength{\parsep}         { 0.0cm} 
\setlength{\listparindent}  { 0.5cm} 
\setlength{\parindent}      { 0.cm} % Indentation
\newlength{\minindent}               % Indentation declaration
\setlength{\minindent}      { 0.cm} % Indentation in a minipage
\setitemize[0]{label=\textbullet} % Round bullet points

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               (1) PROJECT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\NOT\isundefined{\project}}
{ % If project option: [project]
    %-----------------------------------------------------
    %               Project definitions
    %-----------------------------------------------------
    \def\supervisor#1{\gdef\@supervisor{#1}}
    \def\defensedate#1{\gdef\@defensedate{#1}}
    \def\company#1{\gdef\@company{#1}}
    \def\confidential#1{\gdef\@confidential{#1}}
    \def\typedoc#1{\gdef\@typedoc{#1}}
    \def\promotion#1{\gdef\@promotion{#1}}
    \def\partnerlogo#1{\gdef\@partnerlogo{#1}}
    \ifthenelse{\NOT \isundefined{\fr} }
    %-----------------------------------------------------
    %               French project
    %-----------------------------------------------------
    {% If: french option [fr]
        \renewcommand{\maketitle}
        { % Cover page definition
            \pagestyle{empty}
            % Extend Footer
            \enlargethispage{4cm}
            \addtolength{\voffset}{-2cm}
            % Logos
            \begin{minipage}{0.35\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_enac_and_marianne} 
            \end{minipage}
            \hfill
            \begin{minipage}{0.16\linewidth}
            \end{minipage}
            \rule{\textwidth}{0.8pt}
            \vspace{10pt}
            \begin{center} 
                % Document type
                \huge 
                \textbf{\@typedoc} \\[20pt]
                \large 
                Dernière version : \today \\[20pt]
                % Document title
                \begin{minipage}{0.75\linewidth}
                    \begin{center}
                        \rule{\textwidth}{0.8pt} \\
                        \begin{spacing}{2.0}
                            {\Large \bf \@title} 
                        \end{spacing}
                        \rule{\textwidth}{0.8pt} \\[50pt]
                    \end{center}
                \end{minipage}
                ~\\[50pt]
                % Date, authors and tutors
                \large 
                Présenté le {\@defensedate} par \\[20pt]
                {\bf \@author} \\[20pt]
                Promotion : \\[20pt]
                {\bf \@promotion}
                \large
                ~\\[20pt] 
                Supervisé à {\bf\@company} par \\[20pt]
                \large 
                {\bf \@supervisor} \\[250pt]
                \ifx\@confidential\undefined
                \else
                    \Large 
                    \textcolor{red}{\textbf{\fbox{CONFIDENTIEL}}}
                \fi
            \end{center}
            % White page after cover page
            \newpage
            \null
            \thispagestyle{empty}
            \addtolength{\voffset}{2cm}
            \newpage
        } % End of cover definition
    }
    %-----------------------------------------------------
    %               English project
    %-----------------------------------------------------
    {% Else: 
        \renewcommand{\maketitle}
        { % Cover page definition
            \thispagestyle{empty}
            \enlargethispage{4cm}
            \addtolength{\voffset}{-2cm}
            % Logos
            \begin{minipage}{0.35\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_enac_and_marianne} 
            \end{minipage}
            \hfill
            \begin{minipage}{0.16\linewidth}
%                 \includegraphics[height=26mm]{sources/logos/logo_enac_right_corner} 
            \end{minipage}
            \rule{\textwidth}{0.8pt}
            \vspace{10pt}
            \begin{center} 
                % Document type
                \huge 
                \textbf{\@typedoc} \\[20pt]
                \large 
                Last update: \today \\[20pt]
                % Document title
                \begin{minipage}{0.75\linewidth}
                    \begin{center}
                        \rule{\textwidth}{0.8pt} \\
                        \begin{spacing}{2.0}
                            {\Large \bf \@title} 
                        \end{spacing}
                        \rule{\textwidth}{0.8pt} \\[50pt]
                    \end{center}
                \end{minipage}
                ~\\[50pt]
                % Date, authors and tutors
                \large 
                Presented on {\@defensedate} by \\[20pt]
                {\bf \@author}\\[20pt]
                Promotion: \\[20pt]
                {\bf \@promotion}
                \large
                ~\\[20pt] 
                Supervised at {\bf \@company} by   \\[20pt]
                \large 
                {\bf \@supervisor} \\[250pt]
                \ifx\@confidential\undefined % If not confidential
                    % Do nothing
                \else 
                    \Large 
                    \textcolor{red}{\textbf{\fbox{CONFIDENTIAL}}}
                \fi
            \end{center}
            % White page after cover page
            \newpage
            \null
            \thispagestyle{empty}
            \addtolength{\voffset}{2cm} % Restore offset
            \newpage
        } % End of cover page definition
    }
}
{ % Else 
    % Do nothing
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               (2) THESIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\NOT\isundefined{\thesis}}
{ % If thesis option: [thesis]
    % OPTION
    %emptysheetbefore => Insert two white pages (one sheet) before the flyleaf
    \newif\if@emptysheetbefore\@emptysheetbeforefalse 
    \DeclareOptionX{emptysheetbefore}[none]{\@emptysheetbeforetrue}
    %emptypageafter => insert one page after the flyleaf
    \newif\if@emptypageafter\@emptypageafterfalse 
    \DeclareOptionX{emptypageafter}[none]{\@emptypageaftertrue}
    % %draft => Remove flyleaf page
    % \newif\if@draft\@draftfalse
    % \DeclareOptionX{draft}[none]{\@drafttrue}
    
    %% KEY=VALUE OPTION
    % Establishment
    \def\establishment#1{\gdef\@establishment{#1}}
    \establishment{ENAC1}
    % Docschool and speciality
    \def\docschool#1{\gdef\@docschool{#1}}
    \docschool{ENAC2}
    \def\partnerlogo#1{\gdef\@partnerlogo{#1}}
    
    %% PROCESS OPTION
    \ProcessOptionsX
    
    % ============================================================
    % OPTION ERROR
    \ifx\@establishment\undefined
      \PackageWarning{enac_template}{No option Ets given: set Ets to default}
      \establishment{{\color{pdgred}D\'efinir le nom de l'\'etablissement avec l'option 'Ets' du paquet enac_template.cls}}
    \fi
    \ifx\@docschool\undefined
      \PackageWarning{enac_template}{No option ED given: set ED to default}
      \docschool{{\color{pdgred}D\'efinir l'\'ecole doctorale avec l'option 'ED' du paquet enac_template.tex}}
    \fi
    
    % ============================================================
    
    
    % ============================================================
    % LENGTH
    \newlength{\RuleWidth}
    \newlength{\@pdgLinethickness}
    \newlength{\@pdgMargeSize}
    \newlength{\@pdgInnerBoxWidth}
    \newlength{\@pdgInnerBoxHeight}
    
    % ============================================================
    % COMMAND
    % Unit convertor
    \def\convertto#1#2{\strip@pt\dimexpr #2*65536/\number\dimexpr 1#1}
    % Blank sheet
    \newcommand{\blanksheet}[1][num]{%
    	\ifstrequal{#1}{nonum}{%true nonum
    		\newpage{\thispagestyle{empty}} ~ \newpage{\thispagestyle{empty}~}
    	}{%false
    		\ifstrequal{#1}{num}{%true num
    			\newpage ~ \newpage
    		}{%false not nonum and not num
    			\PackageWarning{obianphd-blanksheet}{'#1' is not a possible option(nonum[default], num)}
    		}
    	}
    }
    % textline
    \newcommand\textline[4][t]{%
      \par\noindent\parbox[#1]{.333\textwidth}{\raggedright{\scshape #2}}%
      \parbox[#1]{.333\textwidth}{\centering#3}%
      \parbox[#1]{.333\textwidth}{\raggedleft#4}\par%
    }
    % makesomeone
    \gdef\showline{show}% Permet de tester si la ligne doit etre affichee
    \newcommand{\makesomeone}[5]{%
    	\edef\makesomeonearg{{#1}}%
    	\expandafter\ifstrequal\makesomeonearg{judge}{}{%FALSE
    		\expandafter\ifstrequal\makesomeonearg{referee}{}{%FALSE
    			\expandafter\ifstrequal\makesomeonearg{boss}{}{%FALSE
    				\PackageError{tlsflyleaf-makesomeone}{%
                        '#1' is not a possible argument
                    }
                    {%
                        First argument could be in {judge, referee, boss}
                    }
    	        }%
            }%
        }%
    	\expandafter\gdef\csname @#1N#2\endcsname{#3}
    	\expandafter\gdef\csname @#1P#2\endcsname{#4}
    	\expandafter\gdef\csname @#1L#2\endcsname{#5}
    	\expandafter\gdef\csname @#1S#2\endcsname{\showline}
    }
    % Box and background picture
    \newcommand\MakeBackground{%
    	% Line thickness
    	\setlength{\@pdgLinethickness}{1pt}
    	%dimention
    	\setlength{\@pdgMargeSize}{15mm}%
    	\setlength{\@pdgInnerBoxWidth}{\paperwidth-2\@pdgMargeSize-2\@pdgLinethickness}%
    	\setlength{\@pdgInnerBoxHeight}{\paperheight-2\@pdgMargeSize-2\@pdgLinethickness}%
        % University logo
    	\put(\convertto{pt}{1.5\@pdgMargeSize},\convertto{pt}{\paperheight-6.1\@pdgMargeSize}){%
            \parbox[t][\paperheight]{\paperwidth}{%
                \includegraphics[width=5cm]{sources/logos/logo-univ}%
            }
        }
    	% Background picture
        \put(\convertto{pt}{\paperwidth-6.92\@pdgMargeSize}, \convertto{pt}{0.42\@pdgMargeSize}){%
    		\parbox[b][\paperheight]{\paperwidth}{%
    			\includegraphics[width=10.8cm]{sources/logos/filigrammecut}%
    		}%
    	}%
    	% Colored frame box
    	\put(\LenToUnit{\@pdgMargeSize},\LenToUnit{\@pdgMargeSize}){%
    		\color{pdgred}
    		\framebox(\LenToUnit{\@pdgInnerBoxWidth},\LenToUnit{\@pdgInnerBoxHeight}){}
    	}%
    }
    
    % ============================================================
    % COLOR
    \definecolor{pdgred}{rgb}{0.676,0.224,0.288}
    
    % ============================================================
    \newif\if@showCotutelle\@showCotutellefalse 
    % SIMPLE STRING
    \def\defencedate#1{\gdef\@defencedate{#1}}
    \def\lab#1{\gdef\@lab{#1}}
    \def\cotutelle#1{\gdef\@cotutelle{\textit{#1}}}
    % Boss
    \def\nboss#1{\gdef\@nboss{#1}}
    % Referee
    \def\nreferee#1{\gdef\@nreferee{#1}}
    % Judge
    \def\njudge#1{\gdef\@njudge{#1}}
    
    % ============================================================
    
    
    % ============================================================
    %-----------------------------------------------------
    %                    Cover page
    %-----------------------------------------------------
        \renewcommand{\maketitle}{%
            \ifx\@defencedate\undefined
                \defencedate{Date de soutenance}
            \fi
            \ifx\@lab\undefined
                \lab{Nom de l'Unit\'e de recherche}
            \fi
            \ifx\@cotutelle\undefined\else
                \@showCotutelletrue
            \fi
            \ifx\@nboss\undefined
                \nboss{1}
                \makesomeone{boss}{1}{Nom(s) du/des directeur(s) de th\`ese}{}{}
            \fi
            \ifx\@nreferee\undefined
                \nreferee{1}
                \makesomeone{referee}{1}{Noms des rapporteurs (s'ils ne font pas partie des membres du jury)}{}{}
            \fi
            \ifx\@njudge\undefined
                \njudge{5}
                \makesomeone{judge}{1}{Nom}{Professeur}{Pr\'esident}
                \makesomeone{judge}{2}{Nom}{Directeur de recherche}{Membre}
                \makesomeone{judge}{3}{Nom}{Directeur de recherche}{Membre}
                \makesomeone{judge}{4}{Nom}{Directeur de recherche}{Membre}
                \makesomeone{judge}{5}{~}{\dots\textit{(Pr\'eciser la qualit\'e de chacun des menbres)}}{~}
            \fi
            %% Test if \@variable exist %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % White page
            \if@emptysheetbefore
                \blanksheet[nonum]
            \fi
            % Flyleaf
            \thispagestyle{empty}
            \newgeometry{centering, vmargin=3cm, hmargin=3cm}
            % \addtolength{\textheight}{-2cm} % Hauteur de la page texte
            \AddToShipoutPictureBG*{\MakeBackground} %% Add Colored frame box and picture background
            \begin{center}
                \setstretch{1.05}
                %\vfill
                    \begin{minipage}[t][\textheight-.8\baselineskip-6pt]{\textwidth-1pt}
                        \begin{center}
                            \vspace*{1.2cm}
                            %%%%% THESE %%%%%
                            \shadowoffset{2pt}
                            \shadowrgb{0.4, 0.2, 0.2}
                            \shadowtext{\textcolor{pdgred}{\fontfamily{pbk}\fontsize{1.5cm}{1.8cm}\selectfont{TH\`ESE}}}
                            %%%%%%%%%%%%%%%%%
                            
                            \vspace*{2cm}
                            %%%%% DOC %%%%%
                            
                            {\bfseries En vue de l'obtention du}
                            
                            
    
                            \bigskip
                            
                            {\Large \bfseries DOCTORAT DE L'UNIVERSIT\'E DE TOULOUSE}
                            
                            
                        
                            %%%%% ETS & COTUTELLE %%%%%
                            \bigskip
                            
                            \mbox{\bfseries D\'elivr\'e par :} \mbox{\textit{\@establishment}} \if@showCotutelle\mbox{Cotutelle internationale \@cotutelle}\fi
                           
                            
                            %%%%%%%%%%%%%%%				
                        
                            \vfill
                        
                            \rule{\textwidth}{2.5pt}
    					        
                            \vspace{-2ex}
                            \rule{\textwidth}{1.2pt}
                            
                            {\bfseries \fontfamily{cmr} Pr\'esent\'ee et soutenue le} \textit{\@defencedate} {\bfseries \fontfamily{cmr} par :}\\
                                
                           
                            \settowidth{\RuleWidth}{\large\fontfamily{cmr}\textbf{{\@author}}}
                            
                            \smallskip
                            {\large\fontfamily{cmr}\textbf{{\@author}}}
                            
                            \vspace*{-5pt}
                            ~{\color{pdgred}\rule{1.2\RuleWidth}{0.8pt}}
                            \vspace*{3pt}
    
                            {\large\bfseries\@title}
                            
                            \rule{\textwidth}{1.2pt}
                            
                            \vspace{-1.6ex}
                            \rule{\textwidth}{2.5pt}
    					
                            \vfill
                            %%%% JURY %%%%
                            
                            {\bfseries JURY}
                            
                            
                            \ifnum \@njudge=0
                              \\Membres du jury
                            \else
                              \foreach \n in {1,...,\@njudge}{%
                                  \edef\mytemp{{\csname @judgeS\n\endcsname}{\showline}}%
                                  \expandafter\ifstrequal\mytemp{%TRUE
                                      \textline[t]{\csname @judgeN\n\endcsname}{\csname @judgeP\n\endcsname}{\csname @judgeL\n\endcsname}%
                                  }{}%
                              }
                            \fi
                            %%%% JURY %%%%
                            
                            \vfill
                            \rule{\textwidth}{1.2pt}
                            
                             {\raggedright\bfseries \'Ecole doctorale et sp\'ecialit\'e :\\} \hfill\parbox[t]{0.92\textwidth}{\textit{\@docschool}}
                        
    
                            \ifx\@doubleSpe\undefined\else{\raggedright\bfseries Double mention :\\} \hfill\parbox[t]{0.92\textwidth}{\textit{\@doubleSpe}}\fi
                        
                            
                             {\raggedright\bfseries Unit\'e de Recherche :\\} \hfill\parbox[t]{0.92\textwidth}{\textit{\@lab}}
                            
                            \ifnumgreater{\@nboss}{1}{%TRUE
                                
                                {\raggedright\bfseries Directeurs de Th\`ese :\\}
                               
                            }{%FALSE
                              
                                {\raggedright\bfseries Directeur de Th\`ese :\\}
                               
                            }
                            \hfill\parbox[t]{0.92\textwidth}{
                                \foreach \n in {1,...,\@nboss}{%
                                    \edef\mytemp{{\csname @bossS\n\endcsname}{\showline}}%
                                    \ifnumgreater{\n}{1}{%TRUE
                                        \ifnumgreater{\n}{\@nboss-1}{%TRUE
                                            \expandafter\ifstrequal\mytemp{%TRUE
                                                \ et \textit{\csname @bossN\n\endcsname}\ignorespaces
                                            }{}%
                                        }{% false
                                            \expandafter\ifstrequal\mytemp{%TRUE
                                                , \textit{\csname @bossN\n\endcsname}\ignorespaces
                                            }{}%
                                        }
                                    }{% False
                                        \expandafter\ifstrequal\mytemp{%TRUE
                                            \textit{\csname @bossN\n\endcsname}\ignorespaces
                                        }{}%
                                    }
                                }
                            }
                        
                            \ifnumgreater{\@nreferee}{1}{%TRUE
    
                             {\raggedright\bfseries Rapporteurs :\\}
                               
                                
                            }{%FALSE
                                
                                 {\raggedright\bfseries Rapporteur :\\}
                            
                            }
                            \hfill\parbox[t]{0.92\textwidth}{
                                \foreach \n in {1,...,\@nreferee}{%
                                    \edef\mytemp{{\csname @refereeS\n\endcsname}{\showline}}%
                                    \ifnumgreater{\n}{1}{%TRUE
                                        \ifnumgreater{\n}{\@nreferee-1}{%TRUE
                                            \expandafter\ifstrequal\mytemp{%
                                                \ et \textit{\csname @refereeN\n\endcsname}\ignorespaces
                                            }{}%
                                        }{%FALSE
                                            \expandafter\ifstrequal\mytemp{%
                                                , \textit{\csname @refereeN\n\endcsname}\ignorespaces
                                            }{}%
                                        }
                                    }{%FALSE
                                        \expandafter\ifstrequal\mytemp{%TRUE
                                            \textit{\csname @refereeN\n\endcsname}\ignorespaces
                                        }{}%
                                    }
                                }
                            }
                            \vfill
                                            
                        \end{center}
                    \end{minipage}
                \vfill
            \end{center}
    
    \newpage
    \null
    \thispagestyle{fancy}
    \setlength{\footskip}{2cm} 
    
        }   
}
{ % Else 
    % Do nothing
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               (3) REPORT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\NOT\isundefined{\report}}
{ % If report option 
    \setlength{\textheight}{23.5cm} 
    \setlength{\footskip}{0.7cm} 
    % Report definitions
    \def\department#1{\gdef\@department{#1}}
    \def\lastupdate#1{\gdef\@lastupdate{#1}}
    \def\version#1{\gdef\@version{#1}}
    \def\reference#1{\gdef\@reference{#1}}
    %-----------------------------------------------------
    %                   French report
    %-----------------------------------------------------
    \ifthenelse{\NOT \isundefined{\fr} }
    {% If: french option [fr]
        % Boss
        \def\writer#1{\gdef\@writer{#1}}
        % Referee
        \def\controller#1{\gdef\@controller{#1}}
        % Judge
        \def\superior#1{\gdef\@superior{#1}}
        % propagation
        \def\propagation#1{\gdef\@propagation{#1}}
        % update
        \def\update#1{\gdef\@update{#1}}

        \newcommand{\myApprobationTable}[3]{%
            \def\superiortabledata{}% reset \superiortabledata
            \def\controllertabledata{}
            \def\writertabledata{}
        
            
            
            \newcounter{writercounter}
            \setcounter{writercounter}{0}
            
            \newcounter{superiorcounter}
            \setcounter{superiorcounter}{0}
            
            \newcounter{controllercounter}
            \setcounter{controllercounter}{0}
            
            
            \newcounter{writernumber}
            \setcounter{writernumber}{0}
            \foreach \n in #1 {\addtocounter{writernumber}{1}}
            
            \newcounter{controllernumber}
            \setcounter{controllernumber}{0}
            \foreach \n in #2 {\addtocounter{controllernumber}{1}}
        
            
            \newcounter{superiornumber}
            \setcounter{superiornumber}{0}
            \foreach \n in #3 {\addtocounter{superiornumber}{1}}
          
            
            \foreach \job/\entity/\name/\validationdate in #1 {% build table data from #1 
                \ifthenelse{ \thewritercounter = 0}{\protected@xappto\writertabledata{ \multirow{2}{*}{\textbf{Rédacteur }} & \job & \text{\entity} & \name & \validationdate \\}}{\protected@xappto\writertabledata{ & \job & \text{\entity} & \name & \validationdate \\}}
                \addtocounter{writercounter}{1}
            
            }
            
            
            
            \foreach \job/\entity/\name/\validationdate in #2 {% build table data from #1 
                \ifthenelse{ \thecontrollercounter = 0}{\protected@xappto\controllertabledata{ \multirow{2}{*}{\textbf{Vérification}} & \job & \text{\entity} & \name & \validationdate \\ }}{\protected@xappto\controllertabledata{ & \job & \text{\entity} & \name & \validationdate \\}}
                \addtocounter{controllercounter}{1}
                }
                
            \foreach \job/\entity/\name/\validationdate in #3 {% build table data from #1 
                \ifthenelse{ \thesuperiorcounter = 0}{\protected@xappto\superiortabledata{ \multirow{2}{*}{\textbf{Approbation }} & \job & \text{\entity} & \name & \validationdate \\}}{\protected@xappto\superiortabledata{ & \job & \text{\entity} & \name & \validationdate \\}}
                \addtocounter{superiorcounter}{1}
            %\multirow{\thesuperiornumber}{*}{\textbf{Approbation }}
            }
            \begin{tabular}{|>{\centering\arraybackslash}p{2.5cm}|>{\centering\arraybackslash}p{3cm}|>{\centering\arraybackslash}p{3cm}|>{\centering\arraybackslash}p{2.5cm}|>{\centering\arraybackslash}p{2cm}|}
            \hline
                \multicolumn{5}{|l|}{\textbf{Approbation}}  \\ \hline
                & \textbf{Fonction} & \textbf{Entité} & \textbf{Nom et visa} & \textbf{Date} \\ \hline
                \writertabledata \hline   
                \controllertabledata \hline
                \superiortabledata \hline
            \end{tabular}
        }
        
        
        \newcommand{\myPropagationTable}[1]{%
            \def\propagationtabledata{}% reset \superiortabledata
            
          
            \newcounter{propagationcounter}
            \setcounter{propagationcounter}{0}
         
            \newcounter{propagationnumber}
            \setcounter{propagationnumber}{0}
            \foreach \n in #1 {\addtocounter{propagationnumber}{1}}
          
            \foreach \name/\entity/\observation in #1 {
                \protected@xappto\propagationtabledata{ \name & \entity & \observation \\}
                % \protected@xappto\writertabledata{ & \job & \text{\entity} & \name & \validationdate \\}
            }
            
            
            \begin{tabular}{|>{\centering\arraybackslash}p{8cm}|>{\centering\arraybackslash}p{3cm}|>{\centering\arraybackslash}p{3cm}|}
            \hline
            \textbf{Nom- Fonction} & \textbf{Entité} & \textbf{Observation} \\ \hline
            \propagationtabledata \hline   
            \end{tabular}
        }
        
        
        \newcommand{\myUpdateTable}[1]{%
            \def\updatetabledata{}% reset \superiortabledata
            
          
            \newcounter{updatecounter}
            \setcounter{updatecounter}{0}
         
            \newcounter{updatennumber}
            \setcounter{updatennumber}{0}
            \foreach \n in #1 {\addtocounter{updatennumber}{1}}
          
            \foreach \date/\update/\page in #1 {
                \protected@xappto\updatetabledata{ \date & \update & \page \\}
            }
            
            
            \begin{tabular}{|>{\centering\arraybackslash}p{4cm}|>{\centering\arraybackslash}p{7cm}|>{\centering\arraybackslash}p{3cm}|}
            \hline
                \textbf{Date - Version} & \textbf{Natures des modifications} & \textbf{§ ou Pages concernées} \\ \hline
                \updatetabledata \hline   
            \end{tabular}
        }
        
        
        \renewcommand{\maketitle}
        { % Cover page definition
            \thispagestyle{empty}
            \enlargethispage{2cm}
            \addtolength{\voffset}{-2cm}
            % Logos
            \begin{minipage}{0.35\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_enac_and_marianne} 
            \end{minipage}
            \hfill
            \begin{minipage}{0.3\linewidth}
                Référence : \@reference \\
                Version : \@version \\
                Date : \@lastupdate \\
            \end{minipage}
            \rule{\textwidth}{0.8pt}
            \@department
            \vfill
            %\vspace{10pt}
            \begin{center} 
                \begin{minipage}{0.75\linewidth}
                    \begin{center}
                        %\rule{\textwidth}{0.8pt} \\
                        \begin{spacing}{2.0}
                            {\Huge \bf \@title} 
                        \end{spacing}
                        %\rule{\textwidth}{0.8pt} \\[50pt]
                    \end{center}
                \end{minipage}
                \large \\[50pt]
            \end{center}
               
            \vfill
            %\text{\writername} \\
            
            \begin{table}[H]
                \centering
                \myApprobationTable{\@writer}{\@controller}{\@superior}
                %\myTable{\@writer}
            \end{table}
            \vspace{100pt}
            
            { \centering  
                \footnotesize \textbf{Ecole Nationale de l’Aviation Civile}\\
                7 Avenue Edouard Belin,\\
                31055 TOULOUSE Cedex 04\\
                Tél : 33(0)5 62 12 43 21\\
                \url{www.enac.fr} \\
            } % End of footer definition
        
            % White page after cover page
            \newpage
            \thispagestyle{fancy}
            \addtolength{\voffset}{2cm} % Restore offset
            \underline{\textbf{Diffusion :}}
            \begin{table}[H]
                \centering
                \myPropagationTable{\@propagation}
            \end{table}
            
            \underline{\textbf{Suivi des modifications :}}
            \begin{table}[H]
                \centering
                 \myUpdateTable{\@update}
            \end{table}

         \fancyfoot[LO] % Left footer on odd pages
            {   
                \footnotesize
                2021 @ ENAC\\
                Nom du fichier : \jobname
            } % End of footer definition

            \newpage
        } % End of cover page definition
    }
    %-----------------------------------------------------
    %                   English report
    %-----------------------------------------------------
    {% Else: 
        % Boss
        \def\writer#1{\gdef\@writer{#1}}
        % Referee
        \def\controller#1{\gdef\@controller{#1}}
        % Judge
        \def\superior#1{\gdef\@superior{#1}}

        % propagation
        \def\propagation#1{\gdef\@propagation{#1}}
        % update
        \def\update#1{\gdef\@update{#1}}

        \newcommand{\myApprobationTable}[3]{%
            \def\superiortabledata{}% reset \superiortabledata
            \def\controllertabledata{}
            \def\writertabledata{}

            \newcounter{writercounter}
            \setcounter{writercounter}{0}
            
            \newcounter{superiorcounter}
            \setcounter{superiorcounter}{0}
            
            \newcounter{controllercounter}
            \setcounter{controllercounter}{0}
            
            \newcounter{writernumber}
            \setcounter{writernumber}{0}
            \foreach \n in #1 {\addtocounter{writernumber}{1}}
            
            \newcounter{controllernumber}
            \setcounter{controllernumber}{0}
            \foreach \n in #2 {\addtocounter{controllernumber}{1}}
        
            
            \newcounter{superiornumber}
            \setcounter{superiornumber}{0}
            \foreach \n in #3 {\addtocounter{superiornumber}{1}}
          
            
            \foreach \job/\entity/\name/\validationdate in #1 {% build table data from #1 
                \ifthenelse{ \thewritercounter = 0}{\protected@xappto\writertabledata{ \multirow{2}{*}{\textbf{Writer }} & \job & \text{\entity} & \name & \validationdate \\}}{\protected@xappto\writertabledata{ & \job & \text{\entity} & \name & \validationdate \\}}
                \addtocounter{writercounter}{1}
            
            }
            
            
            
            \foreach \job/\entity/\name/\validationdate in #2 {% build table data from #1 
                \ifthenelse{ \thecontrollercounter = 0}{\protected@xappto\controllertabledata{ \multirow{2}{*}{\textbf{Controller }} & \job & \text{\entity} & \name & \validationdate \\ }}{\protected@xappto\controllertabledata{ & \job & \text{\entity} & \name & \validationdate \\}}
                \addtocounter{controllercounter}{1}
                }
                
            \foreach \job/\entity/\name/\validationdate in #3 {% build table data from #1 
                \ifthenelse{ \thesuperiorcounter = 0}{\protected@xappto\superiortabledata{ \multirow{2}{*}{\textbf{Approval }} & \job & \text{\entity} & \name & \validationdate \\}}{\protected@xappto\superiortabledata{ & \job & \text{\entity} & \name & \validationdate \\}}
                \addtocounter{superiorcounter}{1}
            
            }
            \begin{tabular}{|>{\centering\arraybackslash}p{2.5cm}|>{\centering\arraybackslash}p{3.5cm}|>{\centering\arraybackslash}p{3cm}|>{\centering\arraybackslash}p{3cm}|>{\centering\arraybackslash}p{2cm}|}
            \hline
                \multicolumn{5}{|l|}{\textbf{Approval}}  \\ \hline
                & \textbf{Job} & \textbf{Entity} & \textbf{Name and visa} & \textbf{Date} \\ \hline
                
                \writertabledata \hline   
                \controllertabledata \hline
                \superiortabledata \hline
            \end{tabular}
        }
        
        
        \newcommand{\myPropagationTable}[1]{%
            \def\propagationtabledata{}% reset \superiortabledata
            
          
            \newcounter{propagationcounter}
            \setcounter{propagationcounter}{0}
         
            \newcounter{propagationnumber}
            \setcounter{propagationnumber}{0}
            \foreach \n in #1 {\addtocounter{propagationnumber}{1}}
          
            \foreach \name/\entity/\observation in #1 {
                \protected@xappto\propagationtabledata{ \name & \entity & \observation \\}
                % \protected@xappto\writertabledata{ & \job & \text{\entity} & \name & \validationdate \\}
            }
            
            
            \begin{tabular}{|>{\centering\arraybackslash}p{8cm}|>{\centering\arraybackslash}p{3cm}|>{\centering\arraybackslash}p{3cm}|}
            \hline
            \textbf{Name - Job} & \textbf{Entity} & \textbf{Comment} \\ \hline
            \propagationtabledata \hline   
            \end{tabular}
        }
        
        
        \newcommand{\myUpdateTable}[1]{%
            \def\updatetabledata{}% reset \superiortabledata
            
          
            \newcounter{updatecounter}
            \setcounter{updatecounter}{0}
         
            \newcounter{updatennumber}
            \setcounter{updatennumber}{0}
            \foreach \n in #1 {\addtocounter{updatennumber}{1}}
          
            \foreach \date/\update/\page in #1 {
                \protected@xappto\updatetabledata{ \date & \update & \page \\}
            }
            
            
            \begin{tabular}{|>{\centering\arraybackslash}p{4cm}|>{\centering\arraybackslash}p{7cm}|>{\centering\arraybackslash}p{3cm}|}
            \hline
                \textbf{Date - Version} & \textbf{Modifications} & \textbf{§ or Pages concerned} \\ \hline
                \updatetabledata \hline   
            \end{tabular}
        }
        
        
        \renewcommand{\maketitle}
        { % Cover page definition
            \thispagestyle{empty}
            \enlargethispage{2cm}
            \addtolength{\voffset}{-2cm}
            % Logos
            \begin{minipage}{0.35\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_enac_and_marianne} 
            \end{minipage}
            \hfill
            \begin{minipage}{0.3\linewidth}
                Reference: \@reference \\
                Version: \@version \\
                Date: \@lastupdate \\
            \end{minipage}
            \rule{\textwidth}{0.8pt}
            \@department
            \vfill
            %\vspace{10pt}
            \begin{center} 
                \begin{minipage}{0.75\linewidth}
                    \begin{center}
                        %\rule{\textwidth}{0.8pt} \\
                        \begin{spacing}{2.0}
                            {\Huge \bf \@title} 
                        \end{spacing}
                        %\rule{\textwidth}{0.8pt} \\[50pt]
                    \end{center}
                \end{minipage}
                \large \\[50pt]
            \end{center}
               
            \vfill
            %\text{\writername} \\
            
            \begin{table}[H]
                \centering
                \myApprobationTable{\@writer}{\@controller}{\@superior}
                %\myTable{\@writer}
            \end{table}
        
           \vspace{100pt}
           
            {  \centering 
                \footnotesize \textbf{Ecole Nationale de l’Aviation Civile}\\
                7 Avenue Edouard Belin,\\
                31055 TOULOUSE Cedex 04\\
                Tél : 33(0)5 62 12 43 21\\
                \url{www.enac.fr} \\
            } % End of footer definition


        
        % White page after cover page
            \newpage
            \thispagestyle{fancy}
            \addtolength{\voffset}{2cm} % Restore offset
            \underline{\textbf{Propagation:}}
            \begin{table}[H]
                \centering
                \myPropagationTable{\@propagation}
            \end{table}
            
            \underline{\textbf{Track changes:}}
            \begin{table}[H]
                \centering
                 \myUpdateTable{\@update}
            \end{table}

         \fancyfoot[LO] % Left footer on odd pages
            {   
                \footnotesize
                2021 @ ENAC\\
                File Name: \jobname
            } % End of footer definition
 % 
            \newpage
        } % End of cover page definition
    }
}
{ % Else 
    % Do nothing
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               (4) LECTURE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\NOT\isundefined{\lecture}}
{ % If lecture: [lecture]
    \def\typedoc#1{\gdef\@typedoc{#1}}
    \def\promotion#1{\gdef\@promotion{#1}}
    %-----------------------------------------------------
    %                   French lecture
    %-----------------------------------------------------
    \ifthenelse{\NOT \isundefined{\fr} }
    {% If: french option [fr]
        % Definitions
        \def\typedoc#1{\gdef\@typedoc{#1}}
        \def\promotion#1{\gdef\@promotion{#1}}

        \renewcommand{\maketitle}
        { % Cover page definition
            \pagestyle{empty}
            % Extend Footer
            \enlargethispage{4cm}
            \addtolength{\voffset}{-2cm}
            % Logos
            \begin{minipage}{0.35\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_enac_and_marianne} 
            \end{minipage}
            \hfill
            \begin{minipage}{0.16\linewidth}
%                 \includegraphics[height=25mm]{sources/logos/logo_enac_right_corner} 
            \end{minipage}
            \rule{\textwidth}{0.8pt}
            \vspace{10pt}
            \begin{center} 
                % Document type
                \vspace{50pt}
                \large 
                \@typedoc \\[20pt]
        
                % Document title
                \begin{minipage}{0.75\linewidth}
                    \begin{center}
                        \rule{\textwidth}{0.8pt} \\
                        \begin{spacing}{2.0}
                            {\huge \bf \@title} 
                        \end{spacing}
                        \rule{\textwidth}{0.8pt} \\[50pt]
                    \end{center}
                \end{minipage}
                ~\\[50pt]
                % Date, authors and tutors
                \large 
                \@promotion \\[20pt]
                Version du : \today \\[50pt]
                
                
                \large 
                Ecrit par \\[20pt]
                {\bf \@author} \\[20pt]
            \end{center}
            % White page after cover page
            \newpage
            \null
            \thispagestyle{empty}
            \addtolength{\voffset}{2cm}
            \newpage
        } % End of cover definition
    }
    %-----------------------------------------------------
    %                   English lecture
    %-----------------------------------------------------
    {% Else: 
        % Cover page
        \renewcommand{\maketitle}
        { % Cover page definition
            \pagestyle{empty}
            % Extend Footer
            \enlargethispage{4cm}
            \addtolength{\voffset}{-2cm}
            % Logos
            \begin{minipage}{0.35\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_enac_and_marianne} 
            \end{minipage}
            \hfill
            \begin{minipage}{0.16\linewidth}
%                 \includegraphics[height=25mm]{sources/logos/logo_enac_right_corner} 
            \end{minipage}
            \rule{\textwidth}{0.8pt}
            \vspace{10pt}
            \begin{center} 
                % Document type
                \vspace{50pt}
                \large 
                \@typedoc \\[20pt]
        
                % Document title
                \begin{minipage}{0.75\linewidth}
                    \begin{center}
                        \rule{\textwidth}{0.8pt} \\
                        \begin{spacing}{2.0}
                            {\huge \bf \@title} 
                        \end{spacing}
                        \rule{\textwidth}{0.8pt} \\[50pt]
                    \end{center}
                \end{minipage}
                ~\\[50pt]
                % Date, authors and tutors
                \large 
                \@promotion \\[20pt]
                Version: \today \\[50pt]
                
                
                \large 
                Written by \\[20pt]
                {\bf \@author} \\[20pt]
            \end{center}
            % White page after cover page
            \newpage
            \null
            \thispagestyle{empty}
            \addtolength{\voffset}{2cm}
            \newpage
        } % End of cover definition
    }

}
{ % Else 
    % Do nothing
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               (5) LETTER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\NOT\isundefined{\letter}}
{ % If letter option: [letter]
    \setlength{\textheight}{26cm} 
    \setlength{\footskip}{0.7cm} 
    % Letter definitions
    \def\city#1{\gdef\@city{#1}}
    \def\docref#1{\gdef\@docref{#1}}
    \def\docvref#1{\gdef\@docvref{#1}}
    \def\addressee#1{\gdef\@addressee{#1}}
    \def\address#1{\gdef\@address{#1}}
    \def\name#1{\gdef\@name{#1}}
    \def\date#1{\gdef\@date{#1}}
    \def\object#1{\gdef\@object{#1}}
    \def\contactmail#1{\gdef\@contactmail{#1}}
    \def\contactname#1{\gdef\@contactname{#1}}
    \def\contactnum#1{\gdef\@contactnum{#1}}
    \def\sender#1{\gdef\@sender{#1}}
    \def\senderadress#1{\gdef\@senderadress{#1}}
    \def\follower#1{\gdef\@follower{#1}}
    \def\signature#1{\gdef\@signature{#1}}
    %-----------------------------------------------------
    %                   French letter
    %-----------------------------------------------------
    \ifthenelse{\NOT \isundefined{\fr} }
    {% If: french option [fr]
        \renewcommand{\maketitle}
        { % Cover page definition
            \pagestyle{fancy}
            % Extend Footer
            \enlargethispage{0cm}
            \addtolength{\voffset}{-2cm}
            % Logos
            \begin{minipage}{0.20\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_marianne} 
            \end{minipage}
            \hfill
            \begin{minipage}{0.20\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_enac_right_corner} 
            \end{minipage}
            % \rule{\textwidth}{0.8pt}
            \vspace{30pt}
            
            % Sender
            \begin{minipage}{0.49\linewidth}
%             \begin{flushleft}
                \vspace{5pt}
                \textbf{Service émetteur}\\
                \@sender\\
                \@senderadress
%             \end{flushleft}
            \end{minipage}
\hfill
            % Addresse
            \begin{minipage}{0.49\linewidth}
%             \begin{flushright}
                \vspace{5pt}
                \textbf{Destinataire}\\
                \@addressee \\
                \@address
%             \end{flushright}
            \end{minipage}

            \vspace{20pt}
            % Follower
            \begin{flushleft}
            \small
             N. Réf : \@docref \\
             V. Réf : \@docvref\\[10pt]
            \vspace{5pt}
            \emph{Affaire suivie par :}\\
                \vspace{5pt}
                \@contactname \\
                mail: \href{mailto:\@contactmail}{\@contactmail} \\
                Tel: \@contactnum \\
            \end{flushleft}
            
            \vspace{20pt}
            
            % Letter information
            \textbf{Objet :} \textbf{\@object}
  
            \vspace{20pt}

            \hfill
            \begin{minipage}{.49\linewidth}
            \@city, \@date 
            \end{minipage}
            \vspace{10pt}
        } % End over page definition
            
        %-----------------------------------------------------
        % Letter closing definition
        %-----------------------------------------------------
        
        \newcommand{\closing}[1]
        { % Closing definition
            \vspace{10pt}
            \begin{minipage}{0.05\linewidth}
            
            \end{minipage}
            \hfill
            \begin{minipage}{0.53\linewidth}
                #1 \\ % Salutations
                \textbf{\@sender} % Sender name
                \ifx\@signature\undefined 
                    % Do nothing
                \else 
                    \begin{figure}[H] % Signature
                        \centering
                        \includegraphics[width=\linewidth]{\@signature}
                    \end{figure}
                \fi
    
            \end{minipage}
        } % End of closing definition

    }
    %-----------------------------------------------------
    %                   English letter
    %-----------------------------------------------------
    {% Else: 
        \renewcommand{\maketitle}
        { % Cover page definition
            \pagestyle{fancy}
            % Extend Footer
            \enlargethispage{0cm}
            \addtolength{\voffset}{-2cm}
            % Logos
            \begin{minipage}{0.20\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_marianne} 
            \end{minipage}
            \hfill
            \begin{minipage}{0.20\linewidth}
                \includegraphics[height=25mm]{sources/logos/logo_enac_right_corner} 
            \end{minipage}

            
            \vspace{30pt}
            
            % Sender
            \begin{minipage}{0.49\linewidth}
%             \begin{flushright}
                \vspace{5pt}
                \textbf{To}\\
                \@addressee \\
                \@address
%             \end{flushright}
            \end{minipage}
            \hfill
            % Addresse
            \begin{minipage}{0.49\linewidth}
%             \begin{flushleft}
                \vspace{5pt}
                \textbf{From}\\
                \@sender\\
                \@senderadress
%             \end{flushleft}
            \end{minipage}

            
            \vspace{20pt}
            % Follower
            \begin{flushleft}
            \small
             Our Ref: \@docref \\
             Your Ref: \@docvref\\[10pt]
            \vspace{5pt}
            \emph{Followed by:}\\
                \vspace{5pt}
                \@contactname \\
                mail: \href{mailto:\@contactmail}{\@contactmail} \\
                Tel: \@contactnum \\
            \end{flushleft}
            
            \vspace{20pt}
            
            % Letter information
            \textbf{Object:} \textbf{\@object}
  
            \vspace{20pt}

            \hfill
            \begin{minipage}{.49\linewidth}
            \@city, \@date 
            \end{minipage}
            \vspace{10pt}
        } % End cover page definition
            
           
        %-----------------------------------------------------
        % Letter closing definition
        %-----------------------------------------------------
        
        \newcommand{\closing}[1]
        {   
            \vspace{10pt}
            \begin{minipage}{0.65\linewidth}
            
            \end{minipage}
            \hfill
            \begin{minipage}{0.33\linewidth}
                #1  \\  % Salutations
                \textbf{\@sender} % Sender name
                \ifx\@signature\undefined 
                    % Do nothing
                \else 
                    \begin{figure}[H] % Signature
                        \centering
                        \includegraphics[width=\linewidth]{\@signature}
                    \end{figure}
                \fi
            \end{minipage}
        }

    }
}
{ % Else 
    % Do nothing
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             header and footer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\NOT\isundefined{\letter} \OR \NOT\isundefined{\report} \OR \NOT\isundefined{\lecture}}
{ % If letter or report or lecture option: [letter,lecture,report]
    %-----------------------------------------------------
    %                    (5) LETTER
    %-----------------------------------------------------
    \ifthenelse{\NOT\isundefined{\letter}}
    {
        \pagestyle{fancy}
        \fancyhf{}
        \renewcommand{\headrulewidth}{0pt} % Header line width (no line here)
        \fancyfoot[CO] % Left footer on odd pages
        {   
            \tiny \textbf{Ecole Nationale de l’Aviation Civile}\\
            7 Avenue Edouard Belin,\\
            31055 TOULOUSE Cedex 04\\
            Tél : 33(0)5 62 17 40 00 - \url{www.enac.fr} \\
            \'Etablissement Public - Direction Générale de l'Aviation Civile
        } % End of feft footer definition
    }
    {
    %-----------------------------------------------------
    %                    (3) REPORT
    %-----------------------------------------------------
        \ifthenelse{\NOT\isundefined{\report}}
        {
            \pagestyle{fancy}
             \fancyhf{}
            
            \fancyhead[CO] % Centered header on odd pages
            { % Centered header on odd pages
            \begin{minipage}{0.3\linewidth}
                \includegraphics[height=16mm]{sources/logos/logo_enac_and_marianne} 
                \end{minipage}
                \begin{minipage}{0.45\linewidth}
                    \begin{center}
                        \nouppercase{\@title}
                    \end{center}
                \end{minipage}  
                \begin{minipage}{0.2\linewidth}
                    \begin{flushright}
                \small
                Ref: \@reference \\
                Version \@version\\
                \@lastupdate
                    \end{flushright}
                \end{minipage}
            } % End of centered header definition
            
            \renewcommand{\headrulewidth}{1pt} % Header line width
            \renewcommand{\footrulewidth}{1pt} % Footer line width
            
            
            \fancyfoot[CO]{\vfill \small \thepage/\pageref{LastPage}} % Centered footer on odd pages
            

        }
        {
        %-----------------------------------------------------
        %                    (4) LECTURE
        %-----------------------------------------------------
        \ifthenelse{\NOT\isundefined{\lecture}}
        {
            \pagestyle{fancy}
            
            \renewcommand{\headrulewidth}{0.4pt} % Header line width (Default \headrulewidth is 0.4pt)
            \renewcommand{\footrulewidth}{0.4pt} % Footer line width (Default \footrulewidth is 0pt)
            
            \fancyhf{}
            
            \fancyhead[RO,LE]{\nouppercase{\rightmark}}
            \fancyhead[RE,LO]{\includegraphics[height=20mm]{sources/logos/logo_enac_and_marianne}}
           
            \fancyfoot[CE,CO]
            {\scriptsize
                \begin{minipage}{0.05\linewidth}
                \hfill
                \end{minipage}
                \begin{minipage}{0.85\linewidth}
                    \begin{center}{
                        \ifthenelse{\NOT \isundefined{\fr}} 
                        { % If not french option []
                          Ce document ne peut être reproduit, modifié, adapté, publié, traduit d'une quelconque façon, en tout ou partie, ni divulgué à un tiers sans l'accord préalable et écrit de l'ENAC. © 2021, ENAC }
                        { % Else french option [fr]
                          This document may not be reproduced, modified, adapted, published, translated in any way, in whole \\or in part, nor disclosed to a third party without the prior written consent of ENAC. © 2021, ENAC }
                        }
                    \end{center}
                \end{minipage}  
                \begin{minipage}{0.05\linewidth}
                    \hfill 
                \end{minipage}
            }
            \fancyfoot[LE,RO]{\thepage}
%             \lfoot[\vspace{0.3cm}\thepage]{}
        }
    } }
    
}
%-----------------------------------------------------
%            (1,2) PROJECT and THESIS
%-----------------------------------------------------
{ % Else
    \pagestyle{fancy}
    
    \renewcommand{\headrulewidth}{0.4pt} % Header line width (Default \headrulewidth is 0.4pt)
    \renewcommand{\footrulewidth}{0.4pt} % Footer line width (Default \footrulewidth is 0pt)
    
    \fancyhf{}
    
    \fancyhead[RO,LE]{\nouppercase{\rightmark}}
    \fancyhead[RE,LO]{\includegraphics[height=20mm]{sources/logos/logo_enac_and_marianne}}

        \cfoot[]
    {   \ifx\@partnerlogo\undefined
    \scriptsize
            \begin{minipage}{0.05\linewidth}
                \hfill
            \end{minipage}
            \begin{minipage}{0.85\linewidth}
                \begin{center}{
                    \ifthenelse{\NOT \isundefined{\fr}} 
                    { % If not french option []
                      Ce document ne peut être reproduit, modifié, adapté, publié, traduit d'une quelconque façon, en tout ou partie, ni divulgué à un tiers sans l'accord préalable et écrit de l'ENAC. © 2021, ENAC}
                    { % Else french option [fr]
                      This document may not be reproduced, modified, adapted, published, translated in any way, in whole or in part, nor disclosed to a third party without the prior written consent of ENAC. © 2021, ENAC}
                    }
                \end{center}
            \end{minipage}  
            \begin{minipage}{0.05\linewidth}
                \hfill 
            \end{minipage}
        \else
        \scriptsize
            \begin{minipage}{0.10\linewidth}
                \includegraphics[height=16mm]{\@partnerlogo} 
            \end{minipage}
            \begin{minipage}{0.75\linewidth}
                \begin{center}{
                    \ifthenelse{\NOT \isundefined{\fr}} 
                    { % If not french option []
                      Ce document ne peut être reproduit, modifié, adapté, publié, traduit d'une quelconque façon, en tout ou partie, ni divulgué à un tiers sans l'accord préalable et écrit de l'ENAC. © 2021, ENAC}
                    { % Else french option [fr]
                      This document may not be reproduced, modified, adapted, published, translated in any way, in whole or in part, nor disclosed to a third party without the prior written consent of ENAC. © 2021, ENAC}
                    }
                \end{center}
            \end{minipage}  
            \begin{minipage}{0.10\linewidth}
                \hfill 
            \end{minipage}  
        \fi
    }
     \rfoot[]{\vspace{0.3cm}\thepage}
     \lfoot[\vspace{0.3cm}\thepage]{}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
