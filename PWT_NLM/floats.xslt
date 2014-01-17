<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">
  <xsl:param name="figures" select="//node()[@object_id='236']"/>
  <xsl:param name="tables" select="//node()[@object_id='237']"/>
  <xsl:template name="floats">
    <xsl:if test="(normalize-space($figures)!='') or (normalize-space($tables)!='')">
      <floats-group>
        <xsl:call-template name="figures"/>
        <xsl:call-template name="tables"/>
      </floats-group>
    </xsl:if>
  </xsl:template>
  <!--
    FIGURES
  -->
  <xsl:template name="figures">
    <xsl:for-each select="$figures/figure">
      <xsl:variable name="num" select="@nlm_id"/>
      <xsl:variable name="id" select="@instance_id"/>
      <xsl:variable name="type" select="'Figure'"/>
      <xsl:for-each select="node()">
        <xsl:choose>
          <xsl:when test="@object_id='222'"><!-- Image -->
            <fig>
              <xsl:attribute name="id">
                <xsl:text>F</xsl:text>
                <xsl:value-of select="$id"/>
              </xsl:attribute>
              <xsl:attribute name="position">float</xsl:attribute>
              <xsl:attribute name="orientation">portrait</xsl:attribute>
              <label>
                <xsl:value-of select="$type"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$num"/>
                <xsl:text>.</xsl:text>
              </label>
              <xsl:for-each select="fields/node()[@id='482']">
                <caption>
                  <xsl:apply-templates mode="p" select="value"/>
                </caption>
              </xsl:for-each>
              <xsl:for-each select="fields/node()[@id='483']">
                <graphic>
                  <xsl:attribute name="xlink:href">
                  <xsl:text>biodiversity_data_journal-</xsl:text>
      <xsl:value-of select="$article_issue"/>
      <xsl:text>-e</xsl:text>
      <xsl:value-of select="$article_id"/>
      <xsl:text>-g00</xsl:text>
      <xsl:number/>
<!--                     <xsl:text>big_</xsl:text> -->
<!--                     <xsl:value-of select="normalize-space(value)"/> -->
                    <xsl:text>.jpg</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="position">float</xsl:attribute>
                  <xsl:attribute name="orientation">portrait</xsl:attribute>
                  <xsl:attribute name="xlink:type">simple</xsl:attribute>
                </graphic>
              </xsl:for-each>
            </fig>
          </xsl:when>
          <xsl:when test="@object_id='223'"><!-- Video -->
            <fig>
              <xsl:attribute name="id">
                <xsl:text>F</xsl:text>
                <xsl:value-of select="$id"/>
              </xsl:attribute>
              <xsl:attribute name="position">float</xsl:attribute>
              <xsl:attribute name="orientation">portrait</xsl:attribute>
              <label>
                <xsl:value-of select="$type"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$num"/>
                <xsl:text>.</xsl:text>
              </label>
              <xsl:for-each select="fields/node()[@id='482']">
                <caption>
                  <xsl:apply-templates mode="p" select="value"/>
                </caption>
              </xsl:for-each>
              <xsl:for-each select="fields/node()[@id='486']">
                <media>
                  <xsl:attribute name="xlink:href">
                    <xsl:value-of select="normalize-space(value)"/>
                  </xsl:attribute>
                  <xsl:attribute name="position">float</xsl:attribute>
                  <xsl:attribute name="orientation">portrait</xsl:attribute>
                </media>
              </xsl:for-each>
            </fig>
          </xsl:when>
          <xsl:when test="@object_id='224'"><!-- Plates -->
            <fig-group>
              <xsl:attribute name="id">
                <xsl:text>F</xsl:text>
                <xsl:value-of select="$id"/>
              </xsl:attribute>
              <xsl:attribute name="position">float</xsl:attribute>
              <xsl:attribute name="orientation">portrait</xsl:attribute>
              <xsl:for-each select="fields/node()[@id='482']">
                <caption>
                  <xsl:apply-templates mode="p" select="value"/>
                </caption>
              </xsl:for-each>
              <xsl:for-each select="node()[@object_id='235']"><!-- Plate type wrapper -->
                <xsl:for-each select="./*/node()[normalize-space(.)!='']"><!-- Plate part -->
                  <xsl:choose>
                    <xsl:when test="@object_id='225'"><!-- Plate part a -->
                      <xsl:apply-templates mode="plate-part" select=".">
                        <xsl:with-param name="fig_num" select="$num"/>
                        <xsl:with-param name="label" select="'a'"/>
                        <xsl:with-param name="type" select="$type"/>
                        <xsl:with-param name="id" select="@instance_id"/>
                      </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="@object_id='226'"><!-- Plate part b -->
                      <xsl:apply-templates mode="plate-part" select=".">
                        <xsl:with-param name="fig_num" select="$num"/>
                        <xsl:with-param name="label" select="'b'"/>
                        <xsl:with-param name="type" select="$type"/>
                        <xsl:with-param name="id" select="@instance_id"/>
                      </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="@object_id='227'"><!-- Plate part c -->
                      <xsl:apply-templates mode="plate-part" select=".">
                        <xsl:with-param name="fig_num" select="$num"/>
                        <xsl:with-param name="label" select="'c'"/>
                        <xsl:with-param name="type" select="$type"/>
                        <xsl:with-param name="id" select="@instance_id"/>
                      </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="@object_id='228'"><!-- Plate part d -->
                      <xsl:apply-templates mode="plate-part" select=".">
                        <xsl:with-param name="fig_num" select="$num"/>
                        <xsl:with-param name="label" select="'d'"/>
                        <xsl:with-param name="type" select="$type"/>
                        <xsl:with-param name="id" select="@instance_id"/>
                      </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="@object_id='229'"><!-- Plate part e -->
                      <xsl:apply-templates mode="plate-part" select=".">
                        <xsl:with-param name="fig_num" select="$num"/>
                        <xsl:with-param name="label" select="'e'"/>
                        <xsl:with-param name="type" select="$type"/>
                        <xsl:with-param name="id" select="@instance_id"/>
                      </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="@object_id='230'"><!-- Plate part f -->
                      <xsl:apply-templates mode="plate-part" select=".">
                        <xsl:with-param name="fig_num" select="$num"/>
                        <xsl:with-param name="label" select="'f'"/>
                        <xsl:with-param name="type" select="$type"/>
                        <xsl:with-param name="id" select="@instance_id"/>
                      </xsl:apply-templates>
                    </xsl:when>
                  </xsl:choose>
                </xsl:for-each>
              </xsl:for-each>
            </fig-group>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <xsl:template mode="plate-part" match="*">
    <xsl:param name="fig_num" select="'1'"/>
    <xsl:param name="label" select="''"/>
    <xsl:param name="type" select="''"/>
    <xsl:param name="id" select="'1'"/>
    <xsl:variable name="caption" select="fields/node()[@id='487']/value"/>
    <xsl:variable name="url">
      <xsl:text>biodiversity_data_journal-</xsl:text>
      <xsl:value-of select="$article_issue"/>
      <xsl:text>-e</xsl:text>
      <xsl:value-of select="$article_id"/>
      <xsl:text>-g00</xsl:text>
      <xsl:number/>
