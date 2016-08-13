#!/bin/bash

# 『デスクトップ』『音楽』などの日本語フォルダー名を英語表記にする
# （ダイアログを自動化する方法が分からないので最初に行う）
LANG=C xdg-user-dirs-gtk-update


# ppaの追加
PPAs=`tr '\n' ' ' < ppa.list`
for f in $PPAs
do
	yes | sudo apt-add-repository $f;
done

# packageのアップデート
yes | sudo apt update

# package及びソフトウェアのアップグレード
yes | sudo apt upgrade

# login画面の背景画像の固定

# ゲストセッションを無効化
yes | sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'

# シャットダウンに時間がかかる事がある現象に対応する
sudo sed -i 's/#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=10s/g' /etc/systemd/system.conf

# aptでのpackageのインストール
APT_PACKAGES=`tr '\n' ' ' < apt_package.list`
yes | sudo apt install $APT_PACKAGES

# aptパッケージが用意されていないアプリをリストファイルからダウンロード（$HOME/Downloadsに保存）
yes | wget -i wget.list -P "$HOME"/Downloads

# debパッケージの依存関係の解決
yes | sudo apt install -f

# debパッケージのインストール
DPKGS=`tr '\n' ' ' < dpkg.list`
for f in $DPKGS
do
	yes | sudo dpkg -i "$HOME"/Downloads/$f;
done

# launcherのAmazonをシステムから削除
yes | sudo apt-get remove unity-webapps-common

# 不要な依存関係の削除
yes | sudo apt autoremove

# 全体的なキーバインドをEmacsにする
gsettings set org.gnome.desktop.interface gtk-key-theme Emacs

# xkbでキー配列を変更する
yes | sudo mv /usr/share/X11/xkb/keycodes/evdev /usr/share/X11/xkb/keycodes/bk-evdev && sudo cp evdev /usr/share/X11/xkb/keycodes/

# マウスのスクロール方向を反転(デバイス名は必要に応じて変える)
yes | sudo cp 20-natural-scrolling.conf /usr/share/X11/xorg.conf.d/
xinput set-prop "Logitech Wireless Mouse" "Evdev Scrolling Distance" -1 -1 -1

# 設定ファイルのシンボリックリンクをホームディレクトリに作成
#sh install.sh

# 手動でやる必要のあることを表示
cat manual_setup.list
