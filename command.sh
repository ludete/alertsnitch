#!/bin/bash

cd script.d
bash bootstrap_mysql.sh

cd ..
nohup ./alertnitch &
