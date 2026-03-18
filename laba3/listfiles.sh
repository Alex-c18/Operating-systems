#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Использование: $0 <каталог>"
    exit 1
fi

start_dir="$1"

if [ ! -d "$start_dir" ]; then
    echo "Ошибка: каталог '$start_dir' не существует."
    exit 1
fi

echo "Список файлов в алфавитном порядке (с размерами):"
echo "--------------------------------------------------"

# Временный файл для сохранения результатов
tmpfile=$(mktemp)

# Находим все обычные файлы, выводим "путь<tab>размер", сортируем по пути
find "$start_dir" -type f -printf "%p\t%s\n" | sort > "$tmpfile"

count=$(wc -l < "$tmpfile")

# Вывод с выравниванием через column -t (если доступно)
if command -v column >/dev/null; then
    column -t -s $'\t' "$tmpfile"
else
    cat "$tmpfile"
fi

echo "--------------------------------------------------"
echo "Всего файлов: $count"

rm -f "$tmpfile"
