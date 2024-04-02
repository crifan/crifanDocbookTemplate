<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY % common.entities SYSTEM "../common/entities.ent">
%common.entities;
]>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:d="http://docbook.org/ns/docbook"
xmlns:exsl="http://exslt.org/common"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:stbl="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Table"
  xmlns:xtbl="xalan://com.nwalsh.xalan.Table"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:ptbl="http://nwalsh.com/xslt/ext/xsltproc/python/Table"
  exclude-result-prefixes="exsl stbl xtbl lxslt ptbl d"
  version="1.0">

<!-- $Id: html5-element-mods.xsl,v 1.2 2011-09-18 17:47:28 bobs Exp $ -->

<!--==============================================================-->
<!--  DocBook XSL Parameter settings                              -->
<!--==============================================================-->
<!-- Set these to blank so can output special HTML5 empty DOCTYPE -->
<xsl:param name="chunker.output.doctype-system" select="''"/>
<xsl:param name="chunker.output.doctype-public" select="''"/>

<xsl:param name="table.borders.with.css" select="1"/>
<xsl:param name="html.ext">.xhtml</xsl:param>
<xsl:param name="toc.list.type">ul</xsl:param>
<xsl:param name="css.decoration" select="1"/>
<xsl:param name="make.clean.html" select="1"/>
<xsl:param name="generate.id.attributes" select="1"/>

<!--==============================================================-->
<!--  Customized templates                                        -->
<!--==============================================================-->

<!-- HTML5: Replace HTML acronum with abbr for HTML 5 -->
<xsl:template match="d:acronym">
  <xsl:call-template name="inline.charseq">
    <xsl:with-param name="wrapper-name">abbr</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- HTML5: replace border="0" with border="" -->
<!-- HTML5: No @summary allowed -->
<!-- HTML5: replace many table atts with CSS styles -->
<xsl:template match="d:tgroup" name="tgroup">
  <xsl:if test="not(@cols) or @cols = '' or string(number(@cols)) = 'NaN'">
    <xsl:message terminate="yes">
      <xsl:text>Error: CALS tables must specify the number of columns.</xsl:text>
    </xsl:message>
  </xsl:if>

  <xsl:variable name="summary">
    <xsl:call-template name="pi.dbhtml_table-summary"/>
  </xsl:variable>

  <xsl:variable name="cellspacing">
    <xsl:call-template name="pi.dbhtml_cellspacing"/>
  </xsl:variable>

  <xsl:variable name="cellpadding">
    <xsl:call-template name="pi.dbhtml_cellpadding"/>
  </xsl:variable>

  <!-- First generate colgroup with attributes -->
  <xsl:variable name="colgroup.with.attributes">
    <colgroup>
      <xsl:call-template name="generate.colgroup">
        <xsl:with-param name="cols" select="@cols"/>
      </xsl:call-template>
    </colgroup>
  </xsl:variable>

  <!-- then modify colgroup attributes with extension -->
  <xsl:variable name="colgroup.with.extension">
    <xsl:choose>
      <xsl:when test="$use.extensions != 0
                      and $tablecolumns.extension != 0">
        <xsl:choose>
          <xsl:when test="function-available('stbl:adjustColumnWidths')">
            <xsl:copy-of select="stbl:adjustColumnWidths($colgroup.with.attributes)"/>
          </xsl:when>
          <xsl:when test="function-available('xtbl:adjustColumnWidths')">
            <xsl:copy-of select="xtbl:adjustColumnWidths($colgroup.with.attributes)"/>
          </xsl:when>
          <xsl:when test="function-available('ptbl:adjustColumnWidths')">
            <xsl:copy-of select="ptbl:adjustColumnWidths($colgroup.with.attributes)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:message terminate="yes">
              <xsl:text>No adjustColumnWidths function available.</xsl:text>
            </xsl:message>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$colgroup.with.attributes"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Now convert to @style -->
  <xsl:variable name="colgroup">
    <xsl:call-template name="colgroup.with.style">
      <xsl:with-param name="colgroup" select="$colgroup.with.extension"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="explicit.table.width">
    <xsl:call-template name="pi.dbhtml_table-width">
      <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="table.width.candidate">
    <xsl:choose>
      <xsl:when test="$explicit.table.width != ''">
        <xsl:value-of select="$explicit.table.width"/>
      </xsl:when>
      <xsl:when test="$default.table.width = ''">
        <xsl:text>100%</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$default.table.width"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>


  <xsl:variable name="table.width">
    <xsl:if test="$default.table.width != ''
                  or $explicit.table.width != ''">
      <xsl:choose>
        <xsl:when test="contains($table.width.candidate, '%')">
          <xsl:value-of select="$table.width.candidate"/>
        </xsl:when>
        <xsl:when test="$use.extensions != 0
                        and $tablecolumns.extension != 0">
          <xsl:choose>
            <xsl:when test="function-available('stbl:convertLength')">
              <xsl:value-of select="stbl:convertLength($table.width.candidate)"/>
            </xsl:when>
            <xsl:when test="function-available('xtbl:convertLength')">
              <xsl:value-of select="xtbl:convertLength($table.width.candidate)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:message terminate="yes">
                <xsl:text>No convertLength function available.</xsl:text>
              </xsl:message>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$table.width.candidate"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:variable>

  <!-- assemble a table @style -->
  <xsl:variable name="table.style">

    <xsl:if test="$cellspacing != '' or $html.cellspacing != ''">
      <xsl:text>cellspacing: </xsl:text>
      <xsl:choose>
        <xsl:when test="$cellspacing != ''">
          <xsl:value-of select="$cellspacing"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$html.cellspacing"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>; </xsl:text>
    </xsl:if>

    <xsl:if test="$cellpadding != '' or $html.cellpadding != ''">
      <xsl:text>cellpadding: </xsl:text>
      <xsl:choose>
        <xsl:when test="$cellpadding != ''">
          <xsl:value-of select="$cellpadding"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$html.cellpadding"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>; </xsl:text>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="string-length($table.width) != 0">
        <xsl:text>width: </xsl:text>
        <xsl:value-of select="$table.width"/>
        <xsl:text>; </xsl:text>
      </xsl:when>
      <xsl:when test="../@pgwide=1 or local-name(.) = 'entrytbl'">
        <xsl:text>width: 100%; </xsl:text>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="../@frame='all' or (not(../@frame) and $default.table.frame='all')">
        <xsl:text>border-collapse: collapse; </xsl:text>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'top'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'bottom'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'left'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'right'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="../@frame='topbot' or (not(../@frame) and $default.table.frame='topbot')">
        <xsl:text>border-collapse: collapse;</xsl:text>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'top'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'bottom'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="../@frame='top' or (not(../@frame) and $default.table.frame='top')">
        <xsl:text>border-collapse: collapse;</xsl:text>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'top'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="../@frame='bottom' or (not(../@frame) and $default.table.frame='bottom')">
        <xsl:text>border-collapse: collapse;</xsl:text>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'bottom'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="../@frame='sides' or (not(../@frame) and $default.table.frame='sides')">
        <xsl:text>border-collapse: collapse;</xsl:text>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'left'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'right'"/>
          <xsl:with-param name="style" select="$table.frame.border.style"/>
          <xsl:with-param name="color" select="$table.frame.border.color"/>
          <xsl:with-param name="thickness" select="$table.frame.border.thickness"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="../@frame='none'">
        <xsl:text>border: none;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>border-collapse: collapse;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <table>
    <!-- HTML5: no table summary allowed -->
    <xsl:if test="string-length($table.style) != 0">
      <xsl:attribute name="style">
        <xsl:value-of select="$table.style"/>
      </xsl:attribute>
    </xsl:if>


    <xsl:copy-of select="$colgroup"/>

    <xsl:apply-templates select="d:thead"/>
    <xsl:apply-templates select="d:tfoot"/>
    <xsl:apply-templates select="d:tbody"/>

    <xsl:if test=".//d:footnote|../d:title//d:footnote">
      <tbody class="footnotes">
        <tr>
          <td colspan="{@cols}">
            <xsl:apply-templates select=".//d:footnote|../d:title//d:footnote" mode="table.footnote.mode"/>
          </td>
        </tr>
      </tbody>
    </xsl:if>
  </table>
