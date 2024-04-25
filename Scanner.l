%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%%

[a-zA-Z][a-zA-Z]*[0-9]*_*           {return T_IDENT;}
[ \t\n\r ]          {/*ignorisem bjeline*/}
[0-9]+              {return T_DEC;}
"0x"[0-9a-fA-F]+    {return T_HEX;}
"0X"[0-9a-fA-F]+    {return T_HEX;}
[0-9]+.[0-9]*



%%

int main(){
    yylex();
    return 0;
}