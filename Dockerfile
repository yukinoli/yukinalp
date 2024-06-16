FROM alpine:3.19.0 

RUN apk update && \
    apk add --no-cache \
    openssl \
    ncurses \
    wget \
    curl \
    python3 \
    neovim \
    tmux \
    zsh \
    git \
    build-base

RUN adduser -D yukinoli -s /usr/bin/sh 

USER yukinoli

RUN wget https://raw.githubusercontent.com/yukinoli/MesDocker/main/.tmux.conf -O /home/yukinoli/.tmux.conf && \ 
    git clone https://github.com/tmux-plugins/tpm /home/yukinoli/.tmux/tpm && \
    mkdir /home/yukinoli/mnt

RUN cd $HOME && \
    git clone https://github.com/NvChad/starter /home/yukinoli/.config/nvim && \
    nvim --headless +qa 

WORKDIR /home/yukinoli
