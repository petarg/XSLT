<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />

	<xsl:template mode="materials" match="*">
		<xsl:if test="count(material//*[normalize-space(value)!=''])!=0">
			<tp:treatment-sec>
				<xsl:attribute name="sec-type">Materials</xsl:attribute>
				<title>Materials</title>
				<xsl:for-each select="material">
					<xsl:for-each select="priority_darwincore">
						<list>
							<xsl:attribute name="list-type">alpha-lower</xsl:attribute>
							<xsl:if test="normalize-space(fields/type_status/value)!=''">
								<label><xsl:value-of select="fields/type_status/value"/></label>
							</xsl:if>
							<xsl:for-each select="node()[name()!='' and name()!='fields']">
								<list-item><xsl:apply-templates mode="materials_mode" select="."/></list-item>
							</xsl:for-each>
						</list>
					</xsl:for-each>
					<xsl:for-each select="extended_darwincore">
						<list>
							<xsl:attribute name="list-type">alpha-lower</xsl:attribute>
							<xsl:if test="normalize-space(fields/type_status/value)!=''">
								<label><xsl:value-of select="fields/type_status/value"/></label>
							</xsl:if>
							<xsl:for-each select="node()[name()!='' and name()!='fields']">
								<list-item><xsl:apply-templates mode="materials_mode" select="."/></list-item>
							</xsl:for-each>
						</list>
					</xsl:for-each>
				</xsl:for-each>
			</tp:treatment-sec>
		</xsl:if>
	</xsl:template>




	<xsl:template mode="materials_mode" match="*">
		<p>
			<xsl:for-each select=".//fields/*[@field_name!='']">
				<xsl:if test="normalize-space(value)!=''">
					<xsl:if test="name()='verbatimcoordinates'"></xsl:if>
					<xsl:value-of select="@field_name"/>
					<xsl:text>: </xsl:text>
					<xsl:value-of select="value"/>
					<xsl:if test="position()!=last()"><xsl:text>; </xsl:text></xsl:if>
				</xsl:if>
			</xsl:for-each>
		</p>
	</xsl:template>


<!-- 
	PRIORITY
 -->
	<xsl:template mode="ttm_extant_freshwater_priority_dcFields" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_extant_freshwater_priority_dc" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_extant_marine_priority_dc" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_extant_na_priority_dc" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_extant_terrestrial_priority_dc" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_fossil" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

<!-- 
	EXTENDED
 -->

	<xsl:template mode="ttm_extant_freshwater_extended_dc" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_extant_marine_extended_dc" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_extant_na_extended_dc" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_extant_terrestrial_extended_dc" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_fossil_extended_dc" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>

	<xsl:template mode="ttm_fossilFields" match="*">
		<xsl:apply-templates mode="materials_mode" select="."/>
	</xsl:template>
</xsl:stylesheet>