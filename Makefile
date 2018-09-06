all: clientA.exec clientB.exec

clientA.exec: libfib_fast.o libfib_slow.o libfib_wrong.o clientA.o
	@echo "Compiling clientA.exec"
	@g++ -std=c++11 libfib_fast.o libfib_slow.o libfib_wrong.o clientA.o -o clientA.exec

clientB.exec: libfib_fast.o libfib_slow.o libfib_wrong.o clientB.o
	@echo "Compiling clientB.exec"
	@g++ -std=c++11  libfib_fast.o libfib_slow.o libfib_wrong.o clientB.o -o clientB.exec

libfib_fast.o: libfib_fast.cpp
	@echo "Compiling libfib_fast"
	@g++ -std=c++11  -c libfib_fast.cpp -o libfib_fast.o

libfib_slow.o: libfib_slow.cpp
	@echo "Compiling libfib_slow"
	@g++ -std=c++11  -c libfib_slow.cpp -o libfib_slow.o

libfib_wrong.o: libfib_wrong.cpp
	@echo "Compiling libfib_wrong"
	@g++ -std=c++11  -c libfib_wrong.cpp -o libfib_wrong.o

clientA.o: clientA.cc
	@echo "Compiling clientA.o"
	@g++ -std=c++11  -c clientA.cc -o clientA.o


clientB.o: clientB.cc
	@echo "Compiling clientB.o"
	@g++ -std=c++11  -c clientB.cc -o clientB.o

clean:
	@rm -rf clientA.exec clientB.exec clientA.o clientB.o libfib_fast.o libfib_slow.o libfib_wrong.o

.PHONY: all clean
