<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />

	<xsl:template mode="software-description-section" match="*">
		<xsl:for-each select="fields[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<sec>
						<xsl:variable name="title" select="normalize-space(@field_name)"/>
						<xsl:attribute name="sec-type"><xsl:value-of select="$title"/></xsl:attribute>
						<title><xsl:value-of select="$title"/></title>
						<xsl:apply-templates mode="p" select="value"/>
					</sec>
				</xsl:for-each>
			</sec>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>