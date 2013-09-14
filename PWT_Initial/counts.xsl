<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<out>
			<treatments>
				<xsl:value-of select="count(//treatment)"/>
			</treatments>
			<ref>
				<xsl:value-of select="count(//reference)"/>
			</ref>
		</out>
	</xsl:template>
</xsl:stylesheet>