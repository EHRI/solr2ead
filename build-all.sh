#!/bin/bash

FILE=$1

[ -e eadtest ] && rm -r eadtest
mkdir eadtest
cd eadtest
#java -Xmx1g -jar ../saxon9he.jar -explain -traceout:trace.txt -s:$FILE -xsl:../solr2ead.xsl
java -Xmx1g -jar ../saxon9he.jar -s:../$FILE -xsl:../solr2ead.xsl
cd ..

