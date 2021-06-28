# Virtual Donkey Racing2021_June

# Repository Introduction
This repository will share Donkey v4.2 driving data, trained models, and Donkey configuration data for participation in the Virtual DonkeyCar Race racing in June 2021.  
This repository refers to [hogenimushi/vdc2020_race03](https://github.com/hogenimushi/vdc2020_race03).

## Preparation
### Install Donkeycar
1. [Please follow instruction from "Install Donkeycar on Linux"](https://docs.donkeycar.com/guide/host_pc/setup_ubuntu/)
1. [Please follow instruction from "Donkey Simulator"](https://docs.donkeycar.com/guide/simulator/)  

### Attention
**Please upgrade your TensorFlow version to 2.4.0 to use the automated driving models in this repository.**  
How to check the version of TensorFlow in conda
```shell
conda list | grep tensor
```  
If you confirmed tensorflow == 2.2.0, please type below command
```shell
conda uninstall tensorflow
pip install tensorflow==2.4.0
If you have GPU
pip install tensorflow-gpu==2.4.0
```
### Install the simulator.
```shell
make install_sim
```

### Get running data
```shell
make record
````

### Create a model with the example data.
models/test.h5 will create.  
```shell
make test_train
```

### Use test.h5 for automatic operation.
```shell
cp save_model/test.h5 models/
make test_run
```

### Miscellaneous.
See the Makefile.

## Description of each directory and file.
- ```cfgs```: Contains the configuration data for Donkey. Donkey's configuration data is including car body settings and machine learning settings.
- ```data```: This contains the simulator's running data. If you want to share your running data, move it to _save_data_.
- ```models```: The directory where models will be output after training. Move models to _save_model_ if you want to share them.
- ```save_data```: Share Donkey's running data with others.
- ```save_model```: Share Donkey's trained model with others.
- ```Makefile```: We use this mainly for reproducibility of the trained model. Specifically, it describes the data used in the trained model. It also allows you to invoke long commands with your own commands.
- ```config.py```: Contains Donkey's configuration data, which can be overwritten from _cfgs_, so there is no need to edit config.py.
- ```manage.py```: Manages Donkey's train and drive modes.
- ```train.py```: Takes arguments specified during training.
- ```.gitignore```: This allows you to specify files and directories not to be pushed to the repository.

# リポジトリ紹介
このリポジトリは2021年6月のVirtual DonkeyCar Race racingに参加するためにDonkey v4.2 の走行データ、学習済みモデル、Donkeyのコンフィグデータを共有します。
このリポジトリは[hogenimushi/vdc2020_race03](https://github.com/hogenimushi/vdc2020_race03) を参考にして作っています。

## 準備
### Donkeycarをインストールする
1. [Install Donkeycar on Linux に沿ってインストールしてください](https://docs.donkeycar.com/guide/host_pc/setup_ubuntu/)
1. [Donkey Simulator に沿ってインストールしてください](https://docs.donkeycar.com/guide/simulator/)  

### 注意
**このリポジトリの自動運転モデルを利用するにはtensorflowのバージョンは2.4.0へアップグレードしてください。**  
conda内のtensorflowのバージョン確認方法
```shell
conda list | grep tensor
```  
もし、tensorflow == 2.2.0の場合
```shell
conda uninstall tensorflow
pip install tensorflow==2.4.0
GPUがある場合は
pip install tensorflow-gpu==2.4.0
```

### シミュレータをインストールする
```shell
make install_sim
```

### 走行データを得る
```shell
make record
```

### Exampleデータを使ってモデルを作る
models/test.h5を作ります  
```shell
make test_train
```

### test.h5を使って自動運転
```shell
cp save_model/test.h5 models/
make test_run
```

### その他
Makefileをご覧ください。

## 各ディレクトリとファイルの説明
- ```cfgs```: Donkeyのコンフィグデータが入っています。コンフィグデータとは、車体設定や、機械学習時の設定などが書いてあります。
- ```data```: シミュレータでの走行データが書き込まれます。共有したい走行データは*save_data*へ移動しましょう。
- ```models```: 学習後にモデルが出力されるディレクトリです。共有したいモデルは*save_model*へ移動しましょう。
- ```save_data```: Donkeyの走行データをみんなと共有します。
- ```save_model```: Donkeyの学習済モデルをみんなと共有します。
- ```Makefile```: 学習済みモデルの再現性を主な目的として使っています。具体的には、学習済みモデルに使ったデータを記述します。また、長いコマンドを独自のコマンドで呼び出すことができます。
- ```config.py```: Donkeyのコンフィグデータが記されています。*cfgs*から上書きできるため、config.pyを編集する必要はありません。
- ```manage.py```: Donkeyのtrainやdriveモードを管理しています。
- ```train.py```: 学習時に指定した引数を受け取ります。
- ```.gitignore```: リポジトリにpushしないファイルやディレクトリを指定できます。
