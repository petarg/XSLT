<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:template mode="section" match="*">
		<xsl:param name="title" />
		<sec>
			<xsl:attribute name="sec-type"><xsl:value-of select="$title"/></xsl:attribute>
			<xsl:choose>
				<xsl:when test="normalize-space(fields/title/value)!=''">
					<title><xsl:apply-templates mode="title" select="fields/title/value"/></title>
				</xsl:when>
				<xsl:otherwise>
					<title><xsl:value-of select="$title"/></title>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates mode="p" select="fields/*[name()!='title']/value" />
			<xsl:apply-templates mode="subsection" select="."/>
		</sec>
	</xsl:template>
	<xsl:template mode="subsection" match="*">
		<xsl:for-each select="subsection">
			<xsl:variable name="title" select="fields/enter_title_of_this_subsection/value"/>
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="normalize-space($title)"/></xsl:attribute>
				<title><xsl:apply-templates mode="title" select="$title"/></title>
				<xsl:apply-templates mode="p" select="fields/content/value" />
			</sec>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="little-section" match="*">
		<sec>
			<xsl:attribute name="sec-type"><xsl:value-of select="@field_name"/></xsl:attribute>
			<title><xsl:value-of select="@field_name"/></title>
			<xsl:apply-templates mode="p" select="value"/>
		</sec>
	</xsl:template>
	<xsl:template mode="little-p" match="*">
		<xsl:choose>
			<xsl:when test="@id='307' or @id='293' or @id='294' or @id='295' or @id='296' or @id='297' or @id='298' or @id='299' or @id='300'">
				<xsl:variable name="address" select="normalize-space(value)"/>
				<p>
					<xsl:value-of select="@field_name"/>
					<xsl:text>: </xsl:text>
					<ext-link>
						<xsl:attribute name="ext-link-type">uri</xsl:attribute>
						<xsl:attribute name="xlink:href"><xsl:value-of select="$address"/></xsl:attribute>
						<xsl:value-of select="$address"/>
					</ext-link>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p><xsl:value-of select="@field_name"/><xsl:text>: </xsl:text><xsl:apply-templates mode="format" select="value"/></p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template mode="data-p" match="*">
		<xsl:if test="normalize-space(value)!=''">
			<p>
				<bold><xsl:value-of select="@field_name"/><xsl:text>:</xsl:text></bold>
				<xsl:text> </xsl:text>
				<xsl:value-of select="normalize-space(value)"/>
			</p>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="data-p-link" match="*">
		<xsl:if test="normalize-space(value)!=''">
			<p>
				<bold><xsl:value-of select="@field_name"/><xsl:text>:</xsl:text></bold>
				<xsl:text> </xsl:text>
				<ext-link>
					<xsl:attribute name="ext-link-type">uri</xsl:attribute>
					<xsl:attribute name="xlink:href"><xsl:value-of select="normalize-space(value)"/></xsl:attribute>
					<xsl:value-of select="normalize-space(value)"/>
				</ext-link>
			</p>
		</xsl:if>
	</xsl:template>

	<xsl:template mode="p" match="*">
		<xsl:choose>
			<xsl:when test="normalize-space(.)='' and count(.//*[name()!='' and name!='p' and name()!='ol' and name()!='ul'])=0"></xsl:when>
			<xsl:when test="count(*[(name()='p') or (name()='ul') or (name()='ol')])!=0">
				<xsl:for-each select="node()[(normalize-space(.)!='') or (count(*[name()!='p' and name()!='ul' and name()!='ol'])!=0) or (name()!='')]">
					<xsl:choose>
						<xsl:when test="(name()='p') or (name()='')">
							<p><xsl:apply-templates mode="format" select="."/></p>
						</xsl:when>
						<xsl:when test="name()='ul'">
							<xsl:apply-templates mode="section-unordered-list" select="."/>
						</xsl:when>
						<xsl:when test="name()='ol'">
							<xsl:apply-templates mode="section-ordered-list" select="."/>
						</xsl:when>
						<xsl:otherwise>
							<invalid-tag><xsl:copy-of select="."/></invalid-tag>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<p><xsl:apply-templates mode="format" select="."/></p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template mode="section-ordered-list" match="*">
		<list>
			<xsl:attribute name="list-type">order</xsl:attribute>
			<xsl:for-each select="li">
				<list-item>
					<p><xsl:apply-templates mode="format" select="."/></p>
				</list-item>
			</xsl:for-each>
		</list>
	</xsl:template>

	<xsl:template mode="section-unordered-list" match="*">
		<list>
			<xsl:attribute name="list-type">bullet</xsl:attribute>
			<xsl:for-each select="li">
				<list-item>
					<p><xsl:apply-templates mode="format" select="."/></p>
				</list-item>
			</xsl:for-each>
		</list>
	</xsl:template>


	
