dotfiles
========

My awesome config files.

```bash
sudo ln -s /home/b/.vimrc /root/.vimrc
sudo ln -s /home/b/.vim /root/.vim
sudo ln -s /home/b/.zshrc /root/.zshrc
sudo ln -s /home/b/.oh-my-zsh /root/.oh-my-zsh
```

Initialize submodules:
```bash
git submodule update --init --recursive
```

Update submodules:
```bash
git submodule foreach git pull origin master
```
