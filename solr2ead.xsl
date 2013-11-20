<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>
    <xsl:output encoding="UTF-8"/>

<!--
//*****************************************************************************
// Copyright 2013 by Junte Zhang <junte.zhang@meertens.knaw.nl>
// Distributed under the GNU General Public Licence
//*****************************************************************************
-->

    <xsl:template match="/add">
        <xsl:for-each select="//doc">
            <xsl:variable name="parent" select="field[@name = 'assoc_parent_irn']/normalize-space()" />
            <xsl:if test="$parent != ''">
                <xsl:variable name="filename" select="concat('ead/', $parent, '/' , field[@name = 'id'] , '.xml')" />
                <xsl:result-document href="{$filename}" method="xml">
                    <ead>
                        <xsl:call-template name="header"/>
                        <xsl:call-template name="fm"/>
                        <xsl:call-template name="description"/>
                        <xsl:apply-templates />
                    </ead>
                </xsl:result-document>
            </xsl:if>
            <xsl:if test="not($parent)">
                <xsl:variable name="filename" select="concat('ead/', field[@name = 'id'] , '.xml')" />
                <xsl:result-document href="{$filename}" method="xml">
                    <ead>
                        <xsl:call-template name="header"/>
                        <xsl:call-template name="fm"/>
                        <xsl:call-template name="description"/>
                        <xsl:apply-templates />
                    </ead>
                </xsl:result-document>
            </xsl:if>

        </xsl:for-each>
    </xsl:template>

    <!-- header: <eadheader> -->
        <xsl:template name="header">
            <xsl:variable name="convertdate" select="current-dateTime()" />
            <eadheader>
                <eadid>
                    <xsl:value-of select="field[@name = 'id']/normalize-space()" />
                </eadid>
                <filedesc>
                    <titlestmt>
                        <titleproper>
                            <xsl:value-of select="field[@name = 'collection_name']/normalize-space()" />
                        </titleproper>
                        <subtitle>
                            <xsl:value-of select="field[@name = 'title']/normalize-space()" />
                        </subtitle>
                        <author>
                            <xsl:value-of select="field[@name = 'creator_name']/normalize-space()" />
                        </author>
                    </titlestmt>
                    <publicationstmt>
                        <publisher>EHRI partners</publisher>
                        <date><xsl:value-of select="field[@name = 'datetimemodified']/normalize-space()" /></date>
                    </publicationstmt>
                </filedesc>
                <profiledesc>
                    <creation>Automatically converted from USHMM's Solr index file using solr2ead.xsl (https://github.com/bencomp/solr2ead)
                        <date calendar="gregorian" era="ce"><xsl:attribute name="normal" select="$convertdate" />
                            <xsl:value-of select="$convertdate" />
                        </date>
                    </creation>
                    <langusage><language langcode="eng">English</language></langusage>
                </profiledesc>
            </eadheader>
        </xsl:template>

        <!-- frontmatter: <frontmatter> -->
            <xsl:template name="fm">
                <frontmatter>
                    <titlepage>
                        <titleproper>
                            <xsl:value-of select="field[@name = 'collection_name']/normalize-space()" />
                        </titleproper>
                        <publisher>
                        </publisher>
                        <date calendar="gregorian" era="ce">
                            <xsl:value-of select="field[@name = 'display_date']/normalize-space()" />
                        </date>
                    </titlepage>
                </frontmatter>
            </xsl:template>

            <!-- archival description: <archdesc> -->
                <xsl:template name="description">
                    <archdesc>
                        <did>
                            <xsl:variable name="rg" select="field[@name = 'rg_number']/normalize-space()" />
                            <unitid type="irn">
                                <xsl:value-of select="field[@name = 'irn']/normalize-space()" />
                            </unitid>
                            <xsl:if test="$rg != ''">
                                <unitid type="rg_number" label="Record group number">
                                    <xsl:value-of select="$rg" />
                                </unitid>
                            </xsl:if>
                            <unittitle>
                                <xsl:value-of select="field[@name = 'title']/normalize-space()" />
                            </unittitle>
                            <origination>
                                <xsl:value-of select="field[@name = 'provenance']/normalize-space()" />
                            </origination>
                            <unitdate calendar="gregorian" era="ce">
                                <xsl:value-of select="field[@name = 'display_date']/normalize-space()" />
                            </unitdate>
                            <physdesc>
                                <extent>
                                    <xsl:value-of select="field[@name = 'extent']/normalize-space()" />
                                </extent>
                                <physfacet>
                                    <xsl:value-of select="field[@name = 'dimensions']/normalize-space()" />
                                    <xsl:value-of select="field[@name = 'material_composition']/normalize-space()" />
                                </physfacet>
                            </physdesc>
                            <langmaterial>
                                <xsl:for-each select="field[@name = 'language']">
                                    <language><xsl:value-of select="./normalize-space()" /></language>
                                </xsl:for-each>
                            </langmaterial>
                            <arrangement>
                                <xsl:value-of select="field[@name = 'arrangement']/normalize-space()" />
                            </arrangement>
                            <origination>
                                <xsl:value-of select="field[@name = 'finding_aid_provenance']/normalize-space()" />
                            </origination>
                            <repository>

                            </repository>
                            <abstract>
                                <xsl:for-each select="field[@name = 'brief_desc']">
                                    <p>
                                        <xsl:value-of select="./normalize-space()" />
                                    </p>
                                </xsl:for-each>
                            </abstract>
                        </did>

                        <acqinfo>
                            <xsl:variable name="accession" select="field[@name = 'accession_number']/normalize-space()" />
                            <xsl:variable name="source" select="distinct-values(field[@name = 'acq_source']/normalize-space())" /> 
                            <xsl:variable name="credit" select="field[@name = 'acq_credit']/normalize-space()" />
                        
                            <xsl:if test="$accession != ''">
                                <p>Accession number: <xsl:copy-of select="$accession" /></p>
                            </xsl:if>
                            <xsl:if test="$source != ''">
                                <p>Source: <xsl:copy-of select="$source" /></p>
                            </xsl:if>
                            <xsl:if test="$credit != ''">
                                <p>Credit: <xsl:copy-of select="$credit" /></p>
                            </xsl:if>
                        </acqinfo>

                        <!-- biographic description of the person or organization -->
                        <bioghist>
                            <xsl:for-each select="field[@name = 'creator_bio']">
                                <p>
                                    <xsl:value-of select="./normalize-space()" />
                                </p>
                            </xsl:for-each>
                        </bioghist>

                        <!-- a detailed narrative description of the collection material -->
                        <scopecontent>
                            <xsl:for-each select="field[@name = 'scope_content']">
                                <p>
                                    <xsl:value-of select="./normalize-space()" />
                                </p>
                            </xsl:for-each>
                        </scopecontent>

                        <!-- description of items which the repository acquired separately but which are related to this collection, and which a researcher might want to be aware of -->
                        <relatedmaterial>

                        </relatedmaterial>

                        <accessrestrict>
                            <xsl:for-each select="field[@name = 'conditions_access']">
                                <p>
                                    <xsl:value-of select="./normalize-space()" />
                                </p>
                            </xsl:for-each>
                        </accessrestrict>

                        <userestrict>
                            <xsl:for-each select="field[@name = 'conditions_use']">
                                <p>
                                    <xsl:value-of select="./normalize-space()" />
                                </p>
                            </xsl:for-each>
                        </userestrict>

                        <!-- items which the repository acquired as part of this collection but which have been separated from it, perhaps for special treatment, storage needs, or cataloging -->
                        <separatedmaterial>
                        </separatedmaterial>

                        <!-- a list of subject headings or keywords for the collection, usually drawn from an authoritative source such as Library of Congress Subject Headings or the Art and Architecture Thesaurus
