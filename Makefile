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

# +------------------------------------------------------+ #
# + Argument                                             + #
# +------------------------------------------------------+ #

PROJECT=blank_project

# container name 
NAME=$(PROJECT)
NAME_INST=$(NAME)_inst
VERSION=1.00

# common user setting
USER_NAME=ordinary_user
USER_PASSWD=passwd
LOGIN_SHELL=tcsh

# mount host directory
# -v(docer option) AAA(host_dir):BBBB(container_target)
MOUNT_DIR=\
	-v /mnt/d/Work/:/home/$(USER_NAME)/Work \

# +------------------------------------------------------+ #
# + Command                                              + #
# +------------------------------------------------------+ #

build:
	figlet $(PROJECT)
	docker build \
		-t $(NAME):$(VERSION) . \
		--build-arg user_name=$(USER_NAME) \
		--build-arg user_passwd=$(USER_PASSWD) \
		--build-arg lang=$(LANG)

restart:
	stop start

start:
	docker run -itd \
		--name $(NAME_INST) \
		$(MOUNT_DIR) \
		$(NAME):$(VERSION) $(LOGIN_SHELL)

clean:
	docker rm -f $(NAME_INST)
	docker rmi $(NAME):$(VERSION)

stop:
	docker rm -f $(NAME_INST)

attach:
	figlet $(PROJECT)
	docker exec -it \
		-u $(USER_NAME) \
		$(NAME_INST) $(LOGIN_SHELL)

logs:
	docker logs $(NAME_INST)
