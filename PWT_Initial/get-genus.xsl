<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />
	<xsl:template match="/document">
		<out>
			<xsl:for-each select="//tn-part[@type='genus'][contains(text(),'.')]">
				<genus>
					<xsl:attribute name="full-name">
						<xsl:value-of select="@full-name"/>
					</xsl:attribute>
					<xsl:value-of select="normalize-space(.)"/>
				</genus>
			</xsl:for-each>
		</out>
	</xsl:template>
</xsl:stylesheet>