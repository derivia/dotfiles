CC = gcc
CFLAGS = -Wall -Werror -O2 -lm

run: bee
	./bee
bee: bee.o
	$(CC) $(CFLAGS) bee.o -o bee
bee.o: bee.c
	$(CC) -c $(CFLAGS) bee.c -o bee.o
bee.c:
	echo "int main() { return 0; }" > bee.c
clean:
	@rm *.o bee 2>/dev/null || true
