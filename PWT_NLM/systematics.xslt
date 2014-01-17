<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs" xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">

<!-- new_tt_genus_iczn -->
<!-- new_tt_species_iczn -->
<!-- redescription_tt_genus_iczn -->
<!-- redescription_tt_species_iczn -->
<!-- redescription_tt_genus_icn -->
<!-- new_tt_genus_icn -->
<!-- new_tt_species_icn -->
<!-- redescription_tt_species_icn -->

  <xsl:template mode="systematics" match="*">
    <sec>
      <xsl:attribute name="sec-type">
        <xsl:value-of select="@display_name"/>
      </xsl:attribute>
      <title>
        <xsl:value-of select="@display_name"/>
      </title>
      <xsl:for-each select="node()[@object_id='41'][normalize-space(.)!='']"><!-- Treatments -->
        <xsl:variable name="status-animalia">
          <xsl:call-template name="taxon-status-new">
            <xsl:with-param name="kingdom" select="'animalia'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="status-plantae">
          <xsl:call-template name="taxon-status-new">
            <xsl:with-param name="kingdom" select="'plantae'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="normalize-space(node()[name()!='fields'])!=''">
          <tp:taxon-treatment>
            <!-- <xsl:apply-templates mode="treatment-meta" select="."/> -->
            <!-- Taxon data part -->
            <xsl:for-each select="node()">
              <xsl:choose>
                <xsl:when test="@object_id='184'">
                  <xsl:apply-templates mode="new_tt_genus_iczn" select=".">
                    <xsl:with-param name="status" select="$status-animalia"/>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="@object_id='179'">
                  <xsl:apply-templates mode="new_tt_species_iczn" select=".">
                    <xsl:with-param name="status" select="$status-animalia"/>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="@object_id='213'">
                  <xsl:apply-templates mode="redescription_tt_genus_iczn" select="."/>
                </xsl:when>
                <xsl:when test="@object_id='197'">
                  <xsl:apply-templates mode="redescription_tt_species_iczn" select="."/>
                </xsl:when>
                <xsl:when test="@object_id='192'">
                  <xsl:apply-templates mode="new_tt_genus_icn" select=".">
                    <xsl:with-param name="status" select="$status-plantae"/>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="@object_id='182'">
                  <xsl:apply-templates mode="new_tt_species_icn" select=".">
                    <xsl:with-param name="status" select="$status-plantae"/>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="@object_id='216'">
                  <xsl:apply-templates mode="redescription_tt_genus_icn" select="."/>
                </xsl:when>
                <xsl:when test="@object_id='196'">
                  <xsl:apply-templates mode="redescription_tt_species_icn" select="."/>
                </xsl:when>
              </xsl:choose>
            </xsl:for-each>
          </tp:taxon-treatment>
        </xsl:if>
      </xsl:for-each>
    </sec>
  </xsl:template>
<!-- 
#
#  DESCRIPTION OF NEW TAXONS
#
 -->
<!-- 
#
#  NEW GENUS
#
 -->
  <xsl:template mode="new_tt_genus_icn" match="*">
    <xsl:param name="status" select="''"/>
    <tp:nomenclature>
      <xsl:call-template name="treatment-taxon-name-authority-status">
        <xsl:with-param name="taxon_name" select="node()[@object_id='181']"/>
        <xsl:with-param name="object_id" select="."/>
        <xsl:with-param name="status" select="$status"/>
      </xsl:call-template>
      <xsl:apply-templates mode="nomenclature-citation-group" select="."/>
    </tp:nomenclature>
    <xsl:call-template name="treatment-materials-sections">
      <xsl:with-param name="materials" select="node()[@object_id='38']"/>
      <xsl:with-param name="sections" select="node()[@object_id='193']"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="new_tt_genus_iczn" match="*">
    <xsl:param name="status" select="''"/>
    <xsl:variable name="type_species" select="node()[@object_id='186']"/>
    <tp:nomenclature>
      <xsl:call-template name="treatment-taxon-name-authority-status">
        <xsl:with-param name="taxon_name" select="node()[@object_id='181']"/>
        <xsl:with-param name="object_id" select="."/>
        <xsl:with-param name="status" select="$status"/>
      </xsl:call-template>
      <xsl:apply-templates mode="nomenclature-citation-group" select="."/>
    </tp:nomenclature>
    <xsl:call-template name="treatment-materials-sections">
      <xsl:with-param name="materials" select="node()[@object_id='38']"/>
      <xsl:with-param name="sections" select="node()[@object_id='185']"/>
    </xsl:call-template>
  </xsl:template>
