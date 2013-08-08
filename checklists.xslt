<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">

	<xsl:template mode="checklists" match="*">
		<xsl:for-each select="checklist[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
			<xsl:apply-templates mode="checklist" select="."/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="checklist" match="*">
		<sec>
			<xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
			<xsl:apply-templates mode="checklist-meta" select="."/>
			<title><xsl:apply-templates mode="title" select="fields/node()[@id='413']/value"/></title>
			<xsl:for-each select="checklist_taxon[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
				<xsl:apply-templates mode="checklist_taxon" select="."/>
			</xsl:for-each>
			<xsl:apply-templates mode="checklist-locality" select="."/>
		</sec>
	</xsl:template>
	<xsl:template mode="checklist-meta" match="*">
		<sec-meta>
			<xsl:for-each select="fields[normalize-space(.)!='']">
				<kwd-group>
					<xsl:for-each select="*[(normalize-space(value)!='') and (@id!='476')]">
						<xsl:variable name="value" select="normalize-space(value)"/>
						<xsl:choose>
							<xsl:when test="@field_name=''">
								<kwd><xsl:value-of select="$value"/></kwd>
							</xsl:when>
							<xsl:otherwise>
								<kwd>
									<xsl:value-of select="@field_name"/>
									<xsl:text>: </xsl:text>
									<xsl:value-of select="$value"/>
								</kwd>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</kwd-group>
			</xsl:for-each>
		</sec-meta>
	</xsl:template>
	<xsl:template mode="checklist-locality" match="*">
		<xsl:for-each select="node()[@object_id='212']">
			<sec>
				<xsl:attribute name="sec-type">Locality</xsl:attribute>
				<title><xsl:value-of select="normalize-space(@display_name)"/></title>
				<xsl:for-each select="fields/node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
					<xsl:apply-templates mode="little-section" select="."/>
				</xsl:for-each>
				<xsl:for-each select="checklist_taxon">
					<xsl:apply-templates mode="checklist_taxon" select="."/>
				</xsl:for-each>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="checklist_taxon" match="*">
		<xsl:variable name="authors" select="normalize-space(fields/node()[@id='236']/value)"/>
		<xsl:variable name="nomenclature" select="node()[@object_id='210']/fields//value"/>
		<tp:taxon-treatment>
			<tp:nomenclature>
				<tp:taxon-name>
					<xsl:apply-templates mode="checklist-taxon-name" select="fields"/>
					<xsl:apply-templates mode="taxon-object-id" select="."/>
				</tp:taxon-name>
				<xsl:if test="$authors!=''">
					<tp:taxon-authority><xsl:value-of select="$authors"/></tp:taxon-authority>
				</xsl:if>
				<xsl:if test="normalize-space($nomenclature)!='' or count($nomenclature/*/*[name()!=''])!=0">
					<tp:nomenclature-citation-list>
						<xsl:for-each select="$nomenclature/*[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
							<tp:nomenclature-citation>
								<tp:taxon-name><xsl:apply-templates mode="checklist-taxon-name-short" select="../../../../../fields"/></tp:taxon-name>
								<comment><xsl:apply-templates mode="format" select="."/></comment>
							</tp:nomenclature-citation>
						</xsl:for-each>
					</tp:nomenclature-citation-list>
				</xsl:if>
			</tp:nomenclature>
			<xsl:apply-templates mode="materials" select="materials"/>
			<xsl:apply-templates mode="checklist-eco-interactions" select="."/>
			<xsl:for-each select="node()[(@object_id='208') or (@object_id='207') or (@object_id='206')][normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
				<xsl:apply-templates mode="treatment-section" select="."/>
			</xsl:for-each>
		</tp:taxon-treatment>
	</xsl:template>

	<xsl:template mode="checklist-taxon-name-part" match="*">
		<tp:taxon-name-part>
			<xsl:attribute name="taxon-name-part-type"><xsl:value-of select="name()"/></xsl:attribute>
			<xsl:value-of select="value"/>
		</tp:taxon-name-part>
	</xsl:template>
	<xsl:template mode="checklist-taxon-name" match="*">
		<xsl:for-each select="kingdom[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="subkingdom[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="phylum[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="subphylum[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="superclass[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="class[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="subclass[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="superorder[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="order[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="suborder[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="infraorder[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="superfamily[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="family[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="subfamily[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="tribe[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="subtribe[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="genus[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="subgenus[normalize-space(value)!='']">
			<xsl:text> (</xsl:text>
			<xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
			<xsl:text>) </xsl:text>
		</xsl:for-each>
		<xsl:for-each select="species[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="subspecies[normalize-space(value)!='']"><xsl:apply-templates mode="checklist-taxon-name-part" select="."/></xsl:for-each>
		<xsl:for-each select="variety[normalize-space(value)!='']">
			<xsl:text> var. </xsl:text>
			<xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
		</xsl:for-each>
		<xsl:for-each select="form[normalize-space(value)!='']">
			<xsl:text> f. </xsl:text>
			<xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="checklist-taxon-name-short" match="*">
		<xsl:variable name="genus" select="normalize-space(genus/value)"/>
		<xsl:variable name="species" select = "normalize-space(species/value)"/>
		<xsl:choose>
			<xsl:when test="$genus!='' and $species!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="genus"/>
				<xsl:apply-templates mode="checklist-taxon-name-part" select="species"/>
			</xsl:when>
			<xsl:when test="$genus!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="genus"/>
			</xsl:when>
			<xsl:when test="$species!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="species"/>
			</xsl:when>
			<xsl:when test="normalize-space(tribe/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="tribe"/>
			</xsl:when>
			<xsl:when test="normalize-space(subfamily/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="subfamily"/>
			</xsl:when>
			<xsl:when test="normalize-space(family/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="family"/>
			</xsl:when>
			<xsl:when test="normalize-space(superfamily/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="superfamily"/>
			</xsl:when>
			<xsl:when test="normalize-space(infraorder/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="infraorder"/>
			</xsl:when>
			<xsl:when test="normalize-space(suborder/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="suborder"/>
			</xsl:when>
			<xsl:when test="normalize-space(order/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="order"/>
			</xsl:when>
			<xsl:when test="normalize-space(superorder/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="superorder"/>
			</xsl:when>
			<xsl:when test="normalize-space(subclass/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="subclass"/>
			</xsl:when>
			<xsl:when test="normalize-space(class/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="class"/>
			</xsl:when>
			<xsl:when test="normalize-space(superclass/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="superclass"/>
			</xsl:when>
			<xsl:when test="normalize-space(subphylum/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="subphylum"/>
			</xsl:when>
			<xsl:when test="normalize-space(phylum/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="phylum"/>
			</xsl:when>
			<xsl:when test="normalize-space(subkingdom/value)!=''">
				<xsl:apply-templates mode="checklist-taxon-name-part" select="subkingdom"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates mode="checklist-taxon-name-part" select="kingdom"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template mode="checklist-eco-interactions" match="*">
		<xsl:for-each select="node()[@object_id='209']">
			<xsl:if test="normalize-space(.)!=''">
				<tp:treatment-sec>
					<xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
					<title><xsl:value-of select="@display_name"/></title>
					<xsl:for-each select="fields/*[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
						<xsl:apply-templates mode="little-section" select="."/>
					</xsl:for-each>
				</tp:treatment-sec>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>