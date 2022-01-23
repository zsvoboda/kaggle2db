@echo off

set DBD_BIN_DIR=%~dp0

rem Source the environment variables (we need the PYTHON_VIRTUAL_ENV, KAGGLE_USERNAME, and KAGGLE_KEY)
call %DBD_BIN_DIR%\setenv.bat

cd %DBD_BIN_DIR%\..\etl\covid

dbd --project sqlite.project run .