<!-- 
#
#  NEW SPECIES
#
 -->
 <!-- TODO: Correction of the status! --> 
  <xsl:template mode="new_tt_species_icn" match="*">
    <xsl:param name="status" select="''"/>
    <tp:nomenclature>
      <xsl:call-template name="treatment-taxon-name-authority-status">
        <xsl:with-param name="taxon_name" select="node()[@object_id='180']"/>
        <xsl:with-param name="object_id" select="."/>
        <xsl:with-param name="status" select="$status"/>
      </xsl:call-template>
    </tp:nomenclature>
    <xsl:call-template name="treatment-materials-sections">
      <xsl:with-param name="materials" select="node()[@object_id='38']"/>
      <xsl:with-param name="sections" select="node()[@object_id='140']"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="new_tt_species_iczn" match="*">
    <xsl:param name="status" select="''"/>
    <tp:nomenclature>
      <xsl:call-template name="treatment-taxon-name-authority-status">
        <xsl:with-param name="taxon_name" select="node()[@object_id='180']"/>
        <xsl:with-param name="object_id" select="."/>
        <xsl:with-param name="status" select="$status"/>
      </xsl:call-template>
    </tp:nomenclature>
    <xsl:call-template name="treatment-materials-sections">
      <xsl:with-param name="materials" select="node()[@object_id='38']"/>
      <xsl:with-param name="sections" select="node()[@object_id='109']"/>
    </xsl:call-template>
  </xsl:template>
<!-- 
#
#  REDESCRIPTION OF TAXON
#
 -->
<!-- 
#
#  GENUS
#
 -->
  <xsl:template mode="redescription_tt_genus_icn" match="*">
    <xsl:param name="status" select="''"/>
    <tp:nomenclature>
      <xsl:call-template name="treatment-taxon-name-authority-status">
        <xsl:with-param name="taxon_name" select="node()[@object_id='181']"/>
        <xsl:with-param name="object_id" select="."/>
        <xsl:with-param name="status" select="$status"/>
      </xsl:call-template>
      <xsl:apply-templates mode="nomenclature-citation-group" select="."/>
    </tp:nomenclature>
    <xsl:call-template name="treatment-materials-sections">
      <xsl:with-param name="materials" select="node()[@object_id='38']"/>
      <xsl:with-param name="sections" select="node()[@object_id='214']"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="redescription_tt_genus_iczn" match="*">
    <xsl:param name="status" select="''"/>
    <tp:nomenclature>
      <xsl:call-template name="treatment-taxon-name-authority-status">
        <xsl:with-param name="taxon_name" select="node()[@object_id='181']"/>
        <xsl:with-param name="object_id" select="."/>
        <xsl:with-param name="status" select="$status"/>
      </xsl:call-template>
      <xsl:apply-templates mode="nomenclature-citation-group" select="."/>
    </tp:nomenclature>
    <xsl:call-template name="treatment-materials-sections">
      <xsl:with-param name="materials" select="node()[@object_id='38']"/>
      <xsl:with-param name="sections" select="node()[@object_id='214']"/>
    </xsl:call-template>
  </xsl:template>
