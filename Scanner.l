%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #define IF 1

%}

%%

"if"                                            {printf("kljucna rijec");}
"true"|"false"                                  {printf("S Boolean: %s\n", yytext);}
[a-zA-Z][a-zA-Z]*[0-9]*_*{0,31}                 {printf("S Identifikator: %s\n", yytext);}
[ \t\n\r ]                                      {/*ignorisem bjeline*/}
[0-9]+                                          {printf("DEC");}
(0X|0x)[0-9a-fA-F]+                             {printf("HEX: %s\n", yytext);}
[0-9]+\.([0-9]*|[0-9]*[eE]?[+-]?[0-9]+)         {printf("DOUBLE: %s\n", yytext);}
\"[^\n\"]*\"                                    {printf("STRING: %s\n", yytext);}
[";"","".""("")"]                               {printf("znak inerpukcije");} 
["+""-""*""/""%""\""<""<="">"">=""=""==""!=""&&""||""!"]                {printf("Operator");}
"//"(.)*\n                                      {/* Ignorisanje komentara u jednoj liniji */}
"/*"([^*]|(\*+[^*/]))*\*+"/"                    { /* Ignorisanje komentara u više linija */ }


%%

int main(){
    yylex();
    return 0;
}