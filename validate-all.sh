#!/bin/bash

for FILE in `ls eadtest/ead/`; do
    xmllint --noout --schema ead.xsd eadtest/ead/$FILE/* 2>> validation.log
done