<!-- 
#
#  SPECIES
#
 -->
  <xsl:template mode="redescription_tt_species_icn" match="*">
    <xsl:param name="status" select="''"/>
    <xsl:variable name="nomenclature" select="synonims/fields/nomenclature/value"/>
    <tp:nomenclature>
      <xsl:call-template name="treatment-taxon-name-authority-status">
        <xsl:with-param name="taxon_name" select="node()[@object_id='180']"/>
        <xsl:with-param name="object_id" select="."/>
        <xsl:with-param name="status" select="$status"/>
      </xsl:call-template>
      <xsl:apply-templates mode="nomenclature-citation-group" select="."/>
    </tp:nomenclature>
    <xsl:call-template name="treatment-materials-sections">
      <xsl:with-param name="materials" select="node()[@object_id='38']"/>
      <xsl:with-param name="sections" select="node()[@object_id='199']"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="redescription_tt_species_iczn" match="*">
    <xsl:param name="status" select="''"/>
    <xsl:variable name="nomenclature" select="synonyms/fields/nomenclature/value"/>
    <tp:nomenclature>
      <xsl:call-template name="treatment-taxon-name-authority-status">
        <xsl:with-param name="taxon_name" select="node()[@object_id='180']"/>
        <xsl:with-param name="object_id" select="."/>
        <xsl:with-param name="status" select="$status"/>
      </xsl:call-template>
      <xsl:apply-templates mode="nomenclature-citation-group" select="."/>
    </tp:nomenclature>
    <xsl:call-template name="treatment-materials-sections">
      <xsl:with-param name="materials" select="node()[@object_id='38']"/>
      <xsl:with-param name="sections" select="node()[@object_id='198']"/>
    </xsl:call-template>
  </xsl:template>
