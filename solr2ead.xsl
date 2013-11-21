<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								version="2.0">
	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
	<xsl:output encoding="UTF-8"/>

<!--
//*****************************************************************************
// Written by Junte Zhang <juntezhang@gmail.com> in 2013
// With modifications by Michael Bryant and Ben Companjen
//
// See: https://github.com/juntezhang/solr2ead 
// 
// Distributed under the GNU General Public Licence
//*****************************************************************************
-->

	<xsl:template match="/add">
		<xsl:for-each select="//doc">
		  <!-- check if it is a description on collection level with subordinate components -->
		  <xsl:choose>
        <xsl:when test="field[@name = 'assoc_is_parent' and contains(text(),'Yes')]">
          <xsl:variable name="filename" select="concat('ead/' , '_', field[@name = 'id'] , '.xml')" />
          <xsl:result-document href="{$filename}" method="xml">
            <ead>
              <xsl:call-template name="header"/>
              <xsl:call-template name="fm"/>
              <xsl:call-template name="description_with_dsc"/>
              <xsl:apply-templates />
            </ead>
          </xsl:result-document>
        </xsl:when>
        <xsl:otherwise>
          <!-- or else the description is without components -->
          <xsl:if test="not(field[@name = 'assoc_parent_irn']/text())">
            <xsl:variable name="filename" select="concat('ead/' , field[@name = 'id'] , '.xml')" />
            <xsl:result-document href="{$filename}" method="xml">
              <ead>
                <xsl:call-template name="header"/>
                <xsl:call-template name="fm"/>
                <xsl:call-template name="description"/>
                <xsl:apply-templates />
              </ead>
            </xsl:result-document>              
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!-- header: <eadheader> -->
	<xsl:template name="header">
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
					<publisher>
					</publisher>
					<date calendar="gregorian" era="ce"></date>
				</publicationstmt>
			</filedesc>
			<profiledesc>
				<creation>
					<xsl:value-of select="field[@name = 'datetimemodified']/normalize-space()" />
				</creation>
				<langusage>
					<xsl:value-of select="field[@name = 'language']/normalize-space()" />
				</langusage>
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
				<unitid>
					<xsl:value-of select="field[@name = 'accession_number']/normalize-space()" />
				</unitid>
				<unittitle>
					<xsl:value-of select="field[@name = 'unit_title']/normalize-space()" />
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

			<userestrict>
				<xsl:for-each select="field[@name = 'copyright']">
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
				<p>
				<xsl:for-each select="field[@name = 'subject_type']">
					<xsl:choose>
						<xsl:when test=". = 'Personal Name'">
							<xsl:variable name = "pos" select="position()" />
							<persname>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</persname>
						</xsl:when>
						<xsl:when test=". = 'Corporate Name'">
							<xsl:variable name = "pos" select="position()" />
							<corpname>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</corpname>
						</xsl:when>
						<xsl:when test=". = 'Topical Term'">
							<xsl:variable name = "pos" select="position()" />
							<subject>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</subject>
						</xsl:when>
						<xsl:when test=". = 'Geographic Name'">
							<xsl:variable name = "pos" select="position()" />
							<geogname>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</geogname>
						</xsl:when>
						<xsl:when test=". = 'Index Term - Genre/Form'">
							<xsl:variable name = "pos" select="position()" />
							<genreform>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</genreform>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name = "pos" select="position()" />
							<p><xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" /></p>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				</p>
			</controlaccess>

			<!-- second part of the archival description: the inventory with descriptive subordinate components -->
			<dsc>
			</dsc>
		</archdesc>
	</xsl:template>

  <!-- archival description with dsc -->
	<xsl:template name="description_with_dsc">
	  <!-- get the irn to retrieve components -->
	  <xsl:variable name="irn">
      <xsl:value-of select="field[@name = 'irn']/normalize-space()" />
	  </xsl:variable>
	  
		<archdesc>
			<did>
				<unitid>
					<xsl:value-of select="field[@name = 'accession_number']/normalize-space()" />
				</unitid>
				<unittitle>
					<xsl:value-of select="field[@name = 'unit_title']/normalize-space()" />
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

			<userestrict>
				<xsl:for-each select="field[@name = 'copyright']">
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
				<p>
				<xsl:for-each select="field[@name = 'subject_type']">
					<xsl:choose>
						<xsl:when test=". = 'Personal Name'">
							<xsl:variable name = "pos" select="position()" />
							<persname>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</persname>
						</xsl:when>
						<xsl:when test=". = 'Corporate Name'">
							<xsl:variable name = "pos" select="position()" />
							<corpname>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</corpname>
						</xsl:when>
						<xsl:when test=". = 'Topical Term'">
							<xsl:variable name = "pos" select="position()" />
							<subject>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</subject>
						</xsl:when>
						<xsl:when test=". = 'Geographic Name'">
							<xsl:variable name = "pos" select="position()" />
							<geogname>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</geogname>
						</xsl:when>
						<xsl:when test=". = 'Index Term - Genre/Form'">
							<xsl:variable name = "pos" select="position()" />
							<genreform>
								<xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" />
							</genreform>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name = "pos" select="position()" />
							<p><xsl:value-of select="../field[@name = 'subject_heading'][$pos]/normalize-space()" /></p>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				</p>
			</controlaccess>

			<!-- second part of the archival description: the inventory with descriptive subordinate components -->
      <dsc>
        <!-- we do not know at which level the description is, so it is <c> -->
        <xsl:for-each select="//doc/field[@name = 'assoc_parent_irn' and contains(text(), $irn)]">
          <c>
            <did>
              <unitid>
                <xsl:value-of select="preceding-sibling::field[@name = 'id']/normalize-space()" />
              </unitid>
              <unittitle>
                <xsl:value-of select="following-sibling::field[@name = 'unit_title']/normalize-space()" />
              </unittitle>
              <unitdate calendar="gregorian" era="ce">
                <xsl:value-of select="following-sibling::field[@name = 'display_date']/normalize-space()" />
              </unitdate>
              <abstract>
                <xsl:for-each select="following-sibling::field[@name = 'brief_desc']">
                  <p>
                    <xsl:value-of select="./normalize-space()" />
                  </p>
                </xsl:for-each>
              </abstract>              
              <origination>
                <xsl:value-of select="following-sibling::field[@name = 'provenance']/normalize-space()" />
              </origination>              
              <physdesc>
                <extent>
                  <xsl:value-of select="following-sibling::field[@name = 'extent']/normalize-space()" />
                </extent>
                <physfacet>
                  <xsl:value-of select="following-sibling::field[@name = 'dimensions']/normalize-space()" />
                  <xsl:value-of select="following-sibling::field[@name = 'material_composition']/normalize-space()" />
                </physfacet>
              </physdesc>              
            </did>
          </c>
        </xsl:for-each>
      </dsc>
		</archdesc>
	</xsl:template>  

  
	<xsl:template match="text()|@*"/>

</xsl:stylesheet>