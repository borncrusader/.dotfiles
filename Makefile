all: checkout position update
	echo "Done"

list:
	git submodule

position:
	git submodule foreach git checkout master

checkout:
	git submodule foreach git checkout -- .

update:
	git submodule foreach git pull
