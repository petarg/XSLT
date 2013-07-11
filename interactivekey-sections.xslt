<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />

	<xsl:template mode="ik-project-decription" match="*">
		<xsl:for-each select="fields[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<xsl:for-each select="node()[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:choose>
						<xsl:when test="name()='title'">
							<title><xsl:apply-templates mode="format" select="value//*"/></title>
						</xsl:when>
						<xsl:otherwise>
							<sec>
								<xsl:attribute name="sec-type"><xsl:value-of select="@field_name"/></xsl:attribute>
								<title><xsl:value-of select="@field_name"/></title>
								<xsl:apply-templates mode="p" select="value"/>
							</sec>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ik-geographic-coverage" match="*">
		<xsl:for-each select="fields[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="description[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<sec>
						<xsl:attribute name="sec-type"><xsl:value-of select="@field_name"/></xsl:attribute>
						<title><xsl:value-of select="@field_name"/></title>
						<xsl:apply-templates mode="p" select="value"/>
					</sec>
				</xsl:for-each>
				<xsl:for-each select="node()[name()!='description' and name()!='']">
					<sec>
						<xsl:attribute name="sec-type"><xsl:value-of select="@field_name"/></xsl:attribute>
						<title><xsl:value-of select="@field_name"/></title>
						<p><xsl:apply-templates mode="format" select="value"/></p>
					</sec>
				</xsl:for-each>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ik-taxonomic-coverage" match="*">
		<xsl:if test="normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
				<title><xsl:value-of select="@display_name"/></title>
				<xsl:for-each select="fields/node()[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<sec>
						<xsl:attribute name="sec-type"><xsl:value-of select="@field_name"/></xsl:attribute>
						<title><xsl:value-of select="@field_name"/></title>
						<xsl:apply-templates mode="p" select="value"/>
					</sec>
				</xsl:for-each>
				<xsl:for-each select="taxa[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="ik-taxa" select="."/>
				</xsl:for-each>
			</sec>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="ik-taxa" match="*">
		<tp:taxon-treatment>
			<tp:nomenclature>
				<tp:taxon-name>
					<tp:taxon-name-part>
						<xsl:attribute name="taxon-name-part-type"><xsl:value-of select="normalize-space(fields/rank/value)"/></xsl:attribute>
						<xsl:value-of select="normalize-space(fields/specific_name/value)"/>
					</tp:taxon-name-part>
				</tp:taxon-name>
				<tp:nomenclature-citation-list>
					<tp:nomenclature-citation>
						<tp:taxon-name><xsl:value-of select="normalize-space(fields/specific_name/value)"/></tp:taxon-name>
						<comment><xsl:value-of select="normalize-space(fields/common_name/value)"/></comment>
					</tp:nomenclature-citation>
				</tp:nomenclature-citation-list>
			</tp:nomenclature>
		</tp:taxon-treatment>
	</xsl:template>

	<xsl:template mode="ik-usage" match="*">
		<xsl:for-each select="fields[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<sec>
						<xsl:attribute name="sec-type"><xsl:value-of select="@field_name"/></xsl:attribute>
						<title><xsl:value-of select="@field_name"/></title>
						<xsl:apply-templates mode="p" select="value"/>
					</sec>
				</xsl:for-each>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ik-software" match="*">
		<xsl:for-each select="fields[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<sec>
						<xsl:attribute name="sec-type"><xsl:value-of select="@field_name"/></xsl:attribute>
						<title><xsl:value-of select="@field_name"/></title>
						<p><xsl:apply-templates mode="format" select="value"/></p>
					</sec>
				</xsl:for-each>
			</sec>
		</xsl:for-each>
	</xsl:template>









</xsl:stylesheet>