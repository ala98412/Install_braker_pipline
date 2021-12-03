# Install_braker_pipline

此pipeline目的為自動安裝braker以及其所需工具。  
將 Install_braker.sh 以及 Download_GeneMarkEX.py 搬去想要安裝的資料夾下，Install_braker.sh會將當前目錄設定為主要路徑，安裝並將環境變數設定完成。

需要注意的是，有些braker需要的perl模組需要sudo權限。

# Install
```
chmod +x ./Install_braker.sh
sudo ./Install_braker.sh
source ~/.bashrc
```
