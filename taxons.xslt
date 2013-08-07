<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">

	<xsl:template mode="taxon-put-taxon-name" match="*">
		<tp:taxon-name>
			<xsl:apply-templates mode="lower-taxon-name-parts" select="taxon_name/fields"/>
			<xsl:apply-templates mode="lower-taxon-name-parts" select="taxon_name_genus/fields"/>
			<xsl:apply-templates mode="lower-taxon-name-parts" select="taxon_name_species/fields"/>
		</tp:taxon-name>
	</xsl:template>
	<xsl:template mode="lower-taxon-name-parts" match="*">
		<xsl:variable name="genus" select="normalize-space(.//node()[@id='48']/value)"/>
		<xsl:variable name="subgenus" select="normalize-space(.//node()[@id='417']/value)"/>
		<xsl:variable name="species" select="normalize-space(.//node()[@id='49']/value)"/>
		<xsl:variable name="genus1" select="normalize-space(.//node()[@id='441']/value)"/>
		<xsl:variable name="species1" select="normalize-space(.//node()[@id='442']/value)"/>
		<xsl:if test="$genus!=''">
			<tp:taxon-name-part>
				<xsl:attribute name="taxon-name-part-type">genus</xsl:attribute>
				<xsl:value-of select="$genus"/>
			</tp:taxon-name-part>
		</xsl:if>
		<xsl:if test="$genus1!=''">
			<tp:taxon-name-part>
				<xsl:attribute name="taxon-name-part-type">genus</xsl:attribute>
				<xsl:value-of select="$genus1"/>
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
		<xsl:if test="$species1!=''">
			<tp:taxon-name-part>
				<xsl:attribute name="taxon-name-part-type">species</xsl:attribute>
				<xsl:value-of select="$species1"/>
			</tp:taxon-name-part>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="taxon-object-id" match="*">
		<xsl:for-each select="external_links/external_link[normalize-space(.)!='']"><!-- Do not edit! -->
			<xsl:variable name="link_type" select="normalize-space(fields/link_type/value)"/>
			<xsl:variable name="link" select="normalize-space(fields/link/value)"/>
			<object-id>
				<xsl:attribute name="xlink:type">simple</xsl:attribute>
				<xsl:attribute name="object-id-type"><xsl:value-of select="$link_type"/></xsl:attribute>
				<xsl:value-of select="$link"/>
			</object-id>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="taxon-authority" match="*">
		<xsl:variable name="authors" select="normalize-space(.//node()[@id='50']/value)"/>
		<xsl:if test="$authors!=''">
			<tp:taxon-authority><xsl:value-of select="$authors"/></tp:taxon-authority>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="taxon-status-new">
		<xsl:param name="kingdom" select="''"/>
		<xsl:if test="normalize-space(fields/type_of_treatment/value)='New taxon'">
			<xsl:variable name="rank" select="normalize-space(fields/rank/value)"/>
			<xsl:choose>
				<xsl:when test="$kingdom='plantae'">
					<xsl:choose>
						<xsl:when test="$rank='Species'"><xsl:text>sp. nov.</xsl:text></xsl:when>
						<xsl:when test="$rank='Genus'"><xsl:text>gen. nov.</xsl:text></xsl:when>
						<xsl:otherwise><xsl:text>nov.</xsl:text></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$kingdom='animalia'">
					<xsl:choose>
						<xsl:when test="$rank='Species'"><xsl:text>sp. n.</xsl:text></xsl:when>
						<xsl:when test="$rank='Genus'"><xsl:text>gen. n.</xsl:text></xsl:when>
						<xsl:otherwise><xsl:text>n.</xsl:text></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>


	<xsl:template mode="nomenclature-citation-group" match="*">
		<xsl:variable name="genus_group" select="node()[@object_id='181']"/>
		<xsl:variable name="species_group" select="node()[@object_id='180']"/>
		<xsl:if test="(normalize-space(node()[@object_id='186'])!='') or (normalize-space(node()[@object_id='195'])!='') or (normalize-space(node()[@object_id='200'])!='') or (normalize-space(node()[@object_id='210'])!='') or (normalize-space(node()[@object_id='215'])!='') or (normalize-space(node()[@object_id='217'])!='')">
			
			<tp:nomenclature-citation-list>
				<!-- First put nomenclature (210) -->
				<xsl:for-each select="node()[@object_id='210']//p[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
					<tp:nomenclature-citation>
						<tp:taxon-name>
							<xsl:apply-templates mode="lower-taxon-name-parts" select="$genus_group/fields"/>
						</tp:taxon-name>
						<comment>
							<xsl:text> </xsl:text>
							<xsl:apply-templates mode="format" select="."/>
						</comment>
					</tp:nomenclature-citation>
				</xsl:for-each>
				<!-- Next put synonyms (200) -->
				<xsl:for-each select="node()[@object_id='200']//p[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
					<tp:nomenclature-citation>
						<tp:taxon-name>
							<xsl:apply-templates mode="lower-taxon-name-parts" select="$species_group/fields"/>
						</tp:taxon-name>
						<comment>
							<xsl:text> </xsl:text>
							<xsl:apply-templates mode="format" select="."/>
						</comment>
					</tp:nomenclature-citation>
				</xsl:for-each>
				<!-- Next put type species -->
				<xsl:for-each select="node()[@object_id='186' or @object_id='195' or @object_id='215' or @object_id='217']">
					<xsl:variable name="authors" select="normalize-space(fields/node()[@id='443'])"/>
					<xsl:variable name="authors1" select="normalize-space(node()[@object_id='180']//node()[@id='50'])"/>
					<xsl:variable name="authors2" select="normalize-space(node()[@object_id='220']//node()[@id='50'])"/>
					<xsl:variable name="basionym_authors" select="normalize-space(node()[@object_id='220']//node()[@id='478'])"/>
					<xsl:variable name="status" select="normalize-space(fields/node()[@id='440'])"/>
					<xsl:variable name="reason" select="normalize-space(fields/node()[@id='447'])"/>
					<xsl:variable name="reason1" select="normalize-space(fields/node()[@id='480'])"/>
					<tp:nomenclature-citation>
						<tp:taxon-name>
							<xsl:apply-templates mode="lower-taxon-name-parts" select="$genus_group/fields"/>
						</tp:taxon-name>
						<tp:type-species>
							<tp:taxon-name>
								<xsl:apply-templates mode="lower-taxon-name-parts" select="node()[@object_id='180']/fields"/><!-- species_name -->
								<xsl:apply-templates mode="lower-taxon-name-parts" select="node()[@object_id='220']/fields"/><!-- tt_species_name_with_basionym -->
								<xsl:apply-templates mode="lower-taxon-name-parts" select="fields"/><!-- new_tt_genus_icz?n -->
							</tp:taxon-name>
						</tp:type-species>
						<comment>
							<xsl:if test="$authors!=''">
								<xsl:text> </xsl:text>
								<xsl:value-of select="$authors"/>
								<xsl:text>;</xsl:text>
							</xsl:if>
							<xsl:if test="$authors1!=''">
								<xsl:text> </xsl:text>
								<xsl:value-of select="$authors1"/>
								<xsl:text>;</xsl:text>
							</xsl:if>
							<xsl:if test="$authors2!=''">
								<xsl:text> </xsl:text>
								<xsl:value-of select="$authors2"/>
								<xsl:text>;</xsl:text>
							</xsl:if>
							<xsl:apply-templates mode="nomenclature-reference-citations" select="node()[@object_id='187']"/>
							<xsl:if test="$basionym_authors!=''">
								<xsl:text> Basionym author(s): </xsl:text>
								<xsl:value-of select="$basionym_authors"/>
								<xsl:text>.</xsl:text>
							</xsl:if>
							<xsl:if test="$status!=''">
								<xsl:text> Status: </xsl:text>
								<xsl:value-of select="$status"/>
								<xsl:text>.</xsl:text>
							</xsl:if>
							<xsl:if test="$reason!='' or $reason1!=''">
								<xsl:text> Reason for typification: </xsl:text>
								<xsl:value-of select="$reason"/><xsl:value-of select="$reason1"/>
								<xsl:text>.</xsl:text>
							</xsl:if>
							<xsl:if test="normalize-space(node()[@object_id='219'])!=''"><!-- Synonyms -->
								<xsl:text> Synonyms: </xsl:text>
								<xsl:apply-templates mode="type-species-synonyms" select="node()[@object_id='219']"/>
							</xsl:if>
						</comment>
					</tp:nomenclature-citation>
				</xsl:for-each>
			</tp:nomenclature-citation-list>
		</xsl:if>
	</xsl:template>

	<xsl:template mode="nomenclature-reference-citations" match="*">
		<xsl:for-each select="node()[@object_id='201']"><!-- reference_single_citations -->
			<xsl:variable name="pages" select="normalize-space(fields/node()[@id='461'])"/>
			<xsl:variable name="notes" select="normalize-space(fields/node()[@id='462'])"/>
			<xsl:for-each select=".//node()[@id='438']"><!-- reference_citation -->
				<xsl:for-each select=".//p">
					<xsl:apply-templates mode="format" select="."/>
					<xsl:if test="position()!=last() and last()!=1">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
				<xsl:if test="position()!=last() and last()!=1">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:if test="$pages!='' or $notes!=''">
				<xsl:text>: </xsl:text>
				<xsl:value-of select="$pages"/>
				<xsl:if test="$pages!=''"><xsl:text>. </xsl:text></xsl:if>
				<xsl:value-of select="$notes"/>
			</xsl:if>
			<xsl:if test="position()!=last() and last()!=1">
				<xsl:text>; </xsl:text>
			</xsl:if>
		</xsl:for-each>
		<xsl:text>.</xsl:text>
	</xsl:template>
	
	<xsl:template mode="type-species-synonyms" match="*">
		<xsl:for-each select="node()[@object_id='218']">
			<tp:taxon-name>
				<xsl:apply-templates mode="lower-taxon-name-parts" select="node()[@object_id='180']/fields"/>
			</tp:taxon-name>
			<xsl:apply-templates mode="nomenclature-reference-citations" select="node()[@object_id='187']"/>
		</xsl:for-each>
	</xsl:template>








