#!/bin/bash

PPAs=(
    ppa:thomas-schiex/blender               #blender
    ppa:otto-kesselgulasch/gimp             #gimp-gmic
    ppa:inkscape.dev/stable                 #inkscape
    ppa:makehuman-official/makehuman-11x    #makehuman
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

======================================================================
 Add ppa for ${f##*/}
======================================================================

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

======================================================
 Installsing $f
======================================================

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
