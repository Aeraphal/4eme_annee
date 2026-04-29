#!/bin/bash

function is_number()
{
	re='^[+-]?[0-9]+([.][0-9]+)?$'
	if ! [[ $1 =~ $re ]] ; then
		return 1
	else
		return 0
	fi
}


is_number $1

if [ _$? = "_0" ]; then
        echo "Vous avez mis un nombre!"
else
        echo "ERREUR!"
fi
