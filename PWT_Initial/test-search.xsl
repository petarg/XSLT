<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />

	<xsl:template match="/">
		<out>
			<xsl:value-of select="count(//tn)"/>
		</out>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="em | i | span | b | strong">
		<xsl:element name="{name()}">
			<xsl:value-of select="normalize-space(.)"/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>