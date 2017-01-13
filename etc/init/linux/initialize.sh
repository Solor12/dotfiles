#!/bin/bash

# 『デスクトップ』『音楽』などの日本語フォルダー名を英語表記にする
# （ダイアログを自動化する方法が分からないので最初に行う）
cat <<EOF
##########################################
# Change names of directories to English #
##########################################
EOF

LANG=C xdg-user-dirs-gtk-update



# ppaの追加
#echo "Add PPAs"
#PPAs=`tr '\n' ' ' < "$DOTPATH"/etc/init/assets/apt/ppa.list`
#for f in $PPAs
#do
#	yes | sudo apt-add-repository $f;
#done
#echo "Finish adding PPAs"



# packageのアップデート及びアップグレード
cat <<EOF
#############################
# Update & upgrade packages #
#############################
EOF

sudo apt -y update
sudo apt -y upgrade



# 不要な依存関係の削除
cat <<EOF
######################
# Remove unnecessary #
######################
EOF

yes | sudo apt autoremove



## debパッケージの依存関係の解決
#echo "Solve dependancies of dev-packages"
#yes | sudo apt install -f

# login画面の背景画像の固定



# ゲストセッションを無効化
cat <<EOF
#########################
# Disable guest-session #
#########################
EOF

yes | sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'



# シャットダウンに時間がかかる事がある現象に対応する
cat <<EOF
########################
# Make shutdown faster #
########################
EOF

sudo sed -i 's/#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=10s/g' /etc/systemd/system.conf



## aptでのpackageのインストール
#echo "Start installing apt-packages"
#APT_PACKAGES=`tr '\n' ' ' < "$DOTPATH"/etc/init/assets/apt/apt_package.list`
###yes | sudo apt install $APT_PACKAGES && echo "Finish installing apt-packages"
#
#for f in $APT_PACKAGES
#do
#    yes | sudo apt install $f
#done
#echo "Finish installing apt-packages"

## aptパッケージが用意されていないアプリをリストファイルからダウンロード（$HOME/Downloadsに保存）
#echo "Start downloading apps"
#yes | wget -i "$DOTPATH"/etc/init/linux/wget.list -P "$HOME"/Downloads
#echo "Finish downloading apps"

## debパッケージのインストール
#echo "Start installing dev-packages"
#DPKGS=`tr '\n' ' ' < "$DOTPATH"/etc/init/linux/dpkg.list`
#for f in $DPKGS
#do
#	yes | sudo dpkg -i "$HOME"/Downloads/$f;
#done
#echo "Finish installing apps"



# launcherのAmazonをシステムから削除
cat <<EOF
#################
# Remove Amazon #
#################
EOF

yes | sudo apt remove unity-webapps-common



# 全体的なキーバインドをEmacsにする
cat <<EOF
###############################
# Make Emacs like keybindings #
###############################
EOF

gsettings set org.gnome.desktop.interface gtk-key-theme Emacs



# xkbでキー配列を変更する
cat <<EOF
#########################
# Remap physical keymap #
#########################
EOF

yes | sudo mv /usr/share/X11/xkb/keycodes/evdev /usr/share/X11/xkb/keycodes/bk-evdev && sudo cp evdev /usr/share/X11/xkb/keycodes/

## capslockにreturnキーを割り当てる
yes | sudo mv /usr/share/X11/xkb/symbols/jp /usr/share/X11/xkb/symbols/bk-jp && sudo cp jp /usr/share/X11/xkb/symbols/



# マウスのスクロール方向を反転(デバイス名は必要に応じて変える)
cat <<EOF
############################
# Reverse scroll direction #
############################
EOF

yes | sudo cp 20-natural-scrolling.conf /usr/share/X11/xorg.conf.d/
xinput set-prop "Logitech Wireless Mouse" "Evdev Scrolling Distance" -1 -1 -1



# googleドライブをマウントする
#gnome-control-center online-accounts

# chromeIPassを使えるようにする
#wget -O "$HOME"/Downloads/keepasshttp.zip https://github.com/pfn/keepasshttp/archive/master.zip
#unzip "$HOME"/Downloads/keepasshttp.zip -d "$HOME"/Downloads
#sudo mv "$HOME"/Downloads/keepasshttp-master/KeePassHttp.plgx /usr/lib/keepass2/


## 手動でやる必要のあることを表示
#cat "$DOTPATH"/etc/init/linux/manual_setup.list
