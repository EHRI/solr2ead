#!/bin/bash

cd eadtest/ead
for FILE in `ls ./`; do
    xmllint --noout --schema ead.xsd $FILE/* 2> validation-$FILE.log
done
