%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yycolumn = 1;
    #define YY_USER_ACTION \
    yylloc.first_line = yylloc.last_line = yylineno; \
    yylloc.first_column = yycolumn; \
    yylloc.last_column = yycolumn + yyleng - 1; \
    yycolumn += yyleng;

%}

%x SINGLE_LINE_COMMENT
%x MULTILINE_COMMENT
%option noyywrap
%option yylineno

%%

"#define"                                       { return T_DEFINE; }
"IF"                                            { return T_IF; }
"LET"                                           { return T_LET; }
"IN"                                            { return T_IN; }
"END"                                           { return T_END; }
"INTEGER"                                       { return T_INTEGER; }
"SKIP"                                          { return T_SKIP; }
"THEN"                                          { return T_THEN; }
"ELSE"                                          { return T_ELSE; }
"WHILE"                                         { return T_WHILE; }
"READ"                                          { return T_READ; }
"WRITE"                                         { return T_WRITE; }
"FI"                                            { return T_FI; }
"WHILE"                                         { return T_WHILE; }
"DO"                                            { return T_DO; }
":="                                            { return T_ASSIGN; }

"true"|"false"                                  {return T_BOOLEAN;}
[a-zA-Z][a-zA-Z]*[0-9]*_*                       {
                                                    if(strlen(yytext) > 31){
                                                        fprintf(stderr, "Greška: Identifikator na liniji %d je predugačak.\n", yylineno);
                                                        exit(EXIT_FAILURE);
                                                    }
                                                    yylval.ident = strdup(yytext);
                                                    return T_IDENT;
                                                }
[ \t\n\r ]                                      {/*ignorisem bjeline*/}
[0-9]+                                          {
                                                    yylval.intValue = atoi(yytext);
                                                    return T_INT;
                                                }
(0X|0x)[0-9a-fA-F]+                             {
                                                    yylval.intValue = atoi(yytext);
                                                    return T_INT;
                                                }
[0-9]+\.([0-9]*|[0-9]*[eE]?[+-]?[0-9]+)         {
                                                    double val = atof(yytext);
                                                    if (val == 0 && strcmp(yytext, "0.0") != 0) {
                                                        fprintf(stderr, "Greška: Neispravan double izraz na liniji %d.\n", yylineno);
                                                        exit(EXIT_FAILURE);
                                                    }
                                                    yylval.doubleValue = val;
                                                    return T_DOUBLE;
                                                }
\"[^\n\"]*\"                                    {printf("STRING: %s\n", yytext);}
"+"                                             { return T_PLUS; }
"-"                                             { return T_MINUS; }
"*"                                             { return T_MULT; }
"/"                                             { return T_DIV; }
"%"                                             { return T_MOD; }
"\\"                                            { return T_BACKSLASH; }
"<"                                             { return T_LESS_THAN; }
"<="                                            { return T_LESS_THAN_OR_EQUAL; }
">"                                             { return T_GREATER_THAN; }
">="                                            { return T_GREATER_THAN_OR_EQUAL; }
"="                                             { return T_EQUAL; }
"=="                                            { return T_EQUAL_EQUAL; }
"!="                                            { return T_NOT_EQUAL; }
"&&"                                            { return T_LOG_AND; }
"||"                                            { return T_LOG_OR; }
"!"                                             { return T_LOG_NOT; }
";"                                             { return T_SEMICOLON; }
","                                             { return T_COMMA; }
"."                                             { return T_DOT; }
"("                                             { return T_LEFT_PAREN; }
")"                                             { return T_RIGHT_PAREN; }
"//"                                            { BEGIN(SINGLE_LINE_COMMENT); }
"/*"                                            { BEGIN(MULTILINE_COMMENT); }
\n                                              { 
                                                    printf("Trenutni red: %d\n", yylineno); 
                                                    yycolumn = 1; 
                                                }
<SINGLE_LINE_COMMENT>{
\n { BEGIN(INITIAL); }
. { }
}

<MULTILINE_COMMENT>{
"*/" { BEGIN(INITIAL); }
. { }
\n { }
}

.                                               { return yytext[0]; }

%%

int main(){
    yylex();
    return 0;
}