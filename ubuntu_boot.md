# Ubuntu set up

## Applications

* Download and install [chrome](https://www.google.com/chrome/browser/desktop) using Firefox
* Install git
    * `$ sudo apt install git`
    * Configure git
        * `$ git config --global user.email "genrong.meng@gmail.com"`
        * `$ git config --global user.name "Jarod G.R. Meng"`
* Create a `github` folder in home directory
    * `$ mkdir ~/github && cd ~/github`
* Clone `dotfiles` into `~/github`
    * `$ git clone https://github.com/jarodmeng/dotfiles.git`
* Link `dotfiles/vimrc` to `~/.vimrc`
    * `$ ln -s ~/github/dotfiles/vimrc ~/.vimrc`
* Install Vim
    * Install vim-gnome as it's configured with clipboard feature
        * `$ sudo apt install vim-gnome`
    * Install [Vundle](https://github.com/VundleVim/Vundle.vim)
        * `$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
    * Install all plugins in Vim
        * `:PluginInstall`
* Use `gruvbox` color scheme in Gnome terminal
    * `$ git clone https://github.com/metalelf0/gnome-terminal-colors.git`
    * Create a `gruvbox dark` profile in terminal
    * `$ ./install.sh`
    * Use `gruvbox dark` as the default profile
* Install patched fonts for `vim-airline`
    * `$ git clone https://github.com/powerline/fonts.git`
    * `$ ./install.sh`
    * Select a powerline font for the `gruvbox dark` profile in terminal
* Set up SSH with github
    * Main [help page](https://help.github.com/articles/connecting-to-github-with-ssh/)
    * Generate a new SSH key
        * `$ ssh-keygen -t rsa -b 4096 -C "genrong.meng@gmail.com"`
    * Start the ssh-agent in the background
        * `$ eval "$(ssh-agent -s)"`
    * Add the created SSH key to the ssh-agent (assuming the name of the private key file is `id_rsa`)
        * `$ ssh-add ~/.ssh/id_rsa`
    * Install `xclip`
        * `$ sudo apt-get install xclip`
    * Copy the contents of the public key file to clipboard (assuming the name of the public key file is `id_rsa.pub`)
        * `$ xclip -sel clip < ~/.ssh/id_rsa.pub`
    * Add the public key file content to Github 
* Install tmux
    * `$ sudo apt install tmux`
* Install par
    * `$ sudo apt install par`
* Install R
    * Main [help page](https://cran.r-project.org/bin/linux/ubuntu/README.html)
    * Add apt key
        * `$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9`
    * Add CRAN's source to `/etc/apt/sources.list`
        * `$ sudoedit /etc/apt/sources.list`
        * Add `deb https://cloud.r-project.org/bin/linux/ubuntu xenial/` to the end (assuming it's Ubuntu 16.04 LTS)
    * Update repo
        * `$ sudo apt-get update`
    * Install R
        * `$ sudo apt install r-base`
        * `$ sudo apt install r-base-dev`
* Install Go
    * Main [help page](https://golang.org/doc/install)
    * Download Go
        * `$ wget https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz`
    * Extract into `/usr/local`
        * `$ sudo tar -C /usr/local -xzf go1.8.linux-amd64.tar.gz`
    * Add `/usr/local/go/bin` to the `PATH` environment variable in `~/.profile`
        * `$ vim ~/.profile`
        * Add `export PATH=$PATH:/usr/local/go/bin` to the file
