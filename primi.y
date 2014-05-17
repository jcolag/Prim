%{

/* The yacc (byacc) specification for the Recursion Theory Language */

#include <stdio.h>
#include "symtab.h"

int yylex (void);
int yyparse (void);

int     length, count, idx;
%}

%union  {
         int    value;
         int    *addr;
         struct symbol *ptr;
        }

%token  GOES ZETA SIGMA PI TERM
%token  <value> ID INT
%type   <value> expr list listexp

%%

stmtlst :       stmtlst tstmt           { ; }
        |       /* empty */             { ; }
        ;

tstmt   :       stmt TERM               { ; }
        ;

stmt    :       expr GOES ID            { (yylval.ptr)->value = $1; }
        |       expr '?'                { printf ("%d\n", $1); }
        |       /* empty */             { ; }
        ;

expr    :       ZETA '(' ')'            { $$ = 0; }
        |       SIGMA '(' expr ')'      { $$ = $3 + 1; }
        |       PI ':' expr ';' expr '(' list ')'       {
                                          length = $3; idx = $5; count = 1;
                                          if (idx > length) $$ = 0;
                                          else if (idx < 1) $$ = 0;
                                          else $$ = $7;                 }
        |       INT                     { $$ = $1; }
        |       ID                      { $$ = (yylval.ptr)->value; }
        ;

list    :       list ',' listexp        { $$ = 0; $$ = $1 + $3; }
        |       listexp                 { $$ = $1; }
        ;

listexp :       expr                    { $$ = 0;
                                          if (idx == (count - 1)) $$ = $1;
                                          ++count;
                                        }

%%

extern  FILE    *yyin, *yyout;

int main (int argc, char *argv[])
{
 initsym ();
 
 if (argc > 1) yyin = fopen (argv[1], "r");
        /* Open source file for reading */

 while (! feof (yyin)) yyparse ();
 return (0);
}

int yyerror (char *s)
{
 fprintf (stderr, "\nERROR:  %s!\n\n", s);
 return (0);
}
