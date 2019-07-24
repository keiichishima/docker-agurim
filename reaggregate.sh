#!/bin/sh

docker run --rm -v ${PWD}/datasets:/var/www/datasets keiichi/agurim /agurim-master/scripts/reaggregate.sh $@
