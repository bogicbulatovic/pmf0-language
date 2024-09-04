%{
#include "location.h"
#include "parser.h"
#include "errors.h"
#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

void yyerror(); 
%}

//odje proslijedjujem sve tipove koje skener moze da mi vrati
%union {
    int int_value;
    double double_value;
    char* string_value;
    Node *node;  // za AST stablo
}


%token <int_value> INTEGER_CONST
%token <double_value> DOUBLE_CONST
%token <string_value> IDENTIFIER STRING_CONST CHAR
%token PLUS MINUS MULTIPLY DIVIDE MOD LE GE LT GT EQ NE AND OR NOT POW
%token ASSIGN READ WRITE SKIP IF THEN ELSE FI WHILE DO
%token STRING BOOL INT DOUBLE LPARENT RPARENT COMMA DOT SEMICOLON STAR 
%token TRUE FALSE LET IN END

%type <node> program declarations declaration id_seq type command_sequence command expression //za ast stablo

%locations // da bi se koristila ugradjena funkcija za pracenje linije u bisonu

// asocijativnost
%left OR
%left AND
%left EQ NE
%left LT LE GT GE
%left PLUS MINUS
%left MULTIPLY DIVIDE MOD
%right POW
%right NOT // if !x - right da bi se ! odnosilo na x, a ne na if

%%

program:
    LET declarations IN command_sequence END {
        $$ = create_program($2, $4);
        AST($$);
    }
;

declarations:
    declaration {
        $$ = $1;
    }
    | declarations declaration {
        $$ = create_sequence($1, $2);
    }
;

declaration:
    type id_seq DOT { $$ = create_sequence($1, $2); } 
   
;

id_seq:
    IDENTIFIER { $$ = create_identifier($1); } // ovo je da samo deklarisemo x
    | id_seq COMMA IDENTIFIER { $$ = create_sequence($1, create_identifier($3)); } // odje da deklarisem x,y
;


command_sequence: 
    command { $$ = $1; }
    | command_sequence command { $$ = create_sequence($1, $2); } // $$ znaci da je to ono sto ce da vrati cvoru iznad
;

command: 
    SKIP SEMICOLON { $$ = create_skip(); }
    | IDENTIFIER ASSIGN expression SEMICOLON { $$ = create_assign(create_identifier($1), $3); }
    | IF expression THEN command_sequence ELSE command_sequence FI SEMICOLON { $$ = create_if($2, $4, $6); }
    | WHILE expression DO command_sequence END SEMICOLON { $$ = create_while($2, $4); }
    | READ IDENTIFIER SEMICOLON { $$ = create_read(create_identifier($2)); }
    | WRITE expression SEMICOLON { $$ = create_write($2); }
;

expression: 
    INTEGER_CONST { $$ = create_int_const($1); }
    | DOUBLE_CONST { $$ = create_double_const($1); }
    | STRING_CONST { $$ = create_string_const($1); }
    | IDENTIFIER { $$ = create_identifier($1); }
    | TRUE { $$ = create_bool_const(1); }
    | FALSE { $$ = create_bool_const(0); }
    | expression PLUS expression { $$ = create_binary_operator(N_PLUS, $1, $3); }
    | expression MINUS expression { $$ = create_binary_operator(N_MINUS, $1, $3); }
    | expression MULTIPLY expression { $$ = create_binary_operator(N_MULTIPLY, $1, $3); }
    | expression DIVIDE expression { $$ = create_binary_operator(N_DIVIDE, $1, $3); }
    | expression MOD expression { $$ = create_binary_operator(N_MOD, $1, $3); }
    | expression LE expression { $$ = create_binary_operator(N_LE, $1, $3); }
    | expression GE expression { $$ = create_binary_operator(N_GE, $1, $3); }
    | expression LT expression { $$ = create_binary_operator(N_LT, $1, $3); }
    | expression GT expression { $$ = create_binary_operator(N_GT, $1, $3); }
    | expression EQ expression { $$ = create_binary_operator(N_EQ, $1, $3); }
    | expression NE expression { $$ = create_binary_operator(N_NE, $1, $3); }
    | expression AND expression { $$ = create_binary_operator(N_AND, $1, $3); }
    | expression OR expression { $$ = create_binary_operator(N_OR, $1, $3); }
    | expression POW expression { $$ = create_binary_operator(N_POW, $1, $3); }
    | NOT expression { $$ = create_unary_operator(N_NOT, $2); }
    | LPARENT expression RPARENT { $$ = $2; }
;

type: 
    INT { $$ = create_identifier("int"); }
    | DOUBLE { $$ = create_identifier("double"); }
    | BOOL { $$ = create_identifier("bool"); }
    | STRING { $$ = create_identifier("string"); }

;
%%

void yyerror() {
    extern char *yytext; //tekst iz inputa koji se trenutno cita
    syntax_error(yytext, yylloc.first_line, yylloc.first_column);
}
