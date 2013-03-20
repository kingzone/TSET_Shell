@echo off

set starttime=%time%

call drop.bat
call 000.bat
call 001.bat
call 101.bat
call 201.bat

echo Cleaning...
del *.out
del *.b
del *.sql

set endtime=%time%
echo starttime: %starttime%; endtime: %endtime%; time elapsed: %endtime%-%starttime%