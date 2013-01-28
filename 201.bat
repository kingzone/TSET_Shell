@echo off

rem delete records in the table CostProfileTypes and then insert new records
echo Now deleting records in the tables --CostProfileTypes-- and then insert new records...
if exist CostProfileTypes.sql (
  echo .logon 153.64.28.192/dbc,dbc >> CostProfileTypes.b
  echo .defaults >> CostProfileTypes.b
  echo .width 65531 >> CostProfileTypes.b
  
  echo delete from dbc.CostProfileTypes; >> CostProfileTypes.b
  
  copy CostProfileTypes.b+CostProfileTypes.sql CostProfileTypes.b
  
  echo .logoff >> CostProfileTypes.b
  echo .exit >> CostProfileTypes.b
  
  rem bteq < CostProfileTypes.b > CostProfileTypes.bb
  bteq < CostProfileTypes.b
  if errorlevel 1 (
    echo ERROR when tackling CostProfileTypes
	pause & exit
  )
  echo insert into CostProfileTypes success!
  rem pause & exit
) else (
  echo not found CostProfileTypes.sql
)

rem delete records in the table CostProfiles and then insert new records 
echo Now deleting records in the table --CostProfiles-- and then insert new records...
if exist CostProfiles.sql (
  echo .logon 153.64.28.192/dbc,dbc >> CostProfiles.b
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

rem delete records in the table ConstantDefs and then insert new records 
echo Now deleting records in the table --ConstantDefs-- and then insert new records...
if exist ConstantDefs.sql (
  echo .logon 153.64.28.192/dbc,dbc >> ConstantDefs.b
  echo .defaults >> ConstantDefs.b
  echo .width 65531 >> ConstantDefs.b
  
  echo delete from dbc.ConstantDefs; >> ConstantDefs.b
  
  copy ConstantDefs.b+ConstantDefs.sql ConstantDefs.b
  
  echo .logoff >> ConstantDefs.b
  echo .exit >> ConstantDefs.b
  
  echo please waiting...(need about 10 minutes)
  rem bteq < ConstantDefs.b > ConstantDefs.bb
  bteq < ConstantDefs.b
  if errorlevel 1 (
    echo ERROR when tackling ConstantDefs
	pause & exit
  )
  echo insert into ConstantDefs success!
) else (
  echo not found ConstantDefs.sql
)

rem delete records in the table ConstantValues and then insert new records
echo Now deleting records in the table --ConstantValues-- and then insert new records...
if exist ConstantValues.sql (
  echo .logon 153.64.28.192/dbc,dbc >> ConstantValues.b
  echo .defaults >> ConstantValues.b
  echo .width 65531 >> ConstantValues.b
  
  echo delete from dbc.ConstantValues; >> ConstantValues.b
  
  copy ConstantValues.b+ConstantValues.sql ConstantValues.b
  
  echo .logoff >> ConstantValues.b
  echo .exit >> ConstantValues.b
  
  echo please waiting...(need about 10 minutes)
  rem bteq < ConstantValues.b > ConstantValues.bb
  bteq < ConstantValues.b
  if errorlevel 1 (
    echo ERROR when tackling ConstantValues
	pause & exit
  )
  echo insert into ConstantValues success!
) else (
  echo not found ConstantValues.sql
)

echo Now cleaning the directory...
del *.bb
del *.b

echo Done.
