# wildcard will match all the file with the following pattern
# roughly it saves the output of [ls *.cpp] to variable [SRC]
SRC = $(wildcard *.cpp)
TEST = $(wildcard *.cc)

# $(VARIABLE:a%b=c%d) work as below:
# 1. it treat the variable as a space-separated list
# 2. for every item in the list, it match the item with the pattern
#    on the left hand side, wth [%] being the wildcard
# 3. it turn every item in the form of right hand side, with [%] filled in with
#    matched content
# 4. it return the list as a space-separated list
# for example, [$(TEST:%.cc=%.exec)] is translated into [clientA.exec clientB.exec]
all: $(TEST:%.cc=%.exec)

info:
	@echo $(TEST:%.cc=%.o)
	@echo $(TEST:%.cc=hello-%-world)

%.exec: $(SRC:%.cpp=%.o) %.o
	@echo "Compiling $*.exec"
	@g++ -std=c++11 $(SRC:%.cpp=%.o) $*.o -o $*.exec

%.o: %.cpp
	@echo "Compiling $*"
	@g++ -std=c++11 -c $*.cpp -o $*.o

%.o: %.cc
	@echo "Compiling $*"
	@g++ -std=c++11 -c $*.cc -o $*.o

clean:
	@rm -rf $(SRC:%.cpp=%.o) $(TEST:%.cc=%.o) $(TEST:%.cc=%.exec)

.PHONY: all clean

.PRECIOUS: %.o
