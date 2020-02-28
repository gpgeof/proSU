\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cpgf}

%    OPCOES PARA DEFINIR O TIPO DE TEXTO: M: Mestrado; D: Doutorado G: TCC Gradua\c{c}a\~o  %
\DeclareOption{G}{\newcommand\tipo{G}}
\DeclareOption{M}{\newcommand\tipo{M}}
\DeclareOption{D}{\newcommand\tipo{D}}

%   USAR AS CONFIGURACOES DA CLASSE report   %
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[12pt]{report}

%    PACOTES   %
\input{pacotes_extras} % meus pacotes
\RequirePackage[brazil]{babel}      %
\RequirePackage[utf8]{inputenc}    %Para poder digitar os acentos normalmente
\RequirePackage[T1]{fontenc}
\RequirePackage[a4paper,top=3cm,bottom=2cm,left=3cm,right=2cm]{geometry} %Pacote geometry, para fixar as margens.
\RequirePackage{amsmath}
\RequirePackage{graphicx} %Pacote graphicx, para incluir figuras.
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{setspace} %Pacote setspace, para fixar o espacamento entre linhas e permitir variacoes em partes do texto, como citacoes.

%\RequirePackage[subfigure,title]{tocloft}
%\tocloftpagestyle{empty}

\RequirePackage[authoryear,round]{natbib} % Para fazer bibliografia no estilo autor-ano.
\RequirePackage[nottoc,notlof,notlot]{tocbibind} % Para incluir a bibliografia no sumario.
\RequirePackage{ifthen}
\RequirePackage{color}
% \usepackage{lastpage}
\RequirePackage{xstring}

%\RequirePackage{indentfirst}
\RequirePackage{pdfpages} % Para incluir a página com a ficha catalografica e a com as assinaturas da banca.

\pagestyle{myheadings}

\onehalfspacing %Espacamento entre linhas de 1,5 em todo o texto. (Outras opcoes: \singlespacing, \doublespacing, \setstretch{1.1})

\pagenumbering{gobble}

