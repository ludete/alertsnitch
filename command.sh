#!/bin/bash

cd script.d
bash bootstrap_mysql.sh
bash enable_del_event.sh

cd ..
nohup ./alertnitch &
