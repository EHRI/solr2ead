<?xml version='1.0'?>
<!--
//*****************************************************************************
// Written by Junte Zhang <juntezhang@gmail.com> in 2013
// With modifications by Michael Bryant and Ben Companjen
//
// Distributed under the GNU General Public Licence
//*****************************************************************************
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="urn:isbn:1-931666-22-9"
  version="2.0">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:output encoding="UTF-8"/>


  <xsl:template match="/add">
      <!-- Work on top-level <doc>s:
           - <doc> without assoc_parent_irn field
           - <doc> with assoc_parent_irn that does not match any existing <doc>'s irn -->
      <xsl:for-each select="//doc">
        <xsl:variable name="parent_irn" select="field[@name = 'assoc_parent_irn']/text()" />
        <xsl:if test="not($parent_irn) or not(//doc/field[@name = 'irn'] = field[@name = 'assoc_parent_irn'])">
            <xsl:variable name="filename" select="concat('ead/' , field[@name = 'id'] , '.xml')" />
            <xsl:result-document href="{$filename}" method="xml">
              <ead>
                <xsl:call-template name="header"/>
                <xsl:call-template name="fm"/>
                <xsl:call-template name="description_with_dsc"/>
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
                  <publisher>USHMM / EHRI partners</publisher>
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


    <!-- archival description with subordinate components;
         this template is called for top-level descriptions -->
  <xsl:template name="description_with_dsc">
    <!-- get the irn to retrieve components -->
    <xsl:variable name="irn">
      <xsl:value-of select="field[@name = 'irn']/normalize-space()" />
    </xsl:variable>

    <!-- NB: Level attribute is mandatory -->
    <archdesc level="otherlevel">
      <xsl:call-template name="normal_description" />
      <xsl:call-template name="components">
        <xsl:with-param name="level" as="xs:integer" select="0"/>
      </xsl:call-template>
    </archdesc>
  </xsl:template>

  <xsl:template name="normal_description">
    <did>
          <xsl:variable name="rg" select="field[@name = 'rg_number']/normalize-space()" />
          <xsl:variable name="acc_num" select="field[@name = 'accession_number']/normalize-space()" />
          <unittitle>
              <xsl:value-of select="field[@name = 'title']/normalize-space()" />
          </unittitle>
          <unitdate calendar="gregorian" era="ce">
              <xsl:value-of select="field[@name = 'display_date']/normalize-space()" />
          </unitdate>
          <unitid type="irn">
              <xsl:value-of select="field[@name = 'irn']/normalize-space()" />
          </unitid>
          <xsl:if test="$rg != ''">
              <unitid type="rg_number" label="Record group number">
                  <xsl:value-of select="$rg" />
              </unitid>
          </xsl:if>
          <xsl:if test="$acc_num != ''">
              <unitid type="acc_num" label="Accession number">
                  <xsl:value-of select="$acc_num" />
              </unitid>
          </xsl:if>
          <origination>
              <xsl:variable name="finding_aid_provenance" select="field[@name = 'finding_aid_provenance']/normalize-space()" />
              <xsl:variable name="historical_provenance" select="field[@name = 'historical_provenance']/normalize-space()" />

              <xsl:for-each select="$finding_aid_provenance">
                  <p>
                      <xsl:copy-of select="$finding_aid_provenance" />
                  </p>
              </xsl:for-each>
              <xsl:for-each select="$historical_provenance">
                  <p>
                      <xsl:copy-of select="$historical_provenance" />
                  </p>
              </xsl:for-each>
          </origination>

          <!-- document_quantity and document_container are similar -->
          <xsl:variable name="document_quantity" select="field[@name = 'document_quantity']/normalize-space()" />
          <xsl:variable name="document_container" select="field[@name = 'document_container']/normalize-space()" />
          <xsl:for-each select="$document_quantity">
            <xsl:variable name="i" select="position()" />
            <container type="{$document_container[$i]}">
                <xsl:value-of select="$document_quantity" />
            </container>
          </xsl:for-each>
          <physdesc>
              <xsl:variable name="extent_quantity" select="field[@name = 'extent_quantity']/normalize-space()" />
              <xsl:variable name="extent_unit" select="field[@name = 'extent_unit']/normalize-space()" />
              <xsl:variable name="extent_format" select="field[@name = 'extent_format']/normalize-space()" />
              <!-- if there vars exist there should always be an equal number of them,
                   and they need to be reordered to make sense in the EAD -->
              <xsl:for-each select="$extent_quantity">
                <xsl:variable name="i" select="position()" />
                <extent>
                    <xsl:value-of select="concat($extent_quantity[$i], ' ', $extent_unit[$i], ' ', $extent_format[$i])"/>
                </extent>
              </xsl:for-each>

              <xsl:variable name="extent" select="field[@name = 'extent']/normalize-space()" />
              <xsl:for-each select="$extent">
                  <extent>
                      <xsl:copy-of select="$extent" />
                  </extent>
              </xsl:for-each>

              <xsl:variable name="extent" select="field[@name = 'extent']/normalize-space()" />

              <xsl:variable name="dimensions" select="field[@name = 'dimensions']/normalize-space()" />
              <xsl:for-each select="$dimensions">
                  <dimensions>
                      <xsl:copy-of select="$dimensions" />
                  </dimensions>
              </xsl:for-each>
              <xsl:variable name="material_composition" select="field[@name = 'material_composition']/normalize-space()" />
              <xsl:for-each select="$material_composition">
                  <physfacet>
                      <xsl:copy-of select="$material_composition" />
                  </physfacet>
              </xsl:for-each>
              <xsl:variable name="object_type" select="field[@name = 'object_type']/normalize-space()" />
              <xsl:for-each select="$object_type">
                  <physfacet>
                      <xsl:copy-of select="$object_type" />
                  </physfacet>
              </xsl:for-each>
          </physdesc>
          <langmaterial>
              <xsl:for-each select="field[@name = 'language']">
                  <language><xsl:value-of select="./normalize-space()" /></language>
              </xsl:for-each>
          </langmaterial>
      </did>

      <xsl:variable name="arrangement" select="field[@name = 'arrangement']/normalize-space()" />
      <xsl:if test="$arrangement != ''">
          <arrangement>
              <p><xsl:copy-of select="$arrangement" /></p>
          </arrangement>
      </xsl:if>

      <xsl:variable name="provenance" select="field[@name = 'provenance']/normalize-space()" />
      <xsl:if test="$provenance != ''">
          <custodhist>
              <p><xsl:copy-of select="$provenance" /></p>
          </custodhist>
      </xsl:if>

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

      <!-- Optional funding note field -->
      <xsl:variable name="funding_note" select="field[@name = 'funding_note']/normalize-space()" />
      <xsl:if test="$funding_note != ''">
          <note>
              <p><xsl:copy-of select="$funding_note"/></p>
          </note>
      </xsl:if>

      <!-- biographic description of the person or organization -->
      <xsl:variable name="creator_bio" select="field[@name = 'creator_bio']/normalize-space()" />
      <xsl:if test="$creator_bio != ''">
          <bioghist>
              <p><xsl:copy-of select="$creator_bio"/></p>
          </bioghist>
      </xsl:if>

      <!-- a detailed narrative description of the collection material -->
      <scopecontent>
          <xsl:variable name="brief_desc" select="field[@name = 'brief_desc']/normalize-space()" />
          <xsl:variable name="collection_summary" select="field[@name = 'collection_summary']/normalize-space()" />
          <xsl:variable name="interview_summary" select="field[@name = 'interview_summary']/normalize-space()" />
          <xsl:variable name="scope_content" select="field[@name = 'scope_content']/normalize-space()" />

          <xsl:for-each select="$brief_desc">
              <p>
                  <xsl:copy-of select="$brief_desc" />
              </p>
          </xsl:for-each>
          <xsl:for-each select="$collection_summary">
              <p>
                  <xsl:value-of select="$collection_summary" />
              </p>
          </xsl:for-each>
          <xsl:for-each select="$interview_summary">
              <p>
                  <xsl:value-of select="$interview_summary" />
              </p>
          </xsl:for-each>
          <xsl:for-each select="$scope_content">
              <p>
                  <xsl:value-of select="$scope_content" />
              </p>
          </xsl:for-each>
      </scopecontent>

      <!-- description of items which the repository acquired separately but which are related to this collection, and which a researcher might want to be aware of -->
      <!--<relatedmaterial>
      </relatedmaterial>-->

      <xsl:variable name="conditions_access" select="field[@name = 'conditions_access']/normalize-space()" />
      <xsl:if test="$conditions_access != ''">
          <accessrestrict>
              <p><xsl:copy-of select="$conditions_access"/></p>
          </accessrestrict>
      </xsl:if>

      <xsl:variable name="conditions_use" select="field[@name = 'conditions_use']/normalize-space()" />
      <xsl:if test="$conditions_use != ''">
          <userestrict>
              <p><xsl:copy-of select="$conditions_use"/></p>
          </userestrict>
      </xsl:if>

      <xsl:variable name="object_type" select="field[@name = 'object_type']/normalize-space()" />
      <xsl:for-each select="$object_type">
          <odd>
              <p>Object type: <xsl:value-of select="$object_type" /></p>
          </odd>
      </xsl:for-each>
      <xsl:variable name="classification" select="field[@name = 'classification']/normalize-space()" />
      <xsl:for-each select="$classification">
          <odd>
              <p>EMU Classification: <xsl:value-of select="$classification" /></p>
          </odd>
      </xsl:for-each>

      <!-- items which the repository acquired as part of this collection but which have been separated from it, perhaps for special treatment, storage needs, or cataloging -->
      <!--<separatedmaterial>
      </separatedmaterial>-->

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
  </xsl:template>

  <xsl:template name="components">

    <!-- level: 0 when in <archdesc>
                1 - 12 for <c01> - <c12> -->
    <xsl:param name="level" as="xs:integer" />
    <!-- get the irn to retrieve components -->
    <xsl:variable name="irn">
      <xsl:value-of select="field[@name = 'irn']/normalize-space()" />
    </xsl:variable>
  <!-- second part of the archival description: the inventory with descriptive subordinate components -->
    <xsl:variable name="components" select="//doc[field[@name = 'assoc_parent_irn'] = $irn]" />
    <xsl:if test="$components">
      <xsl:choose>
        <xsl:when test="$level = 0">
          <dsc>
            <xsl:for-each select="$components">
              <c01 level="otherlevel">
                <xsl:call-template name="normal_description"/>
                <xsl:call-template name="components">
                  <xsl:with-param name="level" as="xs:integer" select="$level+2" />
                </xsl:call-template>
              </c01>
            </xsl:for-each>
          </dsc>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="$components">
            <xsl:element name="{concat('c', format-number($level, '00'))}">
              <xsl:call-template name="normal_description"/>
              <xsl:call-template name="components">
                <xsl:with-param name="level" as="xs:integer" select="$level+1" />
              </xsl:call-template>
            </xsl:element>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>


  <!-- get rid of any trailing content or structure-->
  <xsl:template match="text()|@*"/>
</xsl:stylesheet>
