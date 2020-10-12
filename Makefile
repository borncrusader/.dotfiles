all:

list:
	git submodule

position:
	git submodule foreach git co master

update:
	git submodule foreach git pull

do: position update
	echo "Done"
