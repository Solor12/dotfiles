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

# aptでのpackageのインストール
APT_PACKAGES=`tr '\n' ' ' < apt_package.list`
yes | sudo apt install $APT_PACKAGES

# aptパッケージが用意されていないアプリをリストファイルからダウンロード（$HOME/Downloadsに保存）
yes | wget -i wget.list -P "$HOME"/Downloads

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

# 設定ファイルのシンボリックリンクをホームディレクトリに作成
sh install.sh

# 手動でやる必要のあることを表示
cat manual_setup.list
