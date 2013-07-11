<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />
	<xsl:import href="taxons.xslt"/>
	<xsl:import href="treatment-sections.xslt"/>
	
	<xsl:template mode="treatment-meta" match="*">
		<tp:treatment-meta>
			<xsl:if test="normalize-space(fields//value)!=''">
				<xsl:for-each select="fields">
					<kwd-group>
						<xsl:for-each select="./*[normalize-space(value)!='']">
							<xsl:choose>
								<xsl:when test="normalize-space(@field_name)=''">
									<kwd><xsl:value-of select="value"/></kwd>
								</xsl:when>
								<xsl:otherwise>
									<kwd><xsl:value-of select="@field_name"/><xsl:text>: </xsl:text><xsl:value-of select="value"/></kwd>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</kwd-group>
				</xsl:for-each>
			</xsl:if>
		</tp:treatment-meta>
	</xsl:template>
<!-- 
#
#	DESCRIPTION OF NEW TAXONS
#
 -->
<!-- 
#
#	NEW GENUS
#
 -->
	<xsl:template mode="new_tt_genus_fungi_plantae_chromista" match="*">
		<xsl:variable name="treatment" select="new_tt_genus_fungi_plantae_chromista"/>
		<xsl:variable name="taxon_name" select="$treatment/taxon_name_genus"/>
		<xsl:variable name="materials" select="$treatment/materials"/>
		<xsl:variable name="sections" select="$treatment/treatment_sections_genus_plantae"/>
		<xsl:if test="normalize-space($taxon_name/fields)!=''">
			<tp:taxon-treatment>
				<xsl:apply-templates mode="treatment-meta" select="."/>
				<tp:nomenclature>
					<tp:taxon-name>
						<xsl:apply-templates mode="lower-taxon-name-parts" select="$taxon_name/fields"/>
						<xsl:apply-templates mode="taxon-object-id" select="$treatment"/>
					</tp:taxon-name>
					<xsl:apply-templates mode="taxon-authority" select="$taxon_name"/>
					<xsl:apply-templates mode="taxon-plantae-status-new" select="fields"/>
					<xsl:apply-templates mode="taxon-nomenclature-citations-plantae" select="$treatment"/>
				</tp:nomenclature>
				<xsl:apply-templates mode="materials" select="$materials"/>
				<xsl:apply-templates mode="treatment-sections" select="$sections"/>
			</tp:taxon-treatment>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="new_tt_genus_protozoa_animalia" match="*">
		<xsl:variable name="treatment" select="new_tt_genus_protozoa_animalia"/>
		<xsl:variable name="taxon_name" select="$treatment/taxon_name_genus"/>
		<xsl:variable name="materials" select="$treatment/materials"/>
		<xsl:variable name="sections" select="$treatment/treatment_sections_genus_animalia"/>
		<xsl:if test="normalize-space($taxon_name/fields)!=''">
			<tp:taxon-treatment>
				<xsl:apply-templates mode="treatment-meta" select="."/>
				<tp:nomenclature>
					<tp:taxon-name>
						<xsl:apply-templates mode="lower-taxon-name-parts" select="$taxon_name/fields"/>
						<xsl:apply-templates mode="taxon-object-id" select="$treatment"/>
					</tp:taxon-name>
					<xsl:apply-templates mode="taxon-authority" select="$taxon_name"/>
					<xsl:apply-templates mode="taxon-animalia-status-new" select="fields"/>
					<xsl:apply-templates mode="taxon-nomenclature-citations-animalia" select="$treatment"/>
				</tp:nomenclature>
				<xsl:apply-templates mode="materials" select="$materials"/>
				<xsl:apply-templates mode="treatment-sections" select="$sections"/>
			</tp:taxon-treatment>
		</xsl:if>
	</xsl:template>
