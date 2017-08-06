# VIM plugins

* Vundle

* vim-airline

  * The plugin still needs to install a patched font for
those powerline symbols to appear. I simply downloaded the
[powerline/fonts](https://github.com/powerline/fonts) package and run
`./install.sh` from it.

  * Initially after installing `vim-airline` and patched powerline
fonts, it didn't work as there was no color. This is answered in the
[FAQ](https://github.com/bling/vim-airline/wiki/FAQ) which cited [this
article](http://vim.wikia.com/wiki/256_colors_in_vim). However, when I added
the code block into my `~/.profile` file, it didn't work. I had to explicitly
include the following line in my `~/.bashrc` file. > export TERM=xterm-256color
* solarized

  * I cloned the
[vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
package and copied the `solarized.vim` file into the `~/.vim/colors/` folder
which I had to first create since it didn't exist.

  * Configuring vim to use `solarized` theme is rather straightforward. I just
copied the following code blocks into my `.vimrc`.

    > syntax enable 
    > set background=dark 
    > colorscheme solarized 

  * When I opened vim in the terminal after the installation and configuration,
the color looked very off. It seems to be a common issue. The author mentioned
it explicitly in the package documentation.

    I tried two methods to fix this.

    * I installed `terminator` and used the
[terminator-solarized](https://github.com/ghuntley/terminator-solarized) package
to set its color scheme also to `solarized` for it to appear correctly in vim.

    * I cloned the
[gnome-terminal-colors-solarized](https://github.com/Anthony25/gnome-terminal-co
lors-solarized) package and ran `~/install.sh`. It worked very well for the
default gnome-terminal.
