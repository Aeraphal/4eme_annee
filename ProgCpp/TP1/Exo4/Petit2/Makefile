CXXFLAGS = -g -Wall -Wextra
CXX=g++

#executable name
project=main

all: ${project}

#linking
${project} : main.o
	${CXX} $^ -o ${project}

#compile object files
main.o: main.cpp

clean:
	rm -f *~ *.o main