NAME = B
CC = cc
CFLAGS = -Wall -Wextra -Werror
SRCS = $(wildcard src/*.c)
OBJS = $(SRCS:src/%.c=build/%.o) build/parser.tab.o build/lex.yy.o

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@

build/parser.tab.c build/parser.tab.h &: src/parser.y | build
	bison -Wall -d -o build/parser.tab.c $<

build/lex.yy.c: src/lexer.l | build
	flex --noyywrap --nounput -DYY_NO_INPUT -o $@ $<

build/%.o: src/%.c | build/parser.tab.c build/parser.tab.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -Isrc -Ibuild -MMD -MP -c $< -o $@

build/%.o: build/%.c | build/parser.tab.c build/parser.tab.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -Isrc -Ibuild -MMD -MP -c $< -o $@

build:
	mkdir -p $@

clean:
	rm -rf build

fclean: clean
	rm -f $(NAME)

re:
	$(MAKE) fclean
	$(MAKE) all

-include $(OBJS:.o=.d)

.DELETE_ON_ERROR:
.PHONY: all clean fclean re
