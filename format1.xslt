<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">

  <xsl:template name="raise-error">
    <xsl:param name="content"/>
    <ERROR>
      <xsl:value-of select="$content"/>
    </ERROR>
  </xsl:template>

  <xsl:template mode="p" match="*">
    <xsl:choose>
      <xsl:when test="normalize-space(.)=''"/>
      <xsl:when test="count(node()[(name()='p') or (name()='ul') or (name()='ol')])!=0">
        <xsl:for-each select="node()[(normalize-space(.)!='') or (name()!='')]">
          <xsl:apply-templates mode="p-format" select="."/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates mode="format" select="."/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="p-format" match="br"/>
  <xsl:template mode="p-format" match="@*"/>
  <xsl:template mode="p-format" match="node()">
    <xsl:choose>
      <xsl:when test="name()=''"/>
      <xsl:otherwise>
        <INVALID-TAG>
          <xsl:copy-of select="."/>
        </INVALID-TAG>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="p-format" match="comment()">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template mode="p-format" match="p">
    <p>
      <xsl:apply-templates mode="format" select="."/>
    </p>
  </xsl:template>
  <xsl:template mode="p-format" match="ol">
    <list>
      <xsl:attribute name="list-type">order</xsl:attribute>
      <xsl:apply-templates mode="p-format" select="node()"/>
    </list>
  </xsl:template>
  <xsl:template mode="p-format" match="ul">
    <list>
      <xsl:attribute name="list-type">bullet</xsl:attribute>
      <xsl:apply-templates mode="p-format" select="node()"/>
    </list>
  </xsl:template>
  <xsl:template mode="p-format" match="li">
    <list-item>
      <p>
        <xsl:apply-templates mode="format" select="."/>
      </p>
    </list-item>
  </xsl:template>

  <xsl:template mode="format" match="*">
    <xsl:for-each select="node()">
      <xsl:choose>
        <xsl:when test="name()=''">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:when test="name()='italic' or name()='bold' or name()='underline' or name()='sup' or name()='sub'">
          <xsl:element name="{name()}">
            <xsl:apply-templates mode="format" select="."/>
          </xsl:element>
        </xsl:when>
        <xsl:when test="name()='ext-link' or name()='tp:taxon-name'">
          <xsl:copy-of select="."/>
        </xsl:when>
        <xsl:when test="name()='br'">
          <xsl:text>&lt;br/&gt;</xsl:text>
        </xsl:when>
        <xsl:when test="name()='fig-citation'">
          <xsl:apply-templates mode="fig-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='tbls-citation'">
          <xsl:apply-templates mode="tbls-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='sup-files-citation'">
          <xsl:apply-templates mode="sup-files-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='reference-citation'">
          <xsl:apply-templates mode="reference-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='xref' and @type='bibr'">
          <xref>
            <xsl:attribute name="ref-type">bibr</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>B</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates mode="format" select="node()"/>
          </xref>
        </xsl:when>
        <xsl:when test="name()='xref' and @type='table'">
          <xref>
            <xsl:attribute name="ref-type">table</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>T</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates mode="format" select="node()"/>
          </xref>
        </xsl:when>
        <xsl:when test="name()='xref' and @type='fig'">
          <xref>
            <xsl:attribute name="ref-type">fig</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>T</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates mode="format" select="node()"/>
          </xref>
        </xsl:when>
        <xsl:when test="name()='locality-coordinates'">
          <named-content>
            <xsl:attribute name="content-type">dwc:verbatimCoordinates</xsl:attribute>
            <xsl:value-of select="normalize-space(.)"/>
          </named-content>
        </xsl:when>
        <xsl:otherwise>
          <INVALID-TAG>
            <xsl:copy-of select="."/>
          </INVALID-TAG>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="title" match="*">
    <xsl:choose>
      <xsl:when test="count(*[name()='p'])!=0">
        <xsl:for-each select="p[normalize-space(.)!='']">
          <xsl:if test="position()!=1"><break/></xsl:if>
          <xsl:apply-templates mode="format-title" select="."/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="format-title" select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="format-title" match="*">
    <xsl:for-each select="node()">
      <xsl:choose>
        <xsl:when test="name()=''">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:when test="name()='italic' or name()='underline' or name()='sup' or name()='sub'">
          <xsl:element name="{name()}">
            <xsl:apply-templates mode="format-title" select="."/>
          </xsl:element>
        </xsl:when>
        <xsl:when test="name()='bold'">
          <xsl:apply-templates mode="format-title" select="."/>
        </xsl:when>
        <xsl:when test="name()='ext-link' or name()='tp:taxon-name'">
          <xsl:copy-of select="."/>
        </xsl:when>
        <xsl:when test="name()='br'">
          <break/>
        </xsl:when>
        <xsl:when test="name()='fig-citation'">
          <xsl:apply-templates mode="fig-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='tbls-citation'">
          <xsl:apply-templates mode="tbls-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='sup-files-citation'">
          <xsl:apply-templates mode="sup-files-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='reference-citation'">
          <xsl:apply-templates mode="reference-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='xref' and @type='bibr'">
          <xref>
            <xsl:attribute name="ref-type">bibr</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>B</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates mode="format-title" select="node()"/>
          </xref>
        </xsl:when>
        <xsl:when test="name()='xref' and @type='table'">
          <xref>
            <xsl:attribute name="ref-type">table</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>T</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates mode="format-title" select="node()"/>
          </xref>
        </xsl:when>
        <xsl:when test="name()='xref' and @type='fig'">
          <xref>
            <xsl:attribute name="ref-type">fig</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>T</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates mode="format-title" select="node()"/>
          </xref>
        </xsl:when>
        <xsl:when test="name()='locality-coordinates'">
          <named-content>
            <xsl:attribute name="content-type">dwc:verbatimCoordinates</xsl:attribute>
            <xsl:value-of select="normalize-space(.)"/>
          </named-content>
        </xsl:when>
        <xsl:otherwise>
          <INVALID-TAG>
            <xsl:copy-of select="."/>
          </INVALID-TAG>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="td-format" match="*">
    <xsl:for-each select="node()[normalize-space(.)!='' or count(.//*[name()!=''])!=0]">
      <xsl:choose>
        <xsl:when test="name()='p'">
          <xsl:apply-templates mode="td-format" select="."/>
          <xsl:if test="position()!=last()">
            <break/>
          </xsl:if>
        </xsl:when>
        <xsl:when test="name()=''">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:when test="name()='italic' or name()='bold' or name()='underline' or name()='sup' or name()='sub'">
          <xsl:element name="{name()}">
            <xsl:apply-templates mode="td-format" select="."/>
          </xsl:element>
        </xsl:when>
        <xsl:when test="name()='ext-link' or name()='tp:taxon-name'">
          <xsl:copy-of select="."/>
        </xsl:when>
        <xsl:when test="name()='br'">
          <break/>
        </xsl:when>
        <xsl:when test="name()='fig-citation'">
          <xsl:apply-templates mode="fig-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='tbls-citation'">
          <xsl:apply-templates mode="tbls-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='sup-files-citation'">
          <xsl:apply-templates mode="sup-files-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='reference-citation'">
          <xsl:apply-templates mode="reference-citation" select="."/>
        </xsl:when>
        <xsl:when test="name()='xref' and @type='bibr'">
          <xref>
            <xsl:attribute name="ref-type">bibr</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>B</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates mode="td-format" select="node()"/>
          </xref>
        </xsl:when>
        <xsl:when test="name()='xref' and @type='table'">
          <xref>
            <xsl:attribute name="ref-type">table</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>T</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates mode="td-format" select="node()"/>
          </xref>
        </xsl:when>
        <xsl:when test="name()='xref' and @type='fig'">
          <xref>
            <xsl:attribute name="ref-type">fig</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>T</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates mode="td-format" select="node()"/>
          </xref>
        </xsl:when>
        <xsl:when test="name()='locality-coordinates'">
          <named-content>
            <xsl:attribute name="content-type">dwc:verbatimCoordinates</xsl:attribute>
            <xsl:value-of select="normalize-space(.)"/>
          </named-content>
        </xsl:when>
        <xsl:otherwise>
          <INVALID-TAG>
            <xsl:copy-of select="."/>
          </INVALID-TAG>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="reference-citation" match="*">
    <xsl:for-each select="node()">
      <xsl:choose>
        <xsl:when test="name()=''">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:when test="name()='xref'">
          <xref>
            <xsl:attribute name="ref-type">bibr</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>B</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </xref>
        </xsl:when>
        <xsl:otherwise>
          <INVALID-TAG>
            <xsl:copy-of select="."/>
          </INVALID-TAG>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="sup-files-citation" match="*">
    <xsl:for-each select="node()">
      <xsl:choose>
        <xsl:when test="name()=''">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:when test="name()='xref'">
          <xref>
            <xsl:attribute name="ref-type">supplementary-material</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>S</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </xref>
        </xsl:when>
        <xsl:otherwise>
          <INVALID-TAG>
            <xsl:copy-of select="."/>
          </INVALID-TAG>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="tbls-citation" match="*">
    <xsl:for-each select="node()">
      <xsl:choose>
        <xsl:when test="name()=''">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:when test="name()='xref'">
          <xref>
            <xsl:attribute name="ref-type">table</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>T</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </xref>
        </xsl:when>
        <xsl:otherwise>
          <INVALID-TAG>
            <xsl:copy-of select="."/>
          </INVALID-TAG>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="fig-citation" match="*">
    <xsl:for-each select="node()">
      <xsl:choose>
        <xsl:when test="name()=''">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:when test="name()='xref'">
          <xref>
            <xsl:attribute name="ref-type">fig</xsl:attribute>
            <xsl:attribute name="rid">
              <xsl:text>F</xsl:text>
              <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </xref>
        </xsl:when>
        <xsl:otherwise>
          <INVALID-TAG>
            <xsl:copy-of select="."/>
          </INVALID-TAG>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
