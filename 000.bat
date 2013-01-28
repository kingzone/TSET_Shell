@echo off
echo Now Retrieving all the tablenames and tablekinds...
bteq < 000.txt
echo Now creating show table/view statements...
if exist objs.out (
  rem get lines from the 3rd line
  set n=1
  SetLocal EnableDelayedExpansion
  for /f "delims=" %%i in (objs.out) do (
    echo %%i
    if !n! geq 3 (
      echo %%i >> 0.txt
    ) else (
      echo not matching...
    )
    set /a n=!n!+1
  )
  endlocal
) else (
  echo not found objs.out
)

echo creating file 1_DDL.txt which contains all the show statements...
if exist 0.txt (
  echo .logon 153.64.28.192/dbc,dbc >> 1_DDL.txt
  echo database hadoop; >> 1_DDL.txt
  rem echo .set format off; >> 1_DDL.txt
  rem echo .set width 65531; >> 1_DDL.txt
  SetLocal EnableDelayedExpansion
  set hasHyphen=false
  for /f "tokens=1,2" %%i in (0.txt) do (
    echo %%i
	echo %%j
	rem can NOT use goto in for
	rem echo "%%i"|findstr "-">nul && goto continue
	set hasHyphen=false
	echo "%%i"|findstr "\-">nul && set hasHyphen=true
	echo i============"%%i"
	if "!hasHyphen!"=="true" (
	  echo has hyphen in the tablename, ignore this line.
	) else (
	  if %%j == T (
	    echo show table %%i; >> 1_DDL.txt
		echo show stats values on %%i; >> 1_DDL.txt
	  ) else (
	    if %%j == V (
	      echo show view %%i; >> 1_DDL.txt
	    ) else (
	      if %%j == O (
		    echo show table %%i; >> 1_DDL.txt
		  )
	    )
	  )
	  echo write a line into 1_DDL.txt successfully.
	)
	rem :continue
	rem echo continue...
  )
  endlocal
  echo .logoff >> 1_DDL.txt
  echo .exit >> 1_DDL.txt
) else (
  echo not found 0.txt
)

echo Now show tables and views et....
bteq < 1_DDL.txt > 1_DDL.out
rem if errorlevel 1 pause&exit
if errorlevel 1 echo sth wrong with the bteq command, but continue...
rem if errorlevel 1 pause

Rem matching and extracting the create table statements
if exist 1_DDL.out (
  echo now extracting create table statements
  set myflag=false
  SetLocal EnableDelayedExpansion
  for /f "delims=" %%i in (1_DDL.out) do (
    echo %%i
	rem tackling the > operator
	rem %%i=%%i:>=GTR
	echo "%%i"
	
	rem some create sentences have NOT semicolon
	echo "%%i"|findstr "+---------">nul && set myflag=false
	
    echo "%%i"|findstr /i "create">nul && set myflag=true
	rem add semicolon before each create
	echo "%%i"|findstr /i "create">nul && echo ; >> DDL.out
	
	echo "%%i"|findstr /i "collect">nul && set myflag=true
	rem add semicolon before each collect
	echo "%%i"|findstr /i "collect">nul && echo ; >> DDL.out
	
	echo myflag !myflag!
    if "!myflag!" == "true" (
      rem echo %%i >> DDL.txt
	  echo %%i >> DDL.out
      rem echo %%i
    ) else (
      echo not matching...
    )
    echo "%%i"|findstr ";">nul && set myflag=false
  )
  endlocal
) else (
  echo not found 1_DDL.out
)
Rem deleting the unused file
echo Now cleaning the unused files...
del objs.out
del 0.txt
del 1_DDL.txt
del 1_DDL.out
echo Done.