<!-- 	<xsl:template mode="taxon-nomenclature" match="*"> -->
<!-- 		<xsl:for-each select="nomenclature"> -->
<!-- 			<xsl:for-each select="fields"> -->
<!-- 				<xsl:for-each select="nomenclature"> -->
<!-- 					<xsl:for-each select="value"> -->
<!-- 						<xsl:for-each select="p">Empty p test? -->
<!-- 							<tp:nomenclature-citation> -->
<!-- 								<tp:taxon-name> -->
<!-- 									<xsl:apply-templates mode="lower-taxon-name-parts" select="../../../../../taxon_name/fields"/> -->
<!-- 									<xsl:apply-templates mode="lower-taxon-name-parts" select="../../../../../taxon_name_species/fields"/> -->
<!-- 								</tp:taxon-name> -->
<!-- 								<comment><xsl:text> </xsl:text><xsl:apply-templates mode="format" select="."/></comment> -->
<!-- 								</tp:nomenclature-citation> -->
<!-- 						</xsl:for-each> -->
<!-- 					</xsl:for-each> -->
<!-- 				</xsl:for-each> -->
<!-- 			</xsl:for-each> -->
<!-- 		</xsl:for-each> -->
<!-- 	</xsl:template> -->

<!-- 	<xsl:template mode="taxon-nomenclature-type-species" match="*"> -->
<!-- 		<xsl:if test="normalize-space(./*/value)!=''"> -->
<!-- 			<tp:type-species> -->
<!-- 				<tp:taxon-name> -->
<!-- 					<xsl:apply-templates mode="lower-taxon-name-parts" select="."/> -->
<!-- 				</tp:taxon-name> -->
<!-- 			</tp:type-species> -->
<!-- 		</xsl:if> -->
<!-- 	</xsl:template> -->

