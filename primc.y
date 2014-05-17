%{

/* The yacc (byacc) specification for the Recursion Theory Language */
/* To Do:       --Put variable list at start of file
 *              --Handle list indexing
 *              --Add minimalization
 */

#include <stdio.h>
#include "symtab.h"

int yylex (void);
int yyparse (void);

int     length, count, idx;
char    lineout[512], line2[512];

extern  int     lineno;

char * aname (void);
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

stmtlst :       stmtlst stmt            { ; }
        |       /* empty */             { ; }
        ;

stmt    :       expr GOES ID TERM       { fprintf (yyout, "%s = %s;\n",
                                                (yylval.ptr)->name, lineout);
                                        }
        |       expr '?' TERM           { fprintf (yyout, "WRITEINT (%s);\n",
                                                lineout);
                                          fprintf (yyout,
                                                "WRITE (\'\\n\');\n");
                                        }
        |       TERM                    { fprintf (yyout, ";\n"); }
        ;

expr    :       ZETA '(' ')'            { sprintf (lineout, "0"); }
        |       SIGMA '(' expr ')'      { strcpy (line2, lineout);
                                          sprintf (lineout, "%s + 1",
                                                line2);         }
        |       PI ':' expr ';' expr '(' list ')'       {
                                          length = $3; idx = $5; count = 0;
                                          if (idx > length) $$ = 0;
                                          else if (idx < 1) $$ = 0;
                                          else $$ = $7;
                                          sprintf (lineout, "$ dw %s ",
                                                aname());
                                          fprintf (yyout, "%s\n", lineout);
                                          fprintf (yyout, "BX = ;\n");
                                          sprintf (lineout, "%s[BX]", aname());
                                        }
        |       INT                     { sprintf (lineout, "%d",
                                                yylval.value); }
        |       ID                      { sprintf (lineout, "%s",
                                                (yylval.ptr)->name); }
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
 void   header (FILE *);
 void   footer (FILE *);

 initsym ();
 
 if (argc > 1 && strcmp (argv[1], "NUL")) yyin = fopen (argv[1], "r");
        /* Open source file for reading */
 if (argc > 2) yyout = fopen (argv[2], "w");
        /* Open destination file for writing */

 header (yyout);
 while (! feof (yyin))
        {
         yyparse ();
        }
 footer (yyout);

 return (0);
}

int yyerror (char *s)
{
 fprintf (stderr, "\nERROR on line %d:  %s!\n\n", lineno, s);
 return (0);
}

char * aname (void)     /* Generates an array name */
{
 static char    a = 'A', b = 'B', c = 'C';
 static int     times = 0;
 static char   name[16];

 if (times % 2)
        {
         sprintf (name, "__%c_%c_%c__", a, b, c);
         a += times;
         b += a % 2;
         c += b % 2;
        }

 ++times;
 return (name);
}

void header (FILE * outfile)
{
 fprintf (outfile, "? jumptomain FALSE\n");
 fprintf (outfile, "? include \"WRITE.H--\"\n");
 fprintf (outfile, "main ()\n{\n");
}

void footer (FILE * outfile)
{
 struct symbol  *sp;

 fprintf (outfile, "}\n\n");
 for (sp = symtab; sp < &symtab[NUMSYMS]; sp++)
        if (sp->name) fprintf (outfile, "int %s;\n", sp->name);
}
