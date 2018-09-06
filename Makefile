CXXFLAGS += -g -std=c++11
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

debug-%: %.exec
	@$(DB) $*.exec

test-%: %.exec
	@mkdir -p stdout
	@mkdir -p stderr
	@./$*.exec > stdout/$* 2> stderr/$*
	@echo "$* test complete"

test: $(TEST:%.cc=test-%)
	@echo "test complete"

.PHONY: all clean test test-% debug-%

.PRECIOUS: %.o
