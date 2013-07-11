<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="keys.xslt"/>
	<xsl:import href="section.xslt" />
	<xsl:import href="systematics.xslt"/>
	<xsl:import href="checklists.xslt"/>
	<xsl:import href="data-resources.xslt"/>

	<xsl:template name="body">
		<xsl:variable name="body" select="/document/objects"/>
		<body>
			<xsl:for-each select="$body/node()[count((.//value//text()[normalize-space(.)!='']))!=0 or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
				<xsl:choose>
					<!-- NON-TRIVIAL SECTIONS -->
					<xsl:when test="name()='systematics'">
						<xsl:apply-templates mode="systematics" select="."/>
					</xsl:when>
					<xsl:when test="name()='checklists'">
						<xsl:apply-templates mode="checklists" select="."/>
					</xsl:when>
					<xsl:when test="name()='checklist'">
						<xsl:apply-templates mode="checklist" select="."/>
					</xsl:when>
					<xsl:when test="name()='identification_keys'">
						<xsl:apply-templates mode="keys" select="." />
					</xsl:when>
					<xsl:when test="name()='project_description'">
						<xsl:apply-templates mode="project-decription" select="."/>
					</xsl:when>
					<xsl:when test="name()='geographic_coverage'">
						<xsl:apply-templates mode="geographic-coverage" select="."/>
					</xsl:when>
					<xsl:when test="name()='taxonomic_coverage'">
						<xsl:apply-templates mode="taxonomic-coverage" select="."/>
					</xsl:when>
					<xsl:when test="name()='usage_rights'">
						<xsl:apply-templates mode="usage-rights" select="."/>
					</xsl:when>
					<xsl:when test="name()='software_specification'">
						<xsl:apply-templates mode="software-specification" select="."/>
					</xsl:when>
					<!-- Software Description Article Type specific sections -->
					<xsl:when test="@object_id='112' or @object_id='113' or @object_id='114'">
						<xsl:apply-templates mode="web-locations-section" select="."/>
					</xsl:when>
					<xsl:when test="@object_id='115' or @object_id='116'">
						<xsl:apply-templates mode="software-description-section" select="."/>
					</xsl:when>
					<!-- Data paper specific -->
					<xsl:when test="@object_id='189'">
						<xsl:apply-templates mode="general-description-section" select="."/>
					</xsl:when>
					<xsl:when test="object_id='123'">
						<xsl:apply-templates mode="sampling-methods-section" select="."/>
					</xsl:when>
					<xsl:when test="@object_id='125'">
						<xsl:apply-templates mode="collection-data-section" select="."/>
					</xsl:when>
					<xsl:when test="@object_id='194'">
						<xsl:apply-templates mode="temporal-coverage-wrapper-section" select="."/>
					</xsl:when>
					<xsl:when test="@object_id='124'">
						<xsl:apply-templates mode="temporal-coverage-section" select="."/>
					</xsl:when>
					<xsl:when test="@object_id='126'">
						<xsl:apply-templates mode="data-resources" select="."/>
					</xsl:when>
					<!-- TRIVIAL SECTIONS -->
					<xsl:when test="@object_id!='14' and @object_id!='21' and @object_id!='56' and @object_id!='57' and @object_id!='202'">
						<xsl:apply-templates mode="section" select="." >
							<xsl:with-param name="title"><xsl:value-of select="normalize-space(@display_name)"/></xsl:with-param>
						</xsl:apply-templates>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</body>
	</xsl:template>
</xsl:stylesheet>