<!-- 	<xsl:template mode="format1" match="*">
		<xsl:for-each select="node()[normalize-space(.)!='']">
			<xsl:variable name="text"><xsl:value-of select="normalize-space(.)"/></xsl:variable>
			<xsl:variable name="first"><xsl:value-of select="substring($text,1,1)"/></xsl:variable>
			<xsl:if test="(position() &gt; 1) and ($first!=',') and ($first!='.') and ($first!=';') and ($first!=')')">
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="name()=''">
					<xsl:value-of select="$text"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="format-nodes" select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template> -->

<!-- 	<xsl:template mode="format0" match="*">
		<xsl:for-each select="node()">
			<xsl:choose>
				<xsl:when test="name()=''">
					<xsl:variable name="val" select="normalize-space(.)"/>
					<xsl:call-template name="tag-uri">
						<xsl:with-param name="string" select="$val"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="format-nodes" select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="tag-uri">
		<xsl:param name="string" select="''"/>
		<xsl:choose>
			<xsl:when test="contains($string, 'http://') or contains($string, 'https://')">
				<xsl:value-of select="substring-before(string, 'http')"/>
				<xsl:variable name="after" select="substring-after($string, 'http')"/>
				<xsl:variable name="address" select="concat('http',substring-before($after, ' '))"/>
				<xsl:call-template name="tag-uri-uri">
					<xsl:with-param name="string" select="$address"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:value-of select="substring-after($after, ' ')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="tag-uri-uri">
		<xsl:param name="string" select="''"/>
		<xsl:choose>
			<xsl:when test="contains($string, ')')">
				<xsl:call-template name="tag-uri-uri">
					<xsl:with-param name="string" select="substring-before($string, ')')"/>
				</xsl:call-template>
				<xsl:text>)</xsl:text>
				<xsl:value-of select="substring-after($string, ')')"/>
			</xsl:when>
			<xsl:when test="contains($string, ']')">
				<xsl:call-template name="tag-uri-uri">
					<xsl:with-param name="string" select="substring-before($string, ']')"/>
				</xsl:call-template>
				<xsl:text>]</xsl:text>
				<xsl:value-of select="substring-after($string, ']')"/>
			</xsl:when>
			<xsl:when test="contains($string, '}')">
				<xsl:call-template name="tag-uri-uri">
					<xsl:with-param name="string" select="substring-before($string, '}')"/>
				</xsl:call-template>
				<xsl:text>}</xsl:text>
				<xsl:value-of select="substring-after($string, '}')"/>
			</xsl:when>
			<xsl:otherwise>
				<uri><xsl:value-of select="$string"/></uri>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template> -->

	<xsl:template mode="format" match="*">
		<xsl:for-each select="node()">
			<xsl:choose>
				<xsl:when test="name()=''">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="format-nodes" select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="format-nodes" match="*">
		<xsl:choose>
			<xsl:when test="name()='em'">
				<italic><xsl:apply-templates mode="format" select="."/></italic>
			</xsl:when>
			<xsl:when test="name()='strong'">
				<bold><xsl:apply-templates mode="format" select="."/></bold>
			</xsl:when>
			<xsl:when test="name()='u'">
				<underline><xsl:apply-templates mode="format" select="."/></underline>
			</xsl:when>
			<xsl:when test="name()='sup'">
				<sup><xsl:apply-templates mode="format" select="."/></sup>
			</xsl:when>
			<xsl:when test="name()='sub'">
				<sub><xsl:apply-templates mode="format" select="."/></sub>
			</xsl:when>
			<xsl:when test="name()='fig-citation'">
				<xref>
					<xsl:attribute name="ref-type">fig</xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>F1</xsl:text></xsl:attribute>
					<xsl:apply-templates mode="format" select="."/>
				</xref>
			</xsl:when>
			<xsl:when test="name()='tbls-citation'">
				<xref>
					<xsl:attribute name="ref-type">table</xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>T1</xsl:text></xsl:attribute>
					<xsl:apply-templates mode="format" select="."/>
				</xref>
			</xsl:when>
			<xsl:when test="name()='sup-files-citation'">
				<xref>
					<xsl:attribute name="ref-type">supplementary-material</xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>S1</xsl:text></xsl:attribute>
					<xsl:apply-templates mode="format" select="."/>
				</xref>
			</xsl:when>
			<xsl:when test="name()='reference-citation'">
				<xref>
					<xsl:attribute name="ref-type">bibr</xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>B1</xsl:text></xsl:attribute>
					<xsl:apply-templates mode="format" select="."/>
				</xref>
			</xsl:when>
			<xsl:when test="name()='a'">
				<ext-link>
					<xsl:attribute name="ext-link-type">uri</xsl:attribute>
					<xsl:attribute name="xlink:href"><xsl:value-of select="@href"/></xsl:attribute>
					<xsl:apply-templates mode="format" select="."/>
				</ext-link>
			</xsl:when>
			<xsl:when test="name()='br'">
				<xsl:text>&lt;br/&gt;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


