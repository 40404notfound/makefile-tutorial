all: clientA.exec clientB.exec

%.exec: libfib_fast.o libfib_slow.o libfib_wrong.o %.o
	@echo "Compiling $*.exec"
	@g++ -std=c++11 libfib_fast.o libfib_slow.o libfib_wrong.o $*.o -o $*.exec

%.o: %.cpp
	@echo "Compiling $*"
	@g++ -std=c++11 -c $*.cpp -o $*.o

%.o: %.cc
	@echo "Compiling $*"
	@g++ -std=c++11 -c $*.cc -o $*.o

clean:
	@rm -rf clientA.exec clientB.exec clientA.o clientB.o libfib_fast.o libfib_slow.o libfib_wrong.o

.PHONY: all clean

.PRECIOUS: %.o