</xsl:template>

<!-- HTML5: convert col attributes to col CSS styles -->
<xsl:template name="colgroup.with.style">
  <xsl:param name="colgroup"/>

  <xsl:variable name="colgroup.nodeset" select="exsl:node-set($colgroup)"/>
  <xsl:apply-templates select="$colgroup.nodeset" mode="convert.to.style"/>
</xsl:template>

<xsl:template match="d:colgroup" mode="convert.to.style">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates mode="convert.to.style"/>
  </xsl:copy>
</xsl:template>

<!-- HTML5: converts obsolete HTML attributes to CSS styles -->
<xsl:template match="*" mode="convert.to.style">

  <xsl:variable name="style.from.atts">
    <xsl:for-each select="@*">

      <xsl:choose>
        <xsl:when test="local-name() = 'width'">
          <xsl:text>width: </xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>; </xsl:text>
        </xsl:when>

        <xsl:when test="local-name() = 'align'">
          <xsl:text>text-align: </xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>; </xsl:text>
        </xsl:when>

        <xsl:when test="local-name() = 'valign'">
          <xsl:text>vertical-align: </xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>; </xsl:text>
        </xsl:when>

        <xsl:when test="local-name() = 'border'">
          <xsl:text>border: </xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>; </xsl:text>
        </xsl:when>

        <xsl:when test="local-name() = 'cellspacing'">
          <xsl:text>border-spacing: </xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>; </xsl:text>
        </xsl:when>

        <xsl:when test="local-name() = 'cellpadding'">
          <xsl:text>padding: </xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>; </xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:variable>

  <!-- merge existing styles with these new styles -->
  <xsl:variable name="style">
    <xsl:value-of select="concat($style.from.atts, @style)"/>
  </xsl:variable>

  <!-- HTML5: <th> does not support block elements, use <td> -->
  <xsl:variable name="element.name">
    <xsl:choose>
      <xsl:when test="local-name(.) = 'th'">td</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="local-name(.)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$element.name}">
    <xsl:if test="string-length($style) != 0">
      <xsl:attribute name="style">
        <xsl:value-of select="$style"/>
      </xsl:attribute>
    </xsl:if>
    <!-- Also skip disallowed summary attributes -->
    <xsl:copy-of select="@*[local-name(.) != 'width' and
                            local-name(.) != 'summary' and
                            local-name(.) != 'border' and
                            local-name(.) != 'cellspacing' and
                            local-name(.) != 'cellpadding' and
                            local-name(.) != 'style' and
                            local-name(.) != 'align' and
                            local-name(.) != 'valign']"/>
    <xsl:apply-templates mode="convert.to.style"/>
  </xsl:element>
</xsl:template>

<!-- HTML5: convert some attributes to CSS style attribute -->
<xsl:template match="d:entry|d:entrytbl">
  <xsl:param name="col">
    <xsl:choose>
      <xsl:when test="@revisionflag">
        <xsl:number from="d:row"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <xsl:param name="spans"/>

  
  <!-- Process with stock template -->
  <xsl:variable name="cell">
    <xsl:call-template name="entry">
      <xsl:with-param name="col" select="$col"/>
      <xsl:with-param name="spans" select="$spans"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="cell.nodes" select="exsl:node-set($cell)"/>

  <xsl:apply-templates select="$cell.nodes" mode="convert.to.style"/>

</xsl:template>

<xsl:template match="d:mediaobject|d:inlinemediaobject">
  <xsl:call-template name="convert.styles"/>
</xsl:template>

<xsl:template match="d:qandaset">
  <xsl:call-template name="convert.styles"/>
</xsl:template>

<xsl:template match="d:calloutlist|d:revhistory|d:footnote|d:figure|d:co">
  <xsl:call-template name="convert.styles"/>
</xsl:template>

<xsl:template match="d:revhistory" mode="titlepage.mode">
  <xsl:call-template name="convert.styles"/>
</xsl:template>

<xsl:template match="d:variablelist">
  <xsl:call-template name="convert.styles"/>
</xsl:template>

<xsl:template match="d:orderedlist[@inheritnum = 'inherit']">
  <xsl:call-template name="convert.styles"/>
</xsl:template>

<xsl:template match="d:simplelist">
  <xsl:call-template name="convert.styles"/>
</xsl:template>

<xsl:template match="d:blockquote">
  <xsl:call-template name="convert.styles"/>
</xsl:template>

<xsl:template name="convert.styles">
  <xsl:param name="content">
   <xsl:apply-imports/>
  </xsl:param>
  <xsl:variable name="nodes" select="exsl:node-set($content)"/>

  <xsl:apply-templates mode="convert.to.style" select="$nodes"/>
</xsl:template>

<!-- Remove table summary and set border="" -->

<xsl:template match="d:segmentedlist" mode="seglist-table">
  <xsl:variable name="table-summary">
    <xsl:call-template name="pi.dbhtml_table-summary"/>
  </xsl:variable>

  <xsl:variable name="list-width">
    <xsl:call-template name="pi.dbhtml_list-width"/>
  </xsl:variable>

  <xsl:apply-templates select="d:title"/>

  <table border="">
    <xsl:if test="$list-width != ''">
      <xsl:attribute name="width">
        <xsl:value-of select="$list-width"/>
      </xsl:attribute>
    </xsl:if>
    <!--
    <xsl:if test="$table-summary != ''">
      <xsl:attribute name="summary">
        <xsl:value-of select="$table-summary"/>
      </xsl:attribute>
    </xsl:if>
    -->
    <thead>
      <tr class="segtitle">
        <xsl:call-template name="tr.attributes">
          <xsl:with-param name="row" select="d:segtitle[1]"/>
          <xsl:with-param name="rownum" select="1"/>
        </xsl:call-template>
        <xsl:apply-templates select="d:segtitle" mode="seglist-table"/>
      </tr>
    </thead>
    <tbody>
      <xsl:apply-templates select="d:seglistitem" mode="seglist-table"/>
    </tbody>
  </table>