<!-- 	<xsl:template mode="taxon-put-type-species" match="*"> -->
<!-- 		<tp:type-species> -->
<!-- 			<tp:taxon-name><xsl:apply-templates mode="lower-taxon-name-parts" select="."/></tp:taxon-name> -->
<!-- 		</tp:type-species> -->
<!-- 	</xsl:template> -->
<!-- 	<xsl:template mode="taxon-type-species-reason" match="*"> -->
<!-- 		<xsl:if test="normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0"> -->
<!-- 			<xsl:text> </xsl:text> -->
<!-- 			<xsl:value-of select="@field_name"/> -->
<!-- 			<xsl:text>: </xsl:text> -->
<!-- 			<xsl:value-of select="value"/> -->
<!-- 			<xsl:text>.</xsl:text> -->
<!-- 		</xsl:if> -->
<!-- 	</xsl:template> -->
<!-- 	<xsl:template mode="taxon-type-species-reference-citations" match="*"> -->
<!-- 		<xsl:for-each select="citation[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]"> -->
<!-- 			<xsl:if test="normalize-space(citation/fields/reference_citation/value)!=''"> -->
<!-- 				<xsl:text> </xsl:text> -->
<!-- 			</xsl:if> -->
<!-- 			<xsl:for-each select="citation/fields/reference_citation/value/p[normalize-space(.)!='' or count(node()[name()!=''])!=0]"> -->
<!-- 				<xsl:apply-templates mode="format" select="."/> -->
<!-- 				<xsl:if test="position()!=last()"> -->
<!-- 					<xsl:text>, </xsl:text> -->
<!-- 				</xsl:if> -->
<!-- 			</xsl:for-each> -->
<!-- 			<xsl:if test="normalize-space(fields/pages__figures/value)!=''"> -->
<!-- 				<xsl:text> [</xsl:text> -->
<!-- 				<xsl:value-of select="fields/pages__figures/value"/> -->
<!-- 				<xsl:text>]</xsl:text> -->
<!-- 			</xsl:if> -->
<!-- 			<xsl:if test="normalize-space(fields/notes/value)!=''"> -->
<!-- 				<xsl:text>: </xsl:text> -->
<!-- 				<xsl:value-of select="fields/notes/value"/> -->
<!-- 			</xsl:if> -->
<!-- 			<xsl:choose> -->
<!-- 				<xsl:when test="position()=last()"> -->
<!-- 					<xsl:text>.</xsl:text> -->
<!-- 				</xsl:when> -->
<!-- 				<xsl:otherwise> -->
<!-- 					<xsl:text>;</xsl:text> -->
<!-- 				</xsl:otherwise> -->
<!-- 			</xsl:choose> -->
<!-- 		</xsl:for-each> -->
<!-- 	</xsl:template> -->
<!-- 	<xsl:template mode="taxon-type-species-synonyms" match="*"> -->
<!-- 		<xsl:variable name="authors" select="normalize-space(taxon_name/fields/taxon_authors)"/> -->
<!-- 		<xsl:for-each select="synonymy[normalize-space(.)!='']">Do not edit! -->
<!-- 			<tp:taxon-name> -->
<!-- 				<xsl:apply-templates mode="lower-taxon-name-parts" select="taxon_name/fields"/> -->
<!-- 			</tp:taxon-name> -->
<!-- 			<xsl:if test="$authors!=''"> -->
<!-- 				<xsl:text> </xsl:text> -->
<!-- 				<xsl:value-of select="$authors"/> -->
<!-- 			</xsl:if> -->
<!-- 			<xsl:text> </xsl:text> -->
<!-- 			<italic><xsl:text>Syn.</xsl:text></italic> -->
<!-- 			<xsl:apply-templates mode="taxon-type-species-reference-citations" select="reference_citations"/> -->
<!-- 		</xsl:for-each> -->
<!-- 	</xsl:template> -->

