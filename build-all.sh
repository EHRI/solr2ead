#!/bin/bash

[ -e eadtest ] && rm -r eadtest
mkdir eadtest
cd eadtest
java -Xmx1g -jar ~/Applications/saxon9he.jar -explain -traceout:trace.txt -s:/Users/ben/Documents/Projecten/EHRI/ushmm/emu_web20140619.xml -xsl:../solr2ead.xsl
cd ..

