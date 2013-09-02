<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" />
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="em | i">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	<xsl:template match="strong | b">
		<b>
			<xsl:apply-templates />
		</b>
	</xsl:template>
	<xsl:template match="span">
		<xsl:apply-templates />
	</xsl:template>
</xsl:stylesheet>