<!-- 	<xsl:template mode="taxon-nomenclature-citation-iczn" match="*"> -->
<!-- 		<xsl:choose> -->
<!-- 			<xsl:when test="normalize-space(nomenclature/fields/nomenclature/value)=''"> -->
<!-- 				<tp:nomenclature-citation-list> -->
<!-- 					<xsl:apply-templates mode="taxon-nomenclature-citation-type-species-iczn" select="."/> -->
<!-- 				</tp:nomenclature-citation-list> -->
<!-- 			</xsl:when> -->
<!-- 			<xsl:otherwise> -->
<!-- 				<tp:nomenclature-citation-list> -->
<!-- 					<xsl:apply-templates mode="taxon-nomenclature" select="."/> -->
<!-- 					<xsl:apply-templates mode="taxon-nomenclature-citation-type-species-iczn" select="."/> -->
<!-- 				</tp:nomenclature-citation-list> -->
<!-- 			</xsl:otherwise> -->
<!-- 		</xsl:choose> -->
<!-- 	</xsl:template> -->
<!-- 	<xsl:template mode="taxon-nomenclature-citation-type-species-iczn" match="*"> -->
<!-- 		<xsl:variable name="ts" select="type_species"/> -->
<!-- 		<xsl:variable name="ts_name" select="$ts/taxon_name"/> -->
<!-- 		<xsl:variable name="ts_authors" select="$ts_name/fields/taxon_authors"/> -->
<!-- 		<xsl:variable name="ts_reason" select="$ts/fields/reason_for_typification_"/> -->
<!-- 		<xsl:variable name="ts_synonyms" select="$ts/synonyms_of_the_type_species"/> -->
<!-- 		<tp:nomenclature-citation> -->
<!-- 			<xsl:apply-templates mode="taxon-put-taxon-name" select="."/> -->
<!-- 			<xsl:apply-templates mode="taxon-put-type-species" select="$ts_name/fields"/> -->
<!-- 			<comment> -->
<!-- 				<xsl:variable name="authors" select="normalize-space($ts_authors/value)"/> -->
<!-- 				<xsl:if test="$authors!=''"> -->
<!-- 					<xsl:value-of select="$authors"/> -->
<!-- 					<xsl:text>. </xsl:text> -->
<!-- 				</xsl:if> -->
<!-- 				<xsl:apply-templates mode="taxon-type-species-reference-citations" select="$ts/reference_citations"/> -->
<!-- 				<xsl:apply-templates mode="taxon-type-species-synonyms" select="$ts_synonyms"/> -->
<!-- 				<xsl:apply-templates mode="taxon-type-species-reason" select="$ts_reason"/> -->
<!-- 			</comment> -->
<!-- 		</tp:nomenclature-citation> -->
<!-- 	</xsl:template> -->

