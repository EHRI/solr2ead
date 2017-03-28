<?xml version='1.0'?><!--
//*****************************************************************************
// Written by Junte Zhang <juntezhang@gmail.com> in 2013
// With modifications by Michael Bryant and Ben Companjen
//
// Distributed under the GNU General Public Licence
//*****************************************************************************
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
    <xsl:output encoding="UTF-8"/>

    <!-- Reverse lookup for language codes -->
    <xsl:variable name="language-map">
        <entry key="Afar">aar</entry>
        <entry key="Abkhazian">abk</entry>
        <entry key="Avestan">ave</entry>
        <entry key="Afrikaans">afr</entry>
        <entry key="Akan">aka</entry>
        <entry key="Amharic">amh</entry>
        <entry key="Aragonese">arg</entry>
        <entry key="Arabic">ara</entry>
        <entry key="Assamese">asm</entry>
        <entry key="Avaric">ava</entry>
        <entry key="Aymara">aym</entry>
        <entry key="Azerbaijani">aze</entry>
        <entry key="Bashkir">bak</entry>
        <entry key="Belarusian">bel</entry>
        <entry key="Bulgarian">bul</entry>
        <entry key="Bihari">bih</entry>
        <entry key="Bislama">bis</entry>
        <entry key="Bambara">bam</entry>
        <entry key="Bengali">ben</entry>
        <entry key="Tibetan">bod</entry>
        <entry key="Breton">bre</entry>
        <entry key="Bosnian">bos</entry>
        <entry key="Catalan">cat</entry>
        <entry key="Chechen">che</entry>
        <entry key="Chamorro">cha</entry>
        <entry key="Corsican">cos</entry>
        <entry key="Cree">cre</entry>
        <entry key="Czech">ces</entry>
        <entry key="Church Slavic">chu</entry>
        <entry key="Chuvash">chv</entry>
        <entry key="Welsh">cym</entry>
        <entry key="Danish">dan</entry>
        <entry key="German">deu</entry>
        <entry key="Divehi">div</entry>
        <entry key="Dzongkha">dzo</entry>
        <entry key="Ewe">ewe</entry>
        <entry key="Greek">ell</entry>
        <entry key="English">eng</entry>
        <entry key="Esperanto">epo</entry>
        <entry key="Spanish">spa</entry>
        <entry key="Estonian">est</entry>
        <entry key="Basque">eus</entry>
        <entry key="Persian">fas</entry>
        <entry key="Fulah">ful</entry>
        <entry key="Finnish">fin</entry>
        <entry key="Fijian">fij</entry>
        <entry key="Faroese">fao</entry>
        <entry key="French">fra</entry>
        <entry key="Frisian">fry</entry>
        <entry key="Irish">gle</entry>
        <entry key="Scottish Gaelic">gla</entry>
        <entry key="Gallegan">glg</entry>
        <entry key="Guarani">grn</entry>
        <entry key="Gujarati">guj</entry>
        <entry key="Manx">glv</entry>
        <entry key="Hausa">hau</entry>
        <entry key="Hebrew">heb</entry>
        <entry key="Hindi">hin</entry>
        <entry key="Hiri Motu">hmo</entry>
        <entry key="Croatian">hrv</entry>
        <entry key="Haitian">hat</entry>
        <entry key="Hungarian">hun</entry>
        <entry key="Armenian">hye</entry>
        <entry key="Herero">her</entry>
        <entry key="Interlingua">ina</entry>
        <entry key="Indonesian">ind</entry>
        <entry key="Interlingue">ile</entry>
        <entry key="Igbo">ibo</entry>
        <entry key="Sichuan Yi">iii</entry>
        <entry key="Inupiaq">ipk</entry>
        <entry key="Indonesian">ind</entry>
        <entry key="Ido">ido</entry>
        <entry key="Icelandic">isl</entry>
        <entry key="Italian">ita</entry>
        <entry key="Inuktitut">iku</entry>
        <entry key="Hebrew">heb</entry>
        <entry key="Japanese">jpn</entry>
        <entry key="Yiddish">yid</entry>
        <entry key="Javanese">jav</entry>
        <entry key="Georgian">kat</entry>
        <entry key="Kongo">kon</entry>
        <entry key="Kikuyu">kik</entry>
        <entry key="Kwanyama">kua</entry>
        <entry key="Kazakh">kaz</entry>
        <entry key="Greenlandic">kal</entry>
        <entry key="Khmer">khm</entry>
        <entry key="Kannada">kan</entry>
        <entry key="Korean">kor</entry>
        <entry key="Kanuri">kau</entry>
        <entry key="Kashmiri">kas</entry>
        <entry key="Kurdish">kur</entry>
        <entry key="Komi">kom</entry>
        <entry key="Cornish">cor</entry>
        <entry key="Kirghiz">kir</entry>
        <entry key="Latin">lat</entry>
        <entry key="Luxembourgish">ltz</entry>
        <entry key="Ganda">lug</entry>
        <entry key="Limburgish">lim</entry>
        <entry key="Lingala">lin</entry>
        <entry key="Lao">lao</entry>
        <entry key="Lithuanian">lit</entry>
        <entry key="Luba-Katanga">lub</entry>
        <entry key="Latvian">lav</entry>
        <entry key="Malagasy">mlg</entry>
        <entry key="Marshallese">mah</entry>
        <entry key="Maori">mri</entry>
        <entry key="Macedonian">mkd</entry>
        <entry key="Malayalam">mal</entry>
        <entry key="Mongolian">mon</entry>
        <entry key="Moldavian">mol</entry>
        <entry key="Marathi">mar</entry>
        <entry key="Malay">msa</entry>
        <entry key="Maltese">mlt</entry>
        <entry key="Burmese">mya</entry>
        <entry key="Nauru">nau</entry>
        <entry key="Norwegian Bokmål">nob</entry>
        <entry key="North Ndebele">nde</entry>
        <entry key="Nepali">nep</entry>
        <entry key="Ndonga">ndo</entry>
        <entry key="Dutch">nld</entry>
        <entry key="Norwegian Nynorsk">nno</entry>
        <entry key="Norwegian">nor</entry>
        <entry key="South Ndebele">nbl</entry>
        <entry key="Navajo">nav</entry>
        <entry key="Nyanja">nya</entry>
        <entry key="Occitan">oci</entry>
        <entry key="Ojibwa">oji</entry>
        <entry key="Oromo">orm</entry>
        <entry key="Oriya">ori</entry>
        <entry key="Ossetian">oss</entry>
        <entry key="Panjabi">pan</entry>
        <entry key="Pali">pli</entry>
        <entry key="Polish">pol</entry>
        <entry key="Pushto">pus</entry>
        <entry key="Portuguese">por</entry>
        <entry key="Quechua">que</entry>
        <entry key="Raeto-Romance">roh</entry>
        <entry key="Rundi">run</entry>
        <entry key="Romanian">ron</entry>
        <entry key="Russian">rus</entry>
        <entry key="Kinyarwanda">kin</entry>
        <entry key="Sanskrit">san</entry>
        <entry key="Sardinian">srd</entry>
        <entry key="Sindhi">snd</entry>
        <entry key="Northern Sami">sme</entry>
        <entry key="Sango">sag</entry>
        <entry key="Sinhalese">sin</entry>
        <entry key="Slovak">slk</entry>
        <entry key="Slovenian">slv</entry>
        <entry key="Samoan">smo</entry>
        <entry key="Shona">sna</entry>
        <entry key="Somali">som</entry>
        <entry key="Albanian">sqi</entry>
        <entry key="Serbian">srp</entry>
        <entry key="Swati">ssw</entry>
        <entry key="Southern Sotho">sot</entry>
        <entry key="Sundanese">sun</entry>
        <entry key="Swedish">swe</entry>
        <entry key="Swahili">swa</entry>
        <entry key="Tamil">tam</entry>
        <entry key="Telugu">tel</entry>
        <entry key="Tajik">tgk</entry>
        <entry key="Thai">tha</entry>
        <entry key="Tigrinya">tir</entry>
        <entry key="Turkmen">tuk</entry>
        <entry key="Tagalog">tgl</entry>
        <entry key="Tswana">tsn</entry>
        <entry key="Tonga">ton</entry>
        <entry key="Turkish">tur</entry>
        <entry key="Tsonga">tso</entry>
        <entry key="Tatar">tat</entry>
        <entry key="Twi">twi</entry>
        <entry key="Tahitian">tah</entry>
        <entry key="Uighur">uig</entry>
        <entry key="Ukrainian">ukr</entry>
        <entry key="Urdu">urd</entry>
        <entry key="Uzbek">uzb</entry>
        <entry key="Venda">ven</entry>
        <entry key="Vietnamese">vie</entry>
        <entry key="Volapük">vol</entry>
        <entry key="Walloon">wln</entry>
        <entry key="Wolof">wol</entry>
        <entry key="Xhosa">xho</entry>
        <entry key="Yiddish">yid</entry>
        <entry key="Yoruba">yor</entry>
        <entry key="Zhuang">zha</entry>
        <entry key="Chinese">zho</entry>
        <entry key="Zulu">zul</entry>
    </xsl:variable>

    <xsl:template match="/response/result">
        <!-- Work on top-level <doc>s:
             - <doc> without assoc_parent_irn field
             - <doc> with assoc_parent_irn that does not match any existing <doc>'s irn -->
        <xsl:apply-templates select="doc[not(*[@name = 'assoc_parent_irn']/normalize-space()) or not(//doc/*[@name = 'irn']/normalize-space() = *[@name = 'assoc_parent_irn']/normalize-space())]"/>
    </xsl:template>

    <xsl:template match="doc">
        <xsl:variable name="recordtype" select="replace(*[@name='record_type']/normalize-space(), '[ /\.]', '')"/>
        <xsl:variable name="filename" select="concat('ead/', $recordtype , '/' , *[@name = 'id'] , '.xml')"/>
        <xsl:result-document href="{$filename}" method="xml">
            <ead>
                <xsl:call-template name="header"/>
                <xsl:call-template name="fm"/>
                <xsl:call-template name="description_with_dsc"/>
                <!-- if we call apply-templates for 'the rest', make sure we don't create duplicates -->
                <!--           <xsl:apply-templates select="field[not(@name=('conditions_access','conditions_use','funding_note','arrangement','creator_name','creator_role','finding_aid_provenance','historical_provenance'))]"/> -->

            </ead>
        </xsl:result-document>
    </xsl:template>

    <!-- header: <eadheader> -->
    <xsl:template name="header">
        <xsl:variable name="convertdatetime" select="current-dateTime()"/>
        <xsl:variable name="convertdate" select="current-date()"/>
        <eadheader>
            <eadid>
                <xsl:value-of select="*[@name = 'id']/normalize-space()"/>
            </eadid>
            <filedesc>
                <titlestmt>
                    <titleproper>
                        <xsl:value-of select="*[@name = 'title_display']/normalize-space()"/>
                    </titleproper>
                    <subtitle>
                        <xsl:value-of select="*[@name = 'title_sub']/normalize-space()"/>
                    </subtitle>
                    <author>
                        <xsl:value-of select="*[@name = 'creator_name']/normalize-space()"/>
                    </author>
                </titlestmt>
                <publicationstmt>
                    <publisher>USHMM / EHRI partners</publisher>
                    <date>
                        <xsl:value-of select="*[@name = 'datetimemodified']/normalize-space()"/>
                    </date>
                </publicationstmt>
            </filedesc>
            <profiledesc>
                <creation>Automatically converted from USHMM's Solr index file using solr2ead.xsl
                    (https://github.com/EHRI/solr2ead)
                    <date calendar="gregorian" era="ce">
                        <xsl:attribute name="normal" select="format-date($convertdate, '[Y0001]-[M01]-[D01]')"/>
                        <xsl:value-of select="$convertdatetime"/>
                    </date>
                </creation>
                <langusage>
                    <language langcode="eng">English</language>
                </langusage>
            </profiledesc>
        </eadheader>
    </xsl:template>

    <!-- frontmatter: <frontmatter> -->
    <xsl:template name="fm">
        <frontmatter>
            <titlepage>
                <titleproper>
                    <xsl:value-of select="*[@name = 'collection_name']/normalize-space()"/>
                </titleproper>
                <date calendar="gregorian" era="ce">
                    <xsl:value-of select="*[@name = 'display_date']/normalize-space()"/>
                </date>
            </titlepage>
        </frontmatter>
    </xsl:template>


    <!-- archival description with subordinate components;
         this template is called for top-level descriptions -->
    <xsl:template name="description_with_dsc">
        <!-- get the irn to retrieve components -->
        <xsl:variable name="irn" select="*[@name = 'irn']/normalize-space()"/>

        <!-- NB: Level attribute is mandatory -->
        <archdesc level="otherlevel">
            <xsl:call-template name="normal_description"/>
            <xsl:call-template name="components">
                <xsl:with-param name="level" as="xs:integer" select="0"/>
            </xsl:call-template>
        </archdesc>
    </xsl:template>

    <xsl:template name="normal_description">
        <!-- First select names -->
        <xsl:variable name="creator_name" select="*[@name = 'creator_name']"/>
        <xsl:variable name="creator_role" select="*[@name = 'creator_role']"/>

        <xsl:variable name="names" as="element()*">
            <xsl:for-each select="$creator_name">
                <xsl:variable name="i" select="position()"/>
                <xsl:element name="name">
                    <xsl:if test="$creator_role[$i] != ''">
                        <xsl:attribute name="role" select="lower-case($creator_role[$i]/normalize-space())"/>
                    </xsl:if>
                    <xsl:value-of select="$creator_name[$i]/normalize-space()"/>
                </xsl:element>
            </xsl:for-each>
        </xsl:variable>

        <!-- DEBUG -->
        <!--           <xsl:message select="trace($names, 'names: ')"/> -->

        <!-- Lists of roles are lower case, make sure to check lower case strings against these lists -->
        <xsl:variable name="creator_roles" select="('artist','publisher','author','issuer','manufacturer','distributor','producer','photographer','designer','agent','maker','compiler','creator','editor','engraver')"/>
        <xsl:variable name="subject_roles" select="('subject')"/>
        <xsl:variable name="custodial_roles" select="('owner','original owner','donor','previous owner')"/>

        <did>
            <xsl:variable name="rg" select="*[@name = 'rg_number']/normalize-space()"/>
            <xsl:variable name="acc_num" select="*[@name = 'accession_number']/normalize-space()"/>
            <unittitle>
                <xsl:value-of select="*[@name = 'title_display']/normalize-space()"/>
            </unittitle>
            <unitdate calendar="gregorian" era="ce">
                <xsl:value-of select="*[@name = 'display_date']/normalize-space()"/>
            </unitdate>
            <unitid type="irn">
                <xsl:value-of select="*[@name = 'id']/normalize-space()"/>
            </unitid>
            <xsl:if test="$rg != ''">
                <unitid type="rg_number" label="Record group number">
                    <xsl:value-of select="$rg"/>
                </unitid>
            </xsl:if>
            <xsl:if test="$acc_num != ''">
                <unitid type="acc_num" label="Accession number">
                    <xsl:value-of select="$acc_num"/>
                </unitid>
            </xsl:if>


            <!-- origination (can be empty) -->

            <origination>
                <xsl:for-each select="$creator_name">
                    <xsl:variable name="i" select="position()"/>
                    <xsl:if test="$creator_role[$i] = '' or lower-case($creator_role[$i]/normalize-space()) = $creator_roles">
                        <xsl:element name="name">
                            <xsl:if test="$creator_role[$i] != ''">
                                <xsl:attribute name="role" select="lower-case($creator_role[$i]/normalize-space())"/>
                            </xsl:if>
                            <xsl:value-of select="$creator_name[$i]/normalize-space()"/>
                        </xsl:element>
                    </xsl:if>
                </xsl:for-each>
                <xsl:variable name="finding_aid_provenance" select="*[@name = 'finding_aid_provenance']/normalize-space()"/>
                <xsl:variable name="historical_provenance" select="*[@name = 'historical_provenance']/normalize-space()"/>
                <xsl:for-each select="$finding_aid_provenance">

                    <xsl:copy-of select="$finding_aid_provenance"/>
                    <xsl:if test="position() &lt; last()">
                        <lb/>
                    </xsl:if>

                </xsl:for-each>
                <xsl:for-each select="$historical_provenance">

                    <xsl:copy-of select="$historical_provenance"/>
                    <xsl:if test="position() &lt; last()">
                        <lb/>
                    </xsl:if>

                </xsl:for-each>
            </origination>

            <!-- document_quantity and document_container are similar -->
            <xsl:variable name="document_quantity" select="*[@name = 'document_quantity']/str/normalize-space()"/>
            <xsl:variable name="document_container" select="*[@name = 'document_container']/str/normalize-space()"/>
            <xsl:for-each select="$document_quantity">
                <xsl:variable name="i" select="position()"/>
                <container type="{tokenize($document_container[$i],'\s+')[1]}">
                    <xsl:value-of select="$document_quantity"/>
                </container>
            </xsl:for-each>
            <physdesc>
                <xsl:variable name="extent_quantity" select="*[@name = 'extent_quantity']/str/normalize-space()"/>
                <xsl:variable name="extent_unit" select="*[@name = 'extent_unit']/str/normalize-space()"/>
                <xsl:variable name="extent_format" select="*[@name = 'extent_format']/str/normalize-space()"/>
                <!-- if there vars exist there should always be an equal number of them,
                     and they need to be reordered to make sense in the EAD -->
                <xsl:for-each select="$extent_quantity">
                    <xsl:variable name="i" select="position()"/>
                    <extent>
                        <xsl:value-of select="concat($extent_quantity[$i], ' ', $extent_unit[$i], ' ', $extent_format[$i])"/>
                    </extent>
                </xsl:for-each>

                <xsl:variable name="extent" select="*[@name = 'extent']/normalize-space()"/>
                <xsl:for-each select="$extent">
                    <extent>
                        <xsl:copy-of select="$extent"/>
                    </extent>
                </xsl:for-each>

                <xsl:variable name="dimensions" select="*[@name = 'dimensions']/str/normalize-space()"/>
                <xsl:for-each select="$dimensions">
                    <dimensions>
                        <xsl:copy-of select="$dimensions"/>
                    </dimensions>
                </xsl:for-each>
                <xsl:variable name="material_composition" select="*[@name = 'material_composition']/normalize-space()"/>
                <xsl:for-each select="$material_composition">
                    <physfacet>
                        <xsl:copy-of select="$material_composition"/>
                    </physfacet>
                </xsl:for-each>
                <xsl:variable name="object_type" select="*[@name = 'object_type']/normalize-space()"/>
                <xsl:for-each select="$object_type">
                    <physfacet>
                        <xsl:copy-of select="$object_type"/>
                    </physfacet>
                </xsl:for-each>
            </physdesc>
            <langmaterial>
                <xsl:for-each select="*[@name = 'language']/str">
                    <xsl:variable name="lang-name" select="./normalize-space()"/>
                    <xsl:variable name="lang-code" select="$language-map/entry[@key=$lang-name]"/>
                    <xsl:if test="not(empty($lang-code))">
                        <language langcode="{$lang-code}"><xsl:value-of select="$lang-name"/></language>
                    </xsl:if>
                    <xsl:if test="empty($lang-code)">
                        <language><xsl:value-of select="$lang-name"/></language>
                    </xsl:if>
                </xsl:for-each>
            </langmaterial>
        </did>

        <!-- arrangement -->
        <xsl:apply-templates select="*[@name = 'arrangement']"/>


        <!-- custodhist -->
        <xsl:variable name="provenance" select="*[@name = 'provenance']/normalize-space()"/>
        <xsl:if test="not(empty(($provenance, $creator_role[lower-case(text()) = $custodial_roles])))">
            <custodhist>
                <xsl:for-each select="$creator_name">
                    <xsl:variable name="i" select="position()"/>
                    <xsl:if test="lower-case($creator_role[$i]/normalize-space()) = $custodial_roles">
                        <xsl:element name="p">
                            <xsl:value-of select="$creator_role[$i]/normalize-space()"/>:
                            <xsl:value-of select="$creator_name[$i]/normalize-space()"/>
                        </xsl:element>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$provenance">
                    <p>
                        <xsl:copy-of select="$provenance"/>
                    </p>
                </xsl:for-each>
            </custodhist>
        </xsl:if>

        <xsl:variable name="accession" select="*[@name = 'accession_number']/normalize-space()"/>
        <xsl:variable name="source" select="distinct-values(*[@name = 'acq_source']/normalize-space())"/>
        <xsl:variable name="credit" select="*[@name = 'acq_credit']/normalize-space()"/>
        <xsl:if test="not(empty(($accession, $source, $credit)))">
            <acqinfo>

                <xsl:if test="$accession != ''">
                    <p>Accession number:
                        <xsl:copy-of select="$accession"/>
                    </p>
                </xsl:if>
                <xsl:if test="$source != ''">
                    <p>Source:
                        <xsl:copy-of select="$source"/>
                    </p>
                </xsl:if>
                <xsl:if test="$credit != ''">
                    <p>Credit:
                        <xsl:copy-of select="$credit"/>
                    </p>
                </xsl:if>
            </acqinfo>
        </xsl:if>

        <!-- Optional funding note field -->
        <xsl:apply-templates select="*[@name = 'funding_note']"/>

        <!-- biographic description of the person or organization -->
        <xsl:variable name="bioghist" select="*[@name = 'creator_bio']/normalize-space()"/>
        <xsl:if test="$bioghist != ''">
            <bioghist>
                <xsl:for-each select="$bioghist">
                    <p>
                        <xsl:value-of select="$bioghist"/>
                    </p>
                </xsl:for-each>
            </bioghist>
        </xsl:if>

        <!-- a detailed narrative description of the collection material -->
        <xsl:variable name="brief_desc" select="*[@name = 'brief_desc']/normalize-space()"/>
        <xsl:variable name="collection_summary" select="*[@name = 'collection_summary']/normalize-space()"/>
        <xsl:variable name="interview_summary" select="*[@name = 'interview_summary']/str/normalize-space()"/>
        <xsl:variable name="scope_content" select="*[@name = 'scope_content']/str/normalize-space()"/>
        <xsl:if test="not(empty(($brief_desc, $collection_summary, $interview_summary, $scope_content)))">
            <scopecontent>
                <xsl:for-each select="$brief_desc">
                    <p>
                        <xsl:copy-of select="$brief_desc"/>
                    </p>
                </xsl:for-each>
                <xsl:for-each select="$collection_summary">
                    <p>
                        <xsl:value-of select="$collection_summary"/>
                    </p>
                </xsl:for-each>
                <xsl:for-each select="$interview_summary">
                    <p>
                        <xsl:value-of select="$interview_summary"/>
                    </p>
                </xsl:for-each>
                <xsl:for-each select="$scope_content">
                    <p>
                        <xsl:value-of select="$scope_content"/>
                    </p>
                </xsl:for-each>
            </scopecontent>
        </xsl:if>

        <!-- description of items which the repository acquired separately but which are related to this collection, and which a researcher might want to be aware of -->
        <!--
    <relatedmaterial>
         </relatedmaterial>
    -->

        <!-- accessrestrict -->
        <xsl:apply-templates select="*[@name = 'conditions_access']"/>

        <!-- userestrict -->
        <xsl:apply-templates select="*[@name = 'conditions_use']"/>

        <!-- odd "Object type:" -->
        <xsl:apply-templates select="*[@name = 'object_type']"/>

        <!-- odd "Record type:" -->
        <xsl:apply-templates select="*[@name = 'record_type']"/>

        <!-- odd "EMU classification:" -->
        <xsl:apply-templates select="*[@name = 'classification']"/>

        <!-- odd "EMU category:" -->
        <xsl:apply-templates select="*[@name = 'emu_category']"/>


        <!-- items which the repository acquired as part of this collection but which have been separated from it, perhaps for special treatment, storage needs, or cataloging -->
        <!--
  <separatedmaterial>
        </separatedmaterial>
   -->

        <!-- a list of subject headings or keywords for the collection, usually drawn from an authoritative source such as Library of Congress Subject Headings or the Art and Architecture Thesaurus
    accessrestrict and userestrict - statement concerning any restrictions on the material in the collection -->
        <!-- subject_corporate subject_person subject_topical subject_genre_form subject_geography subject_meeting_name subject_uniform_title -->
        <xsl:if test="not(empty((*[@name= ('subject_corporate', 'subject_person', 'subject_topical', 'subject_genre_form', 'subject_geography', 'subject_uniform_title')], $creator_role[lower-case(./normalize-space()) = $subject_roles])))">
            <controlaccess>
                <xsl:for-each select="*[@name = 'subject_person']">
                    <persname>
                        <xsl:value-of select="./normalize-space()"/>
                    </persname>
                </xsl:for-each>
                <xsl:for-each select="*[@name = 'subject_topical']">
                    <subject>
                        <xsl:value-of select="./normalize-space()"/>
                    </subject>
                </xsl:for-each>
                <xsl:for-each select="*[@name = 'subject_geography']">
                    <geogname>
                        <xsl:value-of select="./normalize-space()"/>
                    </geogname>
                </xsl:for-each>
                <xsl:for-each select="*[@name = 'subject_corporate']">
                    <corpname>
                        <xsl:value-of select="./normalize-space()"/>
                    </corpname>
                </xsl:for-each>
                <xsl:for-each select="*[@name = 'subject_uniform_title']">
                    <title>
                        <xsl:value-of select="./normalize-space()"/>
                    </title>
                </xsl:for-each>
                <xsl:for-each select="*[@name = 'subject_genre_form']">
                    <genreform>
                        <xsl:value-of select="./normalize-space()"/>
                    </genreform>
                </xsl:for-each>
                <xsl:for-each select="$creator_name">
                    <xsl:variable name="i" select="position()"/>
                    <xsl:if test="lower-case($creator_role[$i]/normalize-space()) = $subject_roles">
                        <xsl:element name="name">
                            <xsl:attribute name="role" select="lower-case($creator_role[$i]/normalize-space())"/>
                            <xsl:value-of select="$creator_name[$i]/normalize-space()"/>
                        </xsl:element>
                    </xsl:if>
                </xsl:for-each>

            </controlaccess>
        </xsl:if>
    </xsl:template>


    <xsl:template name="components">

        <!-- level: 0 when in <archdesc>
                    1 - 12 for <c01> - <c12> -->
        <xsl:param name="level" as="xs:integer"/>
        <!-- get the irn to retrieve components -->
        <xsl:variable name="irn">
            <xsl:value-of select="*[@name = 'irn']/normalize-space()"/>
        </xsl:variable>
        <!-- second part of the archival description: the inventory with descriptive subordinate components -->
        <xsl:variable name="components" select="//doc[*[@name = 'assoc_parent_irn']/normalize-space() = $irn]"/>
        <xsl:if test="$components">
            <xsl:choose>
                <xsl:when test="$level = 0">
                    <dsc>
                        <xsl:for-each select="$components">
                            <c01 level="otherlevel">
                                <xsl:call-template name="normal_description"/>
                                <xsl:call-template name="components">
                                    <xsl:with-param name="level" as="xs:integer" select="$level+2"/>
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
                                <xsl:with-param name="level" as="xs:integer" select="$level+1"/>
                            </xsl:call-template>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>


    <xsl:template match="*[@name = 'conditions_access']">
        <accessrestrict>
            <xsl:for-each select=".">
                <p>
                    <xsl:value-of select="./normalize-space()"/>
                </p>
            </xsl:for-each>
        </accessrestrict>
    </xsl:template>

    <xsl:template match="*[@name = 'conditions_use']">
        <userestrict>
            <xsl:for-each select=".">
                <p>
                    <xsl:value-of select="./normalize-space()"/>
                </p>
            </xsl:for-each>
        </userestrict>
    </xsl:template>

    <xsl:template match="*[@name = 'object_type']">
        <odd>
            <p>Object type:
                <xsl:value-of select="./normalize-space()"/>
            </p>
        </odd>
    </xsl:template>

    <xsl:template match="*[@name = 'record_type']">
        <odd>
            <p>Record type:
                <xsl:value-of select="./normalize-space()"/>
            </p>
        </odd>
    </xsl:template>

    <xsl:template match="*[@name = 'classification']">
        <odd>
            <p>EMU Classification:
                <xsl:value-of select="./normalize-space()"/>
            </p>
        </odd>
    </xsl:template>

    <xsl:template match="*[@name = 'emu_category']">
        <odd>
            <p>EMU Category:
                <xsl:value-of select="./normalize-space()"/>
            </p>
        </odd>
    </xsl:template>

    <xsl:template match="*[@name = 'arrangement']">
        <arrangement>
            <p>
                <xsl:value-of select="normalize-space(.)"/>
            </p>
        </arrangement>
    </xsl:template>

    <xsl:template match="*[@name = 'funding_note']">
        <note>
            <p>
                <xsl:copy-of select="normalize-space(.)"/>
            </p>
        </note>
    </xsl:template>

    <!-- get rid of any trailing content or structure-->
    <xsl:template match="text()|@*"/>
</xsl:stylesheet>
