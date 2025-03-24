#!/bin/bash

read -p "Jaki jest twoj ulubiony system operacyjny?: " fav_os

if [[ $fav_os == "Windows" || $fav_os == "Mac" ]]; then
    echo "Serio wybrales $fav_os...?"
elif [[ $fav_os == "Linux" ]]; then
    echo "Swietny wybor!"
else
    echo "Czy $fav_os jest systemem operacyjnym?"
fi            