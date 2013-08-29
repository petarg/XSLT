<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">
  <xsl:template mode="checklists" match="*">
    <xsl:if test="count(checklist[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0])!=0">
      <sec>
        <xsl:attribute name="sec-type"><xsl:value-of select="@display_name"/></xsl:attribute>
        <title><xsl:value-of select="@display_name"/></title>
        <xsl:for-each select="checklist[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="checklist" select="."/>
        </xsl:for-each>
      </sec>
    </xsl:if>
  </xsl:template>
  <xsl:template mode="checklist" match="*">
    <sec>
      <xsl:attribute name="sec-type">
        <xsl:value-of select="@display_name"/>
      </xsl:attribute>
      <sec-meta>
        <xsl:for-each select="fields[normalize-space(.)!='']">
          <kwd-group>
            <xsl:for-each select="node()[(normalize-space(value)!='') and (@id!='476')]">
              <xsl:variable name="value" select="normalize-space(value)"/>
              <xsl:choose>
                <xsl:when test="@field_name=''">
                  <kwd><xsl:value-of select="$value"/></kwd>
                </xsl:when>
                <xsl:otherwise>
                  <kwd>
                    <xsl:value-of select="@field_name"/>
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="$value"/>
                  </kwd>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </kwd-group>
        </xsl:for-each>
      </sec-meta>
      <title>
        <xsl:apply-templates mode="title" select="fields/node()[@id='413']/value"/>
      </title>
      <xsl:call-template name="checklist-taxons"/>
      <xsl:call-template name="checklist-locality"/>
    </sec>
  </xsl:template>
  <xsl:template mode="checklist-eco-interactions" match="*">
    <xsl:for-each select="node()[@object_id='209'][normalize-space(.)!='']">
      <tp:treatment-sec>
        <xsl:attribute name="sec-type">
          <xsl:value-of select="@display_name"/>
        </xsl:attribute>
        <title><xsl:value-of select="@display_name"/></title>
        <xsl:for-each select="fields/*[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="little-section" select="."/>
        </xsl:for-each>
      </tp:treatment-sec>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="checklist-treatment-sections">
    <xsl:apply-templates mode="materials" select="materials"/>
    <xsl:apply-templates mode="checklist-eco-interactions" select="."/>
    <xsl:for-each select="node()[(@object_id='208') or (@object_id='207') or (@object_id='206')][normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <xsl:apply-templates mode="treatment-section" select="."/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="checklist-locality">
    <xsl:for-each select="node()[@object_id='212']">
      <sec>
        <xsl:attribute name="sec-type">Locality</xsl:attribute>
        <title><xsl:value-of select="normalize-space(@display_name)"/></title>
        <xsl:for-each select="fields/node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
          <xsl:apply-templates mode="little-section" select="."/>
        </xsl:for-each>
        <xsl:apply-templates mode="checklist-taxons" select="."/>
      </sec>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="checklist-taxons">
    <xsl:for-each select="checklist_taxon[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
      <xsl:call-template name="checklist-parse-taxons"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="checklist-higher-treatment">
    <xsl:variable name="nomenclature" select="node()[@object_id='210']/fields//value"/>
    <xsl:variable name="rank" select="normalize-space(fields/node()[@id='414']/value)"/>
    <xsl:variable name="treatment_id" select="fields/node()[name()=$rank]/@id"/>
    <xsl:variable name="taxon" select="fields/node()[@id=$treatment_id]"/>
    <tp:taxon-treatment>
      <xsl:call-template name="checklist-treatment-meta"/>
      <tp:nomenclature>
        <tp:taxon-name>
          <tp:taxon-name-part>
            <xsl:attribute name="taxon-name-part-type">
              <xsl:value-of select="$taxon/@latin"/>
            </xsl:attribute>
            <xsl:value-of select="$taxon/value"/>
          </tp:taxon-name-part>
          <xsl:apply-templates mode="taxon-object-id" select="."/>
        </tp:taxon-name>
        <xsl:call-template name="get-authority"/>
        <xsl:if test="normalize-space($nomenclature)!='' or count($nomenclature/*/*[name()!=''])!=0">
          <tp:nomenclature-citation-list>
            <xsl:choose>
              <xsl:when test="count($nomenclature/p)!=0">
                <xsl:for-each select="$nomenclature/p[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
                  <tp:nomenclature-citation>
                    <tp:taxon-name>
                      <tp:taxon-name-part>
                        <xsl:attribute name="taxon-name-part-type">
                          <xsl:value-of select="$taxon/@latin"/>
                        </xsl:attribute>
                        <xsl:value-of select="$taxon/value"/>
                      </tp:taxon-name-part>
                    </tp:taxon-name>
                    <comment>
                      <xsl:apply-templates mode="format" select="."/>
                    </comment>
                  </tp:nomenclature-citation>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <tp:nomenclature-citation>
                  <tp:taxon-name>
                    <tp:taxon-name-part>
                      <xsl:attribute name="taxon-name-part-type">
                        <xsl:value-of select="$taxon/@latin"/>
                      </xsl:attribute>
                      <xsl:value-of select="$taxon/value"/>
                    </tp:taxon-name-part>
                  </tp:taxon-name>
                  <comment>
                    <xsl:apply-templates mode="format" select="$nomenclature"/>
                  </comment>
                </tp:nomenclature-citation>
              </xsl:otherwise>
            </xsl:choose>
          </tp:nomenclature-citation-list>
        </xsl:if>
      </tp:nomenclature>
      <xsl:call-template name="checklist-treatment-sections"/>
    </tp:taxon-treatment>
  </xsl:template>
  <xsl:template name="checklist-subgenus-treatment">
    <xsl:variable name="top" select="."/>
    <xsl:variable name="nomenclature" select="node()[@object_id='210']/fields//value"/>
    <xsl:variable name="rank" select="normalize-space(fields/node()[@id='414']/value)"/>
    <xsl:variable name="treatment_id" select="fields/node()[name()=$rank]/@id"/>
    <tp:taxon-treatment>
      <xsl:call-template name="checklist-treatment-meta"/>
      <tp:nomenclature>
        <xsl:apply-templates mode="get-subgenus-tagged" select="$top">
          <xsl:with-param name="put_object_id" select="true()"/>
        </xsl:apply-templates>
        <xsl:call-template name="get-authority"/>
        <xsl:if test="normalize-space($nomenclature)!='' or count($nomenclature/*/*[name()!=''])!=0">
          <tp:nomenclature-citation-list>
            <xsl:choose>
              <xsl:when test="count($nomenclature/p)!=0">
                <xsl:for-each select="$nomenclature/p[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
                  <tp:nomenclature-citation>
                    <xsl:apply-templates mode="get-subgenus-tagged" select="$top">
                      <xsl:with-param name="put_object_id" select="false()"/>
                    </xsl:apply-templates>
                    <comment>
                      <xsl:apply-templates mode="format" select="."/>
                    </comment>
                  </tp:nomenclature-citation>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <tp:nomenclature-citation>
                  <xsl:apply-templates mode="get-subgenus-tagged" select="$top">
                    <xsl:with-param name="put_object_id" select="false()"/>
                  </xsl:apply-templates>
                  <comment>
                    <xsl:apply-templates mode="format" select="$nomenclature"/>
                  </comment>
                </tp:nomenclature-citation>
              </xsl:otherwise>
            </xsl:choose>
          </tp:nomenclature-citation-list>
        </xsl:if>
      </tp:nomenclature>
      <xsl:call-template name="checklist-treatment-sections"/>
    </tp:taxon-treatment>
  </xsl:template>
  <xsl:template name="checklist-species-treatment">
    <xsl:variable name="top" select="."/>
    <xsl:variable name="nomenclature" select="node()[@object_id='210']/fields//value"/>
    <xsl:variable name="rank" select="normalize-space(fields/node()[@id='414']/value)"/>
    <xsl:variable name="treatment_id" select="fields/node()[name()=$rank]/@id"/>
    <tp:taxon-treatment>
      <xsl:call-template name="checklist-treatment-meta"/>
      <tp:nomenclature>
        <xsl:apply-templates mode="get-species-tagged" select="$top">
          <xsl:with-param name="put_object_id" select="true()"/>
        </xsl:apply-templates>
        <xsl:call-template name="get-authority"/>
        <xsl:if test="normalize-space($nomenclature)!='' or count($nomenclature/*/*[name()!=''])!=0">
          <tp:nomenclature-citation-list>
            <xsl:choose>
              <xsl:when test="count($nomenclature/p)!=0">
                <xsl:for-each select="$nomenclature/node()[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
                  <tp:nomenclature-citation>
                    <xsl:apply-templates mode="get-species-tagged" select="$top">
                      <xsl:with-param name="put_object_id" select="false()"/>
                    </xsl:apply-templates>
                    <comment>
                      <xsl:apply-templates mode="format" select="."/>
                    </comment>
                  </tp:nomenclature-citation>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <tp:nomenclature-citation>
                  <xsl:apply-templates mode="get-species-tagged" select="$top">
                    <xsl:with-param name="put_object_id" select="false()"/>
                  </xsl:apply-templates>
                  <comment>
                    <xsl:apply-templates mode="format" select="$nomenclature"/>
                  </comment>
                </tp:nomenclature-citation>
              </xsl:otherwise>
            </xsl:choose>
          </tp:nomenclature-citation-list>
        </xsl:if>
      </tp:nomenclature>
      <xsl:call-template name="checklist-treatment-sections"/>
    </tp:taxon-treatment>
  </xsl:template>

  <xsl:template name="checklist-treatment-meta">
    <tp:treatment-meta>
      <kwd-group>
        <xsl:for-each select="fields/node()[@rank_id!=''][normalize-space(.)!='']">
          <kwd>
            <xsl:value-of select="@field_name"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
          </kwd>
        </xsl:for-each>
      </kwd-group>
    </tp:treatment-meta>
  </xsl:template>
  <xsl:template mode="get-higher-tagged" match="*">
    <xsl:param name="put_object_id" select="true()"/>
    <xsl:param name="taxon_rank" select="'family'"/>
    <xsl:param name="taxon" select="fields/family"/>
    <tp:taxon-name>
      <tp:taxon-name-part>
        <xsl:attribute name="taxon-name-part-type">
          <xsl:value-of select="$taxon/@latin"/>
        </xsl:attribute>
        <xsl:value-of select="$taxon/value"/>
      </tp:taxon-name-part>
      <xsl:if test="$put_object_id">
        <xsl:apply-templates mode="taxon-object-id" select="."/>
      </xsl:if>
    </tp:taxon-name>
  </xsl:template>
  <xsl:template mode="get-genus-tagged" match="*">
    <xsl:param name="put_object_id" select="true()"/>
    <tp:taxon-name>
      <tp:taxon-name-part>
        <xsl:attribute name="taxon-name-part-type">genus</xsl:attribute>
        <xsl:value-of select="fields/genus/value"/>
      </tp:taxon-name-part>
      <xsl:if test="$put_object_id">
        <xsl:apply-templates mode="taxon-object-id" select="."/>
      </xsl:if>
    </tp:taxon-name>
  </xsl:template>
  <xsl:template mode="get-subgenus-tagged" match="*">
    <xsl:param name="put_object_id" select="true()"/>
    <tp:taxon-name>
      <xsl:choose>
        <xsl:when test="normalize-space(fields/genus/value)=''">
          <tp:taxon-name-part>
            <xsl:attribute name="taxon-name-part-type">subgenus</xsl:attribute>
            <xsl:value-of select="fields/subgenus/value"/>
          </tp:taxon-name-part>
        </xsl:when>
        <xsl:otherwise>
          <tp:taxon-name-part>
            <xsl:attribute name="taxon-name-part-type">genus</xsl:attribute>
            <xsl:value-of select="fields/genus/value"/>
          </tp:taxon-name-part>
          <xsl:text> (</xsl:text>
          <tp:taxon-name-part>
            <xsl:attribute name="taxon-name-part-type">subgenus</xsl:attribute>
            <xsl:value-of select="fields/subgenus/value"/>
          </tp:taxon-name-part>
          <xsl:text>)</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$put_object_id">
        <xsl:apply-templates mode="taxon-object-id" select="."/>
      </xsl:if>
    </tp:taxon-name>
  </xsl:template>
  <xsl:template mode="get-species-tagged" match="*">
    <xsl:param name="put_object_id" select="true()"/>
    <xsl:variable name="genus" select="normalize-space(fields/genus/value)"/>
    <xsl:variable name="subgenus" select="normalize-space(fields/subspace/value)"/>
    <xsl:variable name="species" select="normalize-space(fields/species/value)"/>
    <xsl:variable name="subspecies" select="normalize-space(fields/subspecies/value)"/>
    <xsl:variable name="forma" select="normalize-space(fields/form/value)"/>
    <xsl:variable name="variety" select="normalize-space(fields/variety/value)"/>
    <tp:taxon-name>
      <xsl:if test="$genus!=''">
        <tp:taxon-name-part>
          <xsl:attribute name="taxon-name-part-type">genus</xsl:attribute>
          <xsl:value-of select="$genus"/>
        </tp:taxon-name-part>
      </xsl:if>
      <xsl:if test="$subgenus!=''">
        <xsl:text> (</xsl:text>
        <tp:taxon-name-part>
          <xsl:attribute name="taxon-name-part-type">subgenus</xsl:attribute>
          <xsl:value-of select="$subgenus"/>
        </tp:taxon-name-part>
        <xsl:text>) </xsl:text>
      </xsl:if>
      <xsl:if test="$species!=''">
        <tp:taxon-name-part>
          <xsl:attribute name="taxon-name-part-type">species</xsl:attribute>
          <xsl:value-of select="$species"/>
        </tp:taxon-name-part>
      </xsl:if>
      <xsl:if test="$subspecies!=''">
        <tp:taxon-name-part>
          <xsl:attribute name="taxon-name-part-type">subspecies</xsl:attribute>
          <xsl:value-of select="$subspecies"/>
        </tp:taxon-name-part>
      </xsl:if>
      <xsl:if test="$forma!=''">
        <xsl:text> f. </xsl:text>
        <tp:taxon-name-part>
          <xsl:attribute name="taxon-name-part-type">forma</xsl:attribute>
          <xsl:value-of select="$forma"/>
        </tp:taxon-name-part>
      </xsl:if>
      <xsl:if test="$variety!=''">
        <xsl:text> var. </xsl:text>
        <tp:taxon-name-part>
          <xsl:attribute name="taxon-name-part-type">varietas</xsl:attribute>
          <xsl:value-of select="$variety"/>
        </tp:taxon-name-part>
      </xsl:if>
      <xsl:if test="$put_object_id">
        <xsl:apply-templates mode="taxon-object-id" select="."/>
      </xsl:if>
    </tp:taxon-name>
  </xsl:template>
  <xsl:template name="get-authority">
    <xsl:variable name="authors" select="normalize-space(fields/node()[@id='236']/value)"/>
    <xsl:if test="$authors!=''">
      <tp:taxon-authority><xsl:value-of select="$authors"/></tp:taxon-authority>
    </xsl:if>
  </xsl:template>
  <xsl:template name="checklist-taxon-sec-title">
    <xsl:param name="taxon"/>
    <xsl:attribute name="sec-type">
      <xsl:value-of select="$taxon/@field_name"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$taxon/value"/>
    </xsl:attribute>
    <title>
      <xsl:value-of select="$taxon/@field_name"/>
      <xsl:text> </xsl:text>
      <tp:taxon-name>
        <tp:taxon-name-part>
          <xsl:attribute name="taxon-name-part-type">
            <xsl:value-of select="$taxon/@latin"/>
          </xsl:attribute>
          <xsl:value-of select="$taxon/value"/>
        </tp:taxon-name-part>
      </tp:taxon-name>
    </title>
  </xsl:template>
  <xsl:template name="checklist-parse-taxons">
    <xsl:variable name="rank" select="normalize-space(fields/rank/value)"/>
    <xsl:variable name="rank_id" select="fields/node()[name()=$rank]/@rank_id"/>
    <xsl:variable name="taxon" select="fields/node()[@rank_id=$rank_id]"/>
    <xsl:choose>
      <xsl:when test="($rank_id &lt; 18) and ($rank_id &gt; 0)"><!-- Higher taxon or genus -->
        <xsl:call-template name="checklist-higher-treatment"/>
      </xsl:when>
      <xsl:when test="$rank_id=18"><!-- Subgenus -->
        <xsl:call-template name="checklist-subgenus-treatment"/>
      </xsl:when>
      <xsl:when test="$rank_id &lt; 23 and $rank_id &gt; 18"><!-- Lower taxa -->
        <xsl:call-template name="checklist-species-treatment"/>
      </xsl:when>
      <xsl:otherwise>
        <INVALID-TAG>
          <xsl:text>Invalid rank_id </xsl:text>
          <xsl:value-of select="$rank_id"/>
        </INVALID-TAG>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="checklist-parse-taxons-RECURSIVE_SEC_STRUCTURE">
    <xsl:param name="rank_id" select="'1'"/>
    <xsl:variable name="taxon" select="fields/node()[@rank_id=$rank_id]"/>
    <xsl:variable name="rank" select="normalize-space(fields/rank/value)"/>
    <xsl:choose>
      <xsl:when test="($rank_id &lt; 18) and ($rank_id &gt; 0)"><!-- Higher taxon or genus -->
        <xsl:choose>
          <xsl:when test="name($taxon)=$rank">
            <xsl:call-template name="checklist-higher-treatment"/>
          </xsl:when>
          <xsl:when test="normalize-space($taxon/value)=''">
            <xsl:call-template name="checklist-parse-taxons-RECURSIVE_SEC_STRUCTURE">
              <xsl:with-param name="rank_id" select="$rank_id+1"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <sec>
              <xsl:call-template name="checklist-taxon-sec-title">
                <xsl:with-param name="taxon" select="$taxon"/>
              </xsl:call-template>
              <xsl:call-template name="checklist-parse-taxons-RECURSIVE_SEC_STRUCTURE">
                <xsl:with-param name="rank_id" select="$rank_id+1"/>
              </xsl:call-template>
            </sec>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$rank_id=18"><!-- Subgenus -->
        <xsl:choose>
          <xsl:when test="name($taxon)=$rank">
            <xsl:call-template name="checklist-subgenus-treatment"/>
          </xsl:when>
          <xsl:when test="normalize-space($taxon/value)=''">
            <xsl:call-template name="checklist-parse-taxons-RECURSIVE_SEC_STRUCTURE">
              <xsl:with-param name="rank_id" select="$rank_id+1"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <sec>
              <xsl:call-template name="checklist-taxon-sec-title">
                <xsl:with-param name="taxon" select="$taxon"/>
              </xsl:call-template>
              <xsl:call-template name="checklist-parse-taxons-RECURSIVE_SEC_STRUCTURE">
                <xsl:with-param name="rank_id" select="$rank_id+1"/>
              </xsl:call-template>
            </sec>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$rank_id &lt; 23 and $rank_id &gt; 18"><!-- Lower taxa -->
        <xsl:call-template name="checklist-species-treatment"/>
      </xsl:when>
      <xsl:otherwise>
        <INVALID-TAG>
          <xsl:text>Invalid rank_id </xsl:text>
          <xsl:value-of select="$rank_id"/>
        </INVALID-TAG>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!-- ################################################################################################################ -->
  <xsl:template mode="checklist_taxon1" match="*">
    <xsl:variable name="authors" select="normalize-space(fields/node()[@id='236']/value)"/>
    <xsl:variable name="nomenclature" select="node()[@object_id='210']/fields//value"/>
    <tp:taxon-treatment>
      <tp:nomenclature>
        <tp:taxon-name>
          <xsl:apply-templates mode="checklist-taxon-name" select="fields"/>
          <xsl:apply-templates mode="taxon-object-id" select="."/>
        </tp:taxon-name>
        <xsl:if test="$authors!=''">
          <tp:taxon-authority><xsl:value-of select="$authors"/></tp:taxon-authority>
        </xsl:if>
        <xsl:if test="normalize-space($nomenclature)!='' or count($nomenclature/*/*[name()!=''])!=0">
          <tp:nomenclature-citation-list>
            <xsl:for-each select="$nomenclature/*[normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
              <tp:nomenclature-citation>
                <tp:taxon-name>
                  <xsl:apply-templates mode="checklist-taxon-name-short" select="../../../../../fields"/>
                </tp:taxon-name>
                <comment>
                  <xsl:apply-templates mode="format" select="."/>
                </comment>
              </tp:nomenclature-citation>
            </xsl:for-each>
          </tp:nomenclature-citation-list>
        </xsl:if>
      </tp:nomenclature>
      <xsl:apply-templates mode="materials" select="materials"/>
      <xsl:apply-templates mode="checklist-eco-interactions" select="."/>
      <xsl:for-each select="node()[(@object_id='208') or (@object_id='207') or (@object_id='206')][normalize-space(.)!='' or count(.//node()[@citation_id!=''])!=0]">
        <xsl:apply-templates mode="treatment-section" select="."/>
      </xsl:for-each>
    </tp:taxon-treatment>
  </xsl:template>
  <xsl:template mode="checklist-taxon-name-part" match="*">
    <tp:taxon-name-part>
      <xsl:attribute name="taxon-name-part-type"><xsl:value-of select="name()"/></xsl:attribute>
      <xsl:value-of select="value"/>
    </tp:taxon-name-part>
  </xsl:template>
  <xsl:template mode="checklist-taxon-name" match="*">
    <xsl:for-each select="kingdom[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="subkingdom[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="phylum[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="subphylum[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="superclass[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="class[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="subclass[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="superorder[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="order[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="suborder[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="infraorder[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="superfamily[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="family[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="subfamily[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="tribe[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="subtribe[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="genus[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="subgenus[normalize-space(value)!='']">
      <xsl:text> (</xsl:text>
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
      <xsl:text>) </xsl:text>
    </xsl:for-each>
    <xsl:for-each select="species[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="subspecies[normalize-space(value)!='']">
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="variety[normalize-space(value)!='']">
      <xsl:text> var. </xsl:text>
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
    <xsl:for-each select="form[normalize-space(value)!='']">
      <xsl:text> f. </xsl:text>
      <xsl:apply-templates mode="checklist-taxon-name-part" select="."/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="checklist-taxon-name-short" match="*">
    <xsl:variable name="genus" select="normalize-space(genus/value)"/>
    <xsl:variable name="species" select = "normalize-space(species/value)"/>
    <xsl:choose>
      <xsl:when test="$genus!='' and $species!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="genus"/>
        <xsl:apply-templates mode="checklist-taxon-name-part" select="species"/>
      </xsl:when>
      <xsl:when test="$genus!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="genus"/>
      </xsl:when>
      <xsl:when test="$species!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="species"/>
      </xsl:when>
      <xsl:when test="normalize-space(tribe/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="tribe"/>
      </xsl:when>
      <xsl:when test="normalize-space(subfamily/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="subfamily"/>
      </xsl:when>
      <xsl:when test="normalize-space(family/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="family"/>
      </xsl:when>
      <xsl:when test="normalize-space(superfamily/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="superfamily"/>
      </xsl:when>
      <xsl:when test="normalize-space(infraorder/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="infraorder"/>
      </xsl:when>
      <xsl:when test="normalize-space(suborder/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="suborder"/>
      </xsl:when>
      <xsl:when test="normalize-space(order/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="order"/>
      </xsl:when>
      <xsl:when test="normalize-space(superorder/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="superorder"/>
      </xsl:when>
      <xsl:when test="normalize-space(subclass/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="subclass"/>
      </xsl:when>
      <xsl:when test="normalize-space(class/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="class"/>
      </xsl:when>
      <xsl:when test="normalize-space(superclass/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="superclass"/>
      </xsl:when>
      <xsl:when test="normalize-space(subphylum/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="subphylum"/>
      </xsl:when>
      <xsl:when test="normalize-space(phylum/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="phylum"/>
      </xsl:when>
      <xsl:when test="normalize-space(subkingdom/value)!=''">
        <xsl:apply-templates mode="checklist-taxon-name-part" select="subkingdom"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="checklist-taxon-name-part" select="kingdom"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>