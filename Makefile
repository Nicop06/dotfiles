# This is a makefile to easily install the dotfiles in your home folder

DOTFILES=$(PWD)
CONFIG ?= $(HOME)/.config

all: installall

installall: install installvim

install:
	ln -s $(DOTFILES)/asoundrc $(HOME)/.asoundrc || true
	ln -s $(DOTFILES)/vimrc $(HOME)/.vimrc || true
	ln -s $(DOTFILES)/tmux.conf $(HOME)/.tmux.conf || true
	ln -s $(DOTFILES)/zshrc $(HOME)/.zshrc || true
	ln -s $(DOTFILES)/Xresources $(HOME)/.Xresources || true
	ln -s $(DOTFILES)/xinitrc $(HOME)/.xinitrc || true
	ln -s $(DOTFILES)/bashrc $(HOME)/.bashrc || true
	ln -s $(DOTFILES)/weechat $(HOME)/.weechat || true
	ln -s $(DOTFILES)/awesome $(CONFIG)/awesome || true
	ln -s $(DOTFILES)/openbox $(CONFIG)/openbox || true
	ln -s $(DOTFILES)/fbpanel $(CONFIG)/fbpanel || true
	ln -s $(DOTFILES)/luakit $(CONFIG)/luakit || true
	ln -s $(DOTFILES)/compton.conf $(CONFIG)/compton.conf || true

installvim: ; @which git > /dev/null
	mkdir -p $(HOME)/.vim/Vundle.vim || true
	git clone "https://github.com/gmarik/Vundle.vim" $(HOME)/.vim/bundle/Vundle.vim
	vim +PluginInstall
	$(HOME)/.vim/bundle/YouCompleteMe/install.py --clang-completer --system-libclang

clean:
	rm $(HOME)/.asoundrc || true
	rm $(HOME)/.vimrc || true
	rm $(HOME)/.tmux.conf || true
	rm $(HOME)/.zshrc || true
	rm $(HOME)/.Xresources || true
	rm $(HOME)/.xinitrc || true
	rm $(HOME)/.bashrc || true
	rm $(HOME)/.weechat || true
	rm $(CONFIG)/awesome || true
	rm $(CONFIG)/openbox || true
	rm $(CONFIG)/fbpanel || true
	rm $(CONFIG)/luakit || true
	rm $(CONFIG)/compton.conf || true
