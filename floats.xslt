<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:param name="figures" select="//node()[@object_id='236']"/>
	<xsl:param name="tables" select="//node()[@object_id='237']"/>
	
	<xsl:template name="floats">
		<xsl:if test="(normalize-space($figures)!='') or (normalize-space($tables)!='')">
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
			<xsl:variable name="num" select="fields/figure_number/value"/>
			<xsl:variable name="type">
				<xsl:call-template name="figure-type">
					<xsl:with-param name="type" select="fields/figure_type/value"/>
				</xsl:call-template>
			</xsl:variable>
			<fig>
				<xsl:attribute name="id"><xsl:text>F</xsl:text><xsl:value-of select="$num"/></xsl:attribute>
				<xsl:attribute name="position">float</xsl:attribute>
				<xsl:attribute name="orientation">portrait</xsl:attribute>
				<label><xsl:value-of select="$type"/><xsl:text> </xsl:text><xsl:value-of select="$num"/><xsl:text>.</xsl:text></label>
				<xsl:for-each select="node()">
					<xsl:choose>
						<xsl:when test="@object_id='222'"><!-- Image -->
							<xsl:for-each select="fields/node()[@id='482']">
								<caption><xsl:apply-templates mode="p" select="value"/></caption>
							</xsl:for-each>
							<xsl:for-each select="fields/node()[@id='483']">
								<graphic>
									<xsl:attribute name="xlink:href"><xsl:value-of select="normalize-space(value)"/><xsl:text>.jpg</xsl:text></xsl:attribute>
									<xsl:attribute name="position">float</xsl:attribute>
									<xsl:attribute name="orientation">portrait</xsl:attribute>
									<xsl:attribute name="xlink:type">simple</xsl:attribute>
								</graphic>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="@object_id='223'"><!-- Video -->
							<xsl:for-each select="fields/node()[@id='482']">
								<caption><xsl:apply-templates mode="p" select="value"/></caption>
							</xsl:for-each>
							<xsl:for-each select="fields/node()[@id='486']">
								<media>
									<xsl:attribute name="xlink:href" select="normalize-space(value)"/>
									<xsl:attribute name="position">float</xsl:attribute>
									<xsl:attribute name="orientation">portrait</xsl:attribute>
								</media>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="@object_id='224'"><!-- Plates -->
							<xsl:for-each select="fields/node()[@id='482']">
								<caption><xsl:apply-templates mode="p" select="value"/></caption>
							</xsl:for-each>
							<xsl:for-each select="node()[@object_id='235']">
								<xsl:for-each select="node()"><!-- Plate type -->
									<xsl:for-each select="node()"><!-- Plate parts -->
										<xsl:for-each select="fields">
											<graphic>
												<xsl:attribute name="xlink:href"><xsl:value-of select="normalize-space(node()[@id='484']/value)"/><xsl:text>.jpg</xsl:text></xsl:attribute>
												<xsl:attribute name="position">float</xsl:attribute>
												<xsl:attribute name="orientation">portrait</xsl:attribute>
												<xsl:attribute name="xlink:type">simple</xsl:attribute>
												<xsl:for-each select="node()[@id='487'][normalize-space(.)!='']">
													<caption><xsl:apply-templates mode="p" select="value"/></caption>
												</xsl:for-each>
											</graphic>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</fig>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="figure-type">
		<xsl:param name="type" select="''"/>
		<xsl:choose>
			<xsl:when test="$type='Video'"><xsl:text>Figure</xsl:text></xsl:when>
			<xsl:when test="$type='Image'"><xsl:text>Figure</xsl:text></xsl:when>
			<xsl:when test="$type='Plate'"><xsl:text>Figure</xsl:text></xsl:when>
			<xsl:otherwise><xsl:text>Unknown Figure Type</xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
		TABLES
	-->
	<xsl:template name="tables">
		<xsl:for-each select="$tables/table">
			<xsl:variable name="num"><xsl:value-of select="fields/node()[@id='489']"/></xsl:variable>
			<table-wrap>
				<xsl:attribute name="id"><xsl:text>T</xsl:text><xsl:value-of select="$num"/></xsl:attribute>
				<xsl:attribute name="position">float</xsl:attribute>
				<xsl:attribute name="orientation">portrait</xsl:attribute>
				<label>Table <xsl:value-of select="$num"/>.</label>
				<xsl:for-each select="fields/node()[@id='482'][normalize-space(.)!='']">
					<caption><xsl:apply-templates mode="p" select="value"/></caption>
				</xsl:for-each>
				<xsl:for-each select="fields/node()[@id='490'][normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]"><!-- non-empty table_editor -->
					<xsl:for-each select="value">
						<xsl:for-each select="node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
							<xsl:choose>
								<xsl:when test="name()='table'">
									<xsl:variable name="align" select="@align"/>
									<xsl:for-each select="caption[normalize-space(.)!='']">
										<long-desc><xsl:value-of select="normalize-space(.)"/></long-desc>
									</xsl:for-each>
									<table>
										<xsl:if test="normalize-space(@border)"><xsl:attribute name="border" select="@border"/></xsl:if>
										<xsl:if test="normalize-space(@cellpadding)"><xsl:attribute name="cellpadding" select="@cellpadding"/></xsl:if>
										<xsl:if test="normalize-space(@cellspacing)"><xsl:attribute name="cellspacing" select="@cellspacing"/></xsl:if>
										<xsl:if test="normalize-space(@style)"><xsl:attribute name="style" select="@style"/></xsl:if>
										<xsl:if test="normalize-space(@summary)"><xsl:attribute name="summary" select="@summary"/></xsl:if>
										<xsl:for-each select="thead[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
											<thead>
												<xsl:for-each select="tr[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
													<tr>
														<xsl:for-each select="th">
															<th>
																<xsl:attribute name="rowspan">1</xsl:attribute>
																<xsl:attribute name="colspan">1</xsl:attribute>
																<xsl:if test="$align!=''"><xsl:attribute name="align" select="$align"/></xsl:if>
																<xsl:apply-templates mode="td-format" select="."/>
															</th>
														</xsl:for-each>
													</tr>
												</xsl:for-each>
											</thead>
										</xsl:for-each>
										<xsl:for-each select="tbody[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
											<tbody>
												<xsl:for-each select="tr[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
													<tr>
														<xsl:for-each select="td">
															<td>
																<xsl:attribute name="rowspan">1</xsl:attribute>
																<xsl:attribute name="colspan">1</xsl:attribute>
																<xsl:if test="$align!=''"><xsl:attribute name="align" select="$align"/></xsl:if>
																<xsl:apply-templates mode="td-format" select="."/>
															</td>
														</xsl:for-each>
													</tr>
												</xsl:for-each>
											</tbody>
										</xsl:for-each>
									</table>
								</xsl:when>
								<xsl:when test="name()='p'">
									<preformat><xsl:apply-templates mode="format" select="."/></preformat>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:for-each>
			</table-wrap>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>