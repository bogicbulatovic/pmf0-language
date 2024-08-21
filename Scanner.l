%{
#include <string.h>
#include <stdlib.h>
#include <stdio.h>


int column = 1;
int num_of_comments = 0;


%}

%x LINE_COMMENT
%x MULTILINE_COMMENT
%option yylineno

%%

[ \t]+      { }
\r          { column = 1; }
\n          { column = 1; }

"//"        { BEGIN(LINE_COMMENT); }
"/*"        { num_of_comments = 1; BEGIN(MULTILINE_COMMENT); }

"INT"       {   yylloc.first_line = yylloc.last_line = yylineno;
                yylloc.first_column = column;
                yylloc.last_column = column + yyleng - 1;
                column += yyleng;
                return INT; 
            }
"DOUBLE"    { yylloc.first_line = yylloc.last_line = yylineno;
                yylloc.first_column = column;
                yylloc.last_column = column + yyleng - 1;
                column += yyleng;
                return DOUBLE; 
            }
"BOOL"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return BOOL;  
            }   
"STRING"    { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return STRING;  
            }
"LET"       { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return LET;  
            }   
"IN"        { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return IN;  
            }   
"END"       { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return END;  
            }      
"READ"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return READ;  
            }   
"WRITE"     { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return WRITE; 
            }  
"SKIP"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return SKIP; 
            }   
"IF"        { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return IF;  
            }    
"THEN"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return THEN;  
            }   
"ELSE"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return ELSE;  
            }   
"FI"        { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return FI;  
            }   
"WHILE"     { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return WHILE;  
            }   
"DO"        { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return DO;  
            }   
"TRUE"      { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return TRUE;  
            }
"FALSE"     { yylloc.first_line = yylloc.last_line = yylineno; 
              yylloc.first_column = column; 
              yylloc.last_column = column + yyleng - 1; 
              column += yyleng;
              return FALSE;  
            }
    




%%

int yywrap(){
    return 1;
}