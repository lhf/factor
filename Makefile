W= http://cvsweb.netbsd.org/bsdweb.cgi/~checkout~/src/games
G= curl -L -R -O
CFLAGS= -Wall -Wextra -O2 -Dlint -D__dead= -DHAVE_OPENSSL

all:	get bin

bin:	factor primes

factor:	factor.o pr_tbl.o
	$(CC) -o $@ factor.o pr_tbl.o -lcrypto

primes:	primes.o pr_tbl.o pattern.o spsp.o
	$(CC) -o $@ primes.o pr_tbl.o pattern.o spsp.o -lm

clean:
	-rm -f factor primes factor.o pattern.o pr_tbl.o primes.o spsp.o

get:
	$G $W/factor/factor.6
	$G $W/factor/factor.c
	$G $W/primes/pattern.c
	$G $W/primes/primes.6
	$G $W/primes/primes.c
	$G $W/primes/primes.h
	$G $W/primes/pr_tbl.c
	$G $W/primes/spsp.c