<!-- TITLE RELATED TEMPLATES -->
	<xsl:template mode="title" match="*">
		<xsl:choose>
			<xsl:when test="count(*[name()='p'])!=0">
				<xsl:for-each select="p[normalize-space(.)!='']">
					<xsl:if test="position()!=1"><break/></xsl:if>
					<xsl:apply-templates mode="format-title" select="."/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates mode="format-title" select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template mode="format-title" match="*">
		<xsl:for-each select="node()">
			<xsl:choose>
				<xsl:when test="name()=''">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="format-title-nodes" select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="format-title-nodes" match="*">
		<xsl:choose>
			<xsl:when test="name()='em'">
				<italic><xsl:apply-templates mode="format-title" select="."/></italic>
			</xsl:when>
			<xsl:when test="name()='strong'">
				<xsl:apply-templates mode="format-title" select="."/>
			</xsl:when>
			<xsl:when test="name()='u'">
				<underline><xsl:apply-templates mode="format-title" select="."/></underline>
			</xsl:when>
			<xsl:when test="name()='sup'">
				<sup><xsl:apply-templates mode="format-title" select="."/></sup>
			</xsl:when>
			<xsl:when test="name()='sub'">
				<sub><xsl:apply-templates mode="format-title" select="."/></sub>
			</xsl:when>
			<!-- TODO: references in title? -->
			<xsl:when test="name()='fig-citation'">
				<xref>
					<xsl:attribute name="ref-type">fig</xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>F1</xsl:text></xsl:attribute>
					<xsl:apply-templates mode="format-title" select="."/>
				</xref>
			</xsl:when>
			<xsl:when test="name()='tbls-citation'">
				<xref>
					<xsl:attribute name="ref-type">table</xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>T1</xsl:text></xsl:attribute>
					<xsl:apply-templates mode="format-title" select="."/>
				</xref>
			</xsl:when>
			<xsl:when test="name()='sup-files-citation'">
				<xref>
					<xsl:attribute name="ref-type">supplementary-material</xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>S1</xsl:text></xsl:attribute>
					<xsl:apply-templates mode="format-title" select="."/>
				</xref>
			</xsl:when>
			<xsl:when test="name()='reference-citation'">
				<xref>
					<xsl:attribute name="ref-type">bibr</xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>B1</xsl:text></xsl:attribute>
					<xsl:apply-templates mode="format-title" select="."/>
				</xref>
			</xsl:when>
			<xsl:when test="name()='a'">
				<ext-link>
					<xsl:attribute name="ext-link-type">uri</xsl:attribute>
					<xsl:attribute name="xlink:href"><xsl:value-of select="@href"/></xsl:attribute>
					<xsl:apply-templates mode="format-title" select="."/>
				</ext-link>
			</xsl:when>
			<xsl:when test="name()='br'">
				<break/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>


