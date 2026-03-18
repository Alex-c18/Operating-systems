#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Использование: $0 <исходный_файл.c> [ключи_оптимизации...]"
    exit 1
fi

source_file="$1"
shift
opt_keys="$@"

if [ ! -f "$source_file" ]; then
    echo "Ошибка: файл '$source_file' не найден."
    exit 1
fi

output_file="./temp_prog_$$"

echo "Компиляция $source_file с ключами: ${opt_keys:-без ключей (по умолчанию -O0)}"
gcc -Wall $opt_keys "$source_file" -o "$output_file" 2> compile_errors.log

if [ $? -ne 0 ]; then
    echo "Ошибка компиляции. Подробности в compile_errors.log"
    exit 1
fi

# Размер исполняемого файла
size=$(stat -c %s "$output_file" 2>/dev/null || wc -c < "$output_file" 2>/dev/null)
echo "Размер исполняемого файла: $size байт"

# Измерение времени выполнения
if command -v /usr/bin/time >/dev/null; then
    real_time=$(/usr/bin/time -f "%e" "$output_file" 2>&1 >/dev/null)
    echo "Время выполнения (real): $real_time сек"
else
    echo "Измерение времени (встроенный time):"
    time "$output_file"
fi

rm -f "$output_file"

echo "Ключи оптимизации: ${opt_keys:-без ключей (эквивалент -O0)}"
