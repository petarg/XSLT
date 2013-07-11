<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />

	<xsl:template mode="treatment-sections" match="*">
		<xsl:for-each select="node()[normalize-space(.)!='']">
			<xsl:choose>
				<xsl:when test="(@display_name='') and (name()!='section')">
					<xsl:comment>There is invalid content</xsl:comment>
				</xsl:when>
				<xsl:when test="name()='section'">
					<xsl:apply-templates mode="treatment-section-section" select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="treatment-section" select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="treatment-section" match="*">
		<!-- This template matches all treatment sections with predefined names -->
		<xsl:variable name="content" select="fields/*/value"/>
		<xsl:if test="normalize-space($content)!=''">
			<tp:treatment-sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
				<title><xsl:value-of select="@display_name"/></title>
				<xsl:apply-templates mode="p" select="$content"/>
				<xsl:apply-templates mode="subsection" select="."/>
			</tp:treatment-sec>
		</xsl:if>
	</xsl:template>

	<xsl:template mode="treatment-section-section" match="*">
		<!-- This template matches all treatment sections without predefined names -->
		<xsl:variable name="title" select="fields/title/value"/>
		<xsl:variable name="content" select="fields/content/value"/>
		<xsl:if test="normalize-space(fields)!=0">
			<tp:treatment-sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="normalize-space($title)"/></xsl:attribute>
				<xsl:if test="normalize-space($title)!=''">
					<title><xsl:apply-templates mode="format" select="$title"/></title>
				</xsl:if>
				<xsl:apply-templates mode="p" select="$content"/>
				<xsl:apply-templates mode="subsection" select="."/>
			</tp:treatment-sec>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>