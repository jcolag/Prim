%{

/* The lex (flex) specification for the Recursion Theory Language */

#include <stdlib.h>
#include <string.h>
#include "primc.tab.h"
#include "symtab.h"

#define yy_flex_alloc   malloc
#define yy_flex_free    free
#define yy_flex_realloc realloc
#define yy_strcpy  strcpy

int     lineno = 1;

%}

%%

Z               { return (ZETA); }
S               { return (SIGMA); }
P               { return (PI); }
_[a-z]*         { yylval.ptr = lookup (yytext);
                        yylval.ptr->type = ARRAY; return (ID); }
[a-z]*          { yylval.ptr = lookup (yytext);
                        yylval.ptr->type = NUMBER; return (ID); }
[0-9]*          { yylval.value = atoi (yytext); return (INT); }
"->"            { return (GOES); }
\.              { return (TERM); }
[\t ]           { ; }
\n              { ++lineno; }
.               { return (yytext[0]); }

%%

int yywrap (void)
{
 return (1);
}
