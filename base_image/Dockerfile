FROM ubuntu:focal

ENV USERNAME yoni


ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*
RUN echo "$USERNAME ALL=(ALL) NOPASSWD: ALL \nroot ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

# === Create User ===
RUN groupadd -g 1000 $USERNAME
RUN useradd -g 1000 $USERNAME

ENV HOME /home/$USERNAME
ENV TMP_SCRIPTS /tmp/scripts
RUN mkdir -p $HOME && chown $USERNAME:$USERNAME $HOME
RUN mkdir -p $TMP_SCRIPTS && chown $USERNAME:$USERNAME $TMP_SCRIPTS
USER $USERNAME
WORKDIR $HOME


# === Basic ubuntu packags ===
COPY --chown=$USERNAME:$USERNAME ubuntu_base_packages.sh $TMP_SCRIPTS/
RUN $TMP_SCRIPTS/ubuntu_base_packages.sh

# === Basic python packags ===
COPY --chown=$USERNAME:$USERNAME python_packages.sh $TMP_SCRIPTS/
RUN $TMP_SCRIPTS/python_packages.sh

# === Neovim Install ===
RUN mkdir -p $TMP_SCRIPTS/neovim && chown $USERNAME:$USERNAME $TMP_SCRIPTS/neovim
COPY --chown=$USERNAME:$USERNAME neovim $TMP_SCRIPTS/neovim
RUN $TMP_SCRIPTS/neovim/neovim_install.sh install
