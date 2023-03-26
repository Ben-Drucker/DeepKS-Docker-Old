# Setup
FROM ubuntu:23.04
RUN apt-get update && apt-get install -y sudo zsh
ARG UN=dockeruser
RUN useradd -ms /bin/zsh $UN
WORKDIR /home/$UN
RUN mkdir docker-build
WORKDIR /home/$UN/docker-build

# Install apt-get packages
RUN apt-get update && apt-get install -y \
    wget \
    sudo \
    zsh \
    build-essential \
    aptitude \
    bsdutils \
    csh \
    dash \
    debconf \
    debianutils \
    diffutils \
    dpkg \
    e2fsprogs \
    emboss \
    findutils \
    font-manager \
    fontforge \
    gcc-12-base \
    git \
    gpg \
    gpgv \
    grep \
    gzip \
    hostname \
    htop \
    init-system-helpers \
    libacl1 \
    libapt-pkg6.0 \
    libattr1 \
    libaudit-common \
    libaudit1 \
    libblkid1 \
    libbz2-1.0 \
    libc-bin \
    libc6 \
    libcap-ng0 \
    libcap2 \
    libcom-err2 \
    libcrypt1 \
    libcurl4-openssl-dev \
    libdb5.3 \
    libdebconfclient0 \
    libext2fs2 \
    libffi8 \
    libgcc-s1 \
    libgcrypt20 \
    libgmp10 \
    libgnutls30 \
    libgpg-error0 \
    libhogweed6 \
    libidn2-0 \
    liblz4-1 \
    liblzma5 \
    libmd0 \
    libmount1 \
    libncurses6 \
    libncursesw6 \
    libnettle8 \
    libp11-kit0 \
    libpam-modules \
    libpam-modules-bin \
    libpam-runtime \
    libpam0g \
    libpcre2-8-0 \
    libpcre3 \
    librsvg2-dev \
    libseccomp2 \
    libselinux1 \
    libsemanage-common \
    libsemanage2 \
    libsepol2 \
    libsmartcols1 \
    libss2 \
    libssl-dev \
    libstdc++6 \
    libsystemd0 \
    libtasn1-6 \
    libtinfo6 \
    libudev1 \
    libunistring2 \
    libuuid1 \
    libxml2-dev \
    libxt-dev \
    libxxhash0 \
    libzstd1 \
    logsave \
    lsb-base \
    man-db \
    mawk \
    mount \
    ncurses-base \
    ncurses-bin \
    openssl \
    passwd \
    perl-base \
    procps \
    sed \
    sensible-utils \
    software-properties-common \
    sysvinit-utils \
    tar \
    ubuntu-keyring \
    unzip \
    usrmerge \
    util-linux \
    util-linux-extra \
    vim \
    zip \
    zlib1g

# Install latest python version and pip and pip packages
RUN apt-get update -y && apt-get install -y python3 && apt-get install -y --only-upgrade python3 && apt-get install -y python3-pip && apt-get install -y python3-venv

# Clone DeepKS
WORKDIR /home/$UN
RUN git clone https://github.com/Ben-Drucker/DeepKS.git

WORKDIR /home/$UN/docker-build
RUN mkdir /home/$UN/python_env && python3 -m venv /home/$UN/python_env
RUN ["/bin/zsh", "-c", "source /home/$UN/python_env/bin/activate && pip install -r /home/$UN/DeepKS/requirements.txt"]
COPY "install-R-script.sh" "install-R-script.sh"
RUN chmod +x install-R-script.sh
RUN ./install-R-script.sh
RUN chown -R $UN /usr/local/lib/R/site-library /home/$UN/DeepKS /home/$UN/python_env