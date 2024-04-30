%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

%}

%x SINGLE_LINE_COMMENT
%x MULTILINE_COMMENT

%%

"true"|"false"                                  {return T_BOOLEAN;}
[a-zA-Z][a-zA-Z]*[0-9]*_*{0,31}                 {
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
                                                    yylval.doubleValue = atof(yytext);
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
<SINGLE_LINE_COMMENT>{
\n { BEGIN(INITIAL); }
. { }
}

<MULTILINE_COMMENT>{
"*/" { BEGIN(INITIAL); }
. { }
\n { }
}

%%

int main(){
    yylex();
    return 0;
}