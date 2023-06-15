#!/bin/bash

shell_renew(){
    cmd="apt-get"
    # 笨笨的检测方法
if [[ $(command -v apt-get) || $(command -v yum) ]] && [[ $(command -v systemctl) ]]; then

    if [[ $(command -v yum) ]]; then

        cmd="yum"

    fi
    if [[ $(command -v apt-get) ]]; then

        apt-get update -y
        apt-get install curl -y

    fi

else

    echo -e " 
    哈哈……这个 ${red}辣鸡脚本${none} 不支持你的系统。 ${yellow}(-_-) ${none}

    备注: 仅支持 Ubuntu 16+ / Debian 8+ / CentOS 7+ 系统
    " && exit 1

fi


    curl -o /root/.naive.sh https://raw.githubusercontent.com/hqqshe/nas_tools/main/NaiveProxy/naive1.sh 
    chmod +x /root/.naive.sh
    ln -s /root/.naive.sh /usr/bin/naive
    echo
    echo " naive 命令安装完毕，请使用naive进行操作。"
}

shell_renew


