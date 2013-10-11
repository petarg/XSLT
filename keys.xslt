<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">
  <xsl:template mode="keys" match="*">
    <sec>
      <xsl:attribute name="sec-type">keys</xsl:attribute>
      <title>Identification Keys</title>
      <xsl:apply-templates mode="key" select="." />
    </sec>
  </xsl:template>
  <xsl:template mode="key" match="*">
    <xsl:for-each select="identification_key">
      <xsl:variable name="title" select="fields/title/value"/>
      <xsl:variable name="key_notes" select="fields/key_notes/value"/>
      <xsl:variable name="key_number" select="position()"/>
      <sec>
        <xsl:attribute name="sec-type">key</xsl:attribute>
        <title>
          <xsl:apply-templates mode="title" select="$title"/>
        </title>
        <table-wrap content-type="key" position="anchor" orientation="portrait">
          <table>
            <tbody>
              <xsl:for-each select="key_couplet">
                <xsl:variable name="ttaxon" select="fields/thesis_taxon_name/value"/>
                <xsl:variable name="tnext" select="fields/thesis_next_couplet/value"/>
                <xsl:variable name="ataxon" select="fields/antithesis_taxon_name/value"/>
                <xsl:variable name="anext" select="fields/antithesis_next_couplet/value"/>
                <xsl:variable name="couplet_number" select="position()"/>
                <tr>
                  <xsl:attribute name="content-type">thesis</xsl:attribute>
                  <td>
                    <xsl:attribute name="rowspan">1</xsl:attribute>
                    <xsl:attribute name="colspan">1</xsl:attribute>
                    <xsl:attribute name="content-type">lead</xsl:attribute>
                    <xsl:attribute name="id">
                      <xsl:text>KEY</xsl:text>
                      <xsl:value-of select="$key_number"/>
                      <xsl:text>.</xsl:text>
                      <xsl:value-of select="$couplet_number"/>
                    </xsl:attribute>
                    <xsl:value-of select="$couplet_number"/>
                  </td>
                  <td>
                    <xsl:attribute name="rowspan">1</xsl:attribute>
                    <xsl:attribute name="colspan">1</xsl:attribute>
                    <xsl:attribute name="content-type">thesis-desc</xsl:attribute>
                    <xsl:apply-templates mode="td-format" select="fields/thesis/value"/>
                  </td>
                  <td>
                    <xsl:attribute name="rowspan">1</xsl:attribute>
                    <xsl:attribute name="colspan">1</xsl:attribute>
                    <xsl:attribute name="content-type">lead-to</xsl:attribute>
                    <xsl:if test="normalize-space($ttaxon)!=''">
                      <xsl:apply-templates mode="td-format" select="$ttaxon" />
                      <xsl:if test="normalize-space($tnext)!=''">
                        <xsl:text>, </xsl:text>
                      </xsl:if>
                    </xsl:if>
                    <xsl:if test="normalize-space($tnext)!=''">
                      <!-- <xsl:apply-templates mode="format" select="$tnext" /> -->
                      <xref>
                        <xsl:attribute name="ref-type">other</xsl:attribute>
                        <xsl:attribute name="rid">
                          <xsl:text>KEY</xsl:text>
                          <xsl:value-of select="$key_number"/>
                          <xsl:text>.</xsl:text>
                          <xsl:value-of select="normalize-space($tnext)"/>
                        </xsl:attribute>
                          <xsl:value-of select="normalize-space($tnext)"/>
                      </xref>
                    </xsl:if>
                  </td>
                </tr>
                <tr>
                  <xsl:attribute name="content-type">antithesis</xsl:attribute>
                  <td>
                    <xsl:attribute name="rowspan">1</xsl:attribute>
                    <xsl:attribute name="colspan">1</xsl:attribute>
                    <xsl:attribute name="content-type">lead</xsl:attribute>
                    <xsl:text>–</xsl:text>
                  </td>
                  <td>
                    <xsl:attribute name="rowspan">1</xsl:attribute>
                    <xsl:attribute name="colspan">1</xsl:attribute>
                    <xsl:attribute name="content-type">antithesis-desc</xsl:attribute>
                    <xsl:apply-templates mode="td-format" select="fields/antithesis/value"/>
                  </td>
                  <td>
                    <xsl:attribute name="rowspan">1</xsl:attribute>
                    <xsl:attribute name="colspan">1</xsl:attribute>
                    <xsl:attribute name="content-type">lead-to</xsl:attribute>
                    <xsl:if test="normalize-space($ataxon)!=''">
                      <xsl:apply-templates mode="td-format" select="$ataxon" />
                      <xsl:if test="normalize-space($anext)!=''">
                        <xsl:text>, </xsl:text>
                      </xsl:if>
                    </xsl:if>
                    <xsl:if test="normalize-space($anext)!=''">
                      <!-- <xsl:apply-templates mode="format" select="$anext" /> -->
                      <xref>
                        <xsl:attribute name="ref-type">other</xsl:attribute>
                        <xsl:attribute name="rid">
                          <xsl:text>KEY</xsl:text>
                          <xsl:value-of select="$key_number"/>
                          <xsl:text>.</xsl:text>
                          <xsl:value-of select="normalize-space($anext)"/>
                        </xsl:attribute>
                          <xsl:value-of select="normalize-space($anext)"/>
                      </xref>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
          <xsl:if test="normalize-space($key_notes)!=''">
            <table-wrap-foot>
              <xsl:apply-templates mode="p" select="$key_notes"/>
            </table-wrap-foot>
          </xsl:if>
        </table-wrap>
      </sec>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
