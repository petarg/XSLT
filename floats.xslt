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
			
				<xsl:for-each select="node()">
					<xsl:choose>
						<xsl:when test="@object_id='222'"><!-- Image -->
							<fig>
								<xsl:attribute name="id"><xsl:text>F</xsl:text><xsl:value-of select="$num"/></xsl:attribute>
								<xsl:attribute name="position">float</xsl:attribute>
								<xsl:attribute name="orientation">portrait</xsl:attribute>
								<label><xsl:value-of select="$type"/><xsl:text> </xsl:text><xsl:value-of select="$num"/><xsl:text>.</xsl:text></label>
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
							</fig>
						</xsl:when>
						<xsl:when test="@object_id='223'"><!-- Video -->
							<fig>
								<xsl:attribute name="id"><xsl:text>F</xsl:text><xsl:value-of select="$num"/></xsl:attribute>
								<xsl:attribute name="position">float</xsl:attribute>
								<xsl:attribute name="orientation">portrait</xsl:attribute>
								<label><xsl:value-of select="$type"/><xsl:text> </xsl:text><xsl:value-of select="$num"/><xsl:text>.</xsl:text></label>
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
							</fig>
						</xsl:when>
						<xsl:when test="@object_id='224'"><!-- Plates -->
							<fig-group>
								<xsl:attribute name="id"><xsl:text>F</xsl:text><xsl:value-of select="$num"/></xsl:attribute>
								<xsl:attribute name="position">float</xsl:attribute>
								<xsl:attribute name="orientation">portrait</xsl:attribute>
								<xsl:for-each select="fields/node()[@id='482']">
									<caption><xsl:apply-templates mode="p" select="value"/></caption>
								</xsl:for-each>
								<xsl:for-each select="node()[@object_id='235']"><!-- Plate type wrapper -->
									<xsl:for-each select="./*/node()"><!-- Plate part -->
										<xsl:choose>
											<xsl:when test="@object_id='225'"><!-- Plate part a -->
												<xsl:apply-templates mode="plate-part" select=".">
													<xsl:with-param name="fig_num" select="$num"/>
													<xsl:with-param name="label" select="'a'"/>
													<xsl:with-param name="type" select="$type"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:when test="@object_id='226'"><!-- Plate part b -->
												<xsl:apply-templates mode="plate-part" select=".">
													<xsl:with-param name="fig_num" select="$num"/>
													<xsl:with-param name="label" select="'b'"/>
													<xsl:with-param name="type" select="$type"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:when test="@object_id='227'"><!-- Plate part c -->
												<xsl:apply-templates mode="plate-part" select=".">
													<xsl:with-param name="fig_num" select="$num"/>
													<xsl:with-param name="label" select="'c'"/>
													<xsl:with-param name="type" select="$type"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:when test="@object_id='228'"><!-- Plate part d -->
												<xsl:apply-templates mode="plate-part" select=".">
													<xsl:with-param name="fig_num" select="$num"/>
													<xsl:with-param name="label" select="'d'"/>
													<xsl:with-param name="type" select="$type"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:when test="@object_id='229'"><!-- Plate part e -->
												<xsl:apply-templates mode="plate-part" select=".">
													<xsl:with-param name="fig_num" select="$num"/>
													<xsl:with-param name="label" select="'e'"/>
													<xsl:with-param name="type" select="$type"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:when test="@object_id='230'"><!-- Plate part f -->
												<xsl:apply-templates mode="plate-part" select=".">
													<xsl:with-param name="fig_num" select="$num"/>
													<xsl:with-param name="label" select="'f'"/>
													<xsl:with-param name="type" select="$type"/>
												</xsl:apply-templates>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
								</xsl:for-each>
							</fig-group>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
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
	<xsl:template mode="plate-part" match="*">
		<xsl:param name="fig_num" select="'1'"/>
		<xsl:param name="label" select="''"/>
		<xsl:param name="type" select="''"/>
		<xsl:variable name="caption" select="fields/node()[@id='487']/value"/>
		<xsl:variable name="url"><xsl:value-of select="fields/image_id/value"/><xsl:text>.jpg</xsl:text></xsl:variable>
		<fig>
			<xsl:attribute name="id"><xsl:text>F</xsl:text><xsl:value-of select="$fig_num"/><xsl:value-of select="$label"/></xsl:attribute>
			<xsl:attribute name="position">float</xsl:attribute>
			<xsl:attribute name="orientation">portrait</xsl:attribute>
			<label>
				<xsl:value-of select="$type"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$fig_num"/>
				<xsl:value-of select="$label"/>
				<xsl:text>.</xsl:text>
			</label>
			<xsl:if test="normalize-space($caption)!=''">
				<caption><xsl:apply-templates mode="p" select="$caption"/></caption>
			</xsl:if>
			<graphic>
				<xsl:attribute name="xlink:href" select="$url"/>
				<xsl:attribute name="position">float</xsl:attribute>
				<xsl:attribute name="orientation">portrait</xsl:attribute>
				<xsl:attribute name="xlink:type">simple</xsl:attribute>
			</graphic>
		</fig>
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
						<xsl:for-each select="table">
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
						</xsl:for-each>
						<xsl:if test="count(node()[name()='p'][normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0])">
							<table-wrap-foot>
								<xsl:for-each select="node()[name()='p'][normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
									<p><xsl:apply-templates mode="format" select="."/></p>
								</xsl:for-each>
							</table-wrap-foot>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
			</table-wrap>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>