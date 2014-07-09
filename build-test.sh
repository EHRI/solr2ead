#!/bin/bash

[ -e eadtest ] && rm -r eadtest
mkdir eadtest
cd eadtest
java -Xmx1g -jar ~/Applications/saxon9he.jar -s:/Users/ben/Documents/Projecten/EHRI/ushmm/3000docs.xml -xsl:../solr2ead.xsl
cd ..
xmllint --noout --schema ead.xsd eadtest/ead/*.xml 2> ead-validation-results.txt
