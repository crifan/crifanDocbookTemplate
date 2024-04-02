<?xml version='1.0'?>

<!DOCTYPE stylesheet [

]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db ng exsl"
                version='1.0'>

<xsl:import href="common_fo.xsl"/>

<!--============================================================================
table setting
=============================================================================-->
<!-- copy from docbook-xsl-ns-1.76.1\fo\table.xsl -->
<!-- Expand this template to add properties to any fo:table-cell -->
<xsl:template name="table.cell.properties">
  <xsl:param name="bgcolor.pi" select="''"/>
  <xsl:param name="rowsep.inherit" select="1"/>
  <xsl:param name="colsep.inherit" select="1"/>
  <xsl:param name="col" select="1"/>
  <xsl:param name="valign.inherit" select="''"/>
  <xsl:param name="align.inherit" select="''"/>
  <xsl:param name="char.inherit" select="''"/>

  <xsl:choose>
    <xsl:when test="ancestor::d:tgroup">

      <!-- added by crifan start -->
      <xsl:if test="ancestor::d:thead">
        <xsl:attribute name="background-color">antiquewhite</xsl:attribute>
      </xsl:if>
      <!-- added by crifan end -->
      
      <xsl:if test="$bgcolor.pi != ''">
        <xsl:attribute name="background-color">
          <xsl:value-of select="$bgcolor.pi"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="$rowsep.inherit &gt; 0">
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'bottom'"/>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$colsep.inherit &gt; 0 and 
                      $col &lt; (ancestor::d:tgroup/@cols|ancestor::d:entrytbl/@cols)[last()]">
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'end'"/>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$valign.inherit != ''">
        <xsl:attribute name="display-align">
          <xsl:choose>
            <xsl:when test="$valign.inherit='top'">before</xsl:when>
            <xsl:when test="$valign.inherit='middle'">center</xsl:when>
            <xsl:when test="$valign.inherit='bottom'">after</xsl:when>
            <xsl:otherwise>
              <xsl:message>
                <xsl:text>Unexpected valign value: </xsl:text>
                <xsl:value-of select="$valign.inherit"/>
                <xsl:text>, center used.</xsl:text>
              </xsl:message>
              <xsl:text>center</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="$align.inherit = 'char' and $char.inherit != ''">
          <xsl:attribute name="text-align">
            <xsl:value-of select="$char.inherit"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="$align.inherit != ''">
          <xsl:attribute name="text-align">
            <xsl:value-of select="$align.inherit"/>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>

    </xsl:when>
    <xsl:otherwise>
      <!-- HTML table -->
      <xsl:if test="$bgcolor.pi != ''">
        <xsl:attribute name="background-color">
          <xsl:value-of select="$bgcolor.pi"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="$align.inherit != ''">
        <xsl:attribute name="text-align">
          <xsl:value-of select="$align.inherit"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="$valign.inherit != ''">
        <xsl:attribute name="display-align">
          <xsl:choose>
            <xsl:when test="$valign.inherit='top'">before</xsl:when>
            <xsl:when test="$valign.inherit='middle'">center</xsl:when>
            <xsl:when test="$valign.inherit='bottom'">after</xsl:when>
            <xsl:otherwise>
              <xsl:message>
                <xsl:text>Unexpected valign value: </xsl:text>
                <xsl:value-of select="$valign.inherit"/>
                <xsl:text>, center used.</xsl:text>
              </xsl:message>
              <xsl:text>center</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>

      <xsl:call-template name="html.table.cell.rules"/>

    </xsl:otherwise>

  </xsl:choose>

</xsl:template>

<!--============================================================================
question background color setting
=============================================================================-->
<!-- copy from docbook-xsl-ns-1.77.0\fo\qandaset.xsl -->
<xsl:template match="d:question">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <xsl:variable name="entry.id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="parent::*"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="deflabel">
    <xsl:apply-templates select="." mode="qanda.defaultlabel"/>
  </xsl:variable>


  <xsl:variable name="label.content">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:if test="contains($deflabel, 'number') and not(d:label)">
      <xsl:apply-templates select="." mode="intralabel.punctuation"/>
    </xsl:if>
  </xsl:variable>

  <!-- changed by crifan start -->
  <!-- <fo:list-item id="{$entry.id}" xsl:use-attribute-sets="list.item.spacing"> -->
  <!-- <fo:list-item background-color="antiquewhite" id="{$entry.id}" xsl:use-attribute-sets="list.item.spacing"> -->
  <fo:list-item id="{$entry.id}" xsl:use-attribute-sets="list.item.spacing">
    <!-- <xsl:attribute name="background-color">antiquewhite</xsl:attribute> -->
    <xsl:attribute name="background-color">
      <xsl:value-of select="$heading_type_bgcolor"/>
    </xsl:attribute>
    
  <!-- changed by crifan end -->
    <fo:list-item-label id="{$id}" end-indent="label-end()">
        <xsl:if test="string-length($label.content) &gt; 0">
			<fo:block font-weight="bold">
			  <xsl:copy-of select="$label.content"/>          
			</fo:block>
        </xsl:if>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <xsl:choose>
        <xsl:when test="$deflabel = 'none' and not(d:label)">
          <fo:block font-weight="bold">
            <xsl:apply-templates select="*[local-name(.)!='label']"/>
          </fo:block>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="*[local-name(.)!='label']"/>
        </xsl:otherwise>
      </xsl:choose>
      <!-- Uncomment this line to get revhistory output in the question -->
      <!-- <xsl:apply-templates select="preceding-sibling::d:revhistory"/> -->
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<!--============================================================================
abstract setting
=============================================================================-->
<!-- set for all abstract -->
<xsl:attribute-set name="abstract.properties">
  <xsl:attribute name="text-align">left</xsl:attribute>
  <xsl:attribute name="font-size">9pt</xsl:attribute>
  <xsl:attribute name="font-family">
    <xsl:value-of select="$body.fontset"/>
  </xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
