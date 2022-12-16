#!/bin/sh
/usr/bin/cppcheck --library=qt -q --std=c++11 --enable=warning,style,performance,portability,unusedFunction --template='{severity},{id}:{file},{line}:{message}' ./src/ 2> ./err.txt
