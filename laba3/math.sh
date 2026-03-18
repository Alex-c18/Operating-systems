#!/bin/bash

if [ $# -ne 3 ]; then
	echo "Ошибка: требуется 3 аргумента (число, оператор, число)"
	exit 1
fi

num1=$1
op=$2
num2=$3

case $op in
	+)
		result=$(echo "$num1 + $num2" | bc)
		;;
	-)
		result=$(echo "$num1 - $num2" | bc)
		;;
	\*|x)
		result=$(echo "$num1 * $num2" | bc)
		;;
	/)
		if [ "$num2" = "0" ]; then
			echo  "Ошибка: деление на ноль"
			exit 1
		fi
		result=$(echo "scale=2; $num1 / $num2" | bc)
		;;
	*)
		echo "Неизвестный оператор. Используйте +, -, x(\*), /"
		exit 1
		;;
esac

echo "Результат: $result"

