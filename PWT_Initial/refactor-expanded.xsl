<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="no"/>
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
		<xsl:variable name="genus" select="normalize-space(@genus)"/>
		<xsl:variable name="subgenus" select="normalize-space(@subgenus)"/>
		<tn>
			<xsl:apply-templates mode="expand"/>
		</tn>
	</xsl:template>
	<xsl:template match="tn-part[@type='genus']" mode="expand">
		<xsl:variable name="genus" select="normalize-space(../@genus)"/>
		<xsl:choose>
			<xsl:when test="$genus=''">
				<xsl:apply-templates select="."/>
			</xsl:when>
			<xsl:otherwise>
				<tn-part>
					<xsl:attribute name="type">genus</xsl:attribute>
					<xsl:attribute name="full-name">
						<xsl:value-of select="$genus"/>
					</xsl:attribute>
					<xsl:value-of select="."/>
				</tn-part>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tn-part[@type='subgenus']" mode="expand">
		<xsl:variable name="subgenus" select="normalize-space(../@subgenus)"/>
		<xsl:choose>
			<xsl:when test="$subgenus=''">
				<xsl:apply-templates select="."/>
			</xsl:when>
			<xsl:otherwise>
				<tn-part>
					<xsl:attribute name="type">subgenus</xsl:attribute>
					<xsl:attribute name="full-name">
						<xsl:value-of select="$subgenus"/>
					</xsl:attribute>
					<xsl:value-of select="."/>
				</tn-part>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>