<!-- 
#
#
#  ADDITIONAL TEMPLATES
#
#
 -->
  <xsl:template mode="treatment-meta" match="*">
    <tp:treatment-meta>
      <xsl:if test="normalize-space(fields)!=''">
        <xsl:for-each select="fields">
          <kwd-group>
            <xsl:for-each select="node()[normalize-space(value)!='']">
              <xsl:choose>
                <xsl:when test="normalize-space(@field_name)=''">
                  <kwd>
                    <xsl:apply-templates mode="format" select="value"/>
                  </kwd>
                </xsl:when>
                <xsl:otherwise>
                  <kwd>
                    <xsl:value-of select="@field_name"/>
                    <xsl:text>: </xsl:text>
                    <xsl:apply-templates mode="format" select="value"/>
                  </kwd>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </kwd-group>
        </xsl:for-each>
      </xsl:if>
    </tp:treatment-meta>
  </xsl:template>

  <xsl:template name="treatment-taxon-name-authority-status">
    <xsl:param name="taxon_name" select="''"/>
    <xsl:param name="object_id" select="''"/>
    <xsl:param name="status" select="''"/>
    <tp:taxon-name>
      <xsl:apply-templates mode="lower-taxon-name-parts" select="$taxon_name/fields"/>
      <xsl:apply-templates mode="taxon-object-id" select="$object_id"/>
    </tp:taxon-name>
    <xsl:apply-templates mode="taxon-authority" select="$taxon_name"/>
    <xsl:if test="$status!=''">
      <tp:taxon-status>
        <xsl:value-of select="$status"/>
      </tp:taxon-status>
    </xsl:if>
  </xsl:template>

  <xsl:template name="treatment-materials-sections">
    <xsl:param name="materials" select="''"/>
    <xsl:param name="sections" select="''"/>
    <xsl:apply-templates mode="materials" select="$materials"/>
    <xsl:apply-templates mode="treatment-sections" select="$sections"/>
  </xsl:template>

  <xsl:template mode="treatment-sections" match="*">
    <xsl:for-each select="node()[normalize-space(.)!='']">
      <xsl:choose>
        <xsl:when test="(@display_name='') and (name()!='section')">
          <xsl:call-template name="raise-error">
            <xsl:with-param name="content" select="'treatment-sections'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="name()='section'">
          <xsl:apply-templates mode="treatment-section-section" select="."/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="treatment-section" select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="treatment-section" match="*">
    <!-- This template matches all treatment sections with predefined names -->
    <xsl:variable name="content" select="fields/*/value"/>
    <tp:treatment-sec>
      <xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
      <title><xsl:value-of select="@display_name"/></title>
      <xsl:apply-templates mode="p" select="fields/*/value"/>
      <xsl:apply-templates mode="subsection" select="."/>
    </tp:treatment-sec>
  </xsl:template>
  <xsl:template mode="treatment-section-section" match="*">
    <!-- This template matches all treatment sections without predefined names -->
    <xsl:variable name="title" select="fields/title/value"/>
    <xsl:variable name="content" select="fields/content/value"/>
    <tp:treatment-sec>
      <xsl:attribute name="sec-type"><xsl:value-of select="normalize-space($title)"/></xsl:attribute>
      <xsl:if test="normalize-space($title)!=''">
        <title><xsl:apply-templates mode="title" select="$title"/></title>
      </xsl:if>
      <xsl:apply-templates mode="p" select="$content"/>
      <xsl:apply-templates mode="subsection" select="."/>
    </tp:treatment-sec>
  </xsl:template>

  <xsl:template mode="materials" match="*">
    <xsl:if test="count(material//*[normalize-space(value)!=''])!=0">
      <tp:treatment-sec>
        <xsl:attribute name="sec-type">materials</xsl:attribute>
        <title>Materials</title>
        <list>
          <xsl:attribute name="list-type">alpha-lower</xsl:attribute>
          <xsl:attribute name="list-content">occurrences</xsl:attribute>
          <xsl:for-each select="material">
            <xsl:variable name="type_status" select="normalize-space(fields/type_status/value)"/>
            <xsl:variable name="type_status_label" select="fields/type_status/@field_name"/>
            <xsl:for-each select="extended_darwincore">
              <list-item>
                <xsl:for-each select="node()[name()!='' and name()!='fields']">
                  <p>
                    <xsl:if test="$type_status!=''">
                      <bold>
                        <xsl:value-of select="$type_status_label"/>
                        <xsl:text>:</xsl:text>
                      </bold>
                      <xsl:text> </xsl:text>
                      <named-content>
                        <xsl:attribute name="content-type">dwc:typeStatus</xsl:attribute>
                        <xsl:attribute name="xlink:type">simple</xsl:attribute>
                        <xsl:value-of select="$type_status"/>
                      </named-content>
                      <xsl:text>. </xsl:text>
                    </xsl:if>
                    <xsl:for-each select="node()[normalize-space()!='']">
                      <bold>
                        <xsl:value-of select="@display_name"/>
                        <xsl:text>:</xsl:text>
                      </bold>
                      <xsl:text> </xsl:text>
                      <xsl:apply-templates mode="materials_mode" select="."/>
                      <xsl:if test="position()!=last()">
                        <xsl:text>; </xsl:text>
                      </xsl:if>
                    </xsl:for-each>
                  </p>
                </xsl:for-each>
              </list-item>
            </xsl:for-each>
          </xsl:for-each>
        </list>
      </tp:treatment-sec>
    </xsl:if>
  </xsl:template>
  <xsl:template mode="materials_mode" match="*">
    <xsl:for-each select=".//fields/node()[(@field_name!='') and (normalize-space(.)!='')]">
      <xsl:value-of select="@field_name"/>
      <xsl:text>: </xsl:text>
      <named-content>
        <xsl:attribute name="content-type">
          <xsl:text>dwc:</xsl:text>
          <xsl:value-of select="@field_name"/>
        </xsl:attribute>
        <xsl:attribute name="xlink:type">simple</xsl:attribute>
        <xsl:apply-templates mode="format" select="value"/>
      </named-content>
      <xsl:if test="position()!=last()">
        <xsl:text>; </xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="material_mode_content" match="tp:taxon-name">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template mode="material_mode_content" match="a">
    <ext-link>
      <xsl:attribute name="ext-link-type">uri</xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:value-of select="href"/>
      </xsl:attribute>
      <xsl:value-of select="normalize-space(.)"/>
    </ext-link>
  </xsl:template>
  <xsl:template mode="material_mode_content" match="@*|node()">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>
</xsl:stylesheet>