</xsl:template>

<xsl:template name="graphical.admonition">
  <xsl:variable name="admon.type">
    <xsl:choose>
      <xsl:when test="local-name(.)='note'">Note</xsl:when>
      <xsl:when test="local-name(.)='warning'">Warning</xsl:when>
      <xsl:when test="local-name(.)='caution'">Caution</xsl:when>
      <xsl:when test="local-name(.)='tip'">Tip</xsl:when>
      <xsl:when test="local-name(.)='important'">Important</xsl:when>
      <xsl:otherwise>Note</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="alt">
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="$admon.type"/>
    </xsl:call-template>
  </xsl:variable>

  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:if test="$admon.style != ''">
      <xsl:attribute name="style">
        <xsl:value-of select="$admon.style"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:variable name="content">
      <table border="">
        <tr>
          <td rowspan="2" align="center" valign="top">
            <xsl:attribute name="width">
              <xsl:apply-templates select="." mode="admon.graphic.width"/>
            </xsl:attribute>
            <img alt="[{$alt}]">
              <xsl:attribute name="src">
                <xsl:call-template name="admon.graphic"/>
              </xsl:attribute>
            </img>
          </td>
          <th align="{$direction.align.start}">
            <xsl:call-template name="anchor"/>
            <xsl:if test="$admon.textlabel != 0 or d:title or d:info/d:title">
              <xsl:apply-templates select="." mode="object.title.markup"/>
            </xsl:if>
          </th>
        </tr>
        <tr>
          <td align="{$direction.align.start}" valign="top">
            <xsl:apply-templates/>
          </td>
        </tr>
      </table>
    </xsl:variable>

    <xsl:variable name="table.nodes" select="exsl:node-set($content)"/>

    <xsl:apply-templates select="$table.nodes" mode="convert.to.style"/>
  </div>
</xsl:template>

<!-- HTML5: needs special doctype -->
<xsl:template name="user.preroot">
  <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
</xsl:template>

<!-- HTML5: @type not permitted on lists -->
<xsl:template match="d:itemizedlist">
  <!-- Handle spacing="compact" as multiple class attribute instead
       of the deprecated HTML compact attribute -->
  <xsl:variable name="default.class">
    <xsl:value-of select="local-name()"/>
    <xsl:if test="@spacing = 'compact'">
      <xsl:text> compact</xsl:text>
    </xsl:if>
  </xsl:variable>
  
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="id.attribute"/>
    <xsl:call-template name="anchor"/>
    <xsl:if test="d:title">
      <xsl:call-template name="formal.object.heading"/>
    </xsl:if>

    <xsl:variable name="style.value">
      <xsl:variable name="type">
        <xsl:call-template name="list.itemsymbol"/>
      </xsl:variable>

      <xsl:text>list-style-type: </xsl:text>
      <xsl:value-of select="$type"/>
      <xsl:text>; </xsl:text>

    </xsl:variable>

    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates 
        select="*[not(self::d:listitem
                  or self::d:title
                  or self::d:titleabbrev)]
                |comment()[not(preceding-sibling::d:listitem)]
                |processing-instruction()[not(preceding-sibling::d:listitem)]"/>

    <ul>
      <xsl:call-template name="generate.class.attribute">
        <xsl:with-param name="class" select="$default.class"/>
      </xsl:call-template>

      <xsl:apply-templates 
            select="d:listitem
                    |comment()[preceding-sibling::d:listitem]
                    |processing-instruction()[preceding-sibling::d:listitem]"/>
    </ul>
  </div>
</xsl:template>

<xsl:template name="process.footnotes">
  <xsl:variable name="footnotes" select=".//d:footnote"/>
  <xsl:variable name="table.footnotes"
                select=".//d:table//d:footnote | .//d:informaltable//d:footnote"/>

  <!-- Only bother to do this if there's at least one non-table footnote -->
  <xsl:if test="count($footnotes)>count($table.footnotes)">
    <div class="footnotes">
      <xsl:call-template name="footnotes.attributes"/>
      <br/>
      <hr style="width: 100; text-align: {$direction.align.start};"/>
      <xsl:apply-templates select="$footnotes" mode="process.footnote.mode"/>
    </div>
  </xsl:if>

  <xsl:if test="$annotation.support != 0 and //d:annotation">
    <div class="annotation-list">
      <div class="annotation-nocss">
	<p>The following annotations are from this essay. You are seeing
	them here because your browser doesn’t support the user-interface
	techniques used to make them appear as ‘popups’ on modern browsers.</p>
      </div>

      <xsl:apply-templates select="//d:annotation"
			   mode="annotation-popup"/>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="footnotes.attributes">
</xsl:template>

<!-- HTML5: ouput section element for chapter -->
<xsl:template match="d:chapter">
  <xsl:call-template name="id.warning"/>

  <section>
    <xsl:call-template name="common.html.attributes">
      <xsl:with-param name="inherit" select="1"/>
    </xsl:call-template>
    <xsl:call-template name="id.attribute">
      <xsl:with-param name="conditional" select="0"/>
    </xsl:call-template>

    <xsl:call-template name="component.separator"/>
    <xsl:call-template name="chapter.titlepage"/>

    <xsl:variable name="toc.params">
      <xsl:call-template name="find.path.params">
        <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="contains($toc.params, 'toc')">
      <xsl:call-template name="component.toc">
        <xsl:with-param name="toc.title.p" select="contains($toc.params, 'title')"/>
      </xsl:call-template>
      <xsl:call-template name="component.toc.separator"/>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </section>
</xsl:template>

<!-- HTML5: ouput section element for appendix -->
<xsl:template match="d:appendix">

  <xsl:variable name="ischunk">
    <xsl:call-template name="chunk"/>
  </xsl:variable>

  <xsl:call-template name="id.warning"/>

  <section>
    <xsl:call-template name="common.html.attributes">
      <xsl:with-param name="inherit" select="1"/>
    </xsl:call-template>
    <xsl:if test="$generate.id.attributes != 0">
      <xsl:attribute name="id">
        <xsl:call-template name="object.id"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="parent::d:article and $ischunk = 0">
        <xsl:call-template name="section.heading">
          <xsl:with-param name="level" select="1"/>
          <xsl:with-param name="title">
            <xsl:apply-templates select="." mode="object.title.markup"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="component.separator"/>
        <xsl:call-template name="appendix.titlepage"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:variable name="toc.params">
      <xsl:call-template name="find.path.params">
        <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="contains($toc.params, 'toc')">
      <xsl:call-template name="component.toc">
        <xsl:with-param name="toc.title.p" select="contains($toc.params, 'title')"/>
      </xsl:call-template>
      <xsl:call-template name="component.toc.separator"/>
    </xsl:if>

    <xsl:apply-templates/>

    <xsl:if test="not(parent::d:article) or $ischunk != 0">
      <xsl:call-template name="process.footnotes"/>
    </xsl:if>
  </section>