<!-- 
#
#	NEW SPECIES
#
 -->
	<xsl:template mode="new_tt_species_fungi_plantae_chromista" match="*">
		<xsl:variable name="treatment" select="new_tt_species_fungi_plantae_chromista"/>
		<xsl:variable name="taxon_name" select="$treatment/taxon_name_species"/>
		<xsl:variable name="materials" select="$treatment/materials"/>
		<xsl:variable name="sections" select="$treatment/new_tt_species_phytokeys_sections"/>
		<xsl:if test="normalize-space($taxon_name/fields)!=''">
			<tp:taxon-treatment>
				<xsl:apply-templates mode="treatment-meta" select="."/>
				<tp:nomenclature>
					<tp:taxon-name>
						<xsl:apply-templates mode="lower-taxon-name-parts" select="$taxon_name/fields"/>
						<xsl:apply-templates mode="taxon-object-id" select="$treatment"/>
					</tp:taxon-name>
					<xsl:apply-templates mode="taxon-authority" select="$taxon_name"/>
					<xsl:apply-templates mode="taxon-plantae-status-new" select="fields"/>
				</tp:nomenclature>
				<xsl:apply-templates mode="materials" select="$materials"/>
				<xsl:apply-templates mode="treatment-sections" select="$sections"/>
			</tp:taxon-treatment>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="new_tt_species_protozoa_animalia" match="*">
		<xsl:variable name="treatment" select="new_tt_species_protozoa_animalia"/>
		<xsl:variable name="taxon_name" select="$treatment/taxon_name_species"/>
		<xsl:variable name="materials" select="$treatment/materials"/>
		<xsl:variable name="sections" select="$treatment/new_tt_species_sections"/>
		<xsl:if test="normalize-space($taxon_name/fields)!=''">
			<tp:taxon-treatment>
				<xsl:apply-templates mode="treatment-meta" select="."/>
				<tp:nomenclature>
					<tp:taxon-name>
						<xsl:apply-templates mode="lower-taxon-name-parts" select="$taxon_name/fields"/>
						<xsl:apply-templates mode="taxon-object-id" select="$treatment"/>
					</tp:taxon-name>
					<xsl:apply-templates mode="taxon-authority" select="$taxon_name"/>
					<xsl:apply-templates mode="taxon-animalia-status-new" select="fields"/>
				</tp:nomenclature>
				<xsl:apply-templates mode="materials" select="$materials"/>
				<xsl:apply-templates mode="treatment-sections" select="$sections"/>
			</tp:taxon-treatment>
		</xsl:if>
	</xsl:template>
<!-- 
#
#	REDESCRIPTION OF TAXON
#
 -->
<!-- 
#
#	GENUS
#
 -->
	<xsl:template mode="redescription_tt_genus_icn" match="*">
		<xsl:variable name="treatment" select="treatment"/>
		<xsl:variable name="taxon_name" select="$treatment/taxon_name"/>
		<xsl:variable name="sections" select="$treatment/treatment_sections"/>
		<xsl:if test="normalize-space($taxon_name/fields)!=''">
			<tp:taxon-treatment>
				<xsl:apply-templates mode="treatment-meta" select="."/>
				<tp:nomenclature>
					<tp:taxon-name>
						<xsl:apply-templates mode="lower-taxon-name-parts" select="$taxon_name/fields"/>
						<xsl:apply-templates mode="taxon-object-id" select="$treatment"/>
					</tp:taxon-name>
					<xsl:apply-templates mode="taxon-authority" select="$taxon_name"/>
					<xsl:apply-templates mode="taxon-nomenclature-citation-icn" select="$treatment"/>
					<xsl:apply-templates mode="taxon-nomenclature-type-species" select="$treatment/type_species/tt_species_name_with_basionym/fields"/>
				</tp:nomenclature>
				<xsl:apply-templates mode="treatment-sections" select="$sections"/>
			</tp:taxon-treatment>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="redescription_tt_genus_iczn" match="*">
		<xsl:variable name="treatment" select="redescription_tt_genus_iczn"/>
		<xsl:variable name="taxon_name" select="$treatment/taxon_name"/>
		<xsl:variable name="sections" select="$treatment/treatment_sections"/>
		<xsl:if test="normalize-space($taxon_name/fields)!=''">
			<tp:taxon-treatment>
				<xsl:apply-templates mode="treatment-meta" select="."/>
				<tp:nomenclature>
					<tp:taxon-name>
						<xsl:apply-templates mode="lower-taxon-name-parts" select="$taxon_name/fields"/>
						<xsl:apply-templates mode="taxon-object-id" select="$treatment"/>
					</tp:taxon-name>
					<xsl:apply-templates mode="taxon-authority" select="$taxon_name"/>
					<xsl:apply-templates mode="taxon-nomenclature-citation-iczn" select="$treatment"/>
					<xsl:apply-templates mode="taxon-nomenclature-type-species" select="$treatment/type_species/taxon_name/fields"/>
				</tp:nomenclature>
				<xsl:apply-templates mode="treatment-sections" select="$sections"/>
			</tp:taxon-treatment>
		</xsl:if>
	</xsl:template>
