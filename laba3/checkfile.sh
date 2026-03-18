#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Использование: $0 <имя_файла>"
    exit 1
fi

file="$1"

if [ -e "$file" ]; then
    echo "Файл '$file' существует."
    if [ -f "$file" ]; then
        echo "Это обычный файл."
    elif [ -d "$file" ]; then
        echo "Это каталог."
    else
        echo "Это специальный файл."
    fi
else
    echo "Файл '$file' не существует."
fi
