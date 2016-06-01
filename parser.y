%{
	#include <header.hpp>

/*typedef enum {BLOOP = 1, BLOOPI, PREC, LOOPC, LOOP, PSTC, ALOOP, INVR} TYPEtype; */

extern int yylex();
int yyerror(char const *str);
%}

/* Represents the many different ways we can access our data */
%union {
	int tp;
	char* str;
	strlist *list;
	Program *program;
}

/* Define our terminal symbols (tokens). This should
   match our tokens.l lex file. We also define the node type
   they represent.
 */
/*%token <token> NAMES BLOOP BLOOPI PREC LOOPC LOOP PSTC ALOOP INVR NAMESTR VALUE*/
%token <tp> NAMES BLOOP BLOOPI PREC LOOPC LOOP PSTC ALOOP INVR
%token <str> VALUE
%type <list> namelist stmtlist stmt
%type <tp> ttype
%type <program> root
/*%type <program> root*/ 

%start root

%%

root: namelist stmtlist { $$ = create_program($1, $2); }
	;

namelist : NAMES VALUE { $$ = newlist($2); }
		 ;

stmtlist : stmt stmtlist { $$ = $1; $1->next = $2; }
		 | stmt { $$ = $1; $$->next = NULL; }
			;

stmt : ttype VALUE
	 {
		$$ = newlist($2);
		$$->type = $1;
	}
	;

ttype: BLOOP
	 | BLOOPI
	| PREC
	| LOOPC
	| LOOP
	| PSTC
	| ALOOP
	| INVR
	;

%%

int yyerror(char const *str)
{
	extern char* yytext;
	fprintf(stderr, "parser error near %s\n", yytext);
	return 0;
}

int main(void)
{
	extern int yyparse(void);
	extern FILE *yyin;

	yyin = stdin;
	if (yyparse()) {
		fprintf(stderr, "Error ! Error ! Error !\n");
		exit(1);
	}
}
