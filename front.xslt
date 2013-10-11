<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
  <xsl:param name="jname" select="/document/document_info/journal_name"/>
  <xsl:param name="front_classifications" select="/document/objects/article_metadata/classifications"/>
  <xsl:param name="front_article_title" select="/document/objects/article_metadata/title_and_authors/fields/title/value"/>
  <xsl:param name="front_authors" select="/document/objects/article_metadata/title_and_authors"/>
  <xsl:param name="front_authors_number" select="count($front_authors/author)"/>
  <xsl:param name="front_contributors" select="/document/objects/article_metadata/contributors"/>
  <xsl:param name="front_abstract" select="/document/objects/article_metadata/abstract_and_keywords/fields/abstract"/>
  <xsl:param name="front_keywords" select="/document/objects/article_metadata/abstract_and_keywords/fields/keywords"/>
  <xsl:param name="front_funding" select="/document/objects/article_metadata/funding_agencies"/>

  <xsl:template name="front">
    <front>
      <xsl:call-template name="front-journal-meta"/>
      <xsl:call-template name="front-article-meta"/>
    </front>
  </xsl:template>

  <xsl:template name="front-journal-meta">
    <xsl:variable name="bdj" select="'Biodiversity Data Journal'"/>
    <xsl:variable name="bdjabbrev" select="'BDJ'"/>
    <journal-meta>
      <xsl:choose>
        <xsl:when test="$jname=$bdj">
          <journal-id journal-id-type="pmc">
            <xsl:value-of select="$bdj"/>
          </journal-id>
          <journal-id journal-id-type="publisher-id">
            <xsl:value-of select="$bdj"/>
          </journal-id>
          <journal-title-group>
            <journal-title xml:lang="en">
              <xsl:value-of select="$bdj"/>
            </journal-title>
            <abbrev-journal-title xml:lang="en">
              <xsl:value-of select="$bdjabbrev"/>
            </abbrev-journal-title>
          </journal-title-group>
          <issn pub-type="ppub">1314-2836</issn>
          <issn pub-type="epub">1314-2828</issn>
        </xsl:when>
      </xsl:choose>
      <publisher>
        <publisher-name>Pensoft Publishers</publisher-name>
      </publisher>
    </journal-meta>
  </xsl:template>

  <xsl:template name="front-article-meta">
    <article-meta>
      <article-id pub-id-type="publisher-id"><xsl:value-of select="$jname"/></article-id>
      <article-id pub-id-type="doi">10.3897/xxx.000.0000</article-id>
      <article-id pub-id-type="other"><xsl:value-of select="/document/@id"/></article-id>
      <xsl:call-template name="front-article-categories"/>
      <xsl:call-template name="front-title-group"/>
      <xsl:call-template name="front-authors"/>
      <xsl:call-template name="front-editors"/>
      <xsl:call-template name="front-affiliations"/>
      <xsl:call-template name="front-author-notes"/>
      <pub-date pub-type="collection">
        <year>2013</year>
      </pub-date>
      <pub-date pub-type="epub">
        <day>16</day>
        <month>9</month>
        <year>2013</year>
      </pub-date>
      <issue>1</issue>
      <elocation-id>e</elocation-id>
      <history>
        <date date-type="received">
          <day>00</day>
          <month>9</month>
          <year>2013</year>
        </date>
        <date date-type="accepted">
          <day>00</day>
          <month>9</month>
          <year>2013</year>
        </date>
      </history>
      <xsl:call-template name="front-permissions"/>
      <xsl:call-template name="front-abstract"/>
      <xsl:call-template name="front-keywords"/>
      <xsl:call-template name="front-funding"/>
      <xsl:call-template name="front-counts"/>
    </article-meta>
  </xsl:template>
  <xsl:template name="front-article-categories">
    <article-categories>
      <xsl:for-each select="$front_classifications/fields">
        <xsl:apply-templates mode="front-classification" select="taxon_classification"/>
        <xsl:apply-templates mode="front-classification" select="subject_classification"/>
        <xsl:apply-templates mode="front-classification" select="chronological_classification"/>
        <xsl:apply-templates mode="front-classification" select="geographical_classification"/>
      </xsl:for-each>
    </article-categories>
  </xsl:template>
  <xsl:template mode="front-classification" match="*">
    <xsl:if test="normalize-space(.)!=''">
      <subj-group>
        <xsl:attribute name="subj-group-type">
          <xsl:value-of select="@field_name"/>
        </xsl:attribute>
        <xsl:for-each select="value">
          <subject>  
            <xsl:value-of select="."/>
          </subject>
        </xsl:for-each>
      </subj-group>
    </xsl:if>
  </xsl:template>
  <xsl:template name="front-title-group">
    <title-group>
      <article-title>
        <xsl:apply-templates mode="title" select="$front_article_title"/>
      </article-title>
    </title-group>
  </xsl:template>

  <xsl:template name="front-authors">
    <contrib-group>
      <xsl:attribute name="content-type">authors</xsl:attribute>
      <xsl:for-each select="$front_authors/author">
        <xsl:variable name="num" select="position()"/>
        <contrib>
          <xsl:attribute name="contrib-type">author</xsl:attribute>
          <xsl:attribute name="corresp">
            <xsl:choose>
              <xsl:when test="normalize-space(fields/corresponding_author/value)=''">no</xsl:when>
              <xsl:otherwise>yes</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:apply-templates mode="front-author-name" select="fields"/>
          <xsl:for-each select="fields/e-mail[normalize-space(.)!='']">
            <email>
              <xsl:attribute name="xlink:type">simple</xsl:attribute>
              <xsl:value-of select="normalize-space(value)"/>
            </email>
          </xsl:for-each>
          <xsl:for-each select="node()[@object_id='5'][normalize-space(.)!='']">
            <xsl:apply-templates mode="front-xref-aff" select="."/>
          </xsl:for-each>
        </contrib>
      </xsl:for-each>
    </contrib-group>
  </xsl:template>
  <xsl:template name="front-editors">
    <xsl:if test="normalize-space($front_contributors)!=''">
      <contrib-group>
        <xsl:attribute name="content-type">editors</xsl:attribute>
        <xsl:for-each select="$front_contributors/contributor">
          <xsl:variable name="num" select="position() + $front_authors_number"/>
          <contrib>
            <xsl:attribute name="contrib-type">editor</xsl:attribute>
            <xsl:apply-templates mode="front-author-name" select="fields"/>
            <xsl:for-each select="fields/e-mail">
              <email>
                <xsl:attribute name="xlink:type">simple</xsl:attribute>
                <xsl:value-of select="value"/>
              </email>
            </xsl:for-each>
            <xsl:for-each select="fields/role">
              <xsl:for-each select="value[normalize-space(.)!='']">
                <role><xsl:value-of select="."/></role>
              </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="node()[@object_id='5'][normalize-space(.)!='']">
              <xsl:apply-templates mode="front-xref-aff" select="."/>
            </xsl:for-each>
          </contrib>
        </xsl:for-each>
      </contrib-group>
    </xsl:if>
  </xsl:template>
  <xsl:template mode="front-getname" match="*">
    <xsl:variable name="last" select="normalize-space(last_name/value)"/>
    <xsl:variable name="first" select="normalize-space(first_name/value)"/>
    <xsl:variable name="middle" select="normalize-space(middle_name/value)"/>
    <xsl:variable name="salut" select="normalize-space(salutation/value)"/>
    <xsl:value-of select="$first"/>
    <xsl:if test="$middle!=''">
      <xsl:text> </xsl:text>
      <xsl:value-of select="$middle"/>
    </xsl:if>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$last"/>
  </xsl:template>
  <xsl:template mode="front-author-name" match="*">
    <xsl:variable name="last" select="normalize-space(last_name/value)"/>
    <xsl:variable name="first" select="normalize-space(first_name/value)"/>
    <xsl:variable name="middle" select="normalize-space(middle_name/value)"/>
    <xsl:variable name="salut" select="normalize-space(salutation/value)"/>
    <name>
      <xsl:attribute name="name-style">western</xsl:attribute>
      <surname>
        <xsl:value-of select="$last"/>
      </surname>
      <given-names>
        <xsl:value-of select="$first"/>
        <xsl:if test="$middle!=''">
          <xsl:text> </xsl:text>
          <xsl:value-of select="$middle"/>
        </xsl:if>
      </given-names>
      <xsl:if test="$salut!=''">
        <prefix>
          <xsl:value-of select="$salut"/>
        </prefix>
      </xsl:if>
    </name>
  </xsl:template>
  <xsl:template mode="front-author-aff" match="*">
    <xsl:variable name="affiliation" select="normalize-space(affiliation/value)"/>
    <xsl:variable name="city" select="normalize-space(city/value)"/>
    <xsl:variable name="country" select="normalize-space(country/value)"/>
    <aff>
      <addr-line>
        <xsl:value-of select="$affiliation"/><xsl:text>, </xsl:text><xsl:value-of select="$city"/><xsl:text>, </xsl:text><xsl:value-of select="$country"/>
      </addr-line>
      <country>
        <xsl:value-of select="$country"/>
      </country>
      <institution>
        <xsl:value-of select="$affiliation"/>
      </institution>
    </aff>
  </xsl:template>

  <xsl:template name="front-affiliations">
    <xsl:variable name="addr" select="/document/objects/article_metadata"/>
    <xsl:variable name="order"><xsl:call-template name="front-aff-order"/></xsl:variable>
    <xsl:for-each select="$addr//node()[@object_id='5']">
      <xsl:if test="contains($order, string(position()))">
        <xsl:variable name="num">
          <xsl:call-template name="position">
            <xsl:with-param name="string" select="$order"/>
            <xsl:with-param name="substring" select="position()"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:apply-templates mode="front-aff" select="fields">
          <xsl:with-param name="num"><xsl:value-of select="$num"/></xsl:with-param>
        </xsl:apply-templates>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="front-aff" match="*">
    <xsl:param name="num"/>
    <xsl:variable name="affiliation" select="normalize-space(affiliation/value)"/>
    <xsl:variable name="city" select="normalize-space(city/value)"/>
    <xsl:variable name="country" select="normalize-space(country/value)"/>
    <aff>
      <xsl:attribute name="id">
        <xsl:text>A</xsl:text><xsl:value-of select="$num"/>
      </xsl:attribute>
      <label><xsl:value-of select="$num"/></label>
      <addr-line>
        <xsl:value-of select="$affiliation"/>
        <xsl:text>, </xsl:text><xsl:value-of select="$city"/>
        <xsl:text>, </xsl:text><xsl:value-of select="$country"/>
      </addr-line>
    </aff>
  </xsl:template>
  <xsl:template name="position">
    <xsl:param name="string"/>
    <xsl:param name="substring"/>
    <xsl:variable name="newstring" select="normalize-space(substring-before($string, $substring))"/>
    <xsl:choose>
      <xsl:when test="$newstring=''">
        <xsl:text>1</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="count-comma">
          <xsl:with-param name="string" select="$newstring"/>
          <xsl:with-param name="count" select="1"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="count-comma">
    <xsl:param name="string" select="''"/>
    <xsl:param name="count" select="1"/>
    <xsl:choose>
      <xsl:when test="contains($string, ',')">
        <xsl:call-template name="count-comma">
          <xsl:with-param name="string" select="substring-after($string, ',')"/>
          <xsl:with-param name="count" select="$count + 1"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$count"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="front-aff-order">
    <xsl:variable name="addr" select="/document/objects/article_metadata"/>
    <xsl:variable name="order"><xsl:call-template name="front-get-aff-order"/></xsl:variable>
    <xsl:for-each select="$addr//node()[@object_id='5']">
      <xsl:if test="contains($order, string(position()))">
        <xsl:value-of select="position()"/>
        <xsl:text>,</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="front-get-aff-order">
    <xsl:variable name="addr" select="/document/objects/article_metadata"/>
    <xsl:for-each select="$addr//node()[@object_id='5']">
      <xsl:variable name="addrnum">
        <xsl:apply-templates mode="front-get-aff-number" select="."/>
      </xsl:variable>
      <xsl:variable name="an">
        <xsl:value-of select="substring-before($addrnum, ',')"/>
      </xsl:variable>
      <xsl:value-of select="$an"/>
      <xsl:text>,</xsl:text>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="front-get-aff-number" match="*">
    <xsl:variable name="inaddr" select="normalize-space(.)"/>
    <xsl:for-each select="/document/objects/article_metadata//node()[@object_id='5']">
      <xsl:variable name="outaddr" select="normalize-space(.)"/>
      <xsl:if test="$inaddr=$outaddr">
        <xsl:value-of select="position()"/>
        <xsl:text>,</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="front-xref-aff" match="*">
    <xsl:variable name="order"><xsl:call-template name="front-aff-order"/></xsl:variable>
    <xsl:variable name="addrnum"><xsl:apply-templates mode="front-get-aff-number" select="."/></xsl:variable>
    <xsl:variable name="an">
      <xsl:call-template name="position">
        <xsl:with-param name="string" select="$order"/>
        <xsl:with-param name="substring" select="substring-before($addrnum, ',')"/>
      </xsl:call-template>
    </xsl:variable>
    <xref>
      <xsl:attribute name="ref-type">aff</xsl:attribute>
      <xsl:attribute name="rid"><xsl:text>A</xsl:text><xsl:value-of select="$an"/></xsl:attribute>
      <xsl:value-of select="$an"/>
    </xref>
  </xsl:template>

  <xsl:template name="front-author-notes">
    <author-notes>
      <xsl:call-template name="front-corresponding-authors"/>
      <xsl:call-template name="front-academic-editor"/>
    </author-notes>
  </xsl:template>
  <xsl:template name="front-corresponding-authors">
    <fn>
      <xsl:attribute name="fn-type">corresp</xsl:attribute>
      <p>
        <xsl:choose>
          <xsl:when test="count($front_authors/author[fields/corresponding_author/value!=''])=1">
            <xsl:text>Corresponding author: </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Corresponding authors: </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:for-each select="$front_authors/author[fields/corresponding_author/value!='']">
          <xsl:apply-templates mode="front-getname" select="fields"/>
          <xsl:text> (</xsl:text><email xlink:type="simple"><xsl:value-of select="fields/e-mail"/></email><xsl:text>)</xsl:text>
          <xsl:choose>
            <xsl:when test="position()=last()">
              <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>, </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </p>
    </fn>
  </xsl:template>
  <xsl:template name="front-academic-editor">
    <fn>
      <xsl:attribute name="fn-type">edited-by</xsl:attribute>
      <p>Academic editor: </p>
    </fn>
  </xsl:template>

  <xsl:template name="front-permissions">
    <permissions>
      <copyright-statement>
        <xsl:for-each select="$front_authors/author">
          <xsl:apply-templates mode="front-getname" select="fields"/>
          <xsl:if test="position()!=last()">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </copyright-statement>
      <license license-type="creative-commons-attribution" xlink:href="http://creativecommons.org/licenses/by/3.0" xlink:type="simple">
        <license-p>This is an open access article distributed under the terms of the Creative Commons Attribution License 3.0 (CC-BY), which permits unrestricted use, distribution, and reproduction in any medium, provided the original author and source are credited.</license-p>
      </license>
    </permissions>
  </xsl:template>
  
  <xsl:template name="front-abstract">
    <xsl:for-each select="$front_abstract[normalize-space(.)!='']">
      <abstract>
        <label>Abstract</label>
        <xsl:apply-templates mode="p" select="value"/>
      </abstract>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="front-keywords">
    <xsl:for-each select="$front_keywords[normalize-space(value)!='']">
      <kwd-group>
        <label>Keywords</label>
        <xsl:for-each select="value">
          <xsl:variable name="kwds">
            <xsl:apply-templates mode="xml-to-string" select="."/>
          </xsl:variable>
          <xsl:call-template name="text-to-xml">
            <xsl:with-param name="text">
              <xsl:call-template name="kwd">
                <xsl:with-param name="string" select="normalize-space($kwds)"/>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>
      </kwd-group>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="kwd">
    <xsl:param name="string" select="''"/>
    <xsl:choose>
      <xsl:when test="contains($string, ',')">
        <xsl:variable name="kwd" select="normalize-space(substring-before($string, ','))"/>
        <xsl:if test="$kwd!=''">
          <xsl:text>{kwd}</xsl:text>
          <xsl:value-of select="$kwd"/>
          <xsl:text>{/kwd}</xsl:text>
        </xsl:if>
        <xsl:call-template name="kwd">
          <xsl:with-param name="string" select="substring-after($string, ',')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($string, ';')">
        <xsl:variable name="kwd" select="normalize-space(substring-before($string, ';'))"/>
        <xsl:if test="$kwd!=''">
          <xsl:text>{kwd}</xsl:text>
          <xsl:value-of select="$kwd"/>
          <xsl:text>{/kwd}</xsl:text>
        </xsl:if>
        <xsl:call-template name="kwd">
          <xsl:with-param name="string" select="substring-after($string, ';')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="kwd" select="normalize-space($string)"/>
        <xsl:if test="$kwd!=''">
          <xsl:text>{kwd}</xsl:text>
          <xsl:value-of select="$kwd"/>
          <xsl:text>{/kwd}</xsl:text>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="xml-to-string" match="*">
    <xsl:for-each select="node()">
      <xsl:choose>
        <xsl:when test="name()='p'">
          <xsl:apply-templates mode="xml-to-string" select="."/>
        </xsl:when>
        <xsl:when test="name()=''">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:when test="name()='ul' or name()='ol'">
          <!-- Skip this tags -->
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>{</xsl:text>
          <xsl:value-of select="name()"/>
          <xsl:for-each select="@*">
            <xsl:text>(((</xsl:text>
            <xsl:value-of select="name(.)"/>
            <xsl:text>#</xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>)))</xsl:text>
          </xsl:for-each>
          <xsl:text>}</xsl:text>
          <xsl:apply-templates mode="xml-to-string" select="."/>
          <xsl:text>{/</xsl:text>
          <xsl:value-of select="name()"/>
          <xsl:text>}</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="text-to-xml">
    <xsl:param name="text" select="''"/>
    <xsl:choose>
      <xsl:when test="contains($text,'}')=true() and contains($text,'{')=true()">
        <xsl:variable name="first_tag" select="substring-before(substring-after($text,'{'),'}')"/>
        <xsl:variable name="tag_name">
          <xsl:choose>
            <xsl:when test="contains($first_tag,'(((')">
              <xsl:value-of select="substring-before($first_tag, '(((')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$first_tag"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="l">
          <xsl:text>{</xsl:text>
          <xsl:value-of select="$first_tag"/>
          <xsl:text>}</xsl:text>
        </xsl:variable>
        <xsl:variable name="r">
          <xsl:text>{/</xsl:text>
          <xsl:value-of select="$tag_name"/>
          <xsl:text>}</xsl:text>
        </xsl:variable>
        <xsl:variable name="attr_name" select="substring-after(substring-before($first_tag,'#'),'(((')"/>
        <xsl:variable name="attr_value" select="substring-after(substring-before($first_tag,')))'),'#')"/>
        <xsl:variable name="before" select="substring-before($text,$l)"/>
        <xsl:variable name="after" select="substring-after($text,$r)"/>
        <xsl:variable name="in" select="substring-before(substring-after($text,$l),$r)"/>
        <xsl:value-of select="$before"/>
        <xsl:element name="{$tag_name}">
          <xsl:if test="$attr_name!=''">
            <xsl:attribute name="{$attr_name}">
              <xsl:value-of select="$attr_value"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:call-template name="text-to-xml">
            <xsl:with-param name="text" select="$in"/>
          </xsl:call-template>
        </xsl:element>
        <xsl:call-template name="text-to-xml">
          <xsl:with-param name="text" select="$after"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="front-funding">
    <xsl:for-each select="$front_funding/fields">
      <xsl:if test="count(supporting_agencies[.//value!=''])!=0">
        <funding-group>
          <xsl:for-each select="supporting_agencies">
            <xsl:if test="normalize-space(value)!=''">
              <award-group>
                <funding-source>
                  <xsl:value-of select="normalize-space(value)"/>
                </funding-source>
              </award-group>
            </xsl:if>
          </xsl:for-each>
        </funding-group>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="front-counts">
    <counts>
      <fig-count>
        <xsl:attribute name="count">
          <xsl:value-of select="count(//figures/figure)"/>
        </xsl:attribute>
      </fig-count>
      <table-count>
        <xsl:attribute name="count">
          <xsl:value-of select="count(//tables/table)"/>
        </xsl:attribute>
      </table-count>
      <ref-count>
        <xsl:attribute name="count">
          <xsl:value-of select="count(//references/reference)"/>
        </xsl:attribute>
      </ref-count>
    </counts>
  </xsl:template>
</xsl:stylesheet>
