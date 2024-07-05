#!/bin/sh

includes=0

get_confirmation() {
    while true; do
        read yn
        if [ "$yn" = "Y" ] || [ "$yn" = "y" ]
        then
            return 0
        else
            return 1
        fi
    done
}

read -p "What's the project name ? : " name
mkdir "$name"
echo "A folder called $name as been created"

echo "Do you need a 'srcs' folder ?"
if get_confirmation; then
    mkdir "$name/srcs"
    echo "srcs folder as been added to your project"
fi

echo "Do you need a 'includes' folder ?"
if get_confirmation; then
    mkdir "$name/includes"
    includes=$((includes + 1))
    echo "includes folder as been added to your project"
fi

echo "Do you need a Makefile ?"
if get_confirmation; then
    touch "$name/Makefile"
    cat << EOF > "$name/Makefile"
EXEC = #name
FLAGS = -Wall -Wextra -Werror
PATH_SRC = ./srcs/
SRC = #.c files
OBJ = \$(SRC:.c=.o)
CC = gcc

all: \$(EXEC)

\$(EXEC): \$(OBJ)
	\$(CC) \$(FLAGS) \$(OBJ) -o \$(EXEC)

%.o: %.c
	\$(CC) \$(FLAGS) -c \$< -o \$@

clean:
	/bin/rm -f \$(OBJ)

fclean: clean
	/bin/rm -f \$(EXEC)

.PHONY: all clean fclean
EOF
    echo "Makefile as been added to your project"
fi

echo "Do you need a header file ?"
if get_confirmation; then
    if [ "$includes" -eq 1 ]; then
        touch "$name/includes/$name.h"
        echo "header file as been added to your project"
    else
        touch "$name/$name.h"
        echo "header file as been added to your project"
    fi
fi

#init git
echo "Your git project will be automatically setup in a few seconds"
cd $name/
git init
git add *
git commit -m "first commit"
git branch -M main
read -p "Give your Github token followed by the repo name : " token
git remote add origin $token
git push -u origin main