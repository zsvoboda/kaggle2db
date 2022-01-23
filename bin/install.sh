#!/bin/bash

DBD_BIN_DIR="$(dirname "$0")"

# Source the environment variables (we need the PYTHON_VIRTUAL_ENV, KAGGLE_USERNAME, and KAGGLE_KEY)
source "${DBD_BIN_DIR}/env.sh"

# Uncomment this to install the Kaggle authentication json file
# with this file, the Kaggle authentication environment variables are not needed
mkdir -p ~/.kaggle
echo "{\"username\": \"${KAGGLE_USERNAME}\", \"key\": \"${KAGGLE_KEY}\"}" > ~/.kaggle/kaggle.json

# Create and activate a new virtual environment
python3 -m venv "${DBD_BIN_DIR}/../${PYTHON_VIRTUAL_ENV}"
source "${DBD_BIN_DIR}/../${PYTHON_VIRTUAL_ENV}/bin/activate"

# Install the dbd package
pip3 install dbd