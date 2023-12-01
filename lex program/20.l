%{
#include<stdio.h>
int ln=0;
%}
%%

.* {ln++; fprintf(yyout,"\n%d:%s",ln,yytext);}
%%
int yywrap(){}

int main(void)
{
FILE *f;
char file[10];
printf("enter file name:");
scanf("%s",file);
f=fopen(file,"r");
yyin=f;
yylex();
printf("number of lines: %d",ln);
fclose(yyin);
}