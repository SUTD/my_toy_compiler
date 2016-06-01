%{
#include <string>
#include <stdio.h>
int line_num = 0;
int vnum = 0;

/*#define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
#define TOKEN(t)    (yylval.token = t)
<INITIAL>[^\n]*\n				{ printf("GET %s\n", yytext); line_num++; }
*/
%}

%start VNAME BLOOP BLOOPI PREC LOOPC LOOP PSTC ALOOP INVR 

%%
<INITIAL>"names="				{ printf("int loopfunction(int a[]) {\n"); BEGIN VNAME; }
<INITIAL>"beforeloop="			{ BEGIN BLOOP; }
<INITIAL>"beforeloopinit="		{ BEGIN BLOOPI;}
<INITIAL>"precondition="		{ BEGIN PREC;}
<INITIAL>"loopcondition="		{ BEGIN LOOPC;}
<INITIAL>"loop="				{ BEGIN LOOP;}
<INITIAL>"postcondition="		{ BEGIN PSTC;}
<INITIAL>"afterloop="			{ BEGIN ALOOP;}
<INITIAL>"inv="					{ BEGIN INVR;}
<VNAME>[a-zA-Z0-9_]*			{ printf("int %s = a[%d];\n", yytext, vnum++); } 
<VNAME>"\ "
<VNAME>"\n"						{ /*printf("GET\n");*/ line_num++; BEGIN INITIAL; }
<BLOOP>[^\n]*\n					{ printf("%s\n", yytext); BEGIN INITIAL; }
<BLOOPI>[^\n]*\n				{ printf("%s\n", yytext); BEGIN INITIAL; }
<PREC>[^\n]*\n					{ yytext[yyleng-1] = '\0'; printf("zilu_assume(%s);\n", yytext); BEGIN INITIAL; }
<LOOPC>[^\n]*\n					{ yytext[yyleng-1] = '\0'; printf("while(%s) \n", yytext); BEGIN INITIAL; }
<LOOP>[^\n]*\n					{ yytext[yyleng-1] = '\0'; printf("{%s}\n", yytext); BEGIN INITIAL; }
<PSTC>[^\n]*\n					{ yytext[yyleng-1] = '\0'; printf("zilu_assert(%s);\n", yytext); BEGIN INITIAL; }
<ALOOP>[^\n]*\n					{ yytext[yyleng-1] = '\0'; printf("%s\n", yytext); BEGIN INITIAL; }
<INVR>[^\n]*\n					{ yytext[yyleng-1] = '\0'; printf("zilu_invariant{%s}\n", yytext); BEGIN INITIAL; }
%%

int yywrap() {
	return 1;
}

int main() {
	yylex();
	return 0;
}
