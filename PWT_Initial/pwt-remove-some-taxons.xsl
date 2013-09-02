<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()" mode="untag">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates mode="untag"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="classifications">
		<xsl:apply-templates select="." mode="untag"/>
	</xsl:template>
	<xsl:template match="form | variety | subspecies | species | subgenus | genus | subtribe | tribe | subfamily | family | superfamily | infraorder | suborder | order | superorder | subclass | class | superclass | subphylum | phylum | subkingdom | kingdom">
		<xsl:apply-templates select="." mode="untag"/>
	</xsl:template>
	<xsl:template match="tn" mode="untag">
		<xsl:apply-templates select="node()" mode="untag"/>
	</xsl:template>
	<xsl:template match="tn-part" mode="untag">
		<xsl:apply-templates select="node()" mode="untag"/>
	</xsl:template>
</xsl:stylesheet>