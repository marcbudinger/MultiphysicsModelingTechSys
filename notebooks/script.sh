#!/bin/bash
cd "$(dirname "$0")"
jupyter nbconvert --config jekyll
echo 
echo "Conversion terminée"
echo 

if command -v git  &>/dev/null; then
	read -r -p "Actualiser le dépôt? [y/N] " response
	case "$response" in
		[yY][eE][sS]|[yY]) 
			cd "../"
			git pull
			git add .
			git commit -a -m "commit"
			git push
			echo 
			echo "Dépôt GitHub actualisé !"
			echo 
			;;
		*)
			echo 
			echo "Pensez à actualiser le dépôt manuellement !"
			echo 
			;;
	esac
$SHELL
else
	echo 
	echo "Actualisation automatique impossible : Git non installé. Pensez à  actualiser le dépôt manuellement !"
	echo 

$SHELL
fi


 