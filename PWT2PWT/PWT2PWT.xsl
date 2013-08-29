<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:tp="http://www.plazi.org/taxpub">

  <xsl:output method="xml" encoding="UTF-8" />

  <xsl:template match="/document">
    <document>
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:attribute name="journal_id"><xsl:value-of select="@journal_id"/></xsl:attribute>
      <xsl:apply-templates/>
    </document>
  </xsl:template>
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="span | div | comment-start | comment-end">
    <xsl:apply-templates select="node()"/>
  </xsl:template>
  <xsl:template match="i | em">
    <italic>
      <xsl:apply-templates select="node()"/>
    </italic>
  </xsl:template>
  <xsl:template match="b | strong">
    <bold>
      <xsl:apply-templates select="node()"/>
    </bold>
  </xsl:template>
  <xsl:template match="u">
    <underline>
      <xsl:apply-templates select="node()"/>
    </underline>
  </xsl:template>
  <xsl:template match="a">
    <ext-link>
      <xsl:attribute name="ext-link-type">uri</xsl:attribute>
      <xsl:attribute name="xlink:href">
        <xsl:value-of select="@href"/>
      </xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </ext-link>
  </xsl:template>
  <xsl:template match="kingdom">
    <kingdom>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">1</xsl:attribute>
      <xsl:attribute name="latin">regnum</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </kingdom>
  </xsl:template>
  <xsl:template match="subkingdom">
    <subkingdom>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">2</xsl:attribute>
      <xsl:attribute name="latin">subregnum</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </subkingdom>
  </xsl:template>
  <xsl:template match="phylum">
    <phylum>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">3</xsl:attribute>
      <xsl:attribute name="latin">phylum</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </phylum>
  </xsl:template>
  <xsl:template match="subphylum">
    <subphylum>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">4</xsl:attribute>
      <xsl:attribute name="latin">subphylum</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </subphylum>
  </xsl:template>
  <xsl:template match="superclass">
    <superclass>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">5</xsl:attribute>
      <xsl:attribute name="latin">superclassis</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </superclass>
  </xsl:template>
  <xsl:template match="class">
    <class>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">6</xsl:attribute>
      <xsl:attribute name="latin">classis</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </class>
  </xsl:template>
  <xsl:template match="subclass">
    <subclass>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">7</xsl:attribute>
      <xsl:attribute name="latin">subclassis</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </subclass>
  </xsl:template>
  <xsl:template match="superorder">
    <superorder>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">8</xsl:attribute>
      <xsl:attribute name="latin">superordo</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </superorder>
  </xsl:template>
  <xsl:template match="order">
    <order>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">9</xsl:attribute>
      <xsl:attribute name="latin">ordo</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </order>
  </xsl:template>
  <xsl:template match="suborder">
    <suborder>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">10</xsl:attribute>
      <xsl:attribute name="latin">subordo</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </suborder>
  </xsl:template>
  <xsl:template match="infraorder">
    <infraorder>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">11</xsl:attribute>
      <xsl:attribute name="latin">infraorder</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </infraorder>
  </xsl:template>
  <xsl:template match="superfamily">
    <superfamily>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">12</xsl:attribute>
      <xsl:attribute name="latin">superfamilia</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </superfamily>
  </xsl:template>
  <xsl:template match="family">
    <family>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">13</xsl:attribute>
      <xsl:attribute name="latin">familia</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </family>
  </xsl:template>
  <xsl:template match="subfamily">
    <subfamily>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">14</xsl:attribute>
      <xsl:attribute name="latin">subfamilia</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </subfamily>
  </xsl:template>
  <xsl:template match="tribe">
    <tribe>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">15</xsl:attribute>
      <xsl:attribute name="latin">tribus</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </tribe>
  </xsl:template>
  <xsl:template match="subtribe">
    <subtribe>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">16</xsl:attribute>
      <xsl:attribute name="latin">subtribus</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </subtribe>
  </xsl:template>
  <xsl:template match="genus">
    <genus>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">17</xsl:attribute>
      <xsl:attribute name="latin">genus</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </genus>
  </xsl:template>
  <xsl:template match="subgenus">
    <subgenus>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">18</xsl:attribute>
      <xsl:attribute name="latin">subgenus</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </subgenus>
  </xsl:template>
  <xsl:template match="species">
    <species>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">19</xsl:attribute>
      <xsl:attribute name="latin">species</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </species>
  </xsl:template>
  <xsl:template match="subspecies">
    <subspecies>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">20</xsl:attribute>
      <xsl:attribute name="latin">subspecies</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </subspecies>
  </xsl:template>
  <xsl:template match="variety">
    <variety>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">21</xsl:attribute>
      <xsl:attribute name="latin">varietas</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </variety>
  </xsl:template>
  <xsl:template match="form">
    <form>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="field_name">
        <xsl:value-of select="@field_name"/>
      </xsl:attribute>
      <xsl:attribute name="rank_id">22</xsl:attribute>
      <xsl:attribute name="latin">forma</xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </form>
  </xsl:template>
  <xsl:template match="tn">
    <tp:taxon-name>
      <xsl:for-each select="node()">
        <xsl:choose>
          <xsl:when test="name()=''">
            <xsl:value-of select="."/>
          </xsl:when>
          <xsl:when test="name()='tn-part'">
            <tp:taxon-name-part>
              <xsl:attribute name="taxon-name-part-type">
                <xsl:value-of select="@type"/>
              </xsl:attribute>
              <xsl:choose>
                <xsl:when test="@full-name!=''">
                  <xsl:value-of select="@full-name"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="node()"/>
                </xsl:otherwise>
              </xsl:choose>
            </tp:taxon-name-part>
          </xsl:when>
          <xsl:otherwise>
            <INVALID-TAG>
              <xsl:copy-of select="."/>
            </INVALID-TAG>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </tp:taxon-name>
  </xsl:template>
  <xsl:template match="references">
    <references>
      <xsl:attribute name="object_id">
        <xsl:value-of select="@object_id"/>
      </xsl:attribute>
      <xsl:attribute name="instance_id">
        <xsl:value-of select="@instance_id"/>
      </xsl:attribute>
      <xsl:attribute name="display_name">
        <xsl:value-of select="@display_name"/>
      </xsl:attribute>
      <xsl:attribute name="pos">
        <xsl:value-of select="@pos"/>
      </xsl:attribute>
      <xsl:for-each select="reference">
        <reference>
          <xsl:attribute name="nlm_id">
            <xsl:value-of select="position()"/>
          </xsl:attribute>
          <xsl:attribute name="object_id">
            <xsl:value-of select="@object_id"/>
          </xsl:attribute>
          <xsl:attribute name="instance_id">
            <xsl:value-of select="@instance_id"/>
          </xsl:attribute>
          <xsl:attribute name="display_name">
            <xsl:value-of select="@display_name"/>
          </xsl:attribute>
          <xsl:attribute name="pos">
            <xsl:value-of select="@pos"/>
          </xsl:attribute>
          <xsl:apply-templates select="node()"/>
        </reference>
      </xsl:for-each>
    </references>
  </xsl:template>
  <xsl:template match="figures">
    <figures>
      <xsl:attribute name="object_id">
        <xsl:value-of select="@object_id"/>
      </xsl:attribute>
      <xsl:attribute name="instance_id">
        <xsl:value-of select="@instance_id"/>
      </xsl:attribute>
      <xsl:attribute name="display_name">
        <xsl:value-of select="@display_name"/>
      </xsl:attribute>
      <xsl:attribute name="pos">
        <xsl:value-of select="@pos"/>
      </xsl:attribute>
      <xsl:for-each select="figure">
        <figure>
          <xsl:attribute name="nlm_id">
            <xsl:value-of select="position()"/>
          </xsl:attribute>
          <xsl:attribute name="object_id">
            <xsl:value-of select="@object_id"/>
          </xsl:attribute>
          <xsl:attribute name="instance_id">
            <xsl:value-of select="@instance_id"/>
          </xsl:attribute>
          <xsl:attribute name="display_name">
            <xsl:value-of select="@display_name"/>
          </xsl:attribute>
          <xsl:attribute name="pos">
            <xsl:value-of select="@pos"/>
          </xsl:attribute>
          <xsl:apply-templates select="node()"/>
        </figure>
      </xsl:for-each>
    </figures>
  </xsl:template>
  <xsl:template match="tables">
    <tables>
      <xsl:attribute name="object_id">
        <xsl:value-of select="@object_id"/>
      </xsl:attribute>
      <xsl:attribute name="instance_id">
        <xsl:value-of select="@instance_id"/>
      </xsl:attribute>
      <xsl:attribute name="display_name">
        <xsl:value-of select="@display_name"/>
      </xsl:attribute>
      <xsl:attribute name="pos">
        <xsl:value-of select="@pos"/>
      </xsl:attribute>
      <xsl:for-each select="table">
        <table>
          <xsl:attribute name="nlm_id">
            <xsl:value-of select="position()"/>
          </xsl:attribute>
          <xsl:attribute name="object_id">
            <xsl:value-of select="@object_id"/>
          </xsl:attribute>
          <xsl:attribute name="instance_id">
            <xsl:value-of select="@instance_id"/>
          </xsl:attribute>
          <xsl:attribute name="display_name">
            <xsl:value-of select="@display_name"/>
          </xsl:attribute>
          <xsl:attribute name="pos">
            <xsl:value-of select="@pos"/>
          </xsl:attribute>
          <xsl:apply-templates select="node()"/>
        </table>
      </xsl:for-each>
    </tables>
  </xsl:template>
  <xsl:template match="supplementary_files">
    <supplementary_files>
      <xsl:attribute name="object_id">  
        <xsl:value-of select="@object_id"/>
      </xsl:attribute>
      <xsl:attribute name="instance_id">
        <xsl:value-of select="@instance_id"/>
      </xsl:attribute>
      <xsl:attribute name="display_name">
        <xsl:value-of select="@display_name"/>
      </xsl:attribute>
      <xsl:attribute name="pos">
        <xsl:value-of select="@pos"/>
      </xsl:attribute>
      <xsl:for-each select="supplementary_file">
        <supplementary_file>
          <xsl:attribute name="nlm_id">
            <xsl:value-of select="position()"/>
          </xsl:attribute>
          <xsl:attribute name="object_id">
            <xsl:value-of select="@object_id"/>
          </xsl:attribute>
          <xsl:attribute name="instance_id">
            <xsl:value-of select="@instance_id"/>
          </xsl:attribute>
          <xsl:attribute name="display_name">
            <xsl:value-of select="@display_name"/>
          </xsl:attribute>
          <xsl:attribute name="pos">
            <xsl:value-of select="@pos"/>
          </xsl:attribute>
          <xsl:apply-templates select="node()"/>
        </supplementary_file>
      </xsl:for-each>
    </supplementary_files>
  </xsl:template>
</xsl:stylesheet>