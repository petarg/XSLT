<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">

  <xsl:template name="body">
    <xsl:variable name="body" select="/document/objects"/>
    <body>
      <xsl:for-each select="$body/node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
<!--       <xsl:for-each select="$body/node()"> -->
        <xsl:choose>
          <!-- NON-TRIVIAL SECTIONS -->
          <xsl:when test="@object_id='54'"><!-- Systematics -->
            <xsl:apply-templates mode="systematics" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='203'"><!-- Check lists -->
            <xsl:apply-templates mode="checklists" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='204'">
            <xsl:apply-templates mode="checklist" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='211'">
            <xsl:apply-templates mode="checklist" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='24'">
            <xsl:apply-templates mode="keys" select="." />
          </xsl:when>
          <xsl:when test="@object_id='111'">
            <xsl:apply-templates mode="project-decription" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='118'">
            <xsl:apply-templates mode="geographic-coverage" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='119'">
            <xsl:apply-templates mode="taxonomic-coverage" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='115'">
            <xsl:apply-templates mode="usage-rights" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='121'">
            <xsl:apply-templates mode="software-specification" select="."/>
          </xsl:when>
          <!-- Software Description Article Type specific sections -->
          <xsl:when test="@object_id='112' or @object_id='113' or @object_id='114'">
            <xsl:apply-templates mode="web-locations-section" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='115' or @object_id='116'">
            <xsl:apply-templates mode="software-description-section" select="."/>
          </xsl:when>
          <!-- Data paper specific -->
          <xsl:when test="@object_id='189'">
            <xsl:apply-templates mode="general-description-section" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='123'">
            <xsl:apply-templates mode="sampling-methods-section" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='125'">
            <xsl:apply-templates mode="collection-data-section" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='194'">
            <xsl:apply-templates mode="temporal-coverage-wrapper-section" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='124'">
            <xsl:apply-templates mode="temporal-coverage-section" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='126'">
            <xsl:apply-templates mode="data-resources" select="."/>
          </xsl:when>
          <xsl:when test="@object_id='165'">
            <xsl:apply-templates mode="editorial-main-text" select="."/>
          </xsl:when>
          <!-- TRIVIAL SECTIONS -->
          <xsl:when test="@object_id!='14' and @object_id!='152' and @object_id!='21' and @object_id!='56' and @object_id!='57' and @object_id!='202' and @object_id!='237' and @object_id!='236'">
            <xsl:apply-templates mode="section" select="." >
              <xsl:with-param name="title">
                <xsl:value-of select="normalize-space(@display_name)"/>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    </body>
  </xsl:template>
</xsl:stylesheet>