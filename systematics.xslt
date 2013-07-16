<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt"/>
	<xsl:import href="treatment.xslt"/>
	<xsl:template mode="systematics" match="*">
		<sec>
			<xsl:attribute name="sec-type">Systematics</xsl:attribute>
			<title>Systematics</title>
			<xsl:for-each select="fields/node()[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
				<xsl:choose>
					<xsl:when test="name()!='title'">
						<xsl:apply-templates mode="p" select="value" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:apply-templates mode="treatment" select="."/>
		</sec>
	</xsl:template>
</xsl:stylesheet>