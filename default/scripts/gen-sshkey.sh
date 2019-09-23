ssh-keygen -t rsa -b 4096 -C "daniel@traveltek.net" -f $HOME/.ssh/id_rsa -N ''
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub

