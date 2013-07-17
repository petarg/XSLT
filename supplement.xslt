<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />
	
	<xsl:template name="supplement">
		<xsl:variable name="sfiles" select="/document/objects/supplementary_files"/>
		<app-group>
			<title><xsl:value-of select="$sfiles/@display_name"/></title>
			<xsl:for-each select="$sfiles/supplementary_file">
				<xsl:variable name="file" select="normalize-space(fields/file/value)"/>
				<xsl:variable name="type" select="fields/type/value"/>
				<xsl:variable name="ext" select="substring-after($file, '.')"/>
				<app>
					<title><xsl:apply-templates mode="title" select="fields/title/value"/></title>
					<supplementary-material>
						<xsl:attribute name="id"><xsl:text>S</xsl:text><xsl:value-of select="position()"/></xsl:attribute>
						<xsl:attribute name="orientation">portrait</xsl:attribute>
						<xsl:attribute name="position">float</xsl:attribute>
						<xsl:attribute name="xlink:type">simple</xsl:attribute>
						<xsl:variable name="caption" select="fields/brief_description/value/p[1]"/>
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
							<bold><xsl:value-of select="fields/authors/@field_name"/><xsl:text>: </xsl:text></bold>
							<xsl:value-of select="fields/authors/value"/>
						</p>
						<p>
							<bold><xsl:text>Data type: </xsl:text></bold>
							<xsl:value-of select="$type"/>
						</p>
						<p><bold>Description:</bold></p>
						<xsl:apply-templates mode="p" select="fields/brief_description/value"/>
						<p><bold><xsl:text>File name: </xsl:text></bold><xsl:value-of select="$file"/></p>
					</supplementary-material>
				</app>
			</xsl:for-each>
		</app-group>
	</xsl:template>
	
	<xsl:template name="mime-type">
		<xsl:param name="ext"/>
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
				<xsl:text>Comma Separated Values</xsl:text>
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
