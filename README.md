# nvidia-vaapi-driver-install-script-for-deepin-linux
A bash script for installing nvidia-vaapi-driver and dependencies for Deepin Linux

The nvidia-vaapi-driver : https://github.com/elFarto/nvidia-vaapi-driver

All source codes are compiled under deepin Linux 20.5 and packaged into DEB. The directory contains dependencies libva and vainfo, which have also been packaged into DEB packages.

This script contains all DEB packages are only suitable to use NVIDIA driver in deepin source, Please do not use this script and DEB package for the ".run" driver (except manually unpacking and extracting .so files).

Update NVIDIA vaapi driver to 0.0.6 and put it in the script directory/deb

The dependent packages that are not in the source are placed in the script directory/depends to execute the script/install.sh automatically install dependencies and ontologies:

chmod +x install.sh

sudo ./install.sh

If you need to compile by yourself, you can see here: https://bbs.deepin.org/post/233052

全部源代码在deepin linux 20.5下编译并且打包成deb，目录中包含依赖libva、vainfo也已打包成deb包。

本脚本包含所有deb打包只适合使用deepin源里的nvidia驱动，“.run”驱动请不要使用本脚本和deb包（手动解包提取.so文件除外）。

nvidia-vaapi-driver更新至0.0.6，放在脚本目录/deb下

源里没有的依赖包放在脚本目录/depends下，执行脚本./install.sh自动安装依赖和本体：

chmod +x install.sh

sudo ./install.sh

如果需要自己编译可以看这里：https://bbs.deepin.org/post/233052
