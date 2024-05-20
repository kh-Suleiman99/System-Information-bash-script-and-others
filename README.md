# System-Information-bash-script-and-others
This repository contains Some of simple Bash scripts, I wrote them while studying The Linux command line reference. 
# Table of Contents
* [Hello World](#hello_world.sh)
* [File Status](#file_status.sh)
* [Hours](#hours.sh)
* [System Information](#sys_info.sh)
* [Trap Demo](#trap_demo.sh)

# Hello World
This is our first script
**Example Usage:**
```shell
$ ./hello_world.sh "
Hello,  World
```

# File Status
a script that Evaluate the status of a file. It demonstrates some of the file expressions.
**Example Usage:**
```shell
$ ./file_status.sh "
Enter the file name: /home/khaled
/home/khaled is a directory.
/home/khaled is readable.
/home/khaled is writable.
/home/khaled is executable/searchable.
```

# Hours
script to count files by modification time.
**Example Usage:**
```shell
$ ./hours.sh /bin "
Hour    Files   Hour    Files
====    =====   ====    =====
00      39      12      54
01      28      13      36
02      70      14      103
03      10      15      110
04      3       16      162
05      12      17      187
06      2       18      102
07      9       19      57
08      30      20      143
09      16      21      118
10      8       22      100
11      118     23      49
=============================

Total files = 1566
```

# System Information
Program to output system information to an html page.
**Example Usage:**
```shell
$ sudo ./sys_info.sh -f sys_info_page.html "
```

# Trap Demo
simple signal handling demo. will execute an echo command each time either the SIGINT or SIGTERM signal is received while the script is running.
**Example Usage:**
```shell
$ ./trap_demo.sh "
Iteration 1 of 5
^C
I am ignoring you.
Iteration 2 of 5
Iteration 3 of 5
^C
I am ignoring you.
Iteration 4 of 5
Iteration 5 of 5
```