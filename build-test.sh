#!/bin/bash

[ -e eadtest ] && rm -r eadtest
mkdir eadtest
cd eadtest
java -Xmx1g -jar ~/Applications/saxon9he.jar -explain -traceout:trace.txt -s:/Users/ben/Documents/Projecten/EHRI/ushmm/1000docs2.xml -xsl:../solr2ead.xsl
cd ..
for FILE in `ls eadtest/ead/`; do
    xmllint --noout --schema ead.xsd eadtest/ead/$FILE/* 2>> validation.log
done