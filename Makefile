all:

submodule-master:
	git submodule foreach git co master

submodule-update:
	git submodule foreach git pull
