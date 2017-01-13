#!/bin/bash


URLs=(
    https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    https://downloads.vivaldi.com/stable/vivaldi-stable_1.3.551.30-1_amd64.deb
    https://www.gitkraken.com/download/linux-deb/gitkraken-amd64.deb
)


DPKGs=(
    google-chrome-stable_current_amd64.deb
    vivaldi-stable_*_amd64.deb
    gitkraken-amd64.deb
)


# aptパッケージが用意されていないアプリをリストファイルからダウンロード（$HOME/Downloadsに保存）
cat <<EOF
##########################
#                        #
# Start downloading apps #
#                        #
##########################
EOF

for f in ${URLs[@]}
do
    cat <<EOF
============================
 Downloading ${f##*/}
============================
EOF
    yes | wget $f -P "$HOME"/Downloads
done

cat <<EOF
###########################
#                         #
# Finish downloading apps #
#                         #
###########################
EOF


## debパッケージの依存関係の解決
#cat <<EOF
#######################################
## Resolve dependance of deb_packages #
#######################################
#EOF
#
#yes | sudo apt update
#yes | sudo apt install -f


# debパッケージのインストール
cat <<EOF
#################################
#                               #
# Start installing deb-packages #
#                               #
#################################
EOF

for f in $DPKGs
do
    #yes | sudo dpkg -i "$HOME"/Downloads/$f;
    yes | sudo gdebi "$HOME"/Downloads/$f;
done

cat <<EOF
##################################
#                                #
# Finish installing deb-packages #
#                                #
##################################
EOF