<!-- 	<xsl:template mode="taxon-nomenclature-citation-icn" match="*"> -->
<!-- 		<xsl:choose> -->
<!-- 			<xsl:when test="nomenclature/fields/nomenclature/value/text()=''"> -->
<!-- 				<tp:nomenclature-citation-list> -->
<!-- 					<xsl:apply-templates mode="taxon-nomenclature-citation-type-species-icn" select="."/> -->
<!-- 				</tp:nomenclature-citation-list> -->
<!-- 			</xsl:when> -->
<!-- 			<xsl:otherwise> -->
<!-- 				<tp:nomenclature-citation-list> -->
<!-- 					<xsl:apply-templates mode="taxon-nomenclature" select="."/> -->
<!-- 					<xsl:apply-templates mode="taxon-nomenclature-citation-type-species-icn" select="."/> -->
<!-- 				</tp:nomenclature-citation-list> -->
<!-- 			</xsl:otherwise> -->
<!-- 		</xsl:choose> -->
<!-- 	</xsl:template> -->
<!-- 	<xsl:template mode="taxon-nomenclature-citation-type-species-icn" match="*"> -->
<!-- 		<xsl:variable name="ts" select="type_species"/> -->
<!-- 		<xsl:variable name="ts_name" select="$ts/tt_species_name_with_basionym"/> -->
<!-- 		<xsl:variable name="ts_authors" select="$ts_name/fields/taxon_authors_and_year"/> -->
<!-- 		<xsl:variable name="ts_b_authors" select="$ts_name/fields/basionym_authors"/> -->
<!-- 		<xsl:variable name="ts_reason" select="$ts/fields/reason_for_typification"/> -->
<!-- 		<xsl:variable name="ts_synonyms" select="$ts/synonyms_of_the_type_species"/> -->
<!-- 		<tp:nomenclature-citation> -->
<!-- 			<xsl:apply-templates mode="taxon-put-taxon-name" select="."/> -->
<!-- 			<xsl:apply-templates mode="taxon-put-type-species" select="$ts_name"/> -->
<!-- 			<comment> -->
<!-- 				<xsl:value-of select="$ts_authors/value/text()"/> -->
<!-- 				<xsl:text>, </xsl:text> -->
<!-- 				<xsl:value-of select="$ts_b_authors/value/text()"/> -->
<!-- 				<xsl:text>. </xsl:text> -->
<!-- 				<xsl:apply-templates mode="taxon-type-species-reference-citations" select="$ts/reference_citations"/> -->
<!-- 				<xsl:apply-templates mode="taxon-type-species-synonyms" select="$ts_synonyms"/> -->
<!-- 				<xsl:apply-templates mode="taxon-type-species-reason" select="$ts_reason"/> -->
<!-- 			</comment> -->
<!-- 		</tp:nomenclature-citation> -->
<!-- 	</xsl:template> -->