<!-- 
#
#	SPECIES
#
 -->
	<xsl:template mode="redescription_tt_species_fungi_plantae_chromista" match="*">
		<xsl:variable name="treatment" select="redescription_tt_species_fungi_plantae_chromista"/>
		<xsl:variable name="taxon_name" select="$treatment/taxon_name_species"/>
		<xsl:variable name="nomenclature" select="$treatment/nomenclature/fields/nomenclature/value"/>
		<xsl:variable name="materials" select="$treatment/materials"/>
		<xsl:variable name="sections" select="$treatment/treatment_sections_species_plantae"/>
		<xsl:if test="normalize-space($taxon_name/fields)!=''"> 
			<tp:taxon-treatment>
				<xsl:apply-templates mode="treatment-meta" select="."/>
				<tp:nomenclature>
					<tp:taxon-name>
						<xsl:apply-templates mode="lower-taxon-name-parts" select="$taxon_name/fields"/>
						<xsl:apply-templates mode="taxon-object-id" select="$treatment"/>
					</tp:taxon-name>
					<xsl:apply-templates mode="taxon-authority" select="$taxon_name"/>
					<xsl:if test="normalize-space($nomenclature/text())!=''">
						<tp:nomenclature-citation-list>
							<xsl:apply-templates mode="taxon-nomenclature" select="$treatment"/>
						</tp:nomenclature-citation-list>
					</xsl:if>
				</tp:nomenclature>
				<xsl:apply-templates mode="materials" select="$materials"/>
				<xsl:apply-templates mode="treatment-sections" select="$sections"/>
			</tp:taxon-treatment>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="redescription_tt_species_protozoa_animalia" match="*">
		<xsl:variable name="treatment" select="redescription_tt_species_protozoa_animalia"/>
		<xsl:variable name="taxon_name" select="$treatment/taxon_name_species"/>
		<xsl:variable name="nomenclature" select="$treatment/nomenclature/fields/nomenclature/value"/>
		<xsl:variable name="materials" select="$treatment/materials"/>
		<xsl:variable name="sections" select="$treatment/treatment_sections_species_animalia"/>
		<xsl:if test="normalize-space($taxon_name/fields)!=''">
			<tp:taxon-treatment>
				<xsl:apply-templates mode="treatment-meta" select="."/>
				<tp:nomenclature>
					<tp:taxon-name>
						<xsl:apply-templates mode="lower-taxon-name-parts" select="$taxon_name/fields"/>
						<xsl:apply-templates mode="taxon-object-id" select="$treatment"/>
					</tp:taxon-name>
					<xsl:apply-templates mode="taxon-authority" select="$taxon_name"/>
					<xsl:if test="$nomenclature/text()!=''">
						<tp:nomenclature-citation-list>
							<xsl:apply-templates mode="taxon-nomenclature" select="$treatment"/>
						</tp:nomenclature-citation-list>
					</xsl:if>
				</tp:nomenclature>
				<xsl:apply-templates mode="materials" select="$materials"/>
				<xsl:apply-templates mode="treatment-sections" select="$sections"/>
			</tp:taxon-treatment>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>