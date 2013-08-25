<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tp="http://www.plazi.org/taxpub">
  <xsl:template name="reference">
    <xsl:for-each select="/document/objects/references/reference">
      <ref>
        <xsl:attribute name="id"><xsl:text>B</xsl:text><xsl:value-of select="@instance_id"/></xsl:attribute>
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
    <element-citation>
      <xsl:attribute name="publication-type">book</xsl:attribute>
      <xsl:apply-templates mode="ref-author-name" select="node()[@object_id='92']"/>
      <xsl:call-template name="ref-year"/>
      <xsl:call-template name="ref-book-title"/>
      <xsl:call-template name="ref-translated-title"/>
      <xsl:call-template name="ref-edition"/>
      <xsl:call-template name="ref-volume"/>
      <xsl:call-template name="ref-publisher-name"/>
      <xsl:call-template name="ref-publisher-loc"/>
      <xsl:call-template name="ref-number-of-pages"/>
      <xsl:call-template name="ref-lang"/>
      <xsl:call-template name="ref-uri"/>
      <xsl:call-template name="ref-isbn"/>
      <xsl:call-template name="ref-doi"/>
    </element-citation>
  </xsl:template>

  <xsl:template mode="ref-book-chapter-biblio" match="*">
    <element-citation>
      <xsl:attribute name="publication-type">chapter</xsl:attribute>
      <xsl:apply-templates mode="ref-author-name" select="node()[@object_id='100']"/>
      <xsl:call-template name="ref-year"/>
      <xsl:call-template name="ref-chapter-title"/>
      <xsl:apply-templates mode="ref-editor-name" select="node()[@object_id='93']"/>
      <xsl:call-template name="ref-book-title"/>
      <xsl:call-template name="ref-edition"/>
      <xsl:call-template name="ref-volume"/>
      <xsl:call-template name="ref-publisher-name"/>
      <xsl:call-template name="ref-publisher-loc"/>
      <xsl:call-template name="ref-number-of-pages"/>
      <xsl:call-template name="ref-lang"/>
      <xsl:call-template name="ref-uri"/>
      <xsl:call-template name="ref-isbn"/>
      <xsl:call-template name="ref-doi"/>
    </element-citation>
  </xsl:template>

  <xsl:template mode="ref-journal-article-biblio" match="*">
    <element-citation>
      <xsl:attribute name="publication-type">article</xsl:attribute>
      <xsl:apply-templates mode="ref-author-name" select="node()[@object_id='100']"/>
      <xsl:call-template name="ref-year"/>
      <xsl:call-template name="ref-article-title"/>
      <xsl:call-template name="ref-journal-name"/>
      <xsl:call-template name="ref-volume"/>
      <xsl:call-template name="ref-issue"/>
      <xsl:call-template name="ref-fpage"/>
      <xsl:call-template name="ref-lpage"/>
      <xsl:call-template name="ref-lang"/>
      <xsl:call-template name="ref-uri"/>
      <xsl:call-template name="ref-doi"/>
    </element-citation>
  </xsl:template>

  <xsl:template mode="ref-conference-paper" match="*">
    <element-citation>
      <xsl:attribute name="publication-type">conference-paper</xsl:attribute>
      <xsl:apply-templates mode="ref-author-name" select="node()[@object_id='100']"/>
      <xsl:call-template name="ref-year"/>
      <xsl:apply-templates mode="ref-editor-name" select="node()[@object_id='93']"/>
      <xsl:call-template name="ref-conf-paper-title"/>
      <xsl:call-template name="ref-volume"/>
      <xsl:call-template name="ref-conference"/>
      <xsl:call-template name="ref-conf-optional"/>
      <xsl:call-template name="ref-number-of-pages"/>
      <xsl:call-template name="ref-lang"/>
      <xsl:call-template name="ref-uri"/>
      <xsl:call-template name="ref-isbn"/>
      <xsl:call-template name="ref-doi"/>
    </element-citation>
  </xsl:template>

  <xsl:template mode="ref-conference-proceedings-biblio" match="*">
    <element-citation>
      <xsl:attribute name="publication-type">conference-preoceeding</xsl:attribute>
      <xsl:apply-templates mode="ref-author-name" select="node()[@object_id='92']"/>
      <xsl:call-template name="ref-year"/>
      <xsl:call-template name="ref-book-title"/>
      <xsl:call-template name="ref-volume"/>
      <xsl:call-template name="ref-conference"/>
      <xsl:call-template name="ref-conf-optional"/>
      <xsl:call-template name="ref-number-of-pages"/>
      <xsl:call-template name="ref-lang"/>
      <xsl:call-template name="ref-uri"/>
      <xsl:call-template name="ref-isbn"/>
      <xsl:call-template name="ref-doi"/>
    </element-citation>
  </xsl:template>

  <xsl:template mode="ref-thesis-biblio" match="*">
    <element-citation>
      <xsl:attribute name="publication-type">thesis</xsl:attribute>
      <xsl:apply-templates mode="ref-author-name" select="node()[@object_id='101']"/>
      <xsl:call-template name="ref-year"/>
      <xsl:call-template name="ref-book-title"/>
      <xsl:call-template name="ref-translated-title"/>
      <xsl:call-template name="ref-publisher-name"/>
      <xsl:call-template name="ref-publisher-loc"/>
      <xsl:call-template name="ref-number-of-pages"/>
      <xsl:call-template name="ref-lang"/>
      <xsl:call-template name="ref-uri"/>
      <xsl:call-template name="ref-isbn"/>
      <xsl:call-template name="ref-doi"/>
    </element-citation>
  </xsl:template>

  <xsl:template mode="ref-software-biblio" match="*">
    <element-citation>
      <xsl:attribute name="publication-type">software</xsl:attribute>
      <xsl:apply-templates mode="ref-author-name" select="node()[@object_id='100']"/>
      <xsl:call-template name="ref-year"/>
      <xsl:call-template name="ref-title"/>
      <xsl:call-template name="ref-publisher-name"/>
      <xsl:call-template name="ref-release-date"/>
      <xsl:call-template name="ref-uri"/>
      <xsl:call-template name="ref-version"/>
    </element-citation>
  </xsl:template>

  <xsl:template mode="ref-website-biblio" match="*">
    <element-citation>
      <xsl:attribute name="publication-type">website</xsl:attribute>
      <xsl:call-template name="ref-title"/>
      <xsl:call-template name="ref-uri"/>
      <xsl:call-template name="ref-access-date"/>
    </element-citation>
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
              <xsl:value-of select="fields/middle_name" />
            </xsl:if>
          </given-names>
        </name>
      </xsl:for-each>
      <xsl:for-each select="author">
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
  </xsl:template>
  <xsl:template mode="ref-editor-name" match="*">
    <xsl:if test="normalize-space(./*[name()!='fields'])!=''">
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
        <xsl:when test="count(reference_editor)=1">
          <role>Ed</role>
        </xsl:when>
        <xsl:otherwise>
          <role>Eds</role>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template name="ref-year">
    <xsl:for-each select="fields/year_of_publication[normalize-space(value)!='']">
      <year><xsl:value-of select="value"/></year>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="ref-book-title">
    <xsl:for-each select="fields/book_title[normalize-space(value)!='']">
      <article-title><xsl:apply-templates mode="format" select="value"/></article-title>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-article-title">
    <xsl:for-each select="fields/article_title[normalize-space(value)!='']">
      <article-title><xsl:apply-templates mode="format" select="value"/></article-title>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-title">
    <xsl:for-each select="fields/title[normalize-space(value)!='']">
      <article-title><xsl:apply-templates mode="format" select="value"/></article-title>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-translated-title">
    <xsl:for-each select="fields/translated_title[normalize-space(value)!='']">
      <trans-title><xsl:apply-templates mode="format" select="value"/></trans-title>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-chapter-title">
    <xsl:for-each select="fields/chapter_title[normalize-space(value)!='']">
      <chapter-title><xsl:apply-templates mode="format" select="value"/></chapter-title>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="ref-journal-name">
    <xsl:for-each select="fields/journal[normalize-space(value)!='']">
      <source><xsl:apply-templates mode="format" select="value"/></source>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="ref-conference">
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
  <xsl:template name="ref-conf-paper-title">
    <xsl:for-each select="fields/title[normalize-space(value)!='']">
      <chapter-title><xsl:apply-templates mode="format" select="value"/></chapter-title>
    </xsl:for-each>
    <xsl:for-each select="fields/book_title[normalize-space(value)!='']">
      <article-title><xsl:apply-templates mode="format" select="value"/></article-title>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-conf-optional">
    <xsl:for-each select="reference_conference_optional_fields/fields/node()[normalize-space(.)!='']">
      <xsl:choose>
        <xsl:when test="name()='publisher'">
          <publisher-name><xsl:value-of select="normalize-space(.)"/></publisher-name>
        </xsl:when>
        <xsl:when test="name()='city'">
          <publisher-loc><xsl:value-of select="normalize-space(.)"/></publisher-loc>
        </xsl:when>
        <xsl:when test="name()='journal_name'">
          <source><xsl:value-of select="normalize-space(.)"/></source>
        </xsl:when>
        <xsl:when test="name()!='journal_volume'">
          <volume><xsl:value-of select="normalize-space(.)"/></volume>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="ref-edition">
    <xsl:for-each select="fields/edition[normalize-space(value)!='']">
      <edition><xsl:value-of select="value"/></edition>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-volume">
    <xsl:for-each select="fields/volume[normalize-space(value)!='']">
      <volume><xsl:value-of select="value"/></volume>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-issue">
    <xsl:for-each select="fields/issue[normalize-space(value)!='']">
      <issue><xsl:value-of select="value"/></issue>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-fpage">
    <xsl:for-each select="fields/first_page[normalize-space(value)!='']">
      <fpage><xsl:value-of select="value"/></fpage>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-lpage">
    <xsl:for-each select="fields/last_page[normalize-space(value)!='']">
      <lpage><xsl:value-of select="value"/></lpage>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-number-of-pages">
    <xsl:for-each select="fields/number_of_pages[normalize-space(value)!='']">
      <size units="page"><xsl:value-of select="value"/> pp.</size>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="ref-publisher-name">
    <xsl:for-each select="fields/publisher[normalize-space(value)!='']">
      <publisher-name><xsl:apply-templates mode="format" select="value"/></publisher-name>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-publisher-loc">
    <xsl:for-each select="fields/city[normalize-space(value)!='']">
      <publisher-loc><xsl:value-of select="value"/></publisher-loc>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="ref-lang">
    <xsl:for-each select="fields/publication_language[normalize-space(value)!='']">
      <comment>
        <xsl:text>[In </xsl:text>
        <xsl:value-of select="value"/>
        <xsl:text>]</xsl:text>
      </comment>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-uri">
    <xsl:for-each select="fields/url[normalize-space(value)!='']">
      <uri><xsl:value-of select="value"/></uri>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-isbn">
    <xsl:for-each select="fields/isbn[normalize-space(value)!='']">
      <isbn><xsl:value-of select="value"/></isbn>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-doi">
    <xsl:for-each select="fields/doi[normalize-space(value)!='']">
      <pub-id>
        <xsl:attribute name="pub-id-type">doi</xsl:attribute>
        <xsl:value-of select="value"/>
      </pub-id>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-access-date">
    <xsl:for-each select="fields/access_date[normalize-space(value)!='']">
      <date-in-citation>
        <xsl:attribute name="content-type">access-date</xsl:attribute>
        <xsl:text>[accessed </xsl:text>
        <xsl:value-of select="value"/>
        <xsl:text>]</xsl:text>
      </date-in-citation>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-release-date">
    <xsl:for-each select="fields/release_date[normalize-space(value)!='']">
      <date-in-citation>
        <xsl:attribute name="content-type">released</xsl:attribute>
        <xsl:text>Released </xsl:text>
        <xsl:value-of select="value"/>
      </date-in-citation>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ref-version">
    <xsl:for-each select="fields/version[normalize-space(value)!='']">
      <comment>
        <xsl:value-of select="@field_name"/>
        <xsl:text>: </xsl:text>
        <xsl:value-of select="value"/>
      </comment>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
