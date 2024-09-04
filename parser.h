#ifndef PARSER_H
#define PARSER_H

#include "location.h"

void yyerror();
int yyparse();
int yylex(); //deklaracije funkcija u parseru
int noOfChar;
#endif 
