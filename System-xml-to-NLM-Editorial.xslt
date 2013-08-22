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
	<xsl:import href="ref1.xslt" />
	<xsl:import href="supplement.xslt" />
	<xsl:import href="keys.xslt" />
	<xsl:import href="systematics.xslt" />
	<xsl:import href="checklists.xslt" />
	<xsl:import href="data-resources.xslt" />
	<xsl:import href="front.xslt" />
	<xsl:import href="body.xslt" />
	<xsl:import href="back.xslt" />
	<xsl:import href="floats.xslt" />

	<xsl:output method="xml" encoding="UTF-8"
		indent="yes"
		doctype-system="http://pmt.pensoft.eu/lib/publishing/tax-treatment-NS0.dtd"
		doctype-public="-//TaxonX//DTD Taxonomic Treatment Publishing DTD v0 20100105//EN"/>

	<xsl:template match="/">
		<article>
			<xsl:attribute name="article-type">editorial</xsl:attribute>
			<xsl:call-template name="front" />
			<xsl:call-template name="body" />
			<xsl:call-template name="back" />
			<xsl:call-template name="floats" />
		</article>
	</xsl:template>
</xsl:stylesheet>