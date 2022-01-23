@echo off

set DBD_BIN_DIR=%~dp0

rem Source the environment variables (we need the PYTHON_VIRTUAL_ENV, KAGGLE_USERNAME, and KAGGLE_KEY)
call %DBD_BIN_DIR%\env.bat

rem Create and activate a new virtual environment
call %DBD_BIN_DIR%\..\%PYTHON_VIRTUAL_ENV%\\Scripts\activate.bat

set PATH=%DBD_BIN_DIR%\..\%PYTHON_VIRTUAL_ENV%\Scripts;%PATH%"