#!/bin/bash
set -ex

export DEBIAN_FRONTEND=noninteractive

# Allow outdated OpenSSL versions for Ruby 2.3 and older.
echo "deb http://security.ubuntu.com/ubuntu cosmic-security main" >> /etc/apt/sources.list

apt-get update

# If you want custom PPAs, you need following.
apt-get install -qq software-properties-common

# Sudo is sudo…
apt-get install -qq sudo

# Following are required build tools:
# Autoconf is required to build GnuPG and RNP from Git sources.
# Build Essential is a collection of compilers and build tools.
# bzip2 is required to unpack GnuPG source packages.
# CMake is required to build RNP.
# cURL is necessary to download RVM.
# Git is obligatory for obvious reasons.
# Libtool is required to build RNP from Git sources.
apt-get install -qq autoconf build-essential bzip2 cmake curl git libtool

# Some GUI toolkit or framework is required to build GnuPG's Pinentry, and
# ncurses is the least demanding option.
apt-get install -qq libncurses5-dev

# These are RNP dependencies.
apt-get install -qq libbotan-2-dev libbz2-dev libjson-c-dev zlib1g-dev

# # Following are required to build Ruby from source, if needed.
# # RVM would install them anyway.
# apt-get install -qq gawk bison libffi-dev libgdbm-dev libsqlite3-dev \
# 	libyaml-dev pkg-config sqlite3 libgmp-dev libreadline-dev libssl-dev

# Vim is entirely optional, but I really love to have it.
apt-get install -qq vim
