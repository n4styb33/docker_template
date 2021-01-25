# +======================================================+ #
# +  ____   ___   ____ _  _______ ____                   + #
# + |  _ \ / _ \ / ___| |/ / ____|  _ \                  + #
# + | | | | | | | |   | ' /|  _| | |_) |                 + #
# + | |_| | |_| | |___| . \| |___|  _ <                  + #
# + |____/ \___/ \____|_|\_\_____|_| \_\                 + #
# +------------------------------------------------------+ #
# + Copyright (c) 2019- n4styb33                         + #
# + Released under the MIT license                       + #
# + https://opensource.org/licenses/mit-license.php      + #
# +======================================================+ #

# TODO: Edit section "Developtool install" to suit your needs.

FROM ubuntu:20.04

# +------------------------------------------------------+ #
# + Enviroment                                           + #
# +------------------------------------------------------+ #
# container identification flag
ENV DOCKER_ENV 1

# 一般ユーザ名，パスワード
ARG user_name
ARG user_passwd

# +------------------------------------------------------+ #
# + OS Enviroment                                        + #
# +------------------------------------------------------+ #
# apt update
RUN apt update && \
    apt upgrade -y

# Login shell
RUN apt install -y tcsh
RUN chsh -s /bin/tcsh root

# Timezone
RUN apt install -y tzdata
ENV TZ Asia/Tokyo

# Languedge
ARG lang
RUN apt install -y \
    locales \
    locales-all
ENV LANG "$lang"

# +------------------------------------------------------+ #
# + create common user                                   + #
# +------------------------------------------------------+ #
RUN apt install -y sudo 

RUN useradd -m "$user_name" && \
    echo "$user_name:$user_passwd" | chpasswd && \
    echo "$user_name ALL=(ALL) ALL" >> /etc/sudoers

RUN chsh -s /bin/tcsh "$user_name"

# +------------------------------------------------------+ #
# + common application install                           + #
# +------------------------------------------------------+ #
RUN apt install -y \
        vim \
        less


# +------------------------------------------------------+ #
# + Developtool install (Edit me)                        + #
# +------------------------------------------------------+ #
# Common
RUN apt install -y \
        git \
        graphviz

# Python
RUN apt install -y \
        python3.9 \
        python3-pip

RUN pip3 install --upgrade pip && \
    pip3 install --upgrade setuptools && \
    pip3 install \
        tensorflow \
        keras \ 
        pydot

# +------------------------------------------------------+ #
# + post processing                                      + #
# +------------------------------------------------------+ #
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*
