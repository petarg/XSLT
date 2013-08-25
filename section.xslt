<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">

  <xsl:template mode="section" match="*">
    <xsl:param name="title"/>
    <xsl:choose>
      <xsl:when test="normalize-space(fields/title/value)!=''">
        <xsl:if test="count(fields/node()[name()!='' and name()!='title'][normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0])!=0">
          <sec>
            <xsl:attribute name="sec-type">
              <xsl:value-of select="$title"/>
            </xsl:attribute>
            <title>
              <xsl:apply-templates mode="title" select="fields/title/value"/>
            </title>
            <xsl:apply-templates mode="p" select="fields/*[name()!='title']/value" />
            <xsl:apply-templates mode="subsection" select="."/>
          </sec>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <sec>
          <xsl:attribute name="sec-type">
            <xsl:value-of select="$title"/>
          </xsl:attribute>
          <title>
            <xsl:value-of select="$title"/>
          </title>
          <xsl:apply-templates mode="p" select="fields/*[name()!='title']/value" />
          <xsl:apply-templates mode="subsection" select="."/>
        </sec>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="subsection" match="*">
    <xsl:for-each select="subsection">
      <xsl:variable name="title" select="fields/node()[@id='211']/value"/>
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="normalize-space($title)"/>
        </xsl:attribute>
        <title>
          <xsl:apply-templates mode="title" select="$title"/>
        </title>
        <xsl:apply-templates mode="p" select="fields/content/value" />
      </sec>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="little-section" match="*">
    <sec>
      <xsl:attribute name="sec-type">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <title>
        <xsl:value-of select="@field_name"/>
      </title>
      <xsl:apply-templates mode="p" select="value"/>
    </sec>
  </xsl:template>
  <xsl:template mode="little-section-uri" match="*">
    <sec>
      <xsl:attribute name="sec-type">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <title>
        <xsl:value-of select="@field_name"/>
      </title>
      <p>
        <uri>
          <xsl:value-of select="normalize-space(value)"/>
        </uri>
      </p>
    </sec>
  </xsl:template>
  <xsl:template mode="little-p" match="*">
    <xsl:choose>
      <xsl:when test="@id='307' or @id='293' or @id='294' or @id='295' or @id='296' or @id='297' or @id='298' or @id='299' or @id='300'">
        <xsl:variable name="address" select="normalize-space(value)"/>
        <p>
          <xsl:value-of select="@field_name"/>
          <xsl:text>: </xsl:text>
          <ext-link>
            <xsl:attribute name="ext-link-type">uri</xsl:attribute>
            <xsl:attribute name="xlink:href">
              <xsl:value-of select="$address"/>
            </xsl:attribute>
            <xsl:value-of select="$address"/>
          </ext-link>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:value-of select="@field_name"/>
          <xsl:text>: </xsl:text>
          <xsl:apply-templates mode="format" select="value"/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="data-p" match="*">
    <xsl:for-each select="value[normalize-space(.)!='']">
      <p>
        <bold>
          <xsl:value-of select="../@field_name"/>
          <xsl:text>:</xsl:text>
        </bold>
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
      </p>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="data-p-link" match="*">
    <xsl:for-each select="value[normalize-space(.)!='']">
      <xsl:variable name="value" select="normalize-space(.)"/>
      <p>
        <bold><xsl:value-of select="../@field_name"/><xsl:text>:</xsl:text></bold>
        <xsl:text> </xsl:text>
        <ext-link>
          <xsl:attribute name="ext-link-type">uri</xsl:attribute>
          <xsl:attribute name="xlink:href"><xsl:value-of select="$value"/></xsl:attribute>
          <xsl:value-of select="$value"/>
        </ext-link>
      </p>
    </xsl:for-each>
  </xsl:template>
