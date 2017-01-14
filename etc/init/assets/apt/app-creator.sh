#!/bin/bash

PPAs=(
    #blender
    ppa:thomas-schiex/blender
    #gimp-gmic
    ppa:otto-kesselgulasch/gimp
    #inkscape
    ppa:inkscape.dev/stable
    #makehuman
    ppa:makehuman-official/makehuman-11x
)

cat <<EOF
#################################
#                               #
# Start adding PPAs for creator #
#                               #
#################################
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
##################################
#                                #
# Finish adding PPAs for creator #
#                                #
##################################
EOF

sudo apt -y update

APTs=(
	  audacity
	  blender
	  gimp-gmic
	  inkscape
	  makehuman
)

cat <<EOF
#############################################
#                                           #
# Start installing apt_packages for creator #
#                                           #
#############################################
EOF

for f in ${APTs[@]}
do
    cat <<EOF
===========================
 Installsing $f
===========================
EOF
    yes | sudo apt install $f
done

cat <<EOF
##############################################
#                                            #
# Finish installing apt_packages for creator #
#                                            #
##############################################
EOF
