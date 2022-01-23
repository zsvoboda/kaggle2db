https://github.com/Kaggle/kaggle-api/blob/master/README.md

```shell
python3 -m venv my-env
source my-env/bin/activate
pip3 install kaggle
kaggle config set -n username -v <your-kaggle-username>
kaggle config set -n key -v <your-kaggle-key>
pip3 install dbd

git clone https://github.com/zsvoboda/omicron.git
cd omicron

kaggle datasets download yamqwe/omicron-covid19-variant-daily-cases -p etl/data

cd etl
dbd run . 
```