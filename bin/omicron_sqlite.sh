#!/bin/bash

DBD_BIN_DIR="$(dirname "$0")"

source "${DBD_BIN_DIR}/setenv.sh"

cd "${DBD_BIN_DIR}/../etl/omicron"

dbd --project "sqlite.project" run .