</xsl:template>

<!-- HTML5: ouput section element for section -->
<xsl:template match="d:section">
  <xsl:variable name="depth" select="count(ancestor::d:section)+1"/>

  <xsl:call-template name="id.warning"/>

  <section>
    <xsl:call-template name="common.html.attributes">
      <xsl:with-param name="inherit" select="1"/>
    </xsl:call-template>
    <xsl:call-template name="id.attribute">
      <xsl:with-param name="conditional" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="section.titlepage"/>

    <xsl:variable name="toc.params">
      <xsl:call-template name="find.path.params">
        <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="contains($toc.params, 'toc')                   and $depth &lt;= $generate.section.toc.level">
      <xsl:call-template name="section.toc">
        <xsl:with-param name="toc.title.p" select="contains($toc.params, 'title')"/>
      </xsl:call-template>
      <xsl:call-template name="section.toc.separator"/>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:call-template name="process.chunk.footnotes"/>
  </section>
</xsl:template>

<!-- HTML5: link rel="home" is not permitted -->
<!-- Add support for attributes on <html> element  -->
<xsl:template match="*" mode="process.root">
  <xsl:variable name="doc" select="self::*"/>

  <xsl:call-template name="user.preroot"/>
  <xsl:call-template name="root.messages"/>

  <html>
    <xsl:call-template name="root.attributes"/>
    <head>
      <xsl:call-template name="system.head.content">
        <xsl:with-param name="node" select="$doc"/>
      </xsl:call-template>
      <xsl:call-template name="head.content">
        <xsl:with-param name="node" select="$doc"/>
      </xsl:call-template>
      <xsl:call-template name="user.head.content">
        <xsl:with-param name="node" select="$doc"/>
      </xsl:call-template>
    </head>
    <body>
      <xsl:call-template name="body.attributes"/>
      <xsl:call-template name="user.header.content">
        <xsl:with-param name="node" select="$doc"/>
      </xsl:call-template>
      <xsl:apply-templates select="."/>
      <xsl:call-template name="user.footer.content">
        <xsl:with-param name="node" select="$doc"/>
      </xsl:call-template>
    </body>
  </html>
  <xsl:value-of select="$html.append"/>
  
  <!-- Generate any css files only once, not once per chunk -->
  <xsl:call-template name="generate.css.files"/>
</xsl:template>

<xsl:template name="root.attributes">
</xsl:template>

