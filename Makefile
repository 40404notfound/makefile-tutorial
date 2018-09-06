CXXFLAGS += -std=c++11

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

.PHONY: all clean

.PRECIOUS: %.o