<!-- 	<xsl:template mode="taxon-type-species-reference-citations-new" match="*"> -->
<!-- 		<xsl:for-each select="reference_single_citation[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]"> -->
<!-- 			<xsl:if test="normalize-space(citation/fields/reference_citation/value)!=''"> -->
<!-- 				<xsl:text> </xsl:text> -->
<!-- 			</xsl:if> -->
<!-- 			<xsl:for-each select="citation/fields/reference_citation/value/p"> -->
<!-- 				<xsl:apply-templates mode="p" select="."/> -->
<!-- 				<xsl:if test="position()!=last()"> -->
<!-- 					<xsl:text>, </xsl:text> -->
<!-- 				</xsl:if> -->
<!-- 			</xsl:for-each> -->
<!-- 			<xsl:if test="normalize-space(fields/pages__figures/value)!=''"> -->
<!-- 				<xsl:text> [</xsl:text> -->
<!-- 				<xsl:value-of select="fields/pages__figures/value"/> -->
<!-- 				<xsl:text>]</xsl:text> -->
<!-- 			</xsl:if> -->
<!-- 			<xsl:if test="normalize-space(fields/notes/value)!=''"> -->
<!-- 				<xsl:text>: </xsl:text> -->
<!-- 				<xsl:value-of select="fields/notes/value"/> -->
<!-- 			</xsl:if> -->
<!-- 			<xsl:choose> -->
<!-- 				<xsl:when test="position()=last()"> -->
<!-- 					<xsl:text>.</xsl:text> -->
<!-- 				</xsl:when> -->
<!-- 				<xsl:otherwise> -->
<!-- 					<xsl:text>;</xsl:text> -->
<!-- 				</xsl:otherwise> -->
<!-- 			</xsl:choose> -->
<!-- 		</xsl:for-each> -->
<!-- 	</xsl:template> -->


<!-- 	<xsl:template mode="taxon-nomenclature-citations-plantae" match="*"> -->
<!-- 		<xsl:variable name="ts" select="node()[@object_id='195']"/> -->
<!-- 		<tp:nomenclature-citation> -->
<!-- 			<xsl:apply-templates mode="taxon-put-taxon-name" select="."/> -->
<!-- 			<xsl:apply-templates mode="taxon-put-type-species" select="$ts/fields"/> -->
<!-- 			<comment> -->
<!-- 				<xsl:value-of select="$ts/fields/taxon_authors/value"/> -->
<!-- 				<xsl:text>, </xsl:text> -->
<!-- 				<xsl:value-of select="$ts/fields/status/value"/> -->
<!-- 				<xsl:text>, </xsl:text> -->
<!-- 				<xsl:value-of select="$ts/fields/basionym_authors/value"/> -->
<!-- 				<xsl:apply-templates mode="taxon-type-species-reference-citations-new" select="$ts/reference_citations"/> -->
<!-- 			</comment> -->
<!-- 		</tp:nomenclature-citation> -->
<!-- 	</xsl:template> -->

<!-- 	<xsl:template mode="taxon-nomenclature-citations-animalia" match="*"> -->
<!-- 		<xsl:variable name="ts" select="type_species_treatment"/> -->
<!-- 		<tp:nomenclature-citation> -->
<!-- 			<xsl:apply-templates mode="taxon-put-taxon-name" select="."/> -->
<!-- 			<xsl:apply-templates mode="taxon-put-type-species" select="$ts/fields"/> -->
<!-- 			<comment> -->
<!-- 				<xsl:value-of select="$ts/fields/taxon_authors/value"/> -->
<!-- 				<xsl:text>, </xsl:text> -->
<!-- 				<xsl:value-of select="$ts/fields/status/value"/> -->
<!-- 				<xsl:apply-templates mode="taxon-type-species-reference-citations-new" select="$ts/reference_citations"/> -->
<!-- 			</comment> -->
<!-- 		</tp:nomenclature-citation> -->
<!-- 	</xsl:template> -->
</xsl:stylesheet>