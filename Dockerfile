FROM alpine:3.19.0 

RUN sed -i 's/#\(.*\/community\)/\1/' /etc/apk/repositories

RUN apk update && \
    apk add --no-cache \
    sudo \
    shadow \
    openssl \
    ncurses \
    wget \
    curl \
    python3 \
    neovim \
    tmux \
    zsh \
    git \
    build-base \
    bash

RUN adduser -D yukinoli -s /usr/bin/bash && \
    addgroup yukinoli wheel && \
    usermod --password $(echo 1234 | openssl passwd -1 -stdin) yukinoli && \
    echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel 

USER yukinoli

RUN wget https://raw.githubusercontent.com/yukinoli/MesDocker/main/.tmux.conf -O /home/yukinoli/.tmux.conf && \ 
    git clone https://github.com/tmux-plugins/tpm /home/yukinoli/.tmux/tpm && \
    mkdir /home/yukinoli/mnt

RUN cd $HOME && \
    git clone https://github.com/NvChad/starter /home/yukinoli/.config/nvim && \
    nvim --headless +qa 

WORKDIR /home/yukinoli
