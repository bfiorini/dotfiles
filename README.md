dotfiles
========

My awesome config files.

```bash
sudo ln -s /home/b/.vimrc /root/.vimrc
sudo ln -s /home/b/.vim /root/.vim
sudo ln -s /home/b/.zshrc /root/.zshrc
sudo ln -s /home/b/.oh-my-zsh /root/.oh-my-zsh
sudo ln -s /home/b/.custom-oh-my-zsh /root/.custom-oh-my-zsh
```

Initialize submodules:
```bash
git submodule update --init --recursive
```

Update submodules:
```bash
git submodule foreach git pull origin master
```

---

Apps:

* apt-listbugs
* apt-listchanges
* chromium
* docker-ce
* dropbox
* firefox-esr
* firmware-linux, firmware-linux-free, firmware-linux-nonfree
* gh
* git
* google-chrome-stable
* helm
* htop
* intelliJ
* jq
* kubeadm, kubectl, kubectx, kubelet
* meld
* nodejs
* rar, tar, 7zip, unrar
* slack-desktop
* spotify-client
* tar
* transmission
* util-linux
* vim
* virtualenv, python
* vlc
* zsh

Bin:
* bbc
* cqlsh
* istioctl
* landing ?
* op 1p
* stern
* terraform

