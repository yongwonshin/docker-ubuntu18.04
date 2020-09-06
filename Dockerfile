FROM ubuntu:18.04
LABEL author="ywshin@postech.ac.kr"

RUN set -e
RUN set -u

# Install libraries for building c++ core on ubuntu
RUN \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get install -y software-properties-common && \
  apt-get install -y --no-install-recommends \
    git make libgtest-dev cmake wget unzip libtinfo-dev libz-dev libcurl4-openssl-dev libopenblas-dev g++ sudo zsh python-pip python3-pip python-dev python3-dev python3-numpy python-numpy git vim curl wget build-essential tmux htop unzip locales ninja-build python3-setuptools python-setuptools build-essential ocl-icd-libopencl1 ninja-build ocl-icd-libopencl1 ocl-icd-dev ocl-icd-opencl-dev libhwloc-dev zlib1g zlib1g-dev clinfo dialog apt-utils pkg-config ssh
RUN apt-get install -y net-tools

# Set environment variables
ENV HOME /root

# Define working directory
WORKDIR /root

# zsh settings
RUN chsh -s /usr/bin/zsh root
RUN curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
RUN git clone https://github.com/zsh-users/zsh-autosuggestions .oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git .oh-my-zsh/custom/plugins/zsh-syntax-highlighting
COPY config/.zshrc .zshrc

# git settings
COPY config/.gitconfig .gitconfig

# vim settings
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY config/.vimrc .vimrc

# Create user
# RUN \
#   adduser --gecos '' --disabled-password --uid 1000 ywshin && \
#   usermod -aG sudo ywshin && \
#   echo "ywshin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Cleanup
# RUN rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]