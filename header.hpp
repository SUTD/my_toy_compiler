#ifndef _HEADER_
#define _HEADER_
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <string>

/*typedef enum {BLOOP = 1, BLOOPI, PREC, LOOPC, LOOP, PSTC, ALOOP, INVR} TYPEtype; */

typedef struct _strlist {
	int type;
	char* value;
	struct _strlist* next;
} strlist;

strlist* newlist(char* str) {
	strlist* p = (strlist*)malloc(sizeof(strlist));
	p->value = str;
	return p;	
}

typedef struct {
	strlist* namelist;
	strlist* stmtlist;
} Program;

//Program* program;
Program* create_program(strlist* n, strlist* m) {
	Program* p = new Program();
	p->namelist = n;
	p->stmtlist = m;
	return p;
}

#endif
