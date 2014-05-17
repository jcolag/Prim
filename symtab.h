#include <string.h>
#include <malloc.h>

#define NUMSYMS 256

#define NONE    -1
#define NUMBER  0
#define ARRAY   1
#define FUNCT   2

struct  symbol
        {
         char   *name;                  /* Identifier name */
         int    value;                  /* Numerical value */
         int    type;                   /* Token value */
         int    size;                   /* If an array */
        };

extern  struct  symbol  symtab[NUMSYMS];

struct symbol * lookup (char *);
void initsym (void);
