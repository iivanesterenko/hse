#!/bin/bash
echo "Список файлов во входной директории (не во вложенных):"
ls -p $1 | grep -v /

echo "Список директорий:"
dirlist=$(find $1 -type d -mindepth 1)
for dir in $dirlist
do
out=$(echo $dir | sed 's|'$1'/|./|')
echo $out
done

echo "Список всех файлов:"
filelist=$(find $1 -mindepth 1)
for file in $filelist
do
out=$(echo $file | sed 's|'$1'/|./|')
echo $out
done

echo "Копирование всех файлов:"
filelist=$(find $1 -mindepth 1)
for file in $filelist
do
out=$(basename $file)
out1="$2/$out"
if [ -e $out1 ]
then
while [ -e $out1 ]
do
out="new_${out}"
out1="$2/$out"
done
fi

if [ -d $file ]
then
echo " "
else
cp $file $out1
echo "$out скопирован под названием $out1"
fi
done
