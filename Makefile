# download and build factor and primes program from the NetBSD

W= http://cvsweb.netbsd.org/bsdweb.cgi/~checkout~/src/games
G= curl -L -R -O
CFLAGS= -Wall -Wextra -O2 -Dlint -D__dead= -DHAVE_OPENSSL
# use this if you don't have openSSL
CFLAGS= -Wall -Wextra -O2 -Dlint -D__dead= -Du_long="unsigned long"

all:	get bin test

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

test:	bin
	./primes 1 1000 | column
	./factor 1234567890123456789

