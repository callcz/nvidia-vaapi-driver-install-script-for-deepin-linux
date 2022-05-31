#!/bin/bash

#upgrade installed packages
#i386 packages
i386_insed=$(apt list --installed $(ls depends/*i386.deb |cut -d/ -f2|cut -d_ -f1)|grep i386|cut -d/ -f1)
i386_ins=$(echo $i386_insed |sed 's/ /*i386.deb /g'|sed 's/$/&*i386.deb/g')
#write LOG file
apt list --installed $(ls depends/*i386.deb |cut -d/ -f2|cut -d_ -f1)|grep i386 > original_version.log
apt list --installed $(ls depends/*amd64.deb |cut -d/ -f2|cut -d_ -f1)|grep amd64 >> original_version.log
#amd64 packages
amd64_insed=$(apt list --installed $(ls depends/*amd64.deb |cut -d/ -f2|cut -d_ -f1)|grep amd64|cut -d/ -f1)
amd64_ins=$(echo $amd64_insed |sed 's/ /*amd64.deb /g'|sed 's/$/&*amd64.deb/g')

#echo upgrade-able packages
cat original_version.log
echo "
以上软件包将被以下软件包替代：
"

for i in $i386_ins $amd64_ins
    do
    ls depends/$i*|cut -d/ -f2
    test_ls=$?
    if [ $test_ls -eq 0 ] ;then
        n=$[$n+1]
        deb_ins=$deb_ins" "$(ls depends/$i)
    fi
done
#echo $deb_ins
echo ""
read -p "是否覆盖安装以上共$n个软件包?[y/N]" opt_v
opt="y Y n N"
if [ $opt_v ] ;then
    echo $opt_v
else
    opt_v=N
    echo "default-N"
fi
echo $opt |grep -q $opt_v
test_opt=$?
if [ $test_opt -eq 0 ] ;then
    echo $opt_v |grep -q -e y -e Y
    test_opt_v=$?
    if [ $test_opt_v -eq 0 ] ;then
        dpkg -i $deb_ins
        apt -f install
#check depends
	depends="libva-x11-2 libva2 libva-drm2 libva-glx2 libva-wayland2 vainfo"
	depends_insed=$(apt list --installed $depends|cut -d/ -f1|cut -d_ -f1)
	for i in $depends
	do
	    echo $depends_insed|grep -q -e $i
	    test_depends_insed=$?
	    if [ $test_depends_insed -ne 0 ] ;then
		    echo $i Missing
		    missing_depends=$missing_depends" "$i
		    n2=$[$n2+1]
	    else
		echo $i installed
	    fi
	done
	if [ $n2 ] ;then
        echo "将安装以下缺失依赖："
        echo $missing_depends
        read -p "是否安装共$n2个缺失依赖？[y/N]" opt_v1
        if [ $opt_v1 ] ;then
            echo $opt_v1
        else
            opt_v1=N
            echo "default-N"
        fi
        echo $opt |grep -q $opt_v1
        test_opt1=$?
        if [ $test_opt1 -eq 0 ] ;then
            echo $opt_v1 |grep -q -e Y -e y
            test_opt_v1=$?
            if [ $test_opt_v1 -eq 0 ] ;then
                echo $missing_depends
                for i in $missing_depends
                do
                    dpkg -i depends/$i*amd64.deb
                done
                apt -f install
            else
                echo "script stop"
                exit 0
            fi
        else
            echo "Please Enter \"Y\" for Yes or \"N\" for No, script stop"
            exit 0
        fi
    else
        echo "Depends check OK"
    fi
#install nvidia-vaapi-driver
    read -p "安装nvidia-vaapi-driver？[y/N]" opt_v2
    if [ $opt_v2 ] ;then
        echo $opt_v2
    else
	    opt_v2=N
	    echo "default-N"
	fi
	echo $opt |grep -q $opt_v2
	test_opt2=$?
	if [ $test_opt2 -eq 0 ] ;then
	    echo $opt_v2 |grep -q -e Y -e y
	    test_opt_v2=$?
	    if [ $test_opt_v2 -eq 0 ] ;then
	        dpkg -i deb/nvidia-vaapi-driver_0.0.6_deepin20.5.deb
            apt -f install
	    else
		echo "script stop"
		exit 0
	    fi
	else
	    echo "Please Enter \"Y\" for Yes or \"N\" for No, script stop"
	    exit 0
	fi
    else
        echo "script stop"
        exit 0
    fi
else
    echo "Please Enter \"Y\" for Yes or \"N\" for No, script stop"
    exit 0
fi
    
#dpkg -i $deb_ins
#dpkg -i /deb/*.deb
#apt -f install
