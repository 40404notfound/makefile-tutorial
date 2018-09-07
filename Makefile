# like normal programming languages, we can define variables in Makefile
# [CXXFLAGS] are the common name of flags for C++ compiler
# we are using [+=] so that we are appending flags, if there is any already
# defined in the environment
CXXFLAGS += -std=c++11

SRC = $(wildcard *.cpp)
TEST = $(wildcard *.cc)

all: $(TEST:%.cc=%.exec)

info:
	@echo $(CXXFLAGS)

%.exec: $(SRC:%.cpp=%.o) %.o
	@echo "Compiling $*.exec"
	@$(CXX) $(CXXFLAGS) $(SRC:%.cpp=%.o) $*.o -o $*.exec
# we didn't define variable [CXX], but it's predefined by make as "g++"

%.o: %.cpp
	@echo "Compiling $*"
	@$(CXX) $(CXXFLAGS) -c $*.cpp -o $*.o

%.o: %.cc
	@echo "Compiling $*"
	@$(CXX) $(CXXFLAGS) -c $*.cc -o $*.o

clean:
	@rm -rf $(SRC:%.cpp=%.o) $(TEST:%.cc=%.o) $(TEST:%.cc=%.exec)

.PHONY: all clean info

.PRECIOUS: %.o
