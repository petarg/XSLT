<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:param name="sfiles" select="//node()[@object_id='56']"/>

	<xsl:template name="supplement">
		<app-group>
			<title><xsl:value-of select="$sfiles/@display_name"/></title>
			<xsl:for-each select="$sfiles/node()[@object_id='55']"><!-- supplementary_file -->
				<xsl:variable name="file"><xsl:value-of select="normalize-space(fields/node()[@id='222']/value)"/><xsl:text>.txt</xsl:text></xsl:variable>
				<xsl:variable name="type" select="fields/node()[@id='216']/value"/>
				<xsl:variable name="ext" select="substring-after($file, '.')"/>
				<app>
					<title><xsl:apply-templates mode="title" select="fields/node()[@id='214']/value"/></title>
					<supplementary-material>
						<xsl:attribute name="id"><xsl:text>S</xsl:text><xsl:value-of select="position()"/></xsl:attribute>
						<xsl:attribute name="orientation">portrait</xsl:attribute>
						<xsl:attribute name="position">float</xsl:attribute>
						<xsl:attribute name="xlink:type">simple</xsl:attribute>
						<xsl:variable name="caption" select="fields/node()[@id='217']/value/p[1]"/>
						<xsl:if test="normalize-space($caption)!='' or count($caption/*[name()!=''])!=0">
							<caption><p><xsl:apply-templates mode="format" select="$caption"/></p></caption>
						</xsl:if>
						<media>
							<xsl:attribute name="xlink:href"><xsl:value-of select="$file"/></xsl:attribute>
							<xsl:attribute name="mimetype">
								<xsl:call-template name="mime-type">
									<xsl:with-param name="ext"><xsl:value-of select="$ext"/></xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:attribute name="mime-subtype"><xsl:value-of select="$ext"/></xsl:attribute>
							<xsl:attribute name="position">float</xsl:attribute>
							<xsl:attribute name="orientation">portrait</xsl:attribute>
							<xsl:attribute name="xlink:type">simple</xsl:attribute>
						</media>
						<p>
							<bold><xsl:value-of select="fields/node()[@id='215']/@field_name"/><xsl:text>:</xsl:text></bold>
							<xsl:text> </xsl:text>
							<xsl:value-of select="fields/node()[@id='215']/value"/>
						</p>
						<p>
							<bold><xsl:value-of select="fields/node()[@id='216']/@field_name"/><xsl:text>:</xsl:text></bold>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$type"/>
						</p>
						<p><bold>Description:</bold></p>
						<xsl:apply-templates mode="p" select="fields/node()[@id='217']/value"/>
						<p><bold><xsl:text>File name:</xsl:text></bold><xsl:text> </xsl:text><xsl:value-of select="$file"/></p>
					</supplementary-material>
				</app>
			</xsl:for-each>
		</app-group>
	</xsl:template>
	
	<xsl:template name="mime-type">
		<xsl:param name="ext" select="''"/>
		<xsl:choose>
			<xsl:when test="($ext='xls') or ($ext='xlsx')">
				<xsl:text>Microsoft Excel Document</xsl:text>
			</xsl:when>
			<xsl:when test="($ext='doc') or ($ext='docx')">
				<xsl:text>Microsoft Word Document</xsl:text>
			</xsl:when>
			<xsl:when test="$ext='pdf'">
				<xsl:text>Adobe PDF File</xsl:text>
			</xsl:when>
			<xsl:when test="($ext='zip') or ($ext='rar') or ($ext='tar') or ($ext='bz2') or ($ext='gz') or ($ext='tgz')">
				<xsl:text>Archive file</xsl:text>
			</xsl:when>
			<xsl:when test="$ext='csv'">
				<xsl:text>Comma Separated Values File</xsl:text>
			</xsl:when>
			<xsl:when test="$ext='lk4'">
				<xsl:text>Lucid Key Data File</xsl:text>
			</xsl:when>
			<xsl:when test="$ext='tif' or $ext='tiff'">
				<xsl:text>Tagged Image File</xsl:text>
			</xsl:when>
			<xsl:when test="$ext=''">
				<xsl:text>Unknown File Type</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$ext"/><xsl:text> file</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