%    Titulos de capitulos: titulo em negrito, maiusculas e tamanho "large", 
\renewcommand{\@makechapterhead}[1]{%
	\ifthenelse{\isodd{\thechapter}}{\ifnum \thechapter=1 {\pagenumbering{arabic} \setcounter{page}{1}} \else \relax \fi}{\relax} % Primeiro capitulo comeca na pagina 1.
	\IfInteger{\thechapter}{\relax}{
		\renewcommand{\theequation}{\thechapter\arabic{equation}} 
		\renewcommand{\thesection}{\thechapter\arabic{section}} 
		\renewcommand{\thesubsection}{\thechapter\arabic{section}.\arabic{subsection}} 
		\renewcommand{\thesubsubsection}{\thechapter\arabic{section}.\arabic{subsection}.\arabic{subsubsection}} 
		\renewcommand{\thefigure}{\thechapter\arabic{figure}} 
		\renewcommand{\thetable}{\thechapter\arabic{table}} 
		} % Formato dos numeros de equacoes, figuras, tabelas e subsecoes nos apendices: A--1, A--2...

  \vspace*{1\p@}%
%%aqui
 {\parindent \z@ \hangindent=0.75cm \raggedright \normalfont \large%
    \ifnum \c@secnumdepth >\m@ne
        \bfseries \space \uppercase{\thechapter}
%        \par\nobreak
%        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \bfseries \large \uppercase{#1} \par \nobreak
    \vskip 18\p@
  }}
%   Repetir o formato dos titulos de capitulos no sumario.
\def\@chapter[#1]#2{%
        \refstepcounter{chapter}%
        \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter} \uppercase{#1}}%
        \addtocontents{lof}{\protect\addvspace{10\p@}}%
        \addtocontents{lot}{\protect\addvspace{10\p@}}%
%        \pagestyle{cpgf}\let\ps@plain\ps@cpgf%
        \@makechapterhead{#2}\@afterheading
}

\setcounter{secnumdepth}{4}
%    Titulos de secoes: Maiusculas, sem negrito.
\renewcommand{\section}{\@startsection
{section}%                   % the name
{1}%                         % the level
{0mm}%                       % the indent
{-\baselineskip}%            % the before skip
{0.5\baselineskip}%          % the after skip
{\normalfont\uppercase}} % the style
%   Repetir titulos de secoes no sumario.
\renewcommand*{\l@section}[2]{\@dottedtocline{1}{0.75cm}{1cm}{\uppercase{#1}}{\hss #2}}
%\renewcommand*{\l@section}[2]{\@dottedtocline{1}{0em}{3.4em}{\uppercase{#1}}{\hss #2}}

%    Titulos de sub-secoes: Minusculas, negrito
\renewcommand{\subsection}{\@startsection
{subsection}%                   % the name
{2}%                         % the level
{0mm}%                       % the indent
{-\baselineskip}%            % the before skip
{0.5\baselineskip}%          % the after skip
{\normalfont\bfseries}} % the style
%   Repetir titulos de sub-secoes no sumario
\renewcommand*{\l@subsection}[2]{\@dottedtocline{2}{1.75cm}{1.5cm}{\bfseries #1}{\hss #2}}
%\renewcommand*{\l@subsection}[2]{\@dottedtocline{2}{0em}{3.4em}{\bfseries #1}{\hss #2}}

%    Titulos de sub-sub-secoes: Minusculas sem negrito
\renewcommand{\subsubsection}{\@startsection
{subsubsection}%                   % the name
{2}%                         % the level
{0mm}%                       % the indent
{-\baselineskip}%            % the before skip
{0.5\baselineskip}%          % the after skip
{\normalfont}} % the style
%   Repetir titulos de sub-secoes no sumario
\renewcommand*{\l@subsubsection}[2]{\@dottedtocline{2}{3.25cm}{1.8cm}{#1}{\hss #2}}
%\renewcommand*{\l@subsubsection}[2]{\@dottedtocline{2}{0em}{3.4em}{#1}{\hss #2}}

%   Definicoes de capitulos sem numeracao: Bibliografia.
\def\@makeschapterhead#1{%
        %\vspace*{40pt}
        \reset@font\centerline{\large \textbf{\uppercase{#1}}}
%        \reset@font\centerline{\ii@chapterfont\sffamily\textbf{\uppercase{#1}}}
        \addvspace{22pt}
}
\addto\captionsbrazil{\renewcommand{\bibname}{REFER\^ENCIAS}}
\addto\captionsbrazil{\renewcommand{\listfigurename}{LISTA DE FIGURAS}}

\DeclareRobustCommand{\chaves}[1]{\newcommand{\@chaves}{#1}} 
\DeclareRobustCommand{\keys}[1]{\newcommand{\@keys}{#1}} 

\newenvironment{resumo}
	{\thispagestyle{empty} \begin{center} \normalfont\bfseries {\large RESUMO} \end{center} \vskip 10\p@}
	{ \ifthenelse{ \isundefined{\@chaves} }{}{\vskip 10\p@ {\bf Palavras-chaves:} \ \@chaves} \newpage}

\renewenvironment{abstract}
	{\thispagestyle{empty} \begin{center} \normalfont\bfseries {\large ABSTRACT} \end{center} \vskip 10\p@}
	{ \ifthenelse{ \isundefined{\@keys} }{}{\vskip 10\p@ {\bf Keywords:} \ \@keys} \newpage}

%\addto\captionsbrazil{\renewcommand{\abstractname}{\large ABSTRACT}}
%\newenvironment{resumo}{
%		\begin{center} \normalfont\bfseries {\large RESUMO} \end{center}
%		}
%		{\newpage}


\renewcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter--}}

\newenvironment{apndc}
	{\newpage \thispagestyle{empty} \begin{center} \vspace*{10cm} \normalfont\bfseries {\Large AP\^ENDICES} \end{center}}{\newpage}
%	{\thispagestyle{empty} \begin{center} \vspace*{\fill} \normalfont\bfseries {\large AP\^ENDICES} \vspace*{\fill} \end{center}}{\newpage}
\newcommand{\apendices}{\begin{apndc} \appendix \addcontentsline{toc}{chapter}{AP\^ENDICES} \end{apndc}}


\newenvironment{anx}
	{\newpage \thispagestyle{empty} \begin{center} \vspace*{10cm} \normalfont\bfseries {\Large ANEXOS} \end{center}}{\newpage}
\newcommand{\anexos}{\begin{anx} \appendix \addcontentsline{toc}{chapter}{ANEXOS} \end{anx}}


%\renewenvironment{abstract}{
%		\addcontentsline{toc}{chapter}{ABSTRACT}
%		\begin{center} \normalfont\bfseries {\Large ABSTRACT} \end{center}
%		}
%		{\newpage}

\newenvironment{agradecimentos}
	{\thispagestyle{empty} \begin{center} \normalfont\bfseries {\large AGRADECIMENTOS} \end{center} \vskip 10\p@}{\newpage}

\newenvironment{epigrafe}
    {\thispagestyle{empty} \begin{center} \normalfont\bfseries {\large 
EP\'IGRAFE} \end{center} \vskip 10\p@}{\newpage}
	
\newenvironment{citacao}
	{\vspace{-18pt} \begin{list} {}%
			{\small \singlespace%
			\setlength{\listparindent}{1cm}%
			\setlength{\itemindent}{\listparindent}%
			\setlength{\rightmargin}{0cm}%
			\setlength{\leftmargin}{4cm}%
			\setlength{\parsep}{0pt}
			\item[]}%
			} {\end{list} }
%			\item[] \makebox[0pt] [r] {}\ignorespaces} {\unskip \makebox[0pt] [l] {} \end{list} }

\newenvironment{textorosto}
	{\begin{list} {}%
			{\singlespace
			\setlength{\listparindent}{0cm}%
			\setlength{\itemindent}{\listparindent}%
			\setlength{\rightmargin}{0cm}%
			\setlength{\leftmargin}{6cm}%
			\setlength{\parsep}{0pt}}%
			\item[] \makebox[0pt] [r] {}\ignorespaces} {\unskip \makebox[0pt] [l] {}\end{list} }

\newenvironment{dedica}
			{\thispagestyle{empty}\ \vfill \begin{list} {}%
			{\setlength{\listparindent}{0cm}%
			\setlength{\itemindent}{\listparindent}%
			\setlength{\rightmargin}{0cm}%
			\setlength{\leftmargin}{8cm}%
			\setlength{\parsep}{0pt}}%
			\item[] \makebox[0pt] [r] {}\ignorespaces} {\unskip \makebox[0pt] [l] {}\end{list} }

\DeclareRobustCommand{\dedicatoria}[1]{\begin{dedica} #1 \end{dedica} \newpage}

%\newenvironment{citacao}{\list{ }{\leftmargin{4cm} \setlength{\leftmargin}{4cm} \footnotesize \begin{singlespace}}{\end{singlespace}}
%{\setlength{\parindent}{5cm} \setlength{\hangindent}{4cm} \footnotesize \begin{singlespace}}{\end{singlespace}}
	
\DeclareRobustCommand{\advisor}[3]{\newcommand{\orientador}{#1}%
							\newcommand{\instadvisor}{#2}%
							\newcommand{\genderadvisor}{#3}}

\DeclareRobustCommand{\coadvisor}[3]{\newcommand{\coorientador}{#1}%
					\newcommand{\instcoadvisor}{#2}%
					\newcommand{\gendercoadvisor}{#3}}

\DeclareRobustCommand{\area}[1]{\newcommand{\concentr}{#1}}

\DeclareRobustCommand{\bancadois}[3][]{ 
					\ifthenelse{\equal{#1}{}}{\relax}{\newcommand{\temco}{#1}}
					\newcommand{\@bancadois}{#2}
					\newcommand{\instbancadois}{#3}}

\DeclareRobustCommand{\bancatres}[2]{\newcommand{\@bancatres}{#1}
					\newcommand{\instbancatres}{#2}}

\DeclareRobustCommand{\bancaquatro}[2]{\newcommand{\@bancaquatro}{#1}
					\newcommand{\instbancaquatro}{#2}}

\DeclareRobustCommand{\bancacinco}[2]{\newcommand{\@bancacinco}{#1}
					\newcommand{\instbancacinco}{#2}}

	
\DeclareRobustCommand{\capa}{
	\setcounter{page}{0}
	\thispagestyle{empty} 
	\begin{figure}[!t]
		\begin{center}
			\includegraphics[scale=0.3]{figuras/capa/Logo_UFPA.pdf}
		\end{center} 
	\end{figure}
	\bigskip 
	\begin{center}
		{UNIVERSIDADE FEDERAL DO PAR\'A \\ INSTITUTO DE GEOCI\^ENCIAS \\ \ifthenelse{ \equal{\tipo}{G} }{PROGRAMA DE P\'OS-GRADUA\c{C}\~AO EM GEOF\'ISICA}{PROGRAMA DE P\'OS-GRADUA\c{C}\~AO EM GEOF\'ISICA} } \\ 
		\vspace{2cm}
		\ifthenelse{ \equal{\tipo}{G} }{RELAT\'ORIO DE PROCESSAMENTO S\'ISMICO}{ \ifthenelse{ \equal{\tipo}{M} } {DISSERTA\c{C}\~AO DE MESTRADO} {TESE DE DOUTORADO}} \\
		\vspace{2cm}
		{\Large \bf \@title} \\
		\vspace{2cm} 
		{\uppercase{\@author}} \\
%		\vspace{2cm}
		\vfill
		Bel\'{e}m \\
		\@date
	\end{center}
	\newpage
}

\DeclareRobustCommand{\rosto}{
	\thispagestyle{empty}
	\begin{center}
		\vspace*{2cm}
		{\large \uppercase{\@author}} \\
		\vspace{2cm}
		{\Large \bf \@title} \\
		\vspace{2cm} 
		\ifthenelse{ \equal{\tipo}{G} } 
            {\begin{textorosto}Relat\'orio de ativades relativo \`a
            disciplina de Processamento de Sísmico.\end{textorosto}}
            {\ifthenelse{ \equal{\tipo}{M} }		
			{\begin{textorosto} Disserta\c{c}\~ao apresentada ao Programa de P\'os-Gradua\c{c}\~ao em Geof\'isica da Universidade Federal do Par\'a para obten\c{c}\~ao do t\'itulo de Mestre em Geof\'isica. \end{textorosto}} 
			{\begin{textorosto} Tese apresentada ao Programa de P\'os-Gradua\c{c}\~ao em Geof\'isica da Universidade Federal do Par\'a para obten\c{c}\~ao do t\'itulo de Doutor em Geof\'isica. \end{textorosto}}}
%		\vspace{1cm}
		\ifthenelse{ \equal{\tipo}{G} }{} {\begin{textorosto} \'Area de Concentra\c{c}\~ao: \concentr \end{textorosto}}
%		\vspace{1cm}
		\ifthenelse{\equal{\genderadvisor}{H}}{\begin{textorosto} Orientador: \orientador \end{textorosto}}{\begin{textorosto} Orientadora: \orientador \end{textorosto}}
		\ifthenelse{ \isundefined{\coorientador} } {} {%
				\ifthenelse{ \equal{\gendercoadvisor}{H} }{\begin{textorosto} Coorientador: \coorientador \end{textorosto}}{\begin{textorosto} Coorientadora: \coorientador \end{textorosto}} }
		\vfill
		Bel\'{e}m \\
		\@date
	\end{center}
	\newpage
}

\DeclareRobustCommand{\aprovacao}[1]{%
	\thispagestyle{empty} 
	\begin{center}
%		\vspace*{2cm}
		{\large \uppercase{\@author}} \\
		\vspace{1cm}
		{\large \bf \@title} \\
		\vspace{1cm}
	\end{center}
    \ifthenelse{\equal{\tipo}{G}}%
        {\begin{textorosto}
            Trabalho de Conclus\~ao de Curso apresentado \`a Faculdade de 
            Geof\'isica do Instituto de Geoci\^encias da Universidade Federal 
            do Par\'a, em cumprimento \`as exig\^encias para 
            obten\c{c}\~ao do grau de Bacharel em Geof\'isica.
        \end{textorosto}%
        Data de aprova\c{c}\~ao: {#1} \\
%   \vspace{1cm}
        Banca Examinadora:\\
        \begin{textorosto}
                \ifthenelse{\equal{\genderadvisor}{H}}{\underline{\hspace{10cm}}\\ \orientador \ (Orientador) \\ \instadvisor}{\underline{\hspace{10cm}}\\ \orientador \ (Orientadora) \\ \instadvisor}

            \vspace{2cm}
                \underline{\hspace{10cm}} \\ \@bancadois \ifthenelse{\isundefined{\temco}}{\relax}{\ifthenelse{\equal{\gendercoadvisor}{H}}{\ (Coorientador)}{\ (Coorientadora)}}\\ \instbancadois

            \vspace{2cm}
            \underline{\hspace{10cm}} \\ \@bancatres\\ \instbancatres
        \end{textorosto}
        \newpage}%
%
    {\ifthenelse{\equal{\tipo}{M}}%
        {\begin{textorosto}
            Disserta\c{c}\~ao apresentada ao Programa de P\'os-Gradua\c{c}\~ao em Geof\'isica da Universidade Federal do Par\'a para obten\c{c}\~ao do t\'itulo de Mestre em Geof\'isica.
        \end{textorosto}%
        Data de aprova\c{c}\~ao: {#1} \\
%   \vspace{1cm}
        Banca Examinadora:\\
        \begin{textorosto}
                \ifthenelse{\equal{\genderadvisor}{H}}{\underline{\hspace{10cm}}\\ \orientador \ (Orientador) \\ \instadvisor}{\underline{\hspace{10cm}}\\ \orientador \ (Orientadora) \\ \instadvisor}

            \vspace{2cm}
                \underline{\hspace{10cm}} \\ \@bancadois \ifthenelse{\isundefined{\temco}}{\relax}{\ifthenelse{\equal{\gendercoadvisor}{H}}{\ (Coorientador)}{\ (Coorientadora)}}\\ \instbancadois

            \vspace{2cm}
            \underline{\hspace{10cm}} \\ \@bancatres\\ \instbancatres
        \end{textorosto}
        \newpage}%
%
		{\begin{textorosto}
			Tese apresentada ao Programa de P\'os-Gradua\c{c}\~ao em Geof\'isica da Universidade Federal do Par\'a para obten\c{c}\~ao do t\'itulo de Doutor em Geof\'isica.
			\end{textorosto}%
			Data de aprova\c{c}\~ao: {#1} \\
	%	\vspace{1cm}
			Banca Examinadora:\\
			\begin{textorosto}
				\ifthenelse{\equal{\genderadvisor}{H}}{\underline{\hspace{10cm}}\\ \orientador \ (Orientador) \\ \instadvisor}{\underline{\hspace{10cm}}\\ \orientador \ (Orientadora) \\ \instadvisor}
	
				\vspace{1.5cm}
				\underline{\hspace{10cm}} \\ \@bancadois \ifthenelse{\isundefined{\temco}}{\relax}{\ifthenelse{\equal{\gendercoadvisor}{H}}{\ (Coorientador)}{\ (Coorientadora)}}\\ \instbancadois
	
				\vspace{1.5cm}
				\underline{\hspace{10cm}} \\ \@bancatres \\ \instbancatres
	
				\vspace{1.5cm}
				\underline{\hspace{10cm}} \\ \@bancaquatro \\ \instbancaquatro
	
				\vspace{1.5cm}
				\underline{\hspace{10cm}} \\ \@bancacinco \\ \instbancacinco
	
			\end{textorosto}
			\newpage}
}}

\endinput
