<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">

  <xsl:import href="format.xslt" />
  <xsl:import href="section.xslt" />
  <xsl:import href="taxons.xslt" />
  <xsl:import href="references.xslt" />
  <xsl:import href="supplement.xslt" />
  <xsl:import href="keys.xslt" />
  <xsl:import href="systematics.xslt" />
  <xsl:import href="checklists.xslt" />
  <xsl:import href="data-resources.xslt"/>
  <xsl:import href="front.xslt" />
  <xsl:import href="body.xslt" />
  <xsl:import href="back.xslt" />
  <xsl:import href="floats.xslt" />
  
  <xsl:param name="article_issue">1</xsl:param>
  <xsl:param name="article_id">1016</xsl:param>

  <xsl:output method="xml" encoding="UTF-8" indent="yes"
    doctype-system="https://raw.github.com/tcatapano/TaxPub/v0.5-beta/tax-treatment-NS0.dtd"
    doctype-public="-//TaxPub//DTD Taxonomic Treatment Publishing DTD v0.5 20110606//EN"/>
  <xsl:preserve-space elements="*"/>

  <xsl:template match="/">
    <article>
      <xsl:choose>
        <xsl:when test="/document/document_info/document_type/@id=8">
          <xsl:attribute name="article-type">editorial</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="article-type">research-article</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="front"/>
      <xsl:call-template name="body"/>
      <xsl:call-template name="back"/>
      <xsl:call-template name="floats"/>
    </article>
  </xsl:template>
</xsl:stylesheet>
