<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()" mode="expand">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="tn">
		<tn>
			
		</tn>
	</xsl:template>
	<xsl:template match="tn-part[@type='genus']" mode="expand">
		<xsl:variable name="genus" select="normalize-space(.)"/>
		<xsl:choose>
			<xsl:when test="not(contains($genus, '.'))">
				<xsl:apply-templates select="."/>
			</xsl:when>
			<xsl:otherwise>
				
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>