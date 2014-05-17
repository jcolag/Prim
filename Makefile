CC=gcc
LEX=flex -l
YACC=byacc -drtv
CFLAGS= -g -c -pedantic-errors -Wall
RM=rm -f

all: primc primi

primc: symtab.o primc.tab.o primc.code.o lex.primc.o
	$(CC) -oprimc symtab.o lex.primc.o primc.tab.o primc.code.o

primi: symtab.o primi.tab.o primi.code.o lex.primi.o
	$(CC) -oprimi symtab.o lex.primi.o primi.tab.o primi.code.o

symtab.o:      symtab.c symtab.h
	$(CC) $(CFLAGS) symtab.c

lex.primc.o: lex.primc.c
	$(CC) $(CFLAGS) lex.primc.c

lex.primi.o: lex.primi.c
	$(CC) $(CFLAGS) lex.primi.c

lex.primc.c: primc.l primc.tab.h
	$(LEX) -olex.primc.c primc.l

lex.primi.c: primc.l primi.tab.h
	$(LEX) -olex.primi.c primc.l

primc.tab.o: primc.tab.c
	$(CC) $(CFLAGS) primc.tab.c

primc.code.o: primc.code.c
	$(CC) $(CFLAGS) primc.code.c

primc.tab.h: primc.y
	$(YACC) -b primc primc.y

primc.tab.c: primc.y
	$(YACC) -b primc primc.y

primc.code.c: primc.y
	$(YACC) -b primc primc.y

primi.tab.o: primi.tab.c
	$(CC) $(CFLAGS) primi.tab.c

primi.code.o: primi.code.c
	$(CC) $(CFLAGS) primi.code.c

primi.tab.c: primi.y
	$(YACC) -b primi primi.y

primi.code.c: primi.y
	$(YACC) -b primi primi.y

clean:
	$(RM) prim?.code.c  prim?.output  prim?.tab.c  prim?.tab.h *.o lex.prim?.c
