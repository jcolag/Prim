#include "symtab.h"

struct  symbol  symtab[NUMSYMS];

extern int yyerror (char *);

struct symbol * lookup (char * s)
{
 struct symbol  *sp;

 for (sp = symtab; sp < &symtab[NUMSYMS]; sp++)
        {
         if (sp->name && !strcmp (sp->name, s))
                return (sp);
         if (!sp->name)
                {
                 sp->name = strdup (s);
                 return (sp);
                }
        }
 yyerror ("Symbol Table overflow");
 return (NULL);
}

void initsym (void)
{
 struct symbol  *sp;
 
 for (sp = symtab; sp < &symtab[NUMSYMS]; sp++)
        {
         sp->name = NULL;
         sp->value = 0;
         sp->type = NONE;
         sp->size = 0;
        }
}
