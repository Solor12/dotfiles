#!/bin/bash

sudo apt -y update

APTs=(
	  emacs
    git
	  tig
	  tmux
	  tree
	  vim
    zsh
)




cat <<EOF

#########################################
#                                       #
# Start installing apt_packages for CLI #
#                                       #
#########################################

EOF

for f in ${APTs[@]}
do
    cat <<EOF

========================================
 Installing $f
========================================

EOF
    yes | sudo apt install $f
done

cat <<EOF

##########################################
#                                        #
# Finish installing apt_packages for CLI #
#                                        #
##########################################

EOF



#Assign zsh as a login shell
cat <<EOF

###############################
#                             #
# Assign zsh as a login shell #
#                             #
###############################

EOF



zsh_path="$(which zsh)"

# Check /etc/shells
if ! grep -xq "${zsh_path:=/bin/zsh}" /etc/shells; then
    exit 1
fi

if [ -x "$zsh_path" ]; then
    # Changing for a general user
    if chsh -s "$zsh_path" "${USER:-root}"; then
        echo "Change shell to $zsh_path for ${USER:-root} successfully"
    else
        exit 1
    fi

    # For root user
    if [ ${EUID:-${UID}} = 0 ]; then
        if chsh -s "$zsh_path" && :; then
            echo "[root] changes shell to $zsh_path successfully"
        fi
    fi
else
    echo "$zsh_path: invalid path"
    exit 1
fi
