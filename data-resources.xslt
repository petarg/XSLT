<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />

	<xsl:template mode="data-resources" match="*">
		<xsl:if test="normalize-space(.//value)!='' or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
				<title><xsl:value-of select="@display_name"/></title>
				<xsl:variable name="data_package_title" select="fields/node()[@id='339']"/>
				<xsl:variable name="resource_link" select="fields/node()[@id='340']"/>
				<xsl:variable name="alternative_identifiers" select="fields/node()[@id='341']"/>
				<xsl:variable name="number_of_data_sets" select="fields/node()[@id='342']"/>
				<table-wrap-group>
					<caption>
						<xsl:apply-templates mode="data-p" select="$data_package_title"/>
						<xsl:apply-templates mode="data-p-link" select="$resource_link"/>
						<xsl:apply-templates mode="data-p" select="$alternative_identifiers"/>
						<xsl:apply-templates mode="data-p" select="$number_of_data_sets"/>
					</caption>
					<!-- Data sets -->
					<xsl:for-each select="node()[@object_id='141'][count(.//value[normalize-space(.)!=''])!='0']">
						<xsl:apply-templates mode="data-set" select=".">
							<xsl:with-param name="n" select="position()"/>
						</xsl:apply-templates>
					</xsl:for-each>
				</table-wrap-group>
			</sec>
		</xsl:if>
	</xsl:template>

	<xsl:template mode="data-set" match="*">
		<xsl:param name="n" select='0'/>
		<xsl:variable name="name" select="fields/node()[@id='397']"/>
		<xsl:variable name="format" select="fields/node()[@id='398']"/>
		<xsl:variable name="description" select="fields/node()[@id='399']"/>
		<xsl:variable name="ncolumns" select="fields/node()[@id='400']"/>
		<xsl:variable name="encoding" select="fields/node()[@id='457']"/>
		<xsl:variable name="url" select="fields/node()[@id='458']"/>
		<xsl:variable name="version" select="fields/node()[@id='459']"/>
		<table-wrap>
			<xsl:attribute name="id"><xsl:text>DS</xsl:text><xsl:value-of select="$n"/></xsl:attribute>
			<xsl:attribute name="orientation">portrait</xsl:attribute>
			<xsl:attribute name="position">anchor</xsl:attribute>
			<label><xsl:text>Data set </xsl:text><xsl:value-of select="$n"/><xsl:text>.</xsl:text></label>
			<caption>
				<xsl:apply-templates mode="data-p" select="$name"/>
				<xsl:apply-templates mode="data-p" select="$format"/>
				<xsl:apply-templates mode="data-p" select="$ncolumns"/>
				<xsl:apply-templates mode="data-p" select="$encoding"/>
				<xsl:apply-templates mode="data-p-link" select="$url"/>
				<xsl:apply-templates mode="data-p" select="$version"/>
				<xsl:if test="normalize-space($description)">
					<p><bold><xsl:value-of select="$description/@field_name"/></bold><xsl:text>:</xsl:text></p>
					<xsl:apply-templates mode="p" select="$description/value"/>
				</xsl:if>
			</caption>
			<table>
				<thead>
					<tr>
						<th>
							<xsl:attribute name="rowspan">1</xsl:attribute>
							<xsl:attribute name="colspan">1</xsl:attribute>
							<xsl:text>Column label</xsl:text>
						</th>
						<th>
							<xsl:attribute name="rowspan">1</xsl:attribute>
							<xsl:attribute name="colspan">1</xsl:attribute>
							<xsl:text>Column description</xsl:text>
						</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="column">
						<xsl:apply-templates mode="column" select="."/>
					</xsl:for-each>
				</tbody>
			</table>
		</table-wrap>
	</xsl:template>
	<xsl:template mode="column" match="*">
		<tr>
			<td>
				<xsl:attribute name="rowspan">1</xsl:attribute>
				<xsl:attribute name="colspan">1</xsl:attribute>
				<xsl:value-of select="normalize-space(fields/node()[@id='401']/value)"/>
			</td>
			<td>
				<xsl:attribute name="rowspan">1</xsl:attribute>
				<xsl:attribute name="colspan">1</xsl:attribute>
				<xsl:value-of select="normalize-space(fields/node()[@id='402']/value)"/>
			</td>
		</tr>
	</xsl:template>





</xsl:stylesheet>