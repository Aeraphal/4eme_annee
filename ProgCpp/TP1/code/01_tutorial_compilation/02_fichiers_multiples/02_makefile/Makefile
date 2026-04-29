CXXFLAGS = -g -Wall -Wextra -std=c++11
CXX=g++

#executable name
project=main

all: ${project}

#linking
${project} : main.o lib1.o
	${CXX} $^ -o ${project}

#compile object files
main.o: main.cpp lib1.hpp
lib1.o: lib1.cpp lib1.hpp

clean:
	rm -f *~ *.o main
