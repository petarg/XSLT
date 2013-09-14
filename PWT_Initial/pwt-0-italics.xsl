<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" />
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template mode="unstyle" match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template mode="unstyle" match="@style"/>
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
	<xsl:template match="u">
		<u>
			<xsl:apply-templates />
		</u>
	</xsl:template>
	<xsl:template match="a">
		<a>
			<xsl:if test="normalize-space(@target)=''">
				<xsl:attribute name="target">_blank</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates mode="unstyle" select="@*"/>
			<xsl:apply-templates />
		</a>
	</xsl:template>
	<xsl:template match="span">
		<xsl:apply-templates />
	</xsl:template>
</xsl:stylesheet>