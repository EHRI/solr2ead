#!/bin/bash

FILE=$1

[ -e eadtest ] && rm -r eadtest
mkdir eadtest
cd eadtest
java -Xmx1g -jar ../saxon9he.jar -explain -traceout:trace.txt -s:../$FILE -xsl:../solr2ead.xsl
cd ..
for FILE in `ls eadtest/ead/`; do
    xmllint --noout --schema ead.xsd eadtest/ead/$FILE/* 2>> validation.log
done