<!-- HTML5: Put glossary in <section> element -->
<xsl:template match="d:glossary">
  
  <xsl:variable name="language">
    <xsl:call-template name="l10n.language"/>
  </xsl:variable>
  
  <xsl:variable name="lowercase">
    <xsl:call-template name="gentext">
      <xsl:with-param name="key">normalize.sort.input</xsl:with-param>
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:variable name="uppercase">
    <xsl:call-template name="gentext">
      <xsl:with-param name="key">normalize.sort.output</xsl:with-param>
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:call-template name="id.warning"/>

  <section>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:if test="$generate.id.attributes != 0">
      <xsl:attribute name="id">
        <xsl:call-template name="object.id"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:call-template name="glossary.titlepage"/>

    <xsl:choose>
      <xsl:when test="d:glossdiv">
        <xsl:apply-templates select="(d:glossdiv[1]/preceding-sibling::*)"/>
      </xsl:when>
      <xsl:when test="d:glossentry">
        <xsl:apply-templates select="(d:glossentry[1]/preceding-sibling::*)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="d:glossdiv">
        <xsl:apply-templates select="d:glossdiv"/>
      </xsl:when>
      <xsl:when test="d:glossentry">
        <dl>
          <xsl:choose>
            <xsl:when test="$glossary.sort != 0">
              <xsl:apply-templates select="d:glossentry">
				<xsl:sort lang="{$language}" select="normalize-space(translate(concat(@sortas, d:glossterm[not(parent::d:glossentry/@sortas) or parent::d:glossentry/@sortas = '']), 'Aa&#192;&#224;&#193;&#225;&#194;&#226;&#195;&#227;&#196;&#228;&#197;&#229;&#256;&#257;&#258;&#259;&#260;&#261;&#461;&#462;&#478;&#479;&#480;&#481;&#506;&#507;&#512;&#513;&#514;&#515;&#550;&#551;&#7680;&#7681;&#7834;&#7840;&#7841;&#7842;&#7843;&#7844;&#7845;&#7846;&#7847;&#7848;&#7849;&#7850;&#7851;&#7852;&#7853;&#7854;&#7855;&#7856;&#7857;&#7858;&#7859;&#7860;&#7861;&#7862;&#7863;Bb&#384;&#385;&#595;&#386;&#387;&#7682;&#7683;&#7684;&#7685;&#7686;&#7687;Cc&#199;&#231;&#262;&#263;&#264;&#265;&#266;&#267;&#268;&#269;&#391;&#392;&#597;&#7688;&#7689;Dd&#270;&#271;&#272;&#273;&#394;&#599;&#395;&#396;&#453;&#498;&#545;&#598;&#7690;&#7691;&#7692;&#7693;&#7694;&#7695;&#7696;&#7697;&#7698;&#7699;Ee&#200;&#232;&#201;&#233;&#202;&#234;&#203;&#235;&#274;&#275;&#276;&#277;&#278;&#279;&#280;&#281;&#282;&#283;&#516;&#517;&#518;&#519;&#552;&#553;&#7700;&#7701;&#7702;&#7703;&#7704;&#7705;&#7706;&#7707;&#7708;&#7709;&#7864;&#7865;&#7866;&#7867;&#7868;&#7869;&#7870;&#7871;&#7872;&#7873;&#7874;&#7875;&#7876;&#7877;&#7878;&#7879;Ff&#401;&#402;&#7710;&#7711;Gg&#284;&#285;&#286;&#287;&#288;&#289;&#290;&#291;&#403;&#608;&#484;&#485;&#486;&#487;&#500;&#501;&#7712;&#7713;Hh&#292;&#293;&#294;&#295;&#542;&#543;&#614;&#7714;&#7715;&#7716;&#7717;&#7718;&#7719;&#7720;&#7721;&#7722;&#7723;&#7830;Ii&#204;&#236;&#205;&#237;&#206;&#238;&#207;&#239;&#296;&#297;&#298;&#299;&#300;&#301;&#302;&#303;&#304;&#407;&#616;&#463;&#464;&#520;&#521;&#522;&#523;&#7724;&#7725;&#7726;&#7727;&#7880;&#7881;&#7882;&#7883;Jj&#308;&#309;&#496;&#669;Kk&#310;&#311;&#408;&#409;&#488;&#489;&#7728;&#7729;&#7730;&#7731;&#7732;&#7733;Ll&#313;&#314;&#315;&#316;&#317;&#318;&#319;&#320;&#321;&#322;&#410;&#456;&#564;&#619;&#620;&#621;&#7734;&#7735;&#7736;&#7737;&#7738;&#7739;&#7740;&#7741;Mm&#625;&#7742;&#7743;&#7744;&#7745;&#7746;&#7747;Nn&#209;&#241;&#323;&#324;&#325;&#326;&#327;&#328;&#413;&#626;&#414;&#544;&#459;&#504;&#505;&#565;&#627;&#7748;&#7749;&#7750;&#7751;&#7752;&#7753;&#7754;&#7755;Oo&#210;&#242;&#211;&#243;&#212;&#244;&#213;&#245;&#214;&#246;&#216;&#248;&#332;&#333;&#334;&#335;&#336;&#337;&#415;&#416;&#417;&#465;&#466;&#490;&#491;&#492;&#493;&#510;&#511;&#524;&#525;&#526;&#527;&#554;&#555;&#556;&#557;&#558;&#559;&#560;&#561;&#7756;&#7757;&#7758;&#7759;&#7760;&#7761;&#7762;&#7763;&#7884;&#7885;&#7886;&#7887;&#7888;&#7889;&#7890;&#7891;&#7892;&#7893;&#7894;&#7895;&#7896;&#7897;&#7898;&#7899;&#7900;&#7901;&#7902;&#7903;&#7904;&#7905;&#7906;&#7907;Pp&#420;&#421;&#7764;&#7765;&#7766;&#7767;Qq&#672;Rr&#340;&#341;&#342;&#343;&#344;&#345;&#528;&#529;&#530;&#531;&#636;&#637;&#638;&#7768;&#7769;&#7770;&#7771;&#7772;&#7773;&#7774;&#7775;Ss&#346;&#347;&#348;&#349;&#350;&#351;&#352;&#353;&#536;&#537;&#642;&#7776;&#7777;&#7778;&#7779;&#7780;&#7781;&#7782;&#7783;&#7784;&#7785;Tt&#354;&#355;&#356;&#357;&#358;&#359;&#427;&#428;&#429;&#430;&#648;&#538;&#539;&#566;&#7786;&#7787;&#7788;&#7789;&#7790;&#7791;&#7792;&#7793;&#7831;Uu&#217;&#249;&#218;&#250;&#219;&#251;&#220;&#252;&#360;&#361;&#362;&#363;&#364;&#365;&#366;&#367;&#368;&#369;&#370;&#371;&#431;&#432;&#467;&#468;&#469;&#470;&#471;&#472;&#473;&#474;&#475;&#476;&#532;&#533;&#534;&#535;&#7794;&#7795;&#7796;&#7797;&#7798;&#7799;&#7800;&#7801;&#7802;&#7803;&#7908;&#7909;&#7910;&#7911;&#7912;&#7913;&#7914;&#7915;&#7916;&#7917;&#7918;&#7919;&#7920;&#7921;Vv&#434;&#651;&#7804;&#7805;&#7806;&#7807;Ww&#372;&#373;&#7808;&#7809;&#7810;&#7811;&#7812;&#7813;&#7814;&#7815;&#7816;&#7817;&#7832;Xx&#7818;&#7819;&#7820;&#7821;Yy&#221;&#253;&#255;&#376;&#374;&#375;&#435;&#436;&#562;&#563;&#7822;&#7823;&#7833;&#7922;&#7923;&#7924;&#7925;&#7926;&#7927;&#7928;&#7929;Zz&#377;&#378;&#379;&#380;&#381;&#382;&#437;&#438;&#548;&#549;&#656;&#657;&#7824;&#7825;&#7826;&#7827;&#7828;&#7829;&#7829;', 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBCCCCCCCCCCCCCCCCCDDDDDDDDDDDDDDDDDDDDDDDDEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEFFFFFFGGGGGGGGGGGGGGGGGGGGHHHHHHHHHHHHHHHHHHHHIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIJJJJJJKKKKKKKKKKKKKKLLLLLLLLLLLLLLLLLLLLLLLLLLMMMMMMMMMNNNNNNNNNNNNNNNNNNNNNNNNNNNOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPQQQRRRRRRRRRRRRRRRRRRRRRRRSSSSSSSSSSSSSSSSSSSSSSSTTTTTTTTTTTTTTTTTTTTTTTTTUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUVVVVVVVVWWWWWWWWWWWWWWWXXXXXXYYYYYYYYYYYYYYYYYYYYYYYZZZZZZZZZZZZZZZZZZZZZ'))"/>
              </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="d:glossentry"/>
            </xsl:otherwise>
          </xsl:choose>
        </dl>
      </xsl:when>
      <xsl:otherwise>
        <!-- empty glossary -->
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="not(parent::d:article)">
      <xsl:call-template name="process.footnotes"/>
    </xsl:if>
  </section>
</xsl:template>

<!-- HTML5: Put glossary in <section> element -->
<xsl:template match="d:preface">
  <xsl:call-template name="id.warning"/>

  <section>
    <xsl:call-template name="common.html.attributes">
      <xsl:with-param name="inherit" select="1"/>
    </xsl:call-template>
    <xsl:if test="$generate.id.attributes != 0">
      <xsl:attribute name="id">
        <xsl:call-template name="object.id"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:call-template name="component.separator"/>
    <xsl:call-template name="preface.titlepage"/>

    <xsl:variable name="toc.params">
      <xsl:call-template name="find.path.params">
        <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="contains($toc.params, 'toc')">
      <xsl:call-template name="component.toc">
        <xsl:with-param name="toc.title.p" select="contains($toc.params, 'title')"/>
      </xsl:call-template>
      <xsl:call-template name="component.toc.separator"/>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </section>
</xsl:template>

