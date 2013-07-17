<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />
	<xsl:param name="figures" select="/document/figures"/>
	<xsl:param name="tables" select="/document/tables"/>
	
	<xsl:template name="floats">
		<xsl:if test="(normalize-space(/document/figures)!='') or (normalize-space(/document/tables)!='')">
			<floats-group>
				<xsl:call-template name="figures"/>
				<xsl:call-template name="tables"/>
			</floats-group>
		</xsl:if>
	</xsl:template>
	<!--
		FIGURES
	-->
	<xsl:template name="figures">
		<xsl:for-each select="$figures/figure">
			<xsl:variable name="num"><xsl:value-of select="position()"/></xsl:variable>
			<fig>
				<xsl:attribute name="id"><xsl:text>F</xsl:text><xsl:value-of select="$num"/></xsl:attribute>
				<xsl:attribute name="position">float</xsl:attribute>
				<xsl:attribute name="orientation">portrait</xsl:attribute>
				<label>Figure <xsl:value-of select="$num"/>.</label>
				<caption><xsl:apply-templates mode="p" select="caption"/></caption>
				<xsl:for-each select="node()">
					<xsl:choose>
						<xsl:when test="name()='url'">
							<graphic>
								<xsl:attribute name="xlink:href"><xsl:value-of select="substring-after(normalize-space(.), '=')"/></xsl:attribute>
								<xsl:attribute name="position">float</xsl:attribute>
								<xsl:attribute name="orientation">portrait</xsl:attribute>
								<xsl:attribute name="xlink:type">simple</xsl:attribute>
							</graphic>
						</xsl:when>
						<xsl:when test="name()='photo_description'">
							<xsl:if test="normalize-space(.)!=''">
								<p><xsl:value-of select="normalize-space(.)"/></p>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</fig>
		</xsl:for-each>
	</xsl:template>
	<!--
		TABLES
	-->
	<xsl:template name="tables">
		<xsl:for-each select="$tables/table">
			<xsl:variable name="num"><xsl:value-of select="position()"/></xsl:variable>
			<table-wrap>
				<xsl:attribute name="id"><xsl:text>T</xsl:text><xsl:value-of select="$num"/></xsl:attribute>
				<xsl:attribute name="position">float</xsl:attribute>
				<xsl:attribute name="orientation">portrait</xsl:attribute>
				<label>Table <xsl:value-of select="$num"/>.</label>
				<caption><xsl:apply-templates mode="p" select="title"/></caption>
				<table>
					<xsl:for-each select="description/table">
						<xsl:for-each select="thead">
							<thead>
								<xsl:for-each select="tr">
									<tr>
										<xsl:for-each select="th">
											<th>
												<xsl:attribute name="rowspan">1</xsl:attribute>
												<xsl:attribute name="colspan">1</xsl:attribute>
												<xsl:apply-templates mode="td-format" select="."/>
											</th>
										</xsl:for-each>
									</tr>
								</xsl:for-each>
							</thead>
						</xsl:for-each>
						<xsl:for-each select="tbody">
							<tbody>
								<xsl:for-each select="tr">
									<tr>
										<xsl:for-each select="td">
											<td>
												<xsl:attribute name="rowspan">1</xsl:attribute>
												<xsl:attribute name="colspan">1</xsl:attribute>
												<xsl:apply-templates mode="td-format" select="."/>
											</td>
										</xsl:for-each>
									</tr>
								</xsl:for-each>
							</tbody>
						</xsl:for-each>
					</xsl:for-each>
				</table>
			</table-wrap>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>