for FILE in `ls -tUr ~/Projects/Thing/backups/`
do
	rm -r ./Thing/
	mkdir ./Thing/
	unar ~/Projects/Thing/backups/${FILE} -o ./Thing/ -D
	git add ./Thing/*       
	git commit -m ${FILE/"Thing_"/""/".rar"/""} 
done
