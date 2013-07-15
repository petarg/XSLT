<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />
	<xsl:import href="ref1.xslt"/>
	<xsl:import href="supplement.xslt"/>

	<xsl:param name="back_ack" select="/document/objects/acknowledgements"/>
	<xsl:param name="back_contrib" select="/document/objects/author_contributions"/>
	<xsl:param name="back_refs" select="/document/objects/references"/>
	<xsl:param name="back_suppl" select="/document/objects/supplementary_files"/>

	<xsl:template name="back">
		<back>
			<xsl:call-template name="back-ack"/>
			<xsl:call-template name="back-contrib"/>
			<xsl:call-template name="back-refs"/>
			<xsl:call-template name="back-suppl"/>
		</back>
	</xsl:template>

	<xsl:template name="back-ack">
		<xsl:for-each select="$back_ack">
			<xsl:for-each select="fields">
				<xsl:for-each select="acknowledgements[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<ack>
						<title>Acknowledgements</title>
						<xsl:apply-templates mode="p" select="value"/>
					</ack>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="back-contrib">
		<xsl:for-each select="$back_contrib[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<xsl:apply-templates mode="section" select="." >
				<xsl:with-param name="title"><xsl:value-of select="fields/author_contributions/@field_name"/></xsl:with-param>
			</xsl:apply-templates>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="back-refs">
		<xsl:if test="normalize-space($back_refs)!=''">
			<ref-list>
				<title>References</title>
				<xsl:call-template name="reference"/>
			</ref-list>
		</xsl:if>
	</xsl:template>

	<xsl:template name="back-suppl">
		<xsl:if test="normalize-space($back_suppl)!=''">
			<xsl:call-template name="supplement"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>