<!-- 
#
#  Some non-trivial sections
#
 -->
  <xsl:template mode="project-decription" match="*">
    <xsl:for-each select="fields[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="../@display_name"/>
        </xsl:attribute>
        <xsl:for-each select="node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:choose>
            <xsl:when test="name()='title'">
              <title>
                <xsl:apply-templates mode="title" select="value"/>
              </title>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates mode="little-section" select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="geographic-coverage" match="*">
    <xsl:for-each select="fields[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <xsl:variable name="west" select="node()[@id='317']"/>
      <xsl:variable name="east" select="node()[@id='318']"/>
      <xsl:variable name="south" select="node()[@id='319']"/>
      <xsl:variable name="north" select="node()[@id='320']"/>
      <xsl:variable name="global" select="node()[@id='321']"/>
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="../@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="../@display_name"/>
        </title>
        <xsl:for-each select="description[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <p>
            <bold>
              <xsl:value-of select="@field_name"/>
              <xsl:text>:</xsl:text>
            </bold>
          </p>
          <xsl:apply-templates mode="p" select="value"/>
        </xsl:for-each>
        <xsl:apply-templates mode="data-p" select="$east"/>
        <xsl:apply-templates mode="data-p" select="$west"/>
        <xsl:apply-templates mode="data-p" select="$north"/>
        <xsl:apply-templates mode="data-p" select="$south"/>
        <xsl:apply-templates mode="data-p" select="$global"/>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="usage-rights" match="*">
    <xsl:for-each select="fields[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="../@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="../@display_name"/>
        </title>
        <xsl:for-each select="node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="little-section" select="."/>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="software-specification" match="*">
    <xsl:for-each select="fields[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="../@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="../@display_name"/>
        </title>
        <xsl:for-each select="node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:choose>
            <xsl:when test="@id='329'">
              <xsl:apply-templates mode="little-section-uri" select="."/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates mode="little-section" select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="taxonomic-coverage" match="*">
    <xsl:if test="normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="@display_name"/>
        </title>
        <xsl:for-each select="fields/node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="little-section" select="."/>
        </xsl:for-each>
        <xsl:for-each select="taxa[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="taxa" select="."/>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:if>
  </xsl:template>
  <xsl:template mode="taxa" match="*">
    <xsl:variable name="sci_name" select="normalize-space(fields/node()[@id='451']/value)"/>
    <xsl:variable name="com_name" select="fields/node()[@id='452']"/>
    <xsl:variable name="rank" select="normalize-space(fields/node()[@id='453']/value)"/>
    <tp:taxon-treatment>
      <tp:nomenclature>
        <tp:taxon-name>
          <tp:taxon-name-part>
            <xsl:attribute name="taxon-name-part-type"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:value-of select="$sci_name"/>
          </tp:taxon-name-part>
        </tp:taxon-name>
        <tp:nomenclature-citation-list>
          <tp:nomenclature-citation>
            <tp:taxon-name><xsl:value-of select="$sci_name"/></tp:taxon-name>
            <comment>
              <xsl:value-of select="$com_name/@field_name"/>
              <xsl:text>: </xsl:text>
              <xsl:value-of select="normalize-space($com_name/value)"/>
            </comment>
          </tp:nomenclature-citation>
        </tp:nomenclature-citation-list>
      </tp:nomenclature>
    </tp:taxon-treatment>
  </xsl:template>

  <xsl:template mode="software-description-section" match="*">
    <xsl:for-each select="fields[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="../@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="../@display_name"/>
        </title>
        <xsl:for-each select="node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:choose>
            <xsl:when test="@id='329'">
              <xsl:apply-templates mode="little-section-uri" select="."/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates mode="little-section" select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="web-locations-section" match="*">
    <xsl:for-each select="fields[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="../@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="../@display_name"/>
        </title>
        <xsl:for-each select="node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="little-p" select="."/>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="web-locations-section1" match="*">
    <xsl:variable name="homepage" select="normalize-space(fields/homepage/value)"/>
    <xsl:variable name="wiki" select="normalize-space(fields/wiki/value)"/>
    <xsl:variable name="download_page" select="normalize-space(fields/download_page/value)"/>
    <xsl:variable name="download_mirror" select="normalize-space(fields/download_mirror/value)"/>
    <xsl:variable name="bug_database" select="normalize-space(fields/bug_database/value)"/>
    <xsl:variable name="mailing_list" select="normalize-space(fields/mailing_list/value)"/>
    <xsl:variable name="blog" select="normalize-space(fields/blog/value)"/>
    <xsl:variable name="vendor" select="normalize-space(fields/vendor/value)"/>
    <sec>
      <xsl:attribute name="sec-type">
        <xsl:value-of select="@display_name"/>
      </xsl:attribute>
      <title>
        <xsl:value-of select="@display_name"/>
      </title>
      <xsl:if test="$homepage!=''">
        <p>
          <xsl:value-of select="fields/homepage/@field_name"/>
          <xsl:text>: </xsl:text>
          <uri><xsl:value-of select="$homepage"/></uri>
        </p>
      </xsl:if>
      <xsl:if test="$wiki!=''">
        <p>
          <xsl:value-of select="fields/wiki/@field_name"/>
          <xsl:text>: </xsl:text>
          <uri><xsl:value-of select="$wiki"/></uri>
        </p>
      </xsl:if>
      <xsl:if test="$download_page!=''">
        <p>
          <xsl:value-of select="fields/download_page/@field_name"/>
          <xsl:text>: </xsl:text>
          <uri><xsl:value-of select="$download_page"/></uri>
        </p>
      </xsl:if>
      <xsl:if test="$download_mirror!=''">
        <p><xsl:value-of select="fields/download_mirror/@field_name"/><xsl:text>: </xsl:text><uri><xsl:value-of select="$download_mirror"/></uri></p>
      </xsl:if>
      <xsl:if test="$bug_database!=''">
        <p>
          <xsl:value-of select="fields/bug_database/@field_name"/>
          <xsl:text>: </xsl:text>
          <uri><xsl:value-of select="$bug_database"/></uri>
        </p>
      </xsl:if>
      <xsl:if test="$mailing_list!=''">
        <p>
          <xsl:value-of select="fields/mailing_list/@field_name"/>
          <xsl:text>: </xsl:text>
          <uri><xsl:value-of select="$mailing_list"/></uri>
        </p>
      </xsl:if>
      <xsl:if test="$blog!=''">
        <p>
          <xsl:value-of select="fields/blog/@field_name"/>
          <xsl:text>: </xsl:text>
          <uri><xsl:value-of select="$blog"/></uri>
        </p>
      </xsl:if>
      <xsl:if test="$vendor!=''">
        <p>
          <xsl:value-of select="fields/vendor/@field_name"/>
          <xsl:text>: </xsl:text>
          <uri><xsl:value-of select="$vendor"/></uri>
        </p>
      </xsl:if>
    </sec>
  </xsl:template>

  <!-- Data paper specific -->
  <xsl:template mode="general-description-section" match="*">
    <xsl:for-each select="fields[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="../@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="../@display_name"/>
        </title>
        <xsl:for-each select="node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="little-section" select="."/>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="sampling-methods-section" match="*">
    <xsl:for-each select="fields[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="../@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="../@display_name"/>
        </title>
        <xsl:for-each select="node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="little-section" select="."/>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="collection-data-section" match="*">
    <xsl:for-each select="fields[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="../@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="../@display_name"/>
        </title>
        <xsl:for-each select="node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="little-section" select="."/>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template mode="temporal-coverage-wrapper-section" match="*">
    <xsl:if test="normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="@display_name"/>
        </title>
        <xsl:for-each select="node()[@object_id='124'][normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="temporal-coverage-section" select="."/>
        </xsl:for-each>
        <xsl:apply-templates mode="subsection" select="."/>
      </sec>
    </xsl:if>
  </xsl:template>
  <xsl:template mode="temporal-coverage-section" match="*">
    <xsl:variable name="type" select="fields/node()[@id='335']"/>
    <xsl:variable name="start" select="fields/node()[@id='392']"/>
    <xsl:variable name="living" select="fields/node()[@id='393']"/>
    <xsl:variable name="formation" select="fields/node()[@id='394']"/>
    <xsl:variable name="data_s" select="fields/node()[@id='395']"/>
    <xsl:variable name="data_e" select="fields/node()[@id='396']"/>
    <sec>
      <xsl:attribute name="sec-type">
        <xsl:value-of select="../@display_name"/>
      </xsl:attribute>
      <title>
        <xsl:value-of select="../@display_name"/>
      </title>
      <xsl:apply-templates mode="data-p" select="$type"/>
      <xsl:apply-templates mode="data-p" select="$start"/>
      <xsl:apply-templates mode="data-p" select="$living"/>
      <xsl:apply-templates mode="data-p" select="$formation"/>
      <xsl:apply-templates mode="data-p" select="$data_s"/>
      <xsl:apply-templates mode="data-p" select="$data_e"/>
    </sec>
  </xsl:template>
  
  <xsl:template mode="editorial-main-text" match="*">
    <xsl:variable name="title" select="fields/node()[@id='413']/value"/>
    <xsl:variable name="main" select="fields/node()[@id='412']/value"/>
    <sec>
      <xsl:attribute name="sec-type">
        <xsl:value-of select="@display_name"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="normalize-space($title)=''">
          <title><xsl:text>Main Text</xsl:text></title>
        </xsl:when>
        <xsl:otherwise>
          <title><xsl:apply-templates mode="title" select="$title"/></title>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="p" select="$main"/>
      <xsl:apply-templates mode="subsection" select="."/>
    </sec>
  </xsl:template>
</xsl:stylesheet>
