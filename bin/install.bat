@echo off

set DBD_BIN_DIR=%~dp0

rem Source the environment variables (we need the PYTHON_VIRTUAL_ENV, KAGGLE_USERNAME, and KAGGLE_KEY)
call %DBD_BIN_DIR%\env.bat

rem Uncomment this to install the Kaggle authentication json file
rem with this file, the Kaggle authentication environment variables are not needed
mkdir %HOMEPATH%\.kaggle
echo {"username": "%KAGGLE_USERNAME%", "key": "%KAGGLE_KEY%"} > %HOMEPATH%\.kaggle\kaggle.json

rem Create and activate a new virtual environment
python3 -m venv %DBD_BIN_DIR%\..\%PYTHON_VIRTUAL_ENV%
call %DBD_BIN_DIR%\..\%PYTHON_VIRTUAL_ENV%\Scripts\activate.bat

rem Install the dbd package
pip3 install dbd