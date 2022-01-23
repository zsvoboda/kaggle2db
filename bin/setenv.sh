#!/bin/bash

DBD_BIN_DIR="$(dirname "$0")"

# Source the environment variables (we need the PYTHON_VIRTUAL_ENV)
source "${DBD_BIN_DIR}/env.sh"

# Create and activate a new virtual environment
source "${DBD_BIN_DIR}/../${PYTHON_VIRTUAL_ENV}/bin/activate"

export PATH="${DBD_BIN_DIR}/../${PYTHON_VIRTUAL_ENV}/bin:$PATH"