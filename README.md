# nvidia-vaapi-driver-install-script-for-deepin-linux
A bash script for installing nvidia-vaapi-driver and dependencies for Deepin Linux

The nvidia-vaapi-driver : https://github.com/elFarto/nvidia-vaapi-driver

本脚本包含所有deb打包只适合使用deepin源里的nvidia驱动，.run驱动请不要使用本脚本和deb包（手动解包提取so文件除外）。

nvidia-vaapi-driver更新至0.0.6，放在脚本目录/deb下

源里没有的依赖包放在脚本目录/depends下，执行脚本./install.sh自动安装依赖和本体：

chmod +x install.sh
sudo ./install.sh

如果需要自己编译可以看这里：https://bbs.deepin.org/post/233052
