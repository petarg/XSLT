<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">

  <xsl:template mode="data-resources" match="*">
    <xsl:if test="normalize-space(.)!=''">
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="@display_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="@display_name"/>
        </title>
        <xsl:apply-templates mode="little-section" select="fields/node()[@id='339']"/><!-- Data package title -->
        <xsl:apply-templates mode="little-section" select="fields/node()[@id='340']"/><!-- Resource link -->
        <xsl:apply-templates mode="little-section" select="fields/node()[@id='341']"/><!-- Alternative identifiers -->
        <xsl:apply-templates mode="little-section" select="fields/node()[@id='342']"/><!-- Number of data sets -->
        <!-- Data sets -->
        <xsl:for-each select="node()[@object_id='141'][normalize-space(.)!='']">
          <xsl:apply-templates mode="data-set" select=".">
            <xsl:with-param name="n" select="position()"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </sec>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="data-set" match="*">
    <xsl:param name="n" select='0'/>
    <xsl:variable name="title">
      <xsl:text>Data set </xsl:text>
      <xsl:value-of select="$n"/>
    </xsl:variable>
    
    <xsl:variable name="description" select="fields/node()[@id='399']"/>
    <sec>
      <xsl:attribute name="sec-type">
        <xsl:value-of select="$title"/>
      </xsl:attribute>
      <title>
        <xsl:value-of select="$title"/>
        <xsl:text>.</xsl:text>
      </title>
      <xsl:apply-templates mode="little-section" select="fields/node()[@id='397']"/><!-- Data set name -->
      <xsl:apply-templates mode="little-section" select="fields/node()[@id='398']"/><!-- Data format -->
      <xsl:apply-templates mode="little-section" select="fields/node()[@id='400']"/><!-- Number of columns -->
      <xsl:apply-templates mode="little-section" select="fields/node()[@id='457']"/><!-- Character set -->
      <xsl:apply-templates mode="little-section" select="fields/node()[@id='458']"/><!-- Download URL -->
      <xsl:apply-templates mode="little-section" select="fields/node()[@id='459']"/><!-- Data format version -->
      <!-- Description -->
      <sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="$description/@field_name"/>
        </xsl:attribute>
        <title>
          <xsl:value-of select="$description/@field_name"/>
        </title>
        <xsl:apply-templates mode="p" select="value"/>
        <table-wrap>
          <xsl:attribute name="id">
            <xsl:text>DS</xsl:text>
            <xsl:value-of select="$n"/>
          </xsl:attribute>
          <xsl:attribute name="orientation">portrait</xsl:attribute>
          <xsl:attribute name="position">anchor</xsl:attribute>
          <label>
            <xsl:value-of select="$title"/>
            <xsl:text>.</xsl:text>
          </label>
          <table>
            <thead>
              <tr>
                <th>
                  <xsl:attribute name="rowspan">1</xsl:attribute>
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:value-of select="column[1]/fields/node()[@id='401']/@field_name"/>
                </th>
                <th>
                  <xsl:attribute name="rowspan">1</xsl:attribute>
                  <xsl:attribute name="colspan">1</xsl:attribute>
                  <xsl:value-of select="column[1]/fields/node()[@id='402']/@field_name"/>
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="column">
                <xsl:apply-templates mode="column" select="."/>
              </xsl:for-each>
            </tbody>
          </table>
        </table-wrap>
      </sec>
    </sec>
  </xsl:template>

  <xsl:template mode="column" match="*">
    <tr>
      <td>
        <xsl:attribute name="rowspan">1</xsl:attribute>
        <xsl:attribute name="colspan">1</xsl:attribute>
        <xsl:apply-templates mode="format" select="fields/node()[@id='401']/value"/>
      </td>
      <td>
        <xsl:attribute name="rowspan">1</xsl:attribute>
        <xsl:attribute name="colspan">1</xsl:attribute>
        <xsl:apply-templates mode="format" select="fields/node()[@id='402']/value"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>