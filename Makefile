SRC = $(wildcard *.cpp)
TEST = $(wildcard *.cc)

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