<!--       <xsl:value-of select="fields/image_id/value"/> -->
      <xsl:text>.jpg</xsl:text>
    </xsl:variable>
    <fig>
      <xsl:attribute name="id">
        <xsl:text>F</xsl:text>
        <xsl:value-of select="$id"/>
      </xsl:attribute>
      <xsl:attribute name="position">float</xsl:attribute>
      <xsl:attribute name="orientation">portrait</xsl:attribute>
      <label>
        <xsl:value-of select="$type"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$fig_num"/>
        <xsl:value-of select="$label"/>
        <xsl:text>.</xsl:text>
      </label>
      <xsl:if test="normalize-space($caption)!=''">
        <caption>
          <xsl:apply-templates mode="p" select="$caption"/>
        </caption>
      </xsl:if>
      <graphic>
        <xsl:attribute name="xlink:href">
          <xsl:value-of select="$url"/>
        </xsl:attribute>
        <xsl:attribute name="position">float</xsl:attribute>
        <xsl:attribute name="orientation">portrait</xsl:attribute>
        <xsl:attribute name="xlink:type">simple</xsl:attribute>
      </graphic>
    </fig>
  </xsl:template>
  <!--
    TABLES
  -->
  <xsl:template name="tables">
    <xsl:for-each select="$tables/table">
      <xsl:variable name="num" select="@nlm_id"/>
      <xsl:variable name="id" select="@instance_id"/>
      <xsl:choose>
        <xsl:when test="count(.//table)=1 and count(.//table/caption[normalize-space(.)!=''])=0">
          <xsl:call-template name="tables-single-table"/>
        </xsl:when>
        <xsl:when test="count(.//table)=0">
          <ERROR>NO TABLES HERE!</ERROR>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="tables-multiple-table"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="tables-multiple-table">
    <xsl:variable name="num" select="@nlm_id"/>
    <xsl:variable name="id" select="@instance_id"/>
    <table-wrap-group>
      <xsl:attribute name="id">
        <xsl:text>T</xsl:text>
        <xsl:value-of select="$id"/>
      </xsl:attribute>
      <xsl:attribute name="position">float</xsl:attribute>
      <xsl:attribute name="orientation">portrait</xsl:attribute>
      <label>Table <xsl:value-of select="$num"/>.</label>
      <xsl:for-each select="fields/node()[@id='482'][normalize-space(.)!='']">
        <caption>
          <xsl:apply-templates mode="p" select="value"/>
        </caption>
      </xsl:for-each>
      <xsl:for-each select="fields/node()[@id='490'][normalize-space(.)!='']"><!-- non-empty table_editor -->
        <xsl:for-each select="value"><!-- Here we can have p* and table* -->
          <xsl:for-each select="table">
            <table-wrap>
              <xsl:attribute name="position">float</xsl:attribute>
              <xsl:attribute name="orientation">portrait</xsl:attribute>
              <xsl:if test="normalize-space(caption)!=''"/>
              <caption>
                <xsl:apply-templates mode="p" select="caption"/>
              </caption>
              <xsl:call-template name="tables-table"/>
              <xsl:if test="count(../node()[name()='p'][normalize-space(.)!=''])">
                <table-wrap-foot>
                  <xsl:for-each select="../node()[name()='p'][normalize-space(.)!='']">
                    <p><xsl:apply-templates mode="format" select="."/></p>
                  </xsl:for-each>
                </table-wrap-foot>
              </xsl:if>
            </table-wrap>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:for-each>
    </table-wrap-group>
  </xsl:template>
  <xsl:template name="tables-single-table">
    <xsl:variable name="num" select="@nlm_id"/>
    <xsl:variable name="id" select="@instance_id"/>
    <table-wrap>
      <xsl:attribute name="id">
        <xsl:text>T</xsl:text>
        <xsl:value-of select="$id"/>
      </xsl:attribute>
      <xsl:attribute name="position">float</xsl:attribute>
      <xsl:attribute name="orientation">portrait</xsl:attribute>
      <label>Table <xsl:value-of select="$num"/>.</label>
      <xsl:for-each select="fields/node()[@id='482'][normalize-space(.)!='']">
        <caption>
          <xsl:apply-templates mode="p" select="value"/>
        </caption>
      </xsl:for-each>
      <xsl:for-each select="fields/node()[@id='490'][normalize-space(.)!='']"><!-- non-empty table_editor -->
        <xsl:for-each select="value">
          <xsl:for-each select="table">
            <xsl:call-template name="tables-table"/>
          </xsl:for-each>
          <xsl:if test="count(node()[name()='p'][normalize-space(.)!=''])">
            <table-wrap-foot>
              <xsl:for-each select="node()[name()='p'][normalize-space(.)!='']">
                <p><xsl:apply-templates mode="format" select="."/></p>
              </xsl:for-each>
            </table-wrap-foot>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </table-wrap>
  </xsl:template>
  <xsl:template name="tables-table">
    <table>
      <xsl:if test="normalize-space(@border)">
        <xsl:attribute name="border">
          <xsl:value-of select="@border"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="normalize-space(@cellpadding)">
        <xsl:attribute name="cellpadding">
          <xsl:value-of select="@cellpadding"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="normalize-space(@cellspacing)">
        <xsl:attribute name="cellspacing">
          <xsl:value-of select="@cellspacing"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="normalize-space(@style)">
        <xsl:attribute name="style">
          <xsl:value-of select="@style"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="normalize-space(@summary)">
        <xsl:attribute name="summary">
          <xsl:value-of select="@summary"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates mode="tables-table-elements" select="node()"/>
    </table>
  </xsl:template>
  <xsl:template mode="tables-table-elements" match="@*|node()"/>
  <xsl:template mode="tables-table-elements" match="thead | tbody">
    <xsl:if test="normalize-space(.)!=''">
      <xsl:element name="{name()}">
        <xsl:apply-templates mode="tables-table-elements" select="node()"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <xsl:template mode="tables-table-elements" match="thead/tr | tbody/tr | tfoot/tr">
    <xsl:if test="normalize-space(.)!=''">
      <tr>
        <xsl:apply-templates mode="tables-table-elements" select="node()"/>
      </tr>
    </xsl:if>
  </xsl:template>
  <xsl:template mode="tables-table-elements" match="tr">
    <xsl:if test="normalize-space(.)!=''">
      <tr>
        <xsl:apply-templates mode="tables-table-elements" select="node()"/>
      </tr>
    </xsl:if>
  </xsl:template>
  <xsl:template mode="tables-table-elements" match="th | td">
    <xsl:element name="{name()}">
      <xsl:attribute name="rowspan">
        <xsl:choose>
          <xsl:when test="normalize-space(@rowspan)=''">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@rowspan"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="colspan">
        <xsl:choose>
          <xsl:when test="normalize-space(@colspan)=''">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@colspan"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:if test="normalize-space(@align)!=''">
        <xsl:attribute name="align">
          <xsl:value-of select="@align"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="normalize-space(@style)!=''">
        <xsl:attribute name="style">
          <xsl:value-of select="@style"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates mode="td-format" select="."/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>