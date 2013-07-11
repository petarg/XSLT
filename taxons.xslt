<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />

	<xsl:template mode="taxon-put-taxon-name" match="*">
		<tp:taxon-name>
			<xsl:apply-templates mode="lower-taxon-name-parts" select="taxon_name/fields"/>
			<xsl:apply-templates mode="lower-taxon-name-parts" select="taxon_name_genus/fields"/>
			<xsl:apply-templates mode="lower-taxon-name-parts" select="taxon_name_species/fields"/>
		</tp:taxon-name>
	</xsl:template>
	<xsl:template mode="lower-taxon-name-parts" match="*">
		<xsl:variable name="genus" select="genus/value"/>
		<xsl:variable name="subgenus" select="subgenus/value"/>
		<xsl:variable name="species" select="species/value"/>
		<xsl:if test="$genus!=''">
			<tp:taxon-name-part>
				<xsl:attribute name="taxon-name-part-type">genus</xsl:attribute>
				<xsl:value-of select="$genus"/>
			</tp:taxon-name-part>
		</xsl:if>
		<xsl:if test="$subgenus!=''">
			<xsl:text> (</xsl:text>
			<tp:taxon-name-part>
				<xsl:attribute name="taxon-name-part-type">subgenus</xsl:attribute>
				<xsl:value-of select="$subgenus"/>
			</tp:taxon-name-part>
			<xsl:text>) </xsl:text>
		</xsl:if>
		<xsl:if test="$species!=''">
			<tp:taxon-name-part>
				<xsl:attribute name="taxon-name-part-type">species</xsl:attribute>
				<xsl:value-of select="$species"/>
			</tp:taxon-name-part>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="taxon-object-id" match="*">
		<xsl:for-each select="external_links/external_link">
			<object-id>
				<xsl:attribute name="xlink:type">simple</xsl:attribute>
				<xsl:attribute name="object-id-type"><xsl:value-of select="fields/link_type/value"/></xsl:attribute>
				<xsl:value-of select="fields/link/value"/>
			</object-id>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="taxon-authority" match="*">
		<xsl:variable name="authors" select="fields/taxon_authors/value"/>
		<xsl:if test="normalize-space($authors)!=''">
			<tp:taxon-authority><xsl:value-of select="$authors"/></tp:taxon-authority>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="taxon-animalia-status-new" match="*">
		<xsl:if test="type_of_treatment/value/text()='New taxon'">
			<tp:taxon-status xlink:type="simple">
				<xsl:if test="rank/value/text()='Species'">
					<xsl:text>sp. n.</xsl:text>
				</xsl:if>
				<xsl:if test="rank/value/text()='Genus'">
					<xsl:text>gen. n.</xsl:text>
				</xsl:if>
			</tp:taxon-status>
	 	</xsl:if>
	</xsl:template>
	<xsl:template mode="taxon-plantae-status-new" match="*">
		<xsl:if test="type_of_treatment/value/text()='New taxon'">
			<tp:taxon-status xlink:type="simple">
				<xsl:if test="rank/value/text()='Species'">
					<xsl:text>sp. nov.</xsl:text>
				</xsl:if>
				<xsl:if test="rank/value/text()='Genus'">
					<xsl:text>gen. nov.</xsl:text>
				</xsl:if>
			</tp:taxon-status>
	 	</xsl:if>
	</xsl:template>

	<xsl:template mode="taxon-nomenclature" match="*">
		<xsl:for-each select="nomenclature">
			<xsl:for-each select="fields">
				<xsl:for-each select="nomenclature">
					<xsl:for-each select="value">
						<xsl:for-each select="p">
							<tp:nomenclature-citation>
								<tp:taxon-name>
									<xsl:apply-templates mode="lower-taxon-name-parts" select="../../../../../taxon_name/fields"/>
									<xsl:apply-templates mode="lower-taxon-name-parts" select="../../../../../taxon_name_species/fields"/>
								</tp:taxon-name>
								<comment><xsl:text> </xsl:text><xsl:apply-templates mode="format" select="."/></comment>
								</tp:nomenclature-citation>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="taxon-nomenclature-type-species" match="*">
		<xsl:if test="normalize-space(./*/value)!=''">
			<tp:type-species>
				<tp:taxon-name>
					<xsl:apply-templates mode="lower-taxon-name-parts" select="."/>
				</tp:taxon-name>
			</tp:type-species>
		</xsl:if>
	</xsl:template>

	<xsl:template mode="taxon-put-type-species" match="*">
		<tp:type-species>
			<tp:taxon-name><xsl:apply-templates mode="lower-taxon-name-parts" select="."/></tp:taxon-name>
		</tp:type-species>
	</xsl:template>
	<xsl:template mode="taxon-type-species-reason" match="*">
		<xsl:if test="normalize-space(value)!=''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="@field_name"/>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="value"/>
			<xsl:text>.</xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="taxon-type-species-reference-citations" match="*">
		<xsl:for-each select="citation">
			<xsl:if test="normalize-space(citation/fields/reference_citation/value)!=''">
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:for-each select="citation/fields/reference_citation/value/p">
				<xsl:apply-templates mode="format" select="."/>
				<xsl:if test="position()!=last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:if test="normalize-space(fields/pages__figures/value)!=''">
				<xsl:text> [</xsl:text>
				<xsl:value-of select="fields/pages__figures/value"/>
				<xsl:text>]</xsl:text>
			</xsl:if>
			<xsl:if test="normalize-space(fields/notes/value)!=''">
				<xsl:text>: </xsl:text>
				<xsl:value-of select="fields/notes/value"/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="position()=last()">
					<xsl:text>.</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="taxon-type-species-synonyms" match="*">
		<xsl:for-each select="synonymy">
			<tp:taxon-name>
				<xsl:apply-templates mode="lower-taxon-name-parts" select="taxon_name/fields"/>
			</tp:taxon-name>
			<xsl:text> </xsl:text>
			<xsl:value-of select="taxon_name/fields/taxon_authors"/>
			<xsl:text> </xsl:text><italic><xsl:text>synon</xsl:text></italic>
			<xsl:apply-templates mode="taxon-type-species-reference-citations" select="reference_citations"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="taxon-nomenclature-citation-iczn" match="*">
		<xsl:choose>
			<xsl:when test="nomenclature/fields/nomenclature/value/text()=''">
				<tp:nomenclature-citation-list>
					<xsl:apply-templates mode="taxon-nomenclature-citation-type-species-iczn" select="."/>
				</tp:nomenclature-citation-list>
			</xsl:when>
			<xsl:otherwise>
				<tp:nomenclature-citation-list>
					<xsl:apply-templates mode="taxon-nomenclature" select="."/>
					<xsl:apply-templates mode="taxon-nomenclature-citation-type-species-iczn" select="."/>
				</tp:nomenclature-citation-list>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template mode="taxon-nomenclature-citation-type-species-iczn" match="*">
		<xsl:variable name="ts" select="type_species"/>
		<xsl:variable name="ts_name" select="$ts/taxon_name"/>
		<xsl:variable name="ts_authors" select="$ts_name/fields/taxon_authors"/>
		<xsl:variable name="ts_reason" select="$ts/fields/reason_for_typification_"/>
		<xsl:variable name="ts_synonyms" select="$ts/synonyms_of_the_type_species"/>
		<tp:nomenclature-citation>
			<xsl:apply-templates mode="taxon-put-taxon-name" select="."/>
			<xsl:apply-templates mode="taxon-put-type-species" select="$ts_name/fields"/>
			<comment>
				<xsl:value-of select="$ts_authors/value/text()"/>
				<xsl:text>. </xsl:text>
				<xsl:apply-templates mode="taxon-type-species-reference-citations" select="$ts/reference_citations"/>
				<xsl:apply-templates mode="taxon-type-species-synonyms" select="$ts_synonyms"/>
				<xsl:apply-templates mode="taxon-type-species-reason" select="$ts_reason"/>
			</comment>
		</tp:nomenclature-citation>
	</xsl:template>

	<xsl:template mode="taxon-nomenclature-citation-icn" match="*">
		<xsl:choose>
			<xsl:when test="nomenclature/fields/nomenclature/value/text()=''">
				<tp:nomenclature-citation-list>
					<xsl:apply-templates mode="taxon-nomenclature-citation-type-species-icn" select="."/>
				</tp:nomenclature-citation-list>
			</xsl:when>
			<xsl:otherwise>
				<tp:nomenclature-citation-list>
					<xsl:apply-templates mode="taxon-nomenclature" select="."/>
					<xsl:apply-templates mode="taxon-nomenclature-citation-type-species-icn" select="."/>
				</tp:nomenclature-citation-list>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template mode="taxon-nomenclature-citation-type-species-icn" match="*">
		<xsl:variable name="ts" select="type_species"/>
		<xsl:variable name="ts_name" select="$ts/tt_species_name_with_basionym"/>
		<xsl:variable name="ts_authors" select="$ts_name/fields/taxon_authors_and_year"/>
		<xsl:variable name="ts_b_authors" select="$ts_name/fields/basionym_authors"/>
		<xsl:variable name="ts_reason" select="$ts/fields/reason_for_typification"/>
		<xsl:variable name="ts_synonyms" select="$ts/synonyms_of_the_type_species"/>
		<tp:nomenclature-citation>
			<xsl:apply-templates mode="taxon-put-taxon-name" select="."/>
			<xsl:apply-templates mode="taxon-put-type-species" select="$ts_name"/>
			<comment>
				<xsl:value-of select="$ts_authors/value/text()"/>
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$ts_b_authors/value/text()"/>
				<xsl:text>. </xsl:text>
				<xsl:apply-templates mode="taxon-type-species-reference-citations" select="$ts/reference_citations"/>
				<xsl:apply-templates mode="taxon-type-species-synonyms" select="$ts_synonyms"/>
				<xsl:apply-templates mode="taxon-type-species-reason" select="$ts_reason"/>
			</comment>
		</tp:nomenclature-citation>
	</xsl:template>



	<xsl:template mode="taxon-type-species-reference-citations-new" match="*">
		<xsl:for-each select="reference_single_citation">
			<xsl:if test="normalize-space(citation/fields/reference_citation/value)!=''">
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:for-each select="citation/fields/reference_citation/value/p">
				<xsl:apply-templates mode="p" select="."/>
				<xsl:if test="position()!=last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:if test="normalize-space(fields/pages__figures/value)!=''">
				<xsl:text> [</xsl:text>
				<xsl:value-of select="fields/pages__figures/value"/>
				<xsl:text>]</xsl:text>
			</xsl:if>
			<xsl:if test="normalize-space(fields/notes/value)!=''">
				<xsl:text>: </xsl:text>
				<xsl:value-of select="fields/notes/value"/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="position()=last()">
					<xsl:text>.</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>


	<xsl:template mode="taxon-nomenclature-citations-plantae" match="*">
		<xsl:variable name="ts" select="type_species_treatment"/>
		<tp:nomenclature-citation>
			<xsl:apply-templates mode="taxon-put-taxon-name" select="."/>
			<xsl:apply-templates mode="taxon-put-type-species" select="$ts/fields"/>
			<comment>
				<xsl:value-of select="$ts/fields/taxon_authors/value"/>
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$ts/fields/status/value"/>
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$ts/fields/basionym_authors/value"/>
				<xsl:apply-templates mode="taxon-type-species-reference-citations-new" select="$ts/reference_citations"/>
			</comment>
		</tp:nomenclature-citation>
	</xsl:template>

	<xsl:template mode="taxon-nomenclature-citations-animalia" match="*">
		<xsl:variable name="ts" select="type_species_treatment"/>
		<tp:nomenclature-citation>
			<xsl:apply-templates mode="taxon-put-taxon-name" select="."/>
			<xsl:apply-templates mode="taxon-put-type-species" select="$ts/fields"/>
			<comment>
				<xsl:value-of select="$ts/fields/taxon_authors/value"/>
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$ts/fields/status/value"/>
				<xsl:apply-templates mode="taxon-type-species-reference-citations-new" select="$ts/reference_citations"/>
			</comment>
		</tp:nomenclature-citation>
	</xsl:template>
</xsl:stylesheet>