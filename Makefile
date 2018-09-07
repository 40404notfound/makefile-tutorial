CXXFLAGS += -g -std=c++11
# the [?=] assignment provides a default value, we can overwrite this by
# environment variables
DB ?= gdb

SRC = $(wildcard *.cpp)
TEST = $(wildcard *.cc)

all: $(TEST:%.cc=%.exec)

%.exec: $(SRC:%.cpp=%.o) %.o
	@echo "Compiling $*.exec"
	@$(CXX) $(CXXFLAGS) $(SRC:%.cpp=%.o) $*.o -o $*.exec

%.o: %.cpp
	@echo "Compiling $*"
	@$(CXX) $(CXXFLAGS) -c $*.cpp -o $*.o

%.o: %.cc
	@echo "Compiling $*"
	@$(CXX) $(CXXFLAGS) -c $*.cc -o $*.o

clean:
	@rm -rf $(SRC:%.cpp=%.o) $(TEST:%.cc=%.o) $(TEST:%.cc=%.exec)

# this rule will call the debugger for us, and compile the program if needed
debug-%: %.exec
	@$(DB) $*.exec

# this rule will run the program, and record the output in corresponding files
test-%: %.exec
	@mkdir -p stdout
	@mkdir -p stderr
	@./$*.exec > stdout/$* 2> stderr/$*
	@echo "$* test complete"

# this rule aggragate aall the test runs
test: $(TEST:%.cc=test-%)
	@echo "test complete"

.PHONY: all clean test test-% debug-%

.PRECIOUS: %.o