<!-- HTML5: uses <ul> instead of <dl> for TOC -->
<xsl:template match="d:question" mode="qandatoc.mode">
  <xsl:variable name="firstch">
    <!-- Use a titleabbrev or title if available -->
    <xsl:choose>
      <xsl:when test="../d:blockinfo/d:titleabbrev">
        <xsl:apply-templates select="../d:blockinfo/d:titleabbrev[1]/node()"/>
      </xsl:when>
      <xsl:when test="../d:blockinfo/d:title">
        <xsl:apply-templates select="../d:blockinfo/d:title[1]/node()"/>
      </xsl:when>
      <xsl:when test="../d:info/d:titleabbrev">
        <xsl:apply-templates select="../d:info/d:titleabbrev[1]/node()"/>
      </xsl:when>
      <xsl:when test="../d:titleabbrev">
        <xsl:apply-templates select="../d:titleabbrev[1]/node()"/>
      </xsl:when>
      <xsl:when test="../d:info/d:title">
        <xsl:apply-templates select="../d:info/d:title[1]/node()"/>
      </xsl:when>
      <xsl:when test="../d:title">
        <xsl:apply-templates select="../d:title[1]/node()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="(*[local-name(.)!='label'])[1]/node()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="deflabel">
    <xsl:choose>
      <xsl:when test="ancestor-or-self::*[@defaultlabel]">
        <xsl:value-of select="(ancestor-or-self::*[@defaultlabel])[last()]
                              /@defaultlabel"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$qanda.defaultlabel"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <li>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="object" select=".."/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="label.markup"/>
      <xsl:if test="contains($deflabel,'number') and not(d:label)">
        <xsl:apply-templates select="." mode="intralabel.punctuation"/>
      </xsl:if>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$firstch"/>
    </a>
    <!-- * include nested qandaset/qandaentry in TOC if user wants it -->

    <xsl:if test="not($qanda.nested.in.toc = 0)">
      <xsl:apply-templates select="following-sibling::d:answer" mode="qandatoc.mode"/>
    </xsl:if>
  </li>
</xsl:template>

<xsl:template match="d:answer" mode="qandatoc.mode">
  <xsl:if test="descendant::d:question">
    <xsl:call-template name="process.qanda.toc"/>
  </xsl:if>
</xsl:template>

<!-- html5 uses <ul> instead of <dl> for toc -->
<xsl:template name="process.qanda.toc">
  <ul>
    <xsl:apply-templates select="d:qandadiv" mode="qandatoc.mode"/>
    <xsl:apply-templates select="d:qandaset|d:qandaentry" mode="qandatoc.mode"/>
  </ul>
</xsl:template>

<xsl:template match="d:qandadiv" mode="qandatoc.mode">
  <!--
  <dt><xsl:apply-templates select="d:title" mode="qandatoc.mode"/></dt>
  <dd><xsl:call-template name="process.qanda.toc"/></dd>
  -->
  <li>
    <xsl:apply-templates select="d:title" mode="qandatoc.mode"/>
    <xsl:call-template name="process.qanda.toc"/>
  </li>
</xsl:template>

<!-- HTML5: each dt must have a dd -->
<xsl:template match="d:indexterm" mode="index-primary">
  <xsl:param name="scope" select="."/>
  <xsl:param name="role" select="''"/>
  <xsl:param name="type" select="''"/>

  <xsl:variable name="key" select="&primary;"/>
  <xsl:variable name="refs" select="key('primary', $key)[&scope;]"/>
  <dt>
    <xsl:for-each select="$refs/d:primary">
      <xsl:if test="@id or @xml:id">
        <a name="{(@id|@xml:id)[1]}"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:value-of select="d:primary"/>
    <xsl:choose>
      <xsl:when test="$index.links.to.section = 1">
        <xsl:for-each select="$refs[generate-id() = generate-id(key('primary-section', concat($key, &sep;, &section.id;))[&scope;][1])]">
          <xsl:apply-templates select="." mode="reference">
            <xsl:with-param name="position" select="position()"/>
            <xsl:with-param name="scope" select="$scope"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="type" select="$type"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="$refs[not(d:see) 
                              and not(d:secondary)][&scope;]">
          <xsl:apply-templates select="." mode="reference">
            <xsl:with-param name="position" select="position()"/>
            <xsl:with-param name="scope" select="$scope"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="type" select="$type"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="$refs[not(d:secondary)]/*[self::d:see]">
      <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see', concat(&primary;, &sep;, &sep;, &sep;, d:see))[&scope;][1])]"
                           mode="index-see">
        <xsl:with-param name="position" select="position()"/>
        <xsl:with-param name="scope" select="$scope"/>
        <xsl:with-param name="role" select="$role"/>
        <xsl:with-param name="type" select="$type"/>
        <xsl:sort select="translate(d:see, &lowercase;, &uppercase;)"/>
      </xsl:apply-templates>
    </xsl:if>
  </dt>
  <dd>
    <xsl:if test="$refs/d:secondary or $refs[not(d:secondary)]/*[self::d:seealso]">
      <dl>
        <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see-also', concat(&primary;, &sep;, &sep;, &sep;, d:seealso))[&scope;][1])]"
                             mode="index-seealso">
          <xsl:with-param name="position" select="position()"/>
          <xsl:with-param name="scope" select="$scope"/>
          <xsl:with-param name="role" select="$role"/>
          <xsl:with-param name="type" select="$type"/>
          <xsl:sort select="translate(d:seealso, &lowercase;, &uppercase;)"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="$refs[d:secondary and count(.|key('secondary', concat($key, &sep;, &secondary;))[&scope;][1]) = 1]" 
                             mode="index-secondary">
          <xsl:with-param name="position" select="position()"/>
          <xsl:with-param name="scope" select="$scope"/>
          <xsl:with-param name="role" select="$role"/>
          <xsl:with-param name="type" select="$type"/>
          <xsl:sort select="translate(&secondary;, &lowercase;, &uppercase;)"/>
        </xsl:apply-templates>
      </dl>
    </xsl:if>
  </dd>
</xsl:template>

<xsl:template match="d:indexterm" mode="index-secondary">
  <xsl:param name="scope" select="."/>
  <xsl:param name="role" select="''"/>
  <xsl:param name="type" select="''"/>

  <xsl:variable name="key" select="concat(&primary;, &sep;, &secondary;)"/>
  <xsl:variable name="refs" select="key('secondary', $key)[&scope;]"/>
  <dt>
    <xsl:for-each select="$refs/d:secondary">
      <xsl:if test="@id or @xml:id">
        <a name="{(@id|@xml:id)[1]}"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:value-of select="d:secondary"/>
    <xsl:choose>
      <xsl:when test="$index.links.to.section = 1">
        <xsl:for-each select="$refs[generate-id() = generate-id(key('secondary-section', concat($key, &sep;, &section.id;))[&scope;][1])]">
          <xsl:apply-templates select="." mode="reference">
            <xsl:with-param name="position" select="position()"/>
            <xsl:with-param name="scope" select="$scope"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="type" select="$type"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="$refs[not(d:see) 
                                and not(d:tertiary)][&scope;]">
          <xsl:apply-templates select="." mode="reference">
            <xsl:with-param name="position" select="position()"/>
            <xsl:with-param name="scope" select="$scope"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="type" select="$type"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="$refs[not(d:tertiary)]/*[self::d:see]">
      <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see', concat(&primary;, &sep;, &secondary;, &sep;, &sep;, d:see))[&scope;][1])]"
                           mode="index-see">
        <xsl:with-param name="position" select="position()"/>
        <xsl:with-param name="scope" select="$scope"/>
        <xsl:with-param name="role" select="$role"/>
        <xsl:with-param name="type" select="$type"/>
        <xsl:sort select="translate(d:see, &lowercase;, &uppercase;)"/>
      </xsl:apply-templates>
    </xsl:if>
  </dt>
  <dd>
    <xsl:if test="$refs/d:tertiary or $refs[not(d:tertiary)]/*[self::d:seealso]">
      <dl>
        <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see-also', concat(&primary;, &sep;, &secondary;, &sep;, &sep;, d:seealso))[&scope;][1])]"
                             mode="index-seealso">
          <xsl:with-param name="position" select="position()"/>
          <xsl:with-param name="scope" select="$scope"/>
          <xsl:with-param name="role" select="$role"/>
          <xsl:with-param name="type" select="$type"/>
          <xsl:sort select="translate(d:seealso, &lowercase;, &uppercase;)"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="$refs[d:tertiary and count(.|key('tertiary', concat($key, &sep;, &tertiary;))[&scope;][1]) = 1]" 
                             mode="index-tertiary">
          <xsl:with-param name="position" select="position()"/>
          <xsl:with-param name="scope" select="$scope"/>
          <xsl:with-param name="role" select="$role"/>
          <xsl:with-param name="type" select="$type"/>
          <xsl:sort select="translate(&tertiary;, &lowercase;, &uppercase;)"/>
        </xsl:apply-templates>
      </dl>
    </xsl:if>
  </dd>