<!-- FORMAT OF TABLE DATA -->
	<xsl:template mode="td-format" match="*">
		<xsl:for-each select="node()[normalize-space(.)!='' or count(.//*[name()!=''])!=0]">
			<xsl:choose>
				<xsl:when test="name()='p'">
					<xsl:apply-templates mode="format" select="."/>
					<xsl:if test="position()!=last()">
						<!-- <xsl:text>&lt;br/&gt;</xsl:text> -->
						<break/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="name()=''">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="format-nodes" select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>




<!-- Some non-trivial sections -->
	<xsl:template mode="project-decription" match="*">
		<xsl:for-each select="fields[count(.//value//*[normalize-space(text())!=''])!=0 or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<xsl:for-each select="node()[count(.//value//*[normalize-space(text())!=''])!=0 or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:choose>
						<xsl:when test="name()='title'">
							<title><xsl:apply-templates mode="title" select="value"/></title>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates mode="little-section" select="."/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="geographic-coverage" match="*">
		<xsl:for-each select="fields[count(.//value//*[normalize-space(text())!=''])!=0 or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<xsl:variable name="west" select="node()[@id='317']"/>
			<xsl:variable name="east" select="node()[@id='318']"/>
			<xsl:variable name="south" select="node()[@id='319']"/>
			<xsl:variable name="north" select="node()[@id='320']"/>
			<xsl:variable name="global" select="node()[@id='321']"/>
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="description[count(.//value//*[normalize-space(text())!=''])!=0 or count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<p><bold><xsl:value-of select="@field_name"/><xsl:text>:</xsl:text></bold></p>
					<xsl:apply-templates mode="p" select="value"/>
				</xsl:for-each>
				<xsl:apply-templates mode="data-p" select="$east"/>
				<xsl:apply-templates mode="data-p" select="$west"/>
				<xsl:apply-templates mode="data-p" select="$north"/>
				<xsl:apply-templates mode="data-p" select="$south"/>
				<xsl:apply-templates mode="data-p" select="$global"/>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="usage-rights" match="*">
		<xsl:for-each select="fields[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="little-section" select="."/>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="software-specification" match="*">
		<xsl:for-each select="fields[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="little-section" select="."/>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="taxonomic-coverage" match="*">
		<xsl:if test="count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
				<title><xsl:value-of select="@display_name"/></title>
				<xsl:for-each select="fields/node()[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="little-section" select="."/>
				</xsl:for-each>
				<xsl:for-each select="taxa[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="taxa" select="."/>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="taxa" match="*">
		<tp:taxon-treatment>
			<tp:nomenclature>
				<tp:taxon-name>
					<tp:taxon-name-part>
						<xsl:attribute name="taxon-name-part-type"><xsl:value-of select="normalize-space(fields/rank/value)"/></xsl:attribute>
						<xsl:value-of select="normalize-space(fields/specific_name/value)"/>
					</tp:taxon-name-part>
				</tp:taxon-name>
				<tp:nomenclature-citation-list>
					<tp:nomenclature-citation>
						<tp:taxon-name><xsl:value-of select="normalize-space(fields/specific_name/value)"/></tp:taxon-name>
						<comment><xsl:value-of select="normalize-space(fields/common_name/value)"/></comment>
					</tp:nomenclature-citation>
				</tp:nomenclature-citation-list>
			</tp:nomenclature>
		</tp:taxon-treatment>
	</xsl:template>

	<xsl:template mode="software-description-section" match="*">
		<xsl:for-each select="fields[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="little-section" select="."/>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="web-locations-section" match="*">
		<xsl:for-each select="fields[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="little-p" select="."/>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="web-locations-section1" match="*">
		<xsl:variable name="homepage" select="normalize-space(fields/homepage/value)"/>
		<xsl:variable name="wiki" select="normalize-space(fields/wiki/value)"/>
		<xsl:variable name="download_page" select="normalize-space(fields/download_page/value)"/>
		<xsl:variable name="download_mirror" select="normalize-space(fields/download_mirror/value)"/>
		<xsl:variable name="bug_database" select="normalize-space(fields/bug_database/value)"/>
		<xsl:variable name="mailing_list" select="normalize-space(fields/mailing_list/value)"/>
		<xsl:variable name="blog" select="normalize-space(fields/blog/value)"/>
		<xsl:variable name="vendor" select="normalize-space(fields/vendor/value)"/>
		<sec>
			<xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
			<title><xsl:value-of select="@display_name"/></title>
			<xsl:if test="$homepage!=''">
				<p><xsl:value-of select="fields/homepage/@field_name"/><xsl:text>: </xsl:text><uri><xsl:value-of select="$homepage"/></uri></p>
			</xsl:if>
			<xsl:if test="$wiki!=''">
				<p><xsl:value-of select="fields/wiki/@field_name"/><xsl:text>: </xsl:text><uri><xsl:value-of select="$wiki"/></uri></p>
			</xsl:if>
			<xsl:if test="$download_page!=''">
				<p><xsl:value-of select="fields/download_page/@field_name"/><xsl:text>: </xsl:text><uri><xsl:value-of select="$download_page"/></uri></p>
			</xsl:if>
			<xsl:if test="$download_mirror!=''">
				<p><xsl:value-of select="fields/download_mirror/@field_name"/><xsl:text>: </xsl:text><uri><xsl:value-of select="$download_mirror"/></uri></p>
			</xsl:if>
			<xsl:if test="$bug_database!=''">
				<p><xsl:value-of select="fields/bug_database/@field_name"/><xsl:text>: </xsl:text><uri><xsl:value-of select="$bug_database"/></uri></p>
			</xsl:if>
			<xsl:if test="$mailing_list!=''">
				<p><xsl:value-of select="fields/mailing_list/@field_name"/><xsl:text>: </xsl:text><uri><xsl:value-of select="$mailing_list"/></uri></p>
			</xsl:if>
			<xsl:if test="$blog!=''">
				<p><xsl:value-of select="fields/blog/@field_name"/><xsl:text>: </xsl:text><uri><xsl:value-of select="$blog"/></uri></p>
			</xsl:if>
			<xsl:if test="$vendor!=''">
				<p><xsl:value-of select="fields/vendor/@field_name"/><xsl:text>: </xsl:text><uri><xsl:value-of select="$vendor"/></uri></p>
			</xsl:if>
		</sec>
	</xsl:template>

	<!-- Data paper specific -->
	<xsl:template mode="general-description-section" match="*">
		<xsl:for-each select="fields[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="little-section" select="."/>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="sampling-methods-section" match="*">
		<xsl:for-each select="fields[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="little-section" select="."/>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="collection-data-section" match="*">
		<xsl:for-each select="fields[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
				<title><xsl:value-of select="../@display_name"/></title>
				<xsl:for-each select="node()[count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="little-section" select="."/>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template mode="temporal-coverage-wrapper-section" match="*">
		<xsl:if test="count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0">
			<sec>
				<xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
				<title><xsl:value-of select="@display_name"/></title>
				<xsl:for-each select="node()[@object_id='124'][count(.//value//*[normalize-space(text())!='']) + count(.//value//*[name()!='p' and name()!='ul' and name()!='ol'])!=0]">
					<xsl:apply-templates mode="temporal-coverage-section" select="."/>
				</xsl:for-each>
				<xsl:apply-templates mode="subsection" select="."/>
			</sec>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="temporal-coverage-section" match="*">
		<xsl:variable name="type" select="fields/node()[@id='335']"/>
		<xsl:variable name="start" select="fields/node()[@id='392']"/>
		<xsl:variable name="living" select="fields/node()[@id='393']"/>
		<xsl:variable name="formation" select="fields/node()[@id='394']"/>
		<xsl:variable name="data_s" select="fields/node()[@id='395']"/>
		<xsl:variable name="data_e" select="fields/node()[@id='396']"/>
		<sec>
			<xsl:attribute name="sec-type"><xsl:value-of select="../@display_name"/></xsl:attribute>
			<title><xsl:value-of select="../@display_name"/></title>
			<xsl:apply-templates mode="data-p" select="$type"/>
			<xsl:apply-templates mode="data-p" select="$start"/>
			<xsl:apply-templates mode="data-p" select="$living"/>
			<xsl:apply-templates mode="data-p" select="$formation"/>
			<xsl:apply-templates mode="data-p" select="$data_s"/>
			<xsl:apply-templates mode="data-p" select="$data_e"/>
		</sec>
	</xsl:template>
</xsl:stylesheet>