accessrestrict and userestrict - statement concerning any restrictions on the material in the collection -->
            <controlaccess>
                <xsl:for-each select="field[@name = 'subject_person']">
                    <persname>
                        <xsl:value-of select="./normalize-space()" />
                    </persname>
                </xsl:for-each>
                <xsl:for-each select="field[@name = 'subject_topical']">
                    <subject>
                        <xsl:value-of select="./normalize-space()" />
                    </subject>
                </xsl:for-each>
                <xsl:for-each select="field[@name = 'subject_geography']">
                    <geogname>
                        <xsl:value-of select="./normalize-space()" />
                    </geogname>
                </xsl:for-each>
                <xsl:for-each select="field[@name = 'subject_corporate']">
                    <corpname>
                        <xsl:value-of select="./normalize-space()" />
                    </corpname>
                </xsl:for-each>
                <xsl:for-each select="field[@name = 'subject_uniform_title']">
                    <title>
                        <xsl:value-of select="./normalize-space()" />
                    </title>
                </xsl:for-each>
                <xsl:for-each select="field[@name = 'subject_genre_form']">
                    <genreform>
                        <xsl:value-of select="./normalize-space()" />
                    </genreform>
                </xsl:for-each>
            </controlaccess>

            <!-- second part of the archival description: the inventory with descriptive subordinate components -->
            <dsc>
            </dsc>
        </archdesc>
    </xsl:template>

    <xsl:template match="text()|@*"/>

</xsl:stylesheet>