</xsl:template>

<xsl:template match="d:indexterm" mode="index-tertiary">
  <xsl:param name="scope" select="."/>
  <xsl:param name="role" select="''"/>
  <xsl:param name="type" select="''"/>

  <xsl:variable name="key" select="concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;)"/>
  <xsl:variable name="refs" select="key('tertiary', $key)[&scope;]"/>
  <dt>
    <xsl:for-each select="$refs/d:tertiary">
      <xsl:if test="@id or @xml:id">
        <a name="{(@id|@xml:id)[1]}"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:value-of select="d:tertiary"/>
    <xsl:choose>
      <xsl:when test="$index.links.to.section = 1">
        <xsl:for-each select="$refs[generate-id() = generate-id(key('tertiary-section', concat($key, &sep;, &section.id;))[&scope;][1])]">
          <xsl:apply-templates select="." mode="reference">
            <xsl:with-param name="position" select="position()"/>
            <xsl:with-param name="scope" select="$scope"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="type" select="$type"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="$refs[not(d:see)][&scope;]">
          <xsl:apply-templates select="." mode="reference">
            <xsl:with-param name="position" select="position()"/>
            <xsl:with-param name="scope" select="$scope"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="type" select="$type"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="$refs/d:see">
      <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see', concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;, &sep;, d:see))[&scope;][1])]"
                           mode="index-see">
        <xsl:with-param name="position" select="position()"/>
        <xsl:with-param name="scope" select="$scope"/>
        <xsl:with-param name="role" select="$role"/>
        <xsl:with-param name="type" select="$type"/>
        <xsl:sort select="translate(d:see, &lowercase;, &uppercase;)"/>
      </xsl:apply-templates>
    </xsl:if>
  </dt>
  <dd>
    <xsl:if test="$refs/d:seealso">
      <dl>
        <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see-also', concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;, &sep;, d:seealso))[&scope;][1])]"
                             mode="index-seealso">
          <xsl:with-param name="position" select="position()"/>
          <xsl:with-param name="scope" select="$scope"/>
          <xsl:with-param name="role" select="$role"/>
          <xsl:with-param name="type" select="$type"/>
          <xsl:sort select="translate(d:seealso, &lowercase;, &uppercase;)"/>
        </xsl:apply-templates>
      </dl>
    </xsl:if>
  </dd>
</xsl:template>

<xsl:template match="d:indexterm" mode="index-seealso">
  <xsl:param name="scope" select="."/>
  <xsl:param name="role" select="''"/>
  <xsl:param name="type" select="''"/>

  <xsl:for-each select="d:seealso">
    <xsl:sort select="translate(., &lowercase;, &uppercase;)"/>
    <dt>
    <xsl:text>(</xsl:text>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'seealso'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>)</xsl:text>
    </dt>
    <dd/>
  </xsl:for-each>
</xsl:template>

<xsl:template match="d:audiodata">
  <xsl:variable name="filename">
    <xsl:call-template name="mediaobject.filename">
      <xsl:with-param name="object" select=".."/>
    </xsl:call-template>
  </xsl:variable>

  <audio>
    <xsl:call-template name="common.html.attributes"/>

    <xsl:attribute name="src">
      <xsl:value-of select="$filename"/>
    </xsl:attribute>

    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates select="../d:multimediaparam"/>

    <!-- add any fallback content -->
    <xsl:call-template name="audio.fallback"/>
  </audio>
</xsl:template>

<!-- generate <video> element for html5 -->
<xsl:template match="d:videodata">
  <xsl:variable name="filename">
    <xsl:call-template name="mediaobject.filename">
      <xsl:with-param name="object" select=".."/>
    </xsl:call-template>
  </xsl:variable>

  <video>
    <xsl:call-template name="common.html.attributes"/>

    <xsl:attribute name="src">
      <xsl:value-of select="$filename"/>
    </xsl:attribute>

    <xsl:call-template name="video.poster"/>

    <xsl:apply-templates select="@*[local-name() != 'fileref']"/>
    <xsl:apply-templates select="../d:multimediaparam"/>
    
    <!-- add any fallback content -->
    <xsl:call-template name="video.fallback"/>
  </video>
</xsl:template>

<!-- use only an imageobject with @role = 'poster' -->
<xsl:template name="video.poster">
  <xsl:variable name="imageobject" select="../../d:imageobject[@role = 'poster'][1]"/>
  <xsl:if test="$imageobject">
    <xsl:attribute name="poster">
      <xsl:value-of select="$imageobject/d:imagedata/@fileref"/>
    </xsl:attribute> 
  </xsl:if>
</xsl:template>

<xsl:template match="d:videodata/@fileref">
  <!-- already handled by videodata template -->
</xsl:template>

<xsl:template match="d:audiodata/@fileref">
  <!-- already handled by audiodata template -->
</xsl:template>

<xsl:template match="d:videodata/@contentwidth">
  <xsl:attribute name="width">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="d:videodata/@contentdepth">
  <xsl:attribute name="height">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="d:videodata/@depth">
  <xsl:attribute name="height">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

<!-- pass through these attributes -->
<xsl:template match="d:videodata/@autoplay |
                     d:videodata/@controls |
                     d:audiodata/@autoplay |
                     d:audiodata/@controls">
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="d:videodata/@*" priority="-1">
  <!-- Do nothing with the rest of the attributes -->
</xsl:template>

<xsl:template match="d:audiodata/@*" priority="-1">
  <!-- Do nothing with the rest of the attributes -->
</xsl:template>

