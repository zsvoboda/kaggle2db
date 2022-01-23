# Loading Kaggle dataset files to a database
This repository contains an example of using [dbd](https://github.com/zsvoboda/dbd) database prototyping tool for loading Kaggle dataset files to a database.

The [dbd](https://github.com/zsvoboda/dbd) tool supports Kaggle datasets since its version 0.8.3. 

This example supports loading of Kaggle files to SQLite, Postgres, and MySQL databases. The [dbd](https://github.com/zsvoboda/dbd) tool supports more database engines. Modyfying the example to support Snowflake, Redshift, or BigQuery should be trivial. Let me know (by submitting an Issue) if you need a help. 

There are two examples available:

* [Kaggle Omicron dataset](https://www.kaggle.com/yamqwe/omicron-covid19-variant-daily-cases) that loads COVID-19 Omicron variant worldwide data. [This example's sources are here](etl/omicron). 
* [Kaggle NYT COVID-19 dataset](https://www.kaggle.com/imoore/us-covid19-dataset-live-hourlydaily-updates) that loads New York Times COVID-19 US data. [This example's sources are here](etl/omicron)

# Running the examples
Here are the quick steps that assume that you already have Python 3.8+ and Python virtual environment installed on your computer. If not, please refer to the [Installation](#installation) chapter below. 

Also, the examples use SQLite. Read the [Using MySQL or Postgres database](#using-mysql-or-postgres-database) chapter below if you have MySQL or Postgres.

1. Modify the `KAGGLE_USERNAME` and `KAGGLE_KEY` environment variables in   the `bin/env.sh` (Linux and MacOS) or `bin\env.bat` scripts. 

To use the Kaggle API, sign up for a Kaggle account at https://www.kaggle.com. Then go to the 'Account' tab  of your user profile (`https://www.kaggle.com/<username>/account`) and select 'Create API Token'. This will trigger the download of kaggle.json, a file containing your API credentials. The file looks like this: 

```json
{"username": "<kaggle-username>", "key": "<kaggle-key>"}
```

Set the `KAGGLE_USERNAME` and `KAGGLE_KEY` environment variables in the `bin/env.sh` or `bin\env.bat` script to to the `<kaggle-username>` and `<kaggle-key>` values. 

**NOTE:** You can double-quote (`"`) these values on Linux or MacOS, but don't quote them on Windows. 

2. Install [dbd](https://github.com/zsvoboda/dbd) by running `bin/install.sh` on Linux or MacOS or `bin\install.bat` on Windows.

3. Set your environment by calling `bin/setenv.sh` or `bin\setenv.bat` 

4. Run the example using a script in the `bin` directory

on Linux or MacOS:

```bash
cd etl
../bin/omicron_sqlite.sh
```

on Windows:

```cmd
cd etl
..\bin\omicron_sqlite.bat
```

OR run the example directly 

on Linux or MacOS:

```bash
source bin/setenv.sh
cd etl/omicron
dbd --project sqlite.project run .
```

on Windows:

```cmd
bin\setenv.bat
cd etl\omicron
dbd --project sqlite.project run .
```

You need to execute the `bin/setenv.sh` or `bin\setenv.bat` script just once per your terminal session. 

# Loading data from other Kaggle datasets 
You can easily modify files in the [model directory](etl/model) of these examples to load your favorite Kaggle dataset. Here are the high-level steps: 

1. Start your terminal or cmd and execute the `bin/setenv.sh` or `bin\setenv.bat` script. 

2. Create a new [dbd](https://github.com/zsvoboda/dbd) project by executing dbd `init` command 

```bash
dbd init my-kaggle-dataset
```

3. Modify the contents of the `my-kaggle-dataset/model` directory that has been generated. You most probably want to delete the demo data files and create a new `my-kaggle-dataset/model/name.ref` file with a reference to a Kaggle dataset:

```text
kaggle://yamqwe/omicron-covid19-variant-daily-cases>covid-variants.csv
```

The reference is an URL with `kaggle://` schema ([dbd](https://github.com/zsvoboda/dbd) supports many other sources), the Kaggle dataset identificator (e.g. `yamqwe/omicron-covid19-variant-daily-cases`) and finally the name of a file inside the dataset (e.g. `covid-variants.csv`).

As the reference is lovcated in the file `my-kaggle-dataset/model/name.ref`, it creates a new `name` table in the target database and populates it with the data.

4. Edit database connection in the `model/dbd.profile` file. The [dbd](https://github.com/zsvoboda/dbd) uses SQLite by default as it doesn't require any database server. See the chapter below on how to modify the `model/dbd.profile` file to load data to MySQL or Postgres. 

Here is an example `dbd.profile` file:

```yaml
databases:
  mysql:
    db.url: "mysql+pymysql://{{ MYSQL_USER }}:{{ MYSQL_PASSWORD }}@{{ MYSQL_HOST }}/{{ MYSQL_DB }}?charset=utf8mb4"
  pgsql:
    db.url: "postgresql://{{ POSTGRES_USER }}:{{ POSTGRES_PASSWORD }}@{{ POSTGRES_HOST }}/{{ POSTGRES_DB }}"
  sqlite:
    db.url: "sqlite:///omicron.db"
```

The `dbd.profile` file can reference your environment variables for database parameters (e.g. host, port, password). 

The `dbd.profile` is usually located in your home directory and contains all database connections that you work with. 

5. Make sure that your `dbd.project` file references and existing database connection from the `dbd.profile` config file. For example:

```yaml
model: model
database: sqlite
```

6. Load data from the referenced Kaggle dataset to a database 

```bash
cd my-kaggle-dataset
dbd run .
```

The [dbd](https://github.com/zsvoboda/dbd) picks up the `dbd.profile` and `dbd.project` files from the current working directory. You can use `--profile` and `--project` commendline options to use different configuration files.  

7. If you want to modify the default column's data types or add database constraints like primary or foreign keys, checks or indexeas, you can create a YAML file with the same base name to override the defaults.

# Installation
This chapter describes how to install Python3 and virtual environment on your computer. 

## Windows
Just install Python from the Microsoft Store. Search for `Python 3.9` app and install it. 

Then proceed with the steps in the [Running the examples](#running-the-examples) chapter. 

## MacOS
Use [Homebrew](https://brew.sh)

```bash
# install homebrew itself
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
# install homebrew Python
brew install python@3.9
brew install virtualenv
```

Then proceed with the steps in the [Running the examples](#running-the-examples) chapter. 

## Fedora/RedHat

```shell
sudo yum install python3
sudo yum install python3-virtualenv
```

Then proceed with the steps in the [Running the examples](#running-the-examples) chapter. 

## Ubuntu/Debian

```shell
sudo apt install python3
sudo apt install python3-venv
```

Then proceed with the steps in the [Running the examples](#running-the-examples) chapter. 


# Using MySQL or Postgres database
First, you have to specify database connection parameters in the `bin/env.sh` script on Linux or MacOS:

```bash
# Postgres environment
export POSTGRES_USER=zsvoboda
export POSTGRES_PASSWORD=
export POSTGRES_HOST=localhost
export POSTGRES_DB=postgres

# MySQL environment
export MYSQL_USER=root
export MYSQL_PASSWORD=
export MYSQL_HOST=localhost
export MYSQL_DB=public
```

or `bin/env.bat` on Windows:

```cmd
rem Postgres environment
set POSTGRES_USER=zsvoboda
set POSTGRES_PASSWORD=
set POSTGRES_HOST=localhost
set POSTGRES_DB=postgres

rem MySQL environment
set MYSQL_USER=root
set MYSQL_PASSWORD=
set MYSQL_HOST=localhost
set MYSQL_DB=public
```

Then you can run the examples by either use a corresponding script in the `bin` directory: `bin/omicron_pgsql.sh` / `bin\omicron_pgsql.bat` or `bin/omicron_mysql.sh` / `bin\omicron_mysql.bat`.

OR

using a corresponding `xxxx.project` file directly. For example:

on Linux or MacOS:

```bash
source bin/setenv.sh
cd etl/omicron
dbd --project pgsql.project run .
```

on Windows:

```cmd
bin\setenv.bat
cd etl\omicron
dbd --project mysql.project run .
```
