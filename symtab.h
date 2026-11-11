/*
 * SPDX-FileCopyrightText: 2014 John Colagioia <john@colagioia.net>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

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