<xsl:template match="d:multimediaparam">
  <xsl:call-template name="process.multimediaparam">
    <xsl:with-param name="object" select=".."/>
    <xsl:with-param name="param.name" select="@name"/>
    <xsl:with-param name="param.value" select="@value"/>
  </xsl:call-template>
</xsl:template>

<!-- Determines the best value of a media attribute from the
  attributes and multimediaparam elements -->
<xsl:template name="process.multimediaparam">
  <xsl:param name="object" select="NOTANELEMENT"/>
  <xsl:param name="param.name"/>
  <xsl:param name="param.value"/>

  <xsl:choose>
    <xsl:when test="$object/*/@*[local-name(.) = $param.name]">
      <!-- explicit attribute with that name takes precedence -->
      <xsl:attribute name="{$param.name}">
        <xsl:value-of select="$object/*/@*[local-name(.) = $param.name]"/>
      </xsl:attribute>
    </xsl:when>
    <xsl:otherwise>
      <xsl:attribute name="{$param.name}">
        <xsl:value-of select="$param.value"/>
      </xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="video.fallback">
  <xsl:param name="videodata" select="."/>
  <xsl:variable name="textobject" select="$videodata/../../d:textobject"/>

  <xsl:apply-templates select="$textobject" mode="fallback"/>
</xsl:template>

<xsl:template name="audio.fallback">
  <xsl:param name="audiodata" select="."/>
  <xsl:variable name="textobject" select="$audiodata/../../d:textobject"/>

  <xsl:apply-templates select="$textobject" mode="fallback"/>
</xsl:template>

<xsl:template match="d:textobject" mode="fallback">
  <div>
    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:apply-templates/>
  </div> 
</xsl:template>

<!-- HTML5: select videoobject and audioobject before textobject -->
<xsl:template name="select.mediaobject.index">
  <xsl:param name="olist"
             select="d:imageobject|d:imageobjectco
                     |d:videoobject|d:audioobject|d:textobject"/>
  <xsl:param name="count">1</xsl:param>

  <xsl:choose>
    <!-- Test for objects preferred by role -->
    <xsl:when test="$use.role.for.mediaobject != 0 
               and $preferred.mediaobject.role != ''
               and $olist[@role = $preferred.mediaobject.role]"> 
      
      <!-- Get the first hit's position index -->
      <xsl:for-each select="$olist">
        <xsl:if test="@role = $preferred.mediaobject.role and
             not(preceding-sibling::*[@role = $preferred.mediaobject.role])"> 
          <xsl:value-of select="position()"/> 
        </xsl:if>
      </xsl:for-each>
    </xsl:when>

    <xsl:when test="$use.role.for.mediaobject != 0 
               and $olist[@role = $stylesheet.result.type]">
      <!-- Get the first hit's position index -->
      <xsl:for-each select="$olist">
        <xsl:if test="@role = $stylesheet.result.type and 
              not(preceding-sibling::*[@role = $stylesheet.result.type])"> 
          <xsl:value-of select="position()"/> 
        </xsl:if>
      </xsl:for-each>
    </xsl:when>
    <!-- Accept 'html' for $stylesheet.result.type = 'xhtml' -->
    <xsl:when test="$use.role.for.mediaobject != 0 
               and $stylesheet.result.type = 'xhtml'
               and $olist[@role = 'html']">
      <!-- Get the first hit's position index -->
      <xsl:for-each select="$olist">
        <xsl:if test="@role = 'html' and 
              not(preceding-sibling::*[@role = 'html'])"> 
          <xsl:value-of select="position()"/> 
        </xsl:if>
      </xsl:for-each>
    </xsl:when>

    <!-- If no selection by role, and there is only one object, use it -->
    <xsl:when test="count($olist) = 1 and $count = 1">
      <xsl:value-of select="$count"/> 
    </xsl:when>

    <xsl:otherwise>
      <!-- Otherwise select first acceptable object -->
      <xsl:if test="$count &lt;= count($olist)">
        <xsl:variable name="object" select="$olist[position()=$count]"/>
    
        <xsl:variable name="useobject">
          <xsl:choose>
            <!-- select videoobject or audioobject before textobject -->
            <xsl:when test="local-name($object) = 'videoobject'">
              <xsl:text>1</xsl:text> 
            </xsl:when>
            <xsl:when test="local-name($object) = 'audioobject'">
              <xsl:text>1</xsl:text> 
            </xsl:when>
            <!-- skip textobject if also video, audio, or image out of order -->
            <xsl:when test="local-name($object) = 'textobject' and
                            ../d:imageobject or
                            ../d:audioobject or
                            ../d:videoobject">
              <xsl:text>0</xsl:text> 
            </xsl:when>
            <!-- The phrase is used only when contains TeX Math and output is FO -->
            <xsl:when test="local-name($object)='textobject' and $object/d:phrase
                            and $object/@role='tex' and $stylesheet.result.type = 'fo'
                            and $tex.math.in.alt != ''">
              <xsl:text>1</xsl:text> 
            </xsl:when>
            <!-- The phrase is never used -->
            <xsl:when test="local-name($object)='textobject' and $object/d:phrase">
              <xsl:text>0</xsl:text>
            </xsl:when>
            <xsl:when test="local-name($object)='textobject'
                            and $object/ancestor::d:equation ">
            <!-- The first textobject is not a reasonable fallback
                 for equation image -->
              <xsl:text>0</xsl:text>
            </xsl:when>
            <!-- The first textobject is a reasonable fallback -->
            <xsl:when test="local-name($object)='textobject'
                            and $object[not(@role) or @role!='tex']">
              <xsl:text>1</xsl:text>
            </xsl:when>
            <!-- don't use graphic when output is FO, TeX Math is used 
                 and there is math in alt element -->
            <xsl:when test="$object/ancestor::d:equation and 
                            $object/ancestor::d:equation/d:alt[@role='tex']
                            and $stylesheet.result.type = 'fo'
                            and $tex.math.in.alt != ''">
              <xsl:text>0</xsl:text>
            </xsl:when>
            <!-- If there's only one object, use it -->
            <xsl:when test="$count = 1 and count($olist) = 1">
               <xsl:text>1</xsl:text>
            </xsl:when>
            <!-- Otherwise, see if this one is a useable graphic -->
            <xsl:otherwise>
              <xsl:choose>
                <!-- peek inside imageobjectco to simplify the test -->
                <xsl:when test="local-name($object) = 'imageobjectco'">
                  <xsl:call-template name="is.acceptable.mediaobject">
                    <xsl:with-param name="object" select="$object/d:imageobject"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:call-template name="is.acceptable.mediaobject">
                    <xsl:with-param name="object" select="$object"/>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
    
        <xsl:choose>
          <xsl:when test="$useobject='1'">
            <xsl:value-of select="$count"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="select.mediaobject.index">
              <xsl:with-param name="olist" select="$olist"/>
              <xsl:with-param name="count" select="$count + 1"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- HTML5: no body attributes -->
<xsl:template name="body.attributes"/>

</xsl:stylesheet>
