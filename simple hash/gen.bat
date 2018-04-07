@echo off
call clang out.c
call javac SimpleHash.java
@echo on
call a.exe | call java SimpleHash > passwords.txt