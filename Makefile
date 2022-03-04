all: checkout position update
	echo "Done"

list:
	git submodule

position:
	git submodule foreach git co master

checkout:
	git submodule foreach git checkout -- .

update:
	git submodule foreach git pull
