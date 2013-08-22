<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs" xmlns:mml="http://www.w3.org/1998/Math/MathML"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />
	
	<xsl:template match="/document">
		<document>
			<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:attribute name="journal_id"><xsl:value-of select="@journal_id"/></xsl:attribute>
			<xsl:apply-templates/>
		</document>
	</xsl:template>
	
	<xsl:template match="@*|node()[name()!='span' and name()!='div' and name()!='comment-start' and name()!='comment-end' and name()!='em' and name()!='i' and name()!='b' and name()!='strong' and name()!='u' and name()!='a' and name()!='tn' and name()!='tn-part' and name()!='references' and name()!='figures' and name()!='tables' and name()!='supplementary_files']">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="span | div | comment-start | comment-end">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="a">
		<ext-link>
			<xsl:attribute name="ext-link-type">uri</xsl:attribute>
			<xsl:attribute name="xlink:href"><xsl:value-of select="@href"/></xsl:attribute>
			<xsl:apply-templates mode="format" select="."/>
		</ext-link>
	</xsl:template>
	<xsl:template match="i | em">
		<italic>
			<xsl:apply-templates />
		</italic>
	</xsl:template>
	<xsl:template match="b | strong">
		<bold>
			<xsl:apply-templates />
		</bold>
	</xsl:template>
	<xsl:template match="u">
		<underline>
			<xsl:apply-templates />
		</underline>
	</xsl:template>
	<xsl:template match="tn">
		<tp:taxon-name>
			<xsl:for-each select="node()">
				<xsl:choose>
					<xsl:when test="name()=''">
						<xsl:value-of select="."/>
					</xsl:when>
					<xsl:when test="name()='tn-part'">
						<tp:taxon-name-part>
							<xsl:attribute name="taxon-name-part-type"><xsl:value-of select="@type"/></xsl:attribute>
							<xsl:value-of select="."/>
						</tp:taxon-name-part>
					</xsl:when>
					<xsl:otherwise>
						<INVALID-TAG><xsl:copy-of select="."/></INVALID-TAG>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</tp:taxon-name>
	</xsl:template>
	
	<xsl:template match="references">
		<references>
			<xsl:attribute name="object_id"><xsl:value-of select="@object_id"/></xsl:attribute>
			<xsl:attribute name="instance_id"><xsl:value-of select="@instance_id"/></xsl:attribute>
			<xsl:attribute name="display_name"><xsl:value-of select="@display_name"/></xsl:attribute>
			<xsl:attribute name="pos"><xsl:value-of select="@pos"/></xsl:attribute>
			<xsl:for-each select="reference">
				<reference>
					<xsl:attribute name="nlm_id"><xsl:value-of select="position()"/></xsl:attribute>
					<xsl:attribute name="object_id"><xsl:value-of select="@object_id"/></xsl:attribute>
					<xsl:attribute name="instance_id"><xsl:value-of select="@instance_id"/></xsl:attribute>
					<xsl:attribute name="display_name"><xsl:value-of select="@display_name"/></xsl:attribute>
					<xsl:attribute name="pos"><xsl:value-of select="@pos"/></xsl:attribute>
					<xsl:apply-templates/>
				</reference>
			</xsl:for-each>
		</references>
	</xsl:template>
	<xsl:template match="figures">
		<figures>
			<xsl:attribute name="object_id"><xsl:value-of select="@object_id"/></xsl:attribute>
			<xsl:attribute name="instance_id"><xsl:value-of select="@instance_id"/></xsl:attribute>
			<xsl:attribute name="display_name"><xsl:value-of select="@display_name"/></xsl:attribute>
			<xsl:attribute name="pos"><xsl:value-of select="@pos"/></xsl:attribute>
			<xsl:for-each select="figure">
				<figure>
					<xsl:attribute name="nlm_id"><xsl:value-of select="position()"/></xsl:attribute>
					<xsl:attribute name="object_id"><xsl:value-of select="@object_id"/></xsl:attribute>
					<xsl:attribute name="instance_id"><xsl:value-of select="@instance_id"/></xsl:attribute>
					<xsl:attribute name="display_name"><xsl:value-of select="@display_name"/></xsl:attribute>
					<xsl:attribute name="pos"><xsl:value-of select="@pos"/></xsl:attribute>
					<xsl:apply-templates/>
				</figure>
			</xsl:for-each>
		</figures>
	</xsl:template>
	<xsl:template match="tables">
		<tables>
			<xsl:attribute name="object_id"><xsl:value-of select="@object_id"/></xsl:attribute>
			<xsl:attribute name="instance_id"><xsl:value-of select="@instance_id"/></xsl:attribute>
			<xsl:attribute name="display_name"><xsl:value-of select="@display_name"/></xsl:attribute>
			<xsl:attribute name="pos"><xsl:value-of select="@pos"/></xsl:attribute>
			<xsl:for-each select="table">
				<table>
					<xsl:attribute name="nlm_id"><xsl:value-of select="position()"/></xsl:attribute>
					<xsl:attribute name="object_id"><xsl:value-of select="@object_id"/></xsl:attribute>
					<xsl:attribute name="instance_id"><xsl:value-of select="@instance_id"/></xsl:attribute>
					<xsl:attribute name="display_name"><xsl:value-of select="@display_name"/></xsl:attribute>
					<xsl:attribute name="pos"><xsl:value-of select="@pos"/></xsl:attribute>
					<xsl:apply-templates/>
				</table>
			</xsl:for-each>
		</tables>
	</xsl:template>
	<xsl:template match="supplementary_files">
		<supplementary_files>
			<xsl:attribute name="object_id"><xsl:value-of select="@object_id"/></xsl:attribute>
			<xsl:attribute name="instance_id"><xsl:value-of select="@instance_id"/></xsl:attribute>
			<xsl:attribute name="display_name"><xsl:value-of select="@display_name"/></xsl:attribute>
			<xsl:attribute name="pos"><xsl:value-of select="@pos"/></xsl:attribute>
			<xsl:for-each select="supplementary_file">
				<supplementary_file>
					<xsl:attribute name="nlm_id"><xsl:value-of select="position()"/></xsl:attribute>
					<xsl:attribute name="object_id"><xsl:value-of select="@object_id"/></xsl:attribute>
					<xsl:attribute name="instance_id"><xsl:value-of select="@instance_id"/></xsl:attribute>
					<xsl:attribute name="display_name"><xsl:value-of select="@display_name"/></xsl:attribute>
					<xsl:attribute name="pos"><xsl:value-of select="@pos"/></xsl:attribute>
					<xsl:apply-templates/>
				</supplementary_file>
			</xsl:for-each>
		</supplementary_files>
	</xsl:template>
</xsl:stylesheet>