</xsl:attribute-set>
<!-- set for abstract title -->
<xsl:attribute-set name="abstract.title.properties">
  <xsl:attribute name="text-align">left</xsl:attribute>
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="font-family">
    <xsl:value-of select="$title.fontset"/>
  </xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>


<!--============================================================================
revhistory setting
=============================================================================-->
<!--<xsl:import href="titlepage_crl.xsl"/> --> 
<xsl:attribute-set name="revhistory.title.properties">
  <!-- <xsl:attribute name="text-align">left</xsl:attribute> -->
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="font-family">
    <xsl:value-of select="$title.fontset"/>
  </xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>
 
<xsl:attribute-set name="revhistory.table.properties">
  <xsl:attribute name="border">0.5pt solid black</xsl:attribute>
  <xsl:attribute name="width">50%</xsl:attribute>
  <xsl:attribute name="text-align">left</xsl:attribute>
  <xsl:attribute name="font-family">
    <xsl:value-of select="$body.fontset"/>
  </xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
</xsl:attribute-set>
 
<xsl:attribute-set name="revhistory.table.cell.properties">
  <xsl:attribute name="border">0.5pt solid black</xsl:attribute>
  <xsl:attribute name="font-size">9pt</xsl:attribute>
  <xsl:attribute name="padding">4pt</xsl:attribute>
</xsl:attribute-set>


<!--============================================================================
emphasis setting
=============================================================================-->
<!-- copy from docbook-xsl-ns-1.77.0\fo\inline.xsl -->
<xsl:template name="inline.italicseq">
  <xsl:param name="content">
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>

  <!-- changed by crifan start -->
  <!-- <fo:inline font-style="italic"> -->
  <fo:inline color="brown">
  <!-- changed by crifan end -->
    <xsl:call-template name="anchor"/>
    <xsl:if test="@dir">
      <xsl:attribute name="direction">
        <xsl:choose>
          <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
          <xsl:otherwise>rtl</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template>

<xsl:template name="inline.boldseq">
  <xsl:param name="content">
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>

  <!-- changed by crifan start -->
  <!-- <fo:inline font-weight="bold"> -->
  <fo:inline color="brown">
  <!-- changed by crifan end -->
    <xsl:if test="@dir">
      <xsl:attribute name="direction">
        <xsl:choose>
          <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
          <xsl:otherwise>rtl</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template>

<!--============================================================================
callout setting
=============================================================================-->
<!--
PDF中callout不能点击跳转（而HTML中却可以）
http://www.crifan.com/files/doc/docbook/docbook_dev_note/release/htmls/ch03_faq.html#qa.pdf_callout_cannot_click
-->

<!--============================================================================
header setting
=============================================================================-->

<!-- E:\Dev_Root\docbook\tools\docbook-xsl-ns-1.78.1\fo\pagesetup.xsl -->

<xsl:template name="footer.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

<!--
  <fo:block>
    <xsl:value-of select="$pageclass"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$sequence"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$position"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$gentext-key"/>
  </fo:block>
-->

  <fo:block>
    <!-- pageclass can be front, body, back -->
    <!-- sequence can be odd, even, first, blank -->
    <!-- position can be left, center, right -->
    <xsl:choose>
      <xsl:when test="$pageclass = 'titlepage'">
        <!-- nop; no footer on title pages -->
      </xsl:when>

      <xsl:when test="$double.sided != 0 and $sequence = 'even'
                      and $position='left'">
        <fo:page-number/>
      </xsl:when>

      <xsl:when test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first')
                      and $position='right'">
        <fo:page-number/>
      </xsl:when>

      <xsl:when test="$double.sided = 0 and $position='right'">
        <fo:page-number/>
      </xsl:when>

      <xsl:when test="$double.sided = 0 and $position='center'">
        <xsl:value-of select="ancestor-or-self::book/info/title"/>
      </xsl:when>

      <xsl:when test="$sequence='blank'">
        <xsl:choose>
          <xsl:when test="$double.sided != 0 and $position = 'left'">
            <fo:page-number/>
          </xsl:when>
          <xsl:when test="$double.sided = 0 and $position = 'center'">
            <fo:page-number/>
          </xsl:when>
          <xsl:otherwise>
            <!-- nop -->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>


      <xsl:otherwise>
        <!-- nop -->
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>

<!--============================================================================
Misc setting
=============================================================================-->


</xsl:stylesheet>