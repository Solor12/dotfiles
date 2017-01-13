#!/bin/bash

PPAs=(
    #albert
    ppa:nilarimogard/webupd8
    #ffmpeg
    ppa:jonathonf/ffmpeg-3
    #handbrake
    ppa:stebbins/handbrake-releases
    #indicator-sysmonitor
    ppa:fossfreedom/indicator-sysmonitor
    #veracrypt
    ppa:unit193/encryption
    #wine
    ppa:ubuntu-wine/ppa
)

cat <<EOF
#############################
#                           #
# Start adding utility PPAs #
#                           #
#############################
EOF

for f in ${PPAs[@]}
do
    cat <<EOF
============================
 Add ppa for ${f##*/}
============================
EOF
    yes | sudo apt-add-repository $f;
done

cat <<EOF
##############################
#                            #
# Finish adding utility PPAs #
#                            #
##############################
EOF

sudo apt -y update

#apt_packages to install
APTs=(
	  albert
	  build-essential
	  clamtk
	  compizconfig-settings-manager
	  dconf-tools
	  docky
	  easystroke
	  exfat-fuse
	  exfat-utils
	  ffmpeg
	  gdebi
	  gloobus-preview
	  gloobus-sushi
	  gufw
	  handbrake
	  indicator-multiload
	  indicator-sysmonitor
	  keepassx
	  nautilus-dropbox
	  p7zip-full
	  python-gi
	  unity-tweak-tool
	  unrar
	  veracrypt
	  virtualbox
	  vlc
	  wine
	  winetricks
	  xdotool
)

cat <<EOF
#############################################
#                                           #
# Start installing apt_packages for utility #
#                                           #
#############################################
EOF

for f in ${APTs[a]}
do
    cat <<EOF
=======================
 Installing $f
=======================
EOF
    yes | sudo apt install $f
done

cat <<EOF
##############################################
#                                            #
# Finish installing apt_packages for utility #
#                                            #
##############################################
EOF
