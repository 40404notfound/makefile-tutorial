all: clientA.exec clientB.exec

# [%] is used for pattern matching, if a target of the form x.exec are to be made,
# this rule will trigger and set the variable [$*] to be the matched string (x).
%.exec: libfib_fast.o libfib_slow.o libfib_wrong.o %.o
	@echo "Compiling $*.exec"
	@g++ -std=c++11 libfib_fast.o libfib_slow.o libfib_wrong.o $*.o -o $*.exec

# we can also use [%] in the dependency. this rule means
# "to build x.o, it requires x.cpp"
%.o: %.cpp
	@echo "Compiling $*"
	@g++ -std=c++11 -c $*.cpp -o $*.o

# we can set multiple pattern matching rule for a single pattern,
# in most case it's confusing, but if there can either be a x.cpp or x.cc,
# make will decide correctly which rule to run
%.o: %.cc
	@echo "Compiling $*"
	@g++ -std=c++11 -c $*.cc -o $*.o

clean:
	@rm -rf clientA.exec clientB.exec clientA.o clientB.o libfib_fast.o libfib_slow.o libfib_wrong.o

.PHONY: all clean

# this is a hack to preserve the intermediate products (object files),
# and it could speed up compilation
# see https://stackoverflow.com/questions/15189704/makefile-removes-object-files-for-no-reason
.PRECIOUS: %.o
