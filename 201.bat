@echo off

rem execute sql to import

echo Now DROP tables and then re-create all the tables...
if exist drop.sql (
  echo .logon 153.64.80.9/dbc,dbc >> drop.b
  echo database hadoop; >> drop.b
  echo .defaults >> drop.b
  echo .width 65531 >> drop.b
  
  
  copy drop.b+drop.sql drop.b
  
  echo .logoff >> drop.b
  echo .exit >> drop.b
  
  bteq < drop.b
  if errorlevel 1 (
    echo ERROR when tackling drop
	pause & exit
  )
  echo drop tables success!
) else (
  echo not found drop.sql
)
echo re-create all the tables...
if exist DDL.sql (
  echo .logon 153.64.80.9/dbc,dbc >> DDL.b
  echo database hadoop; >> DDL.b
  echo .defaults >> DDL.b
  echo .width 65531 >> DDL.b
  
  copy DDL.b+DDL.sql DDL.b
  
  echo .logoff >> DDL.b
  echo .exit >> DDL.b
  
  bteq < DDL.b
  if errorlevel 1 (
    echo ERROR when tackling DDL
	pause & exit
  )
  echo Re-create tables success!
) else (
  echo not found DDL.sql
)


rem delete records in the table CostProfiles and then insert new records 
echo Now deleting records in the table --CostProfiles-- and then insert new records...
if exist CostProfiles.sql (
  echo .logon 153.64.80.9/dbc,dbc >> CostProfiles.b
  echo database hadoop; >> CostProfiles.b
  echo .defaults >> CostProfiles.b
  echo .width 65531 >> CostProfiles.b
  
  echo delete from dbc.CostProfiles; >> CostProfiles.b
  
  copy CostProfiles.b+CostProfiles.sql CostProfiles.b
  
  echo .logoff >> CostProfiles.b
  echo .exit >> CostProfiles.b
  
  rem bteq < CostProfiles.b > CostProfiles.bb
  bteq < CostProfiles.b
  if errorlevel 1 (
    echo ERROR when tackling CostProfiles
	pause & exit
  )
  echo insert into CostProfiles success!
) else (
  echo not found CostProfiles.sql
)

echo Now cleaning the directory...
del *.bb
rem del *.b

echo DONE: execute sql to import.
