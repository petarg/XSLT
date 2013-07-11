<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt"/>
	<xsl:import href="taxons.xslt"/>
	<xsl:import href="taxon-content.xslt"/>
	<xsl:import href="taxon-materials.xslt"/>
	<xsl:template mode="systematics" match="*">
		<sec>
			<xsl:attribute name="sec-type">Systematics</xsl:attribute>
			<title>Systematics</title>
			<xsl:for-each select="fields/node()[normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
				<xsl:choose>
					<xsl:when test="name()!='title'">
						<xsl:apply-templates mode="p" select="value" />
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:apply-templates mode="treatment" select="."/>
		</sec>
	</xsl:template>

	<xsl:template mode="treatment" match="*">
		<xsl:for-each select="treatment">
			<xsl:apply-templates mode="new_tt_genus_fungi_plantae_chromista" select="."/>
			<xsl:apply-templates mode="new_tt_genus_protozoa_animalia" select="."/>
			<xsl:apply-templates mode="new_tt_species_fungi_plantae_chromista" select="."/>
			<xsl:apply-templates mode="new_tt_species_protozoa_animalia" select="."/>
			<xsl:apply-templates mode="redescription_tt_genus_icn" select="."/>
			<xsl:apply-templates mode="redescription_tt_genus_iczn" select="."/>
			<xsl:apply-templates mode="redescription_tt_species_fungi_plantae_chromista" select="."/>
			<xsl:apply-templates mode="redescription_tt_species_protozoa_animalia" select="."/>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>