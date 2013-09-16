<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xml="http://www.w3.org/XML/1998/namespace"
	xmlns="http://www.eol.org/transfer/content/0.3"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:dwc="http://rs.tdwg.org/dwc/dwcore/"
	xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema">

	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<response>
			<xsl:for-each select="/document/objects/systematics/treatment">
				<xsl:variable name="taxon_id" select="position()"/>
				<taxon>
					<dc:identifier>
						<xsl:text>BDJ.1.eXXX.sp_</xsl:text>
						<xsl:value-of select="$taxon_id"/>
					</dc:identifier>
					<dwc:Kingdom>TAXON KINGDOM</dwc:Kingdom>
					<dwc:Family>TAXON FAMILY</dwc:Family>
					<dwc:ScientificName>
						<xsl:apply-templates mode="dwcScientificName"/>
					</dwc:ScientificName>
					<dcterms:created>
						<xsl:value-of select="current-dateTime()"/>
					</dcterms:created>
					<dcterms:modified>
						<xsl:value-of select="current-dateTime()"/>
					</dcterms:modified>
					<reference>
						<xsl:attribute name="doi">
							<xsl:text>10.3897/BDJ.1.eXXX</xsl:text><!-- TODO -->
						</xsl:attribute>
						<xsl:call-template name="getArticleReference"/>
					</reference>
					<xsl:apply-templates mode="TreatmentObjects">
						<xsl:with-param name="taxon_id" select="$taxon_id"/>
					</xsl:apply-templates>
					<xsl:call-template name="Figures">
						<xsl:with-param name="taxon_id" select="$taxon_id"/>
						<xsl:with-param name="plate_id" select="1"/>
						<xsl:with-param name="uniqueIds">
							<xsl:call-template name="getUniqueXrefIds">
								<xsl:with-param name="xref_type" select="'fig'"/>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</taxon>
			</xsl:for-each>
		</response>
	</xsl:template>

	<xsl:template match="@*|node()"  mode="dwcScientificName"/>
	<xsl:template match="new_tt_species_iczn" mode="dwcScientificName">
		<xsl:value-of select="species_name/fields/genus/value"/>
		<xsl:if test="species_name/fields/subgenus/value!=''">
			<xsl:text> (</xsl:text>
			<xsl:value-of select="species_name/fields/subgenus/value"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="species_name/fields/species/value"/>
		<xsl:if test="species_name/fields/taxon_authors!=''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="species_name/fields/taxon_authors"/>
			<xsl:text>,</xsl:text>
		</xsl:if>
		<xsl:text> sp. n.</xsl:text>
	</xsl:template>
	<xsl:template match="redescription_tt_species_iczn" mode="dwcScientificName">
		<xsl:value-of select="species_name/fields/genus/value"/>
		<xsl:if test="species_name/fields/subgenus/value!=''">
			<xsl:text> (</xsl:text>
			<xsl:value-of select="species_name/fields/subgenus/value"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="species_name/fields/species/value"/>
		<xsl:if test="species_name/fields/taxon_authors!=''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="species_name/fields/taxon_authors"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="new_tt_genus_iczn" mode="dwcScientificName">
		<xsl:value-of select="genus_name/fields/genus/value"/>
		<xsl:text> </xsl:text>
		<xsl:if test="normalize-space(genus_name/fields/taxon_authors/value)!=''">
			<xsl:value-of select="normalize-space(genus_name/fields/taxon_authors/value)"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:text>gen. n.</xsl:text>
	</xsl:template>
	<xsl:template match="redescription_tt_genus_iczn" mode="dwcScientificName">
		<xsl:value-of select="genus_name/fields/genus/value"/>
		<xsl:if test="normalize-space(genus_name/fields/taxon_authors/value)!=''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="normalize-space(genus_name/fields/taxon_authors/value)"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="new_tt_species_icn" mode="dwcScientificName">
		<xsl:value-of select="species_name/fields/genus/value"/>
		<xsl:if test="species_name/fields/subgenus/value!=''">
			<xsl:text> (</xsl:text>
			<xsl:value-of select="species_name/fields/subgenus/value"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="species_name/fields/species/value"/>
		<xsl:if test="species_name/fields/taxon_authors!=''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="species_name/fields/taxon_authors"/>
			<xsl:text>,</xsl:text>
		</xsl:if>
		<xsl:text> sp. nov.</xsl:text>
	</xsl:template>
	<xsl:template match="redescription_tt_species_icn" mode="dwcScientificName">
		<xsl:value-of select="species_name/fields/genus/value"/>
		<xsl:if test="species_name/fields/subgenus/value!=''">
			<xsl:text> (</xsl:text>
			<xsl:value-of select="species_name/fields/subgenus/value"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="species_name/fields/species/value"/>
		<xsl:if test="species_name/fields/taxon_authors!=''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="species_name/fields/taxon_authors"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="new_tt_genus_icn" mode="dwcScientificName">
		<xsl:value-of select="genus_name/fields/genus/value"/>
		<xsl:text> </xsl:text>
		<xsl:if test="normalize-space(genus_name/fields/taxon_authors/value)!=''">
			<xsl:value-of select="normalize-space(genus_name/fields/taxon_authors/value)"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:text>gen. nov.</xsl:text>
	</xsl:template>
	<xsl:template match="redescription_tt_genus_icn" mode="dwcScientificName">
		<xsl:value-of select="genus_name/fields/genus/value"/>
		<xsl:if test="normalize-space(genus_name/fields/taxon_authors/value)!=''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="normalize-space(genus_name/fields/taxon_authors/value)"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@*|node()" mode="TreatmentObjects"/>
	<xsl:template match="new_tt_species_iczn" mode="TreatmentObjects">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:apply-templates select="new_tt_species_sections/node()" mode="TreatmentSections">
			<xsl:with-param name="taxon_id" select="$taxon_id"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="redescription_tt_species_iczn" mode="TreatmentObjects">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:apply-templates select="treatment_sections_species_animalia/node()" mode="TreatmentSections">
			<xsl:with-param name="taxon_id" select="$taxon_id"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="new_tt_genus_iczn" mode="TreatmentObjects">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:apply-templates select="treatment_sections_genus_animalia/node()" mode="TreatmentSections">
			<xsl:with-param name="taxon_id" select="$taxon_id"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="redescription_tt_genus_iczn" mode="TreatmentObjects">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:apply-templates select="treatment_sections/node()" mode="TreatmentSections">
			<xsl:with-param name="taxon_id" select="$taxon_id"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="new_tt_species_icn" mode="TreatmentObjects">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:apply-templates select="new_tt_species_phytokeys_sections/node()" mode="TreatmentSections">
			<xsl:with-param name="taxon_id" select="$taxon_id"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="redescription_tt_species_icn" mode="TreatmentObjects">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:apply-templates select="treatment_sections_species_plantae/node()" mode="TreatmentSections">
			<xsl:with-param name="taxon_id" select="$taxon_id"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="new_tt_genus_icn" mode="TreatmentObjects">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:apply-templates select="treatment_sections_genus_plantae/node()" mode="TreatmentSections">
			<xsl:with-param name="taxon_id" select="$taxon_id"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="redescription_tt_genus_icn" mode="TreatmentObjects">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:apply-templates select="treatment_sections/node()" mode="TreatmentSections">
			<xsl:with-param name="taxon_id" select="$taxon_id"/>
		</xsl:apply-templates>
	</xsl:template>
	
	
	
	
	
	
	
	
	<xsl:template match="@*|node()" mode="TreatmentSections"/>
	
	<xsl:template match="description|distribution|ecology|biology|conservation" mode="TreatmentSections">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:if test="normalize-space(.)!=''">
			<dataObject>
				<dc:identifier>
					<xsl:text>BDJ.1.eXXX.sp_</xsl:text><!-- TODO -->
					<xsl:value-of select="$taxon_id"/>
					<xsl:text>_</xsl:text>
					<xsl:value-of select="name()"/>
				</dc:identifier>
				<dataType>http://purl.org/dc/dcmitype/Text</dataType>
				<mimeType>text/html</mimeType>
				<xsl:for-each select="/document/objects/article_metadata/title_and_authors/author[normalize-space(.)!='']">
					<agent>
						<xsl:attribute name="role">author</xsl:attribute>
						<xsl:value-of select="fields/first_name/value"/>
						<xsl:if test="fields/middle_name/value!=''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="fields/middle_name/value"/>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="fields/last_name/value"/>
					</agent>
				</xsl:for-each>
				<dc:title>
					<xsl:attribute name="xml:lang">en</xsl:attribute>
					<xsl:value-of select="@display_name"/>
				</dc:title>
				<dc:language>en</dc:language>
				<license>http://creativecommons.org/licenses/by/3.0/</license>
				<dcterms:rightsHolder>
					<xsl:call-template name="getAuthors"/>
				</dcterms:rightsHolder>
				<dcterms:bibliographicCitation>
					<xsl:call-template name="getArticleReference"/>
				</dcterms:bibliographicCitation>
				<audience>Expert users</audience>
				<audience>General public</audience>
				<dc:source>http://www.pensoft.net/journals//article//abstract/</dc:source>
				<subject>
					<xsl:text>http://rs.tdwg.org/ontology/voc/SPMInfoItems#</xsl:text>
					<xsl:choose>
						<xsl:when test="name()='description'">
							<xsl:text>GeneralDescription</xsl:text>
						</xsl:when>
						<xsl:when test="name()='biology'">
							<xsl:text>TaxonBiology</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@display_name"/>
						</xsl:otherwise>
					</xsl:choose>
				</subject>
				<dc:description>
					<xsl:attribute name="xml:lang">en</xsl:attribute>
					<xsl:for-each select=".//p | .//li">
						<xsl:text>&#x0A;</xsl:text>
						<xsl:value-of select="normalize-space(.)"/>
					</xsl:for-each>
					<xsl:text>&#x0A;         </xsl:text>
				</dc:description>
			</dataObject>
		</xsl:if>
	</xsl:template>

	<xsl:template name="getUniqueXrefIds">
		<xsl:param name="xref_type" select="'fig'"/>
		<xsl:for-each select="distinct-values(.//xref[@type=$xref_type]/@rid)">
			<xsl:value-of select="."/>
			<xsl:text>;</xsl:text>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="Figures">
		<xsl:param name="taxon_id" select="'1'"/>
		<xsl:param name="plate_id" select="1"/>
		<xsl:param name="uniqueIds" select="'1;'"/>
		<xsl:if test="substring-before($uniqueIds, ';')!=''">
			<xsl:variable name="fig" select="/document/objects/figures//node()[@instance_id=substring-before($uniqueIds, ';')]"/>
			<xsl:if test="normalize-space($fig)!='' and count($fig/multiple_images_plate)=0">
				<dataObject>
					<dc:identifier>
						<xsl:text>BDJ.1.eXXX.sp_</xsl:text><!-- TODO -->
						<xsl:value-of select="$taxon_id"/>
						<xsl:text>_p_</xsl:text>
						<xsl:value-of select="$plate_id"/>
					</dc:identifier>
					<dataType>http://purl.org/dc/dcmitype/StillImage</dataType>
					<mimeType>image/jpeg</mimeType>
					<dcterms:created>
						<xsl:text>2013</xsl:text><!-- TODO -->
					</dcterms:created>
					<license>http://creativecommons.org/licenses/by/3.0/</license>
					<dcterms:rightsHolder>
						<xsl:call-template name="getAuthors"/>
					</dcterms:rightsHolder>
					<dcterms:bibliographicCitation>
						<xsl:call-template name="getArticleReference"/>
					</dcterms:bibliographicCitation>
					<audience>Expert users</audience>
					<audience>General public</audience>
					<dc:source>http://www.pensoft.net/journals//article//abstract/</dc:source>
					<xsl:choose>
						<xsl:when test="count($fig/image)!=0"><!-- Image -->
							<xsl:apply-templates mode="image" select="$fig"/>
						</xsl:when>
						<xsl:when test="count($fig/video)!=0"><!-- Video -->
							<xsl:apply-templates mode="video" select="$fig"/>
						</xsl:when>
						<xsl:when test="name($fig)='plate_part_a'">
							<xsl:apply-templates mode="plate" select="$fig">
								<xsl:with-param name="letter" select="'a'"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:when test="name($fig)='plate_part_b'">
							<xsl:apply-templates mode="plate" select="$fig">
								<xsl:with-param name="letter" select="'b'"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:when test="name($fig)='plate_part_c'">
							<xsl:apply-templates mode="plate" select="$fig">
								<xsl:with-param name="letter" select="'c'"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:when test="name($fig)='plate_part_d'">
							<xsl:apply-templates mode="plate" select="$fig">
								<xsl:with-param name="letter" select="'d'"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:when test="name($fig)='plate_part_e'">
							<xsl:apply-templates mode="plate" select="$fig">
								<xsl:with-param name="letter" select="'e'"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:when test="name($fig)='plate_part_f'">
							<xsl:apply-templates mode="plate" select="$fig">
								<xsl:with-param name="letter" select="'f'"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<ERROR>UNDEFINED PLATE TYPE</ERROR>
						</xsl:otherwise>
					</xsl:choose>
				</dataObject>
			</xsl:if>
			<xsl:call-template name="Figures">
				<xsl:with-param name="taxon_id" select="$taxon_id"/>
				<xsl:with-param name="plate_id" select="$plate_id + 1"/>
				<xsl:with-param name="uniqueIds" select="substring-after($uniqueIds, ';')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="image" match="*">
		<xsl:variable name="url">
			<xsl:text>http://pwt.pensoft.net//showfigure.php?filename=big_</xsl:text>
			<xsl:value-of select="image/fields/photo_select/value"/><!-- TODO -->
			<xsl:text>.jpg</xsl:text>
		</xsl:variable>
		<dc:description xml:lang="en">
			<xsl:text>&#x0A;Figure </xsl:text>
			<xsl:value-of select="fields/figure_number/value"/>
			<xsl:text>.</xsl:text>
			<xsl:for-each select="image/fields/figure_caption/value">
				<xsl:for-each select=".//p | .//li">
					<xsl:text>&#x0A;</xsl:text>
					<xsl:value-of select="normalize-space(.)"/>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:text>&#x0A;         </xsl:text>
		</dc:description>
		<mediaURL>
			<xsl:value-of select="$url"/>
		</mediaURL>
		<thumbnailURL>
			<xsl:value-of select="$url"/>
		</thumbnailURL>
	</xsl:template>
	<xsl:template mode="video" match="*">
		<xsl:variable name="url">
			<xsl:text>http://pwt.pensoft.net//showfigure.php?filename=big_</xsl:text>
			<xsl:value-of select="video/fields/youtube_link/value"/><!-- TODO -->
			<xsl:text>.jpg</xsl:text>
		</xsl:variable>
		<dc:description xml:lang="en">
			<xsl:text>&#x0A;Figure </xsl:text>
			<xsl:value-of select="fields/figure_number/value"/>
			<xsl:text>.</xsl:text>
			<xsl:for-each select="video/fields/video_caption/value">
				<xsl:for-each select=".//p | .//li">
					<xsl:text>&#x0A;</xsl:text>
					<xsl:value-of select="normalize-space(.)"/>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:text>&#x0A;         </xsl:text>
		</dc:description>
		<mediaURL>
			<xsl:value-of select="$url"/>
		</mediaURL>
		<thumbnailURL>
			<xsl:value-of select="$url"/>
		</thumbnailURL>
	</xsl:template>
	<xsl:template mode="plate" match="*">
		<xsl:param name="letter" select="'a'"/>
		<xsl:variable name="url">
			<xsl:text>http://pwt.pensoft.net//showfigure.php?filename=big_</xsl:text>
			<xsl:value-of select="fields/image_id/value"/><!-- TODO -->
			<xsl:text>.jpg</xsl:text>
		</xsl:variable>
		<dc:description xml:lang="en">
			<xsl:text>&#x0A;Figure </xsl:text>
			<xsl:value-of select="../../../../fields/figure_number/value"/>
			<xsl:value-of select="$letter"/>
			<xsl:text>.</xsl:text>
			<xsl:for-each select="../../../fields/plate_caption/value">
				<xsl:for-each select=".//p | .//li">
					<xsl:text>&#x0A;</xsl:text>
					<xsl:value-of select="normalize-space(.)"/>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:text>&#x0A;</xsl:text>
			<xsl:value-of select="fields/plate_desc/value"/>
			<xsl:text>&#x0A;         </xsl:text>
		</dc:description>
		<mediaURL>
			<xsl:value-of select="$url"/>
		</mediaURL>
		<thumbnailURL>
			<xsl:value-of select="$url"/>
		</thumbnailURL>
	</xsl:template>










	<xsl:template name="getAuthors">
		<xsl:for-each select="/document/objects/article_metadata/title_and_authors/author[normalize-space(.)!='']">
			<xsl:value-of select="fields/first_name/value"/>
			<xsl:if test="fields/middle_name/value!=''">
				<xsl:text> </xsl:text>
				<xsl:value-of select="fields/middle_name/value"/>
			</xsl:if>
			<xsl:text> </xsl:text>
			<xsl:value-of select="fields/last_name/value"/>
			<xsl:if test="position()!=last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="getArticleReference">
		<xsl:for-each select="/document/objects/article_metadata/title_and_authors/author[normalize-space(.)!='']">
			<xsl:value-of select="fields/last_name/value"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="substring(fields/first_name/value, 1, 1)"/>
			<xsl:if test="fields/middle_name/value!=''">
				<xsl:value-of select="substring(fields/middle_name/value, 1, 1)"/>
			</xsl:if>
			<xsl:if test="position()!=last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
		<xsl:text> (</xsl:text>
		<xsl:text>2013</xsl:text><!-- TODO -->
		<xsl:text>) </xsl:text>
		<xsl:value-of select="normalize-space(/document/objects/article_metadata/title_and_authors/fields/title/value)"/>
		<xsl:text>. </xsl:text>
		<xsl:text>Biodiversity Data Journal 1: eXXX</xsl:text><!-- TODO -->
	</xsl:template>
</xsl:stylesheet>