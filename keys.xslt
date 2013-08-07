<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
<!-- 	<xsl:import href="section.xslt" /> -->
	
	<xsl:template mode="keys" match="*">
		<sec>
			<xsl:attribute name="sec-type">Identification Keys</xsl:attribute>
			<title>Identification Keys</title>
			<xsl:apply-templates mode="key" select="." />
		</sec>
	</xsl:template>

	<xsl:template mode="key" match="*">
			<xsl:for-each select="identification_key">
				<xsl:variable name="title" select="fields/title/value"/>
				<sec>
					<xsl:attribute name="sec-type"><xsl:value-of select="normalize-space($title)"/></xsl:attribute>
					<title><xsl:apply-templates mode="title" select="$title"/></title>
					<table-wrap content-type="key" position="anchor" orientation="portrait">
						<table>
							<tbody>
							<xsl:for-each select="key_couplet">
								<xsl:variable name="ttaxon" select="fields/thesis_taxon_name/value"/>
								<xsl:variable name="tnext" select="fields/thesis_next_couplet/value"/>
								<xsl:variable name="ataxon" select="fields/antithesis_taxon_name/value"/>
								<xsl:variable name="anext" select="fields/antithesis_next_couplet/value"/>
								<tr>
									<td>
										<xsl:attribute name="rowspan">1</xsl:attribute>
										<xsl:attribute name="colspan">1</xsl:attribute>
										<xsl:number/>
									</td>
									<td>
										<xsl:attribute name="rowspan">1</xsl:attribute>
										<xsl:attribute name="colspan">1</xsl:attribute>
										<xsl:apply-templates mode="td-format" select="fields/thesis/value"/>
									</td>
									<td>
										<xsl:attribute name="rowspan">1</xsl:attribute>
										<xsl:attribute name="colspan">1</xsl:attribute>
										<xsl:if test="normalize-space($ttaxon)!=''">
											<xsl:apply-templates mode="td-format" select="$ttaxon" />
											<xsl:if test="normalize-space($tnext)!=''">
												<xsl:text>, </xsl:text>
											</xsl:if>
										</xsl:if>
										<xsl:if test="normalize-space($tnext)!=''">
											<xsl:apply-templates mode="format" select="$tnext" />
										</xsl:if>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:attribute name="rowspan">1</xsl:attribute>
										<xsl:attribute name="colspan">1</xsl:attribute>
										<xsl:text>–</xsl:text>
									</td>
									<td>
										<xsl:attribute name="rowspan">1</xsl:attribute>
										<xsl:attribute name="colspan">1</xsl:attribute>
										<xsl:apply-templates mode="td-format" select="fields/antithesis/value"/>
									</td>
									<td>
										<xsl:attribute name="rowspan">1</xsl:attribute>
										<xsl:attribute name="colspan">1</xsl:attribute>
										<xsl:if test="normalize-space($ataxon)!=''">
											<xsl:apply-templates mode="td-format" select="$ataxon" />
											<xsl:if test="normalize-space($anext)!=''">
												<xsl:text>, </xsl:text>
											</xsl:if>
										</xsl:if>
										<xsl:if test="normalize-space($anext)!=''">
											<xsl:apply-templates mode="format" select="$anext" />
										</xsl:if>
									</td>
								</tr>
							</xsl:for-each>
							</tbody>
						</table>
					</table-wrap>
				</sec>
			</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
