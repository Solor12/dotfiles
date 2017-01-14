#!/bin/bash

PPAs=(
    #KeePass2
    ppa:jtaylor/keepass
    #Systemback
    ppa:nemh/systemback
    #SMPlayer
    ppa:rvm/smplayer
)

cat <<EOF
###########################
#                         #
# Start adding extra PPAs #
#                         #
###########################
EOF

for f in ${PPAs[@]}
do
    cat <<EOF
===================================
 Add ppa for ${f##*/}
===================================
EOF
    yes | sudo apt-add-repository $f;
done

cat <<EOF
############################
#                          #
# Finish adding extra PPAs #
#                          #
############################
EOF

sudo apt -y update

# extra apt_packages to install
APTs=(
    goldendict
    gparted
    keepass2
    mono-complete
    smplayer
    systemback
)

cat <<EOF
######################################
#                                    #
# Start installign extra apt_packags #
#                                    #
######################################
EOF

for f in ${APTs[@]}
do
    cat <<EOF
==========================
 Instaling $f
==========================
EOF
    yes  sudo apt install $f
done

cat <<EOF
#######################################
#                                     #
# Finish installign extra apt_packags #
#                                     #
#######################################
EOF

# chromeIPassを使えるようにする
cat <<EOF
#######################
# Setting chromeIPass #
#######################
EOF

wget -O "$HOME"/Downloads/keepasshttp.zip https://github.com/pfn/keepasshttp/archive/master.zip
unzip "$HOME"/Downloads/keepasshttp.zip -d "$HOME"/Downloads
sudo mv "$HOME"/Downloads/keepasshttp-master/KeePassHttp.plgx /usr/lib/keepass2/
