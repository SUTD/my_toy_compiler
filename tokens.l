%{
#include "parser.tab.h"

/*#define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
#define TOKEN(t)    (yylval.token = t)
*/
#define savestr		yylval.list.value = malloc(yyleng); strcpy(yylval.list.value, yytext);
%}

%option noyywrap
%%
"names="				{ return NAMES;}
"beforeloop="			{ return BLOOP; }
"beforeloopinit="		{ return BLOOPI; }
"precondition="			{ return PREC; }
"loopcondition="		{ return LOOPC; }
"loop="					{ return LOOP; }
"postcondition="		{ return PSTC; }
"afterloop="			{ return ALOOP; }
"inv="					{ return INVR; }
[^\n]*\n				{ return VALUE;}
%%
