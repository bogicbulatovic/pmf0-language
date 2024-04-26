%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

%}

%%

"true"|"false"                                  {printf("Boolean: %s\n", yytext);}
[a-zA-Z][a-zA-Z]*[0-9]*_*{0,31}                 {printf("Identifikator: %s\n", yytext);}
[ \t\n\r ]                                      {/*ignorisem bjeline*/}
[0-9]+                                          {printf("DEC: %s\n", yytext);}
(0X|0x)[0-9a-fA-F]+                             {printf("HEX: %s\n", yytext);}
[0-9]+\.([0-9]*|[0-9]*[eE]?[+-]?[0-9]+)         {printf("DOUBLE: %s\n", yytext);}
\"[^\n\"]*\"                                    {printf("STRING: %s\n", yytext);}
[";"","".""("")"]                               {printf("Znak inerpukcije");} 
["+""-""*""/""%""\""<""<="">"">=""=""==""!=""&&""||""!"]                {printf("Operator");}
"//"(.)*\n                                      {printf("Komentar u jednoj liniji: %s\n",yytext);}
"/*"([^*]|(\*+[^*/]))*\*+"*/"                   {printf("Komentar u vise linija: %s\n", yytext);}


%%

int main(){
    yylex();
    return 0;
}