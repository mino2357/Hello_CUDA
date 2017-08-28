CXX = g++
TARGET = add
CXXFLAGS = -std=c++1z -Wall -Wextra -O2 -DENABLE_AVX -DENABLE_SSE -march=native -mtune=native
LDLFLAGS = -lstdc++
SRCS = add.cpp
OBJS = $(SRCS:.cpp=,o)

all : $(TARGET)

run : all
	./$(TARGET)

clean:
	rm $(TARGET)
