%{
#include "location.h"
#include "ast.h"
#include "parser.tab.h"
#include "errors.h"
#include "scanner.h"

int column = 1;
int no_of_comments = 0;
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

%}

%x LINE_COMMENT
%x MULTILINE_COMMENT
%option yylineno

%%

[ \t]+      { } 
\r          { column = 1; }
\n          { column = 1; } 

"//"        { BEGIN(LINE_COMMENT); }
"/*"        { no_of_comments = 1; BEGIN(MULTILINE_COMMENT); }

"INT"       { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return INT;  }   
"DOUBLE"    { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return DOUBLE;  }   
"BOOL"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return BOOL;  }   
"STRING"    { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return STRING;  }   

"CHAR"      { noOfChar++;
              yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return CHAR;  } 

"*"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return STAR;  } 

"LET"       { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return LET;  }   
"IN"        { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return IN;  }   
"END"       { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return END;  }      
"READ"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return READ;  }   
"WRITE"     { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return WRITE;  }   
"SKIP"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return SKIP;  }   

"IF"        { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return IF;  }    
"THEN"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return THEN;  }   
"ELSE"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return ELSE;  }   
"FI"        { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return FI;  }   
"WHILE"    { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return WHILE;  }   
"DO"        { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return DO;  }   
"TRUE"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return TRUE;  }
"FALSE"     { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return FALSE;  }

0|[1-9][0-9]*                           { yylval.int_value = atoi(yytext); 
                                          yylloc.first_line = yylloc.last_line = yylineno; 
                                          yylloc.first_column = column; 
                                          yylloc.last_column = column + yyleng - 1; 
                                          column += yyleng;
                                          return INTEGER_CONST; }

[a-zA-Z][a-zA-Z0-9_]{0,30}              { yylval.string_value = strdup(yytext); 
                                          yylloc.first_line = yylloc.last_line = yylineno; 
                                          yylloc.first_column = column; 
                                          yylloc.last_column = column + yyleng - 1; 
                                          column += yyleng;
                                          return IDENTIFIER; }

[a-zA-Z][a-zA-Z0-9_]{30}[^ \t\r\n]+     { lexical_error("Duzina identifikatora ne smije biti vise od 31.", yylineno,  yylloc.first_column); }

(0x|0X)(0|[1-9A-Fa-f][0-9A-Fa-f]*)      { yylval.int_value = strtol(yytext, NULL, 16); 
                                          yylloc.first_line = yylloc.last_line = yylineno; 
                                          yylloc.first_column = column; 
                                          yylloc.last_column = column + yyleng - 1; 
                                          column += yyleng;
                                          return INTEGER_CONST; }

(0x|0X)[0-9A-Fa-f]+[^ \t\r\n0-9A-Fa-f]+ { lexical_error("Heksadecimanlna cifra sadrzi nedozvoljene elemente.", yylineno,  yylloc.first_column); }

[0-9]+\.[0-9]*([eE][+-]?[0-9]+)?        { yylval.double_value = atof(yytext); 
                                          yylloc.first_line = yylloc.last_line = yylineno; 
                                          yylloc.first_column = column; 
                                          yylloc.last_column = column + yyleng - 1; 
                                          column += yyleng;
                                          return DOUBLE_CONST; }

\.[0-9]+([eE][+-]?[0-9]+)?              { lexical_error("Neispravan format double konstante (nema vodecu cifru)", yylineno,  yylloc.first_column); }

[0-9]+[eE][+-]?[0-9]+                   { lexical_error("Neispravan format double konstante (eksponent bez tacke)", yylineno,  yylloc.first_column); }

[0-9]+(\.[0-9]*)?\.[0-9]+               { lexical_error("Neispravan format double konstante - dozvoljena je samo jedna tacka.", yylineno,  yylloc.first_column); }

[0-9]+\.[0-9]*[eE][+-]?                 { lexical_error("Neispravan format double konstante (eksponent bez cifara posle znaka)", yylineno,  yylloc.first_column); }

\"[^"\n]*\"                             { yylval.string_value = strdup(yytext);     
                                          yylloc.first_line = yylloc.last_line = yylineno; 
                                          yylloc.first_column = column; 
                                          yylloc.last_column = column + yyleng - 1; 
                                          column += yyleng;
                                          return STRING_CONST; }

[_][a-zA-Z0-9_]+                        { lexical_error("Identifikator ne smije poceti donjom crtom.", yylineno,  yylloc.first_column); }


"="     { yylloc.first_line = yylloc.last_line = yylineno; 
            yylloc.first_column = column; 
            yylloc.last_column = column + yyleng - 1; 
            column += yyleng;
            return ASSIGN;  }  
"<="    { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return LE;  } 
">="    { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return GE;  } 
"<"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return LT;  } 
">"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return GT;  } 
"=="    { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return EQ;  }
"!="    { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return NE;  } 
"&&"    { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return AND;  } 
"||"    { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return OR;  } 
"!"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return NOT;  } 
"^"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return POW;  } 

"+"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return PLUS;  } 
"-"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return MINUS;  } 
"*"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return MULTIPLY;  } 
"/"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return DIVIDE;  } 
"%"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return MOD;  } 
";"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return SEMICOLON;  } 
","     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return COMMA;  } 
"."     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return DOT;  } 
"("     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return LPARENT;  } 
")"     { yylloc.first_line = yylloc.last_line = yylineno; 
          yylloc.first_column = column; 
          yylloc.last_column = column + yyleng - 1; 
          column += yyleng;
          return RPARENT;  } 

.       { lexical_error("Nedefisani karatkter.", yylineno,  yylloc.first_column); }

<LINE_COMMENT>{
"\n"        { column = 1; BEGIN(INITIAL); }
.           { }
}

<MULTILINE_COMMENT>{
"/*"        { no_of_comments++; lexical_error("Nije dozvoljeno ugnjezdjavanje komentara", yylineno,  yylloc.first_column); }
"*/"        { if(no_of_comments == 1) {} BEGIN(INITIAL); }
.           { }
"\n"        { column = 1; }
<<EOF>>     { if(no_of_comments > 0) lexical_error("Nezatvoren viselinijski komentar", yylineno,  yylloc.first_column); BEGIN(INITIAL); }
}


%%

int yywrap() {
    return 1;
}
