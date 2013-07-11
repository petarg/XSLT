<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
	<xsl:import href="section.xslt" />
	
	<xsl:template name="reference">
		<xsl:for-each select="/document/objects/references/reference">
			<ref>
				<xsl:attribute name="id">B<xsl:number/></xsl:attribute>
				<xsl:apply-templates mode="ref-book-biblio" select="biblio_reference_wrapper/book_biblio_reference"/>
				<xsl:apply-templates mode="ref-book-chapter-biblio" select="biblio_reference_wrapper/book_chapter_biblio_reference"/>
				<xsl:apply-templates mode="ref-conference-paper" select="biblio_reference_wrapper/conference_paper"/>
				<xsl:apply-templates mode="ref-conference-proceedings-biblio" select="biblio_reference_wrapper/conference_proceedings_biblio_reference"/>
				<xsl:apply-templates mode="ref-journal-article-biblio" select="biblio_reference_wrapper/journal_article_biblio_reference"/>
				<xsl:apply-templates mode="ref-software-biblio" select="biblio_reference_wrapper/software_biblio_reference"/>
				<xsl:apply-templates mode="ref-thesis-biblio" select="biblio_reference_wrapper/thesis_biblio_reference"/>
				<xsl:apply-templates mode="ref-website-biblio" select="biblio_reference_wrapper/website_biblio_reference"/>
			</ref>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-book-biblio" match="*">
		<mixed-citation>
			<xsl:attribute name="publication-type">book</xsl:attribute>
			<xsl:apply-templates mode="ref-author-name" select="authors"/>
			<xsl:apply-templates mode="ref-year" select="."/>
			<xsl:apply-templates mode="ref-book-title" select="."/>
			<xsl:apply-templates mode="ref-translated-title" select="."/>
			<xsl:apply-templates mode="ref-edition" select="."/>
			<xsl:apply-templates mode="ref-volume" select="."/>
			<xsl:apply-templates mode="ref-publisher-name" select="."/>
			<xsl:apply-templates mode="ref-publisher-loc" select="."/>
			<xsl:apply-templates mode="ref-number-of-pages" select="."/>
			<xsl:apply-templates mode="ref-lang" select="."/>
			<xsl:apply-templates mode="ref-uri" select="."/>
			<xsl:apply-templates mode="ref-isbn" select="."/>
			<xsl:apply-templates mode="ref-doi" select="."/>
		</mixed-citation>
	</xsl:template>

	<xsl:template mode="ref-book-chapter-biblio" match="*">
		<mixed-citation>
			<xsl:attribute name="publication-type">chapter</xsl:attribute>
			<xsl:apply-templates mode="ref-author-name" select="authors_reference"/>
			<xsl:apply-templates mode="ref-year" select="."/>
			<chapter-title><xsl:apply-templates mode="format" select="fields/chapter_title/value"/></chapter-title>
			<xsl:text> In: </xsl:text>
			<xsl:apply-templates mode="ref-editor-name" select="series_editors"/>
			<xsl:text>. </xsl:text>
			<xsl:apply-templates mode="ref-book-title" select="."/>
			<xsl:apply-templates mode="ref-edition" select="."/>
			<xsl:apply-templates mode="ref-volume" select="."/>
			<xsl:apply-templates mode="ref-publisher-name" select="."/>
			<xsl:apply-templates mode="ref-publisher-loc" select="."/>
			<xsl:apply-templates mode="ref-number-of-pages" select="."/>
			<xsl:apply-templates mode="ref-lang" select="."/>
			<xsl:apply-templates mode="ref-uri" select="."/>
			<xsl:apply-templates mode="ref-isbn" select="."/>
			<xsl:apply-templates mode="ref-doi" select="."/>
		</mixed-citation>
	</xsl:template>

	<xsl:template mode="ref-journal-article-biblio" match="*">
		<mixed-citation>
			<xsl:attribute name="publication-type">article</xsl:attribute>
			<xsl:apply-templates mode="ref-author-name" select="authors_reference"/>
			<xsl:apply-templates mode="ref-year" select="."/>
			<xsl:apply-templates mode="ref-article-title" select="."/>
			<xsl:if test="normalize-space(fields/journal/value)!=''">
				<source><xsl:apply-templates mode="format" select="fields/journal/value"/></source>
			</xsl:if>
			<xsl:apply-templates mode="ref-volume" select="."/>
			<xsl:if test="normalize-space(fields/issue/value)!= ''">
				<xsl:text> (</xsl:text>
				<issue><xsl:value-of select="fields/issue/value"/></issue>
				<xsl:text>)</xsl:text>
				<xsl:if test="normalize-space(fields/first_page/value)!=''">
					<xsl:text>: </xsl:text>
				</xsl:if>
			</xsl:if>
			<xsl:if test="normalize-space(fields/first_page/value)!=''">
				<fpage><xsl:value-of select="fields/first_page/value"/></fpage>
			</xsl:if>
			<xsl:if test="normalize-space(fields/last_page/value)!=''">
				<xsl:if test="normalize-space(fields/first_page/value)!=''">
					<xsl:text>-</xsl:text>
				</xsl:if>
				<lpage><xsl:value-of select="fields/last_page/value"/></lpage>
			</xsl:if>
			<xsl:apply-templates mode="ref-lang" select="."/>
			<xsl:apply-templates mode="ref-uri" select="."/>
			<xsl:apply-templates mode="ref-doi" select="."/>
		</mixed-citation>
	</xsl:template>

	<xsl:template mode="ref-conference-paper" match="*">
		<mixed-citation>
			<xsl:attribute name="publication-type">conference-paper</xsl:attribute>
			<xsl:apply-templates mode="ref-author-name" select="authors_reference"/>
			<xsl:apply-templates mode="ref-year" select="."/>
			<xsl:apply-templates mode="ref-editor-name" select="series_editors"/>
			<xsl:apply-templates mode="ref-book-title" select="."/>
			<xsl:apply-templates mode="ref-volume" select="."/>
			<xsl:apply-templates mode="ref-conference" select="."/>
			<xsl:apply-templates mode="ref-number-of-pages" select="."/>
			<xsl:apply-templates mode="ref-lang" select="."/>
			<xsl:apply-templates mode="ref-uri" select="."/>
			<xsl:apply-templates mode="ref-isbn" select="."/>
			<xsl:apply-templates mode="ref-doi" select="."/>
		</mixed-citation>
	</xsl:template>

	<xsl:template mode="ref-conference-proceedings-biblio" match="*">
		<mixed-citation>
			<xsl:attribute name="publication-type">conference-preoceeding</xsl:attribute>
			<xsl:apply-templates mode="ref-author-name" select="authors"/>
			<xsl:apply-templates mode="ref-year" select="."/>
			<xsl:apply-templates mode="ref-book-title" select="."/>
			<xsl:apply-templates mode="ref-volume" select="."/>
			<xsl:apply-templates mode="ref-conference" select="."/>
			<xsl:apply-templates mode="ref-number-of-pages" select="."/>
			<xsl:apply-templates mode="ref-lang" select="."/>
			<xsl:apply-templates mode="ref-uri" select="."/>
			<xsl:apply-templates mode="ref-isbn" select="."/>
			<xsl:apply-templates mode="ref-doi" select="."/>
		</mixed-citation>
	</xsl:template>

	<xsl:template mode="ref-thesis-biblio" match="*">
		<mixed-citation>
			<xsl:attribute name="publication-type">thesis</xsl:attribute>
			<xsl:apply-templates mode="ref-author-name" select="authors_reference_biblio"/>
			<xsl:apply-templates mode="ref-year" select="."/>
			<xsl:apply-templates mode="ref-book-title" select="."/>
			<xsl:apply-templates mode="ref-translated-title" select="."/>
			<xsl:apply-templates mode="ref-publisher-name" select="."/>
			<xsl:apply-templates mode="ref-publisher-loc" select="."/>
			<xsl:apply-templates mode="ref-number-of-pages" select="."/>
			<xsl:apply-templates mode="ref-lang" select="."/>
			<xsl:apply-templates mode="ref-uri" select="."/>
			<xsl:apply-templates mode="ref-isbn" select="."/>
			<xsl:apply-templates mode="ref-doi" select="."/>
		</mixed-citation>
	</xsl:template>

	<xsl:template mode="ref-software-biblio" match="*">
		<mixed-citation>
			<xsl:attribute name="publication-type">software</xsl:attribute>
			<xsl:apply-templates mode="ref-author-name" select="authors_reference"/>
			<xsl:apply-templates mode="ref-year" select="."/>
			<xsl:apply-templates mode="ref-title" select="."/>
			<xsl:apply-templates mode="ref-publisher-name" select="."/>
			<xsl:if test="normalize-space(fields/release_date/value)!=''">
				<date-in-citation>
					<xsl:attribute name="content-type">released</xsl:attribute>
					<xsl:text> Released: </xsl:text>
					<xsl:value-of select="fields/release_date/value"/>
					<xsl:text> </xsl:text>
				</date-in-citation>
			</xsl:if>
			<xsl:apply-templates mode="ref-uri" select="."/>
			<xsl:if test="normalize-space(fields/version/value)!=''">
				<comment>
					<xsl:value-of select="fields/version/@field_name"/><xsl:text>: </xsl:text>
					<xsl:value-of select="fields/version/value"/>
				</comment>
			</xsl:if>
		</mixed-citation>
	</xsl:template>

	<xsl:template mode="ref-website-biblio" match="*">
		<mixed-citation>
			<xsl:attribute name="publication-type">website</xsl:attribute>
			<xsl:apply-templates mode="ref-title" select="."/>
			<xsl:apply-templates mode="ref-uri" select="."/>
			<xsl:if test="normalize-space(fields/access_date/value)!=''">
				<date-in-citation>
					<xsl:attribute name="content-type">access-date</xsl:attribute>
					<xsl:text> [accessed: </xsl:text>
					<xsl:value-of select="fields/access_date/value"/>
					<xsl:text>] </xsl:text>
				</date-in-citation>
			</xsl:if>
		</mixed-citation>
	</xsl:template>

	<xsl:template mode="ref-author-name" match="*">
		<person-group person-group-type="author">
			<xsl:for-each select="reference_author">
				<name>
					<xsl:attribute name="name-style">western</xsl:attribute>
					<surname><xsl:value-of select="fields/last_name/value"/></surname>
					<given-names>
						<xsl:value-of select="fields/first_name/value"/>
						<xsl:if test="normalize-space(fields/middle_name/value)!=''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="fields/middle_name"/>
						</xsl:if>
					</given-names>
				</name>
			</xsl:for-each>
		</person-group>
	</xsl:template>

	<xsl:template mode="ref-editor-name" match="*">
		<xsl:if test="normalize-space(.)!=''">
			<person-group person-group-type="editor">
				<xsl:for-each select="reference_editor">
					<name>
						<xsl:attribute name="name-style">western</xsl:attribute>
						<surname><xsl:value-of select="fields/last_name/value"/></surname>
						<given-names>
							<xsl:value-of select="fields/first_name/value"/>
							<xsl:if test="normalize-space(fields/middle_name/value)!=''">
								<xsl:text> </xsl:text>
								<xsl:value-of select="fields/middle_name" />
							</xsl:if>
						</given-names>
					</name>
				</xsl:for-each>
			</person-group>
			<xsl:choose>
				<xsl:when test="count(reference_editor) = 1">
					<xsl:text> (</xsl:text>
					<role>Ed</role>
					<xsl:text>). </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> (</xsl:text>
					<role>Eds</role>
					<xsl:text>). </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template mode="ref-year" match="*">
		<xsl:for-each select="fields/year_of_publication[normalize-space(value)!='']">
			<xsl:text> (</xsl:text>
			<year><xsl:value-of select="value"/></year>
			<xsl:text>) </xsl:text>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-book-title" match="*">
		<xsl:for-each select="fields/book_title[normalize-space(value)!='']">
			<article-title><xsl:apply-templates mode="format" select="value"/></article-title>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-article-title" match="*">
		<xsl:for-each select="fields/article_title[normalize-space(value)!='']">
			<article-title><xsl:apply-templates mode="format" select="value"/></article-title>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-title" match="*">
		<xsl:for-each select="fields/title[normalize-space(value)!='']">
			<article-title><xsl:apply-templates mode="format" select="value"/></article-title>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-translated-title" match="*">
		<xsl:for-each select="fields/translated_title[normalize-space(value)!='']">
			<xsl:text> [</xsl:text>
			<trans-title><xsl:apply-templates mode="format" select="value"/></trans-title>
			<xsl:text>] </xsl:text>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-edition" match="*">
		<xsl:for-each select="fields/edition[normalize-space(value)!='']">
			<edition><xsl:value-of select="value"/></edition>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-volume" match="*">
		<xsl:for-each select="fields/volume[normalize-space(value)!='']">
			<volume><xsl:value-of select="value"/></volume>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-number-of-pages" match="*">
		<xsl:for-each select="fields/number_of_pages[normalize-space(value)!='']">
			<size units="page"><xsl:value-of select="value"/> pp.</size>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-publisher-name" match="*">
		<xsl:for-each select="fields/publisher[normalize-space(value)!='']">
			<publisher-name><xsl:apply-templates mode="format" select="value/node()"/></publisher-name>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-publisher-loc" match="*">
		<xsl:for-each select="fields/city[normalize-space(value)!='']">
			<publisher-loc><xsl:value-of select="value"/></publisher-loc>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-uri" match="*">
		<xsl:for-each select="fields/url[normalize-space(value)!='']">
			<uri><xsl:value-of select="value"/></uri>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-isbn" match="*">
		<xsl:for-each select="fields/isbn[normalize-space(value)!='']">
			<xsl:text> ISBN: </xsl:text>
			<isbn><xsl:value-of select="value"/></isbn>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-doi" match="*">
		<xsl:for-each select="fields/doi[normalize-space(value)!='']">
			<xsl:text> doi: </xsl:text>
			<pub-id>
				<xsl:attribute name="pub-id-type">doi</xsl:attribute>
				<xsl:value-of select="value"/>
			</pub-id>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-conference" match="*">
		<xsl:for-each select="fields/conference_name[normalize-space(value)!='']">
			<conf-name><xsl:apply-templates mode="format" select="value"/></conf-name>
		</xsl:for-each>
		<xsl:for-each select="fields/conference_location[normalize-space(value)!='']">
			<conf-loc><xsl:value-of select="value"/></conf-loc>
		</xsl:for-each>
		<xsl:for-each select="fields/conference_date[normalize-space(value)!='']">
			<conf-date><xsl:apply-templates mode="format" select="value"/></conf-date>
		</xsl:for-each>
	</xsl:template>

	<xsl:template mode="ref-lang" match="*">
		<xsl:for-each select="fields/publication_language[normalize-space(value)!='']">
			<comment>
				<xsl:text>[In </xsl:text>
				<xsl:value-of select="value"/>
				<xsl:text>]</xsl:text>
			</comment>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
