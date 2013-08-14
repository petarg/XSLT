<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs"
	xmlns:mml="http://www.w3.org/1998/Math/MathML"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:tp="http://www.plazi.org/taxpub">

	<xsl:template name="raise-error">
		<xsl:param name="content"/>
		<ERROR><xsl:value-of select="$content"/></ERROR>
	</xsl:template>

	<xsl:template mode="p" match="*">
		<xsl:choose>
			<xsl:when test="normalize-space(.)='' and count(.//node()[@citation_id!=''])=0"></xsl:when>
			<xsl:when test="count(node()[(name()='p') or (name()='ul') or (name()='ol')])!=0">
				<xsl:for-each select="node()[(normalize-space(.)!='') or (count(.//node()[@citation_id!=''])!=0) or (name()!='')]">
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
						<xsl:when test="name()='br'"></xsl:when>
						<xsl:otherwise>
							<INVALID-TAG><xsl:copy-of select="."/></INVALID-TAG>
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

	<xsl:template mode="format" match="*">
		<xsl:for-each select="node()">
			<xsl:choose>
				<xsl:when test="name()=''">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:when test="name()='italic' or name()='bold' or name()='underline' or name()='sup' or name()='sub'">
					<xsl:element name="{name()}">
						<xsl:apply-templates mode="format" select="."/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="name()='ext-link' or name()='tp:taxon-name'">
					<xsl:copy-of select="."/>
				</xsl:when>
				<xsl:when test="name()='br'">
					<xsl:text>&lt;br/&gt;</xsl:text>
				</xsl:when>
				<xsl:when test="name()='fig-citation'">
					<xsl:apply-templates mode="fig-citation" select="."/>
				</xsl:when>
				<xsl:when test="name()='tbls-citation'">
					<xsl:apply-templates mode="tbls-citation" select="."/>
				</xsl:when>
				<xsl:when test="name()='sup-files-citation'">
					<xsl:apply-templates mode="sup-files-citation" select="."/>
				</xsl:when>
				<xsl:when test="name()='reference-citation'">
					<xsl:apply-templates mode="reference-citation" select="."/>
				</xsl:when>
				<xsl:otherwise>
					<INVALID-TAG><xsl:copy-of select="."/></INVALID-TAG>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	


	<xsl:template name="resolve-reference">
		<xsl:param name="text" select="''"/>
		<xsl:param name="number" select="1"/>
		<xsl:param name="max_number" select="1"/>
		<xsl:if test="$text!=''">
			<xsl:variable name="this_text" select="normalize-space(substring-before($text,','))"/>
			<xsl:variable name="next_text" select="normalize-space(substring-after($text,','))"/>
			<xsl:variable name="id">
				<xsl:call-template name="get-reference-id">
					<xsl:with-param name="rid" select="xref[$number]/@rid"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="authors">
				<xsl:choose>
					<xsl:when test="$this_text!=''">
						<xsl:value-of select="$this_text"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="normalize-space($text)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xref>
				<xsl:attribute name="ref-type"><xsl:value-of select="'bibr'"/></xsl:attribute>
				<xsl:attribute name="rid"><xsl:text>B</xsl:text><xsl:value-of select="$id"/></xsl:attribute>
				<xsl:value-of select="$authors"/>
			</xref>
			<xsl:if test="$next_text!=''">
				<xsl:text>, </xsl:text>
			</xsl:if>
			<xsl:call-template name="resolve-reference">
				<xsl:with-param name="text" select="$next_text"/>
				<xsl:with-param name="number" select="$number+1"/>
				<xsl:with-param name="max_number" select="$max_number"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="get-reference-id">
		<xsl:param name="rid" select="''"/>
		<xsl:for-each select="//node()[@object_id='95']">
			<xsl:if test="@instance_id=$rid">
				<xsl:value-of select="position()"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="resolve-figures">
		<xsl:param name="text" select="''"/>
		<xsl:param name="number" select="1"/>
		<xsl:param name="max_number" select="1"/>
		<xsl:if test="$text!=''">
			<xsl:variable name="this_text" select="normalize-space(substring-before($text,','))"/>
			<xsl:variable name="next_text" select="normalize-space(substring-after($text,','))"/>
			<xsl:variable name="id">
				<xsl:call-template name="get-figure-id">
					<xsl:with-param name="rid" select="xref[$number]/@rid"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="fig">
				<xsl:choose>
					<xsl:when test="$this_text!=''">
						<xsl:value-of select="$this_text"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="normalize-space($text)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xref>
				<xsl:attribute name="ref-type"><xsl:value-of select="'fig'"/></xsl:attribute>
				<xsl:attribute name="rid"><xsl:text>F</xsl:text><xsl:value-of select="$id"/></xsl:attribute>
				<xsl:value-of select="$fig"/>
			</xref>
			<xsl:if test="$next_text!=''">
				<xsl:text>, </xsl:text>
			</xsl:if>
			<xsl:call-template name="resolve-figures">
				<xsl:with-param name="text" select="$next_text"/>
				<xsl:with-param name="number" select="$number+1"/>
				<xsl:with-param name="max_number" select="$max_number"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="get-figure-id">
		<xsl:param name="rid" select="''"/>
		<xsl:for-each select="//node()[@object_id='221']">
			<xsl:if test="@instance_id=$rid">
				<xsl:value-of select="position()"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>






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
				<xsl:when test="name()='italic' or name()='underline' or name()='sup' or name()='sub'">
					<xsl:element name="{name()}">
						<xsl:apply-templates mode="format-title" select="."/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="name()='bold'">
					<xsl:apply-templates mode="format-title" select="."/>
				</xsl:when>
				<xsl:when test="name()='ext-link' or name()='tp:taxon-name'">
					<xsl:copy-of select="."/>
				</xsl:when>
				<xsl:when test="name()='br'">
					<break/>
				</xsl:when>
				<xsl:when test="name()='fig-citation'">
					<xsl:apply-templates mode="fig-citation" select="."/>
				</xsl:when>
				<xsl:when test="name()='tbls-citation'">
					<xsl:apply-templates mode="tbls-citation" select="."/>
				</xsl:when>
				<xsl:when test="name()='sup-files-citation'">
					<xsl:apply-templates mode="sup-files-citation" select="."/>
				</xsl:when>
				<xsl:when test="name()='reference-citation'">
					<xsl:apply-templates mode="reference-citation" select="."/>
				</xsl:when>
				<xsl:otherwise>
					<INVALID-TAG><xsl:copy-of select="."/></INVALID-TAG>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>







	<xsl:template mode="td-format" match="*">
		<xsl:for-each select="node()[normalize-space(.)!='' or count(.//*[name()!=''])!=0]">
			<xsl:choose>
				<xsl:when test="name()='p'">
					<xsl:apply-templates mode="td-format" select="."/>
					<xsl:if test="position()!=last()">
						<break/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="name()=''">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:when test="name()='italic' or name()='bold' or name()='underline' or name()='sup' or name()='sub'">
					<xsl:element name="{name()}">
						<xsl:apply-templates mode="td-format" select="."/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="name()='ext-link' or name()='tp:taxon-name'">
					<xsl:copy-of select="."/>
				</xsl:when>
				<xsl:when test="name()='br'">
					<break/>
				</xsl:when>
				<xsl:when test="name()='fig-citation'">
					<xsl:apply-templates mode="fig-citation" select="."/>
				</xsl:when>
				<xsl:when test="name()='tbls-citation'">
					<xsl:apply-templates mode="tbls-citation" select="."/>
				</xsl:when>
				<xsl:when test="name()='sup-files-citation'">
					<xsl:apply-templates mode="sup-files-citation" select="."/>
				</xsl:when>
				<xsl:when test="name()='reference-citation'">
					<xsl:apply-templates mode="reference-citation" select="."/>
				</xsl:when>
				<xsl:otherwise>
					<INVALID-TAG><xsl:copy-of select="."/></INVALID-TAG>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	<xsl:template mode="reference-citation" match="*">
		<xsl:variable name="text" select="normalize-space(.)"/>
		<xsl:choose>
			<xsl:when test="$text=''">
				<xref>
					<xsl:attribute name="ref-type"><xsl:value-of select="'bibr'"/></xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>B1</xsl:text></xsl:attribute>
					<xsl:text>EMPTY BIBLIOGRAPHIC REFERENCE</xsl:text>
				</xref>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="resolve-reference">
					<xsl:with-param name="text" select="$text"/>
					<xsl:with-param name="number" select="1"/>
					<xsl:with-param name="max_number" select="count(xref)"/>
				</xsl:call-template>
				</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template mode="sup-files-citation" match="*">
		<xref>
			<xsl:attribute name="ref-type">supplementary-material</xsl:attribute>
			<xsl:attribute name="rid"><xsl:text>S1</xsl:text></xsl:attribute>
			<xsl:apply-templates mode="format" select="."/>
		</xref>
	</xsl:template>
	
	<xsl:template mode="tbls-citation" match="*">
		<xref>
			<xsl:attribute name="ref-type">table</xsl:attribute>
			<xsl:attribute name="rid"><xsl:text>T1</xsl:text></xsl:attribute>
			<xsl:apply-templates mode="format" select="."/>
		</xref>
	</xsl:template>
	
	<xsl:template mode="fig-citation" match="*">
		<xsl:variable name="text" select="normalize-space(.)"/>
		<xsl:choose>
			<xsl:when test="$text=''">
				<xref>
					<xsl:attribute name="ref-type"><xsl:value-of select="'fig'"/></xsl:attribute>
					<xsl:attribute name="rid"><xsl:text>F1</xsl:text></xsl:attribute>
					<xsl:text>EMPTY FIGURE REFERENCE</xsl:text>
				</xref>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="resolve-figures">
					<xsl:with-param name="text" select="$text"/>
					<xsl:with-param name="number" select="1"/>
					<xsl:with-param name="max_number" select="count(xref)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
