<?xml version='1.0'?>

<!DOCTYPE stylesheet 
[

<!-- <!ENTITY xsl_ns_base_cygwin "/home/develop/docbook/tools_root/docbook-xsl-ns-1.76.1"> -->

]
>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
                version='1.0'>

<xsl:import href="titlepage.templates_crl.xsl"/>

<xsl:import href="../common_all.xsl"/>

<!-- <xsl:import href="&xsl_ns_base_cygwin;/html/highlight.xsl"/> -->

<xsl:output method="html"
            encoding="UTF-8"
            indent="yes"/>
<!--
 Note: above indent=yes only take effect for single html,
 for html chunk it NOT take effect,
 so need the chunk define itself's chunker.output.indent='yes'
-->

<!--============================================================================
misc setting
=============================================================================-->

<!--
<xsl:param name="use.svg" select="1"></xsl:param>
<xsl:param name="use.embed.for.svg">1</xsl:param>
-->
<!-- has moved following to makefile
<xsl:param name="admon.graphics">1</xsl:param>
<xsl:param name="admon.graphics.extension">.png</xsl:param>
<xsl:param name="admon.graphics.path">images/system/</xsl:param>
-->
<!-- <xsl:param name="admon.graphics.extension">.svg</xsl:param> -->
<!-- <xsl:param name="admon.graphics.path">images/colorsvg/</xsl:param> -->

<!--============================================================================
verbatim(programlisting) setting
=============================================================================-->
<!-- <xsl:param name="shade.verbatim" select="0"></xsl:param> -->
<!-- http://www.sagehill.net/docbookxsl/UsingCSS.html#StylingDisplays -->

<!--============================================================================
table setting
=============================================================================-->
<!-- http://docbook.sourceforge.net/release/xsl/1.76.1/doc/html/table.cell.border.color.html -->
<xsl:param name="table.borders.with.css">1</xsl:param>
<xsl:param name="table.cell.border.style">solid</xsl:param>
<xsl:param name="table.cell.border.color">green</xsl:param>
<xsl:param name="table.frame.border.style">solid</xsl:param>
<xsl:param name="table.frame.border.color">black</xsl:param>
<xsl:param name="table.frame.border.thickness">1.5pt</xsl:param>

<!--============================================================================
equation/programlisting/... setting
=============================================================================-->
<!-- has moved following to makefile
<xsl:param name="html.stylesheet.type">text/css</xsl:param>
<xsl:param name="html.stylesheet">css/common_html.css</xsl:param>
-->

<!--============================================================================
formal(figure/table/equation/example/...) setting
=============================================================================-->
<!-- follow are copied from docbook-xsl-ns-1.76.1\html\formal.xsl -->
<!-- for HTML, since the there many notes for table/figure/...,
so if here change formal title and body to align center,
then the related notes will look urgly,
so here just use the default align(left)
NOT use align center for formal's title and body !!!
-->
<xsl:template name="formal.object.heading">
  <xsl:param name="object" select="."/>
  <xsl:param name="title">
    <xsl:apply-templates select="$object" mode="object.title.markup">
      <xsl:with-param name="allow-anchors" select="1"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:choose>
    <xsl:when test="$make.clean.html != 0">
      <xsl:variable name="html.class" select="concat(local-name($object),'-title')"/>
      <div class="{$html.class}">
        <xsl:copy-of select="$title"/>
      </div>
    </xsl:when>
    <xsl:otherwise>
      <p class="title">
      <!-- <p class="title" align="center"> --> <!-- add align to center of header for table/figure/... -->
        <b>
          <xsl:copy-of select="$title"/>
        </b>
      </p>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="formal.object">
  <xsl:param name="placement" select="'before'"/>
  <xsl:param name="class">
    <xsl:apply-templates select="." mode="class.value"/>
  </xsl:param>

  <xsl:call-template name="id.warning"/>

  <xsl:variable name="content">
    <div class="{$class}">
      <xsl:call-template name="anchor">
        <xsl:with-param name="conditional" select="0"/>
      </xsl:call-template>
    
      <xsl:choose>
        <xsl:when test="$placement = 'before'">
          <xsl:call-template name="formal.object.heading"/>
          <div class="{$class}-contents">
          <!-- <div class="{$class}-contents" align="center" > --> <!-- add align to center for body of table/figure/.. -->
            <xsl:apply-templates/>
          </div>
          <!-- HACK: This doesn't belong inside formal.object; it 
               should be done by the table template, but I want 
               the link to be inside the DIV, so... -->
          <xsl:if test="local-name(.) = 'table'">
            <xsl:call-template name="table.longdesc"/>
          </xsl:if>
    
          <xsl:if test="$spacing.paras != 0"><p/></xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="$spacing.paras != 0"><p/></xsl:if>
          <div class="{$class}-contents"><xsl:apply-templates/></div>
          <!-- HACK: This doesn't belong inside formal.object; it 
               should be done by the table template, but I want 
               the link to be inside the DIV, so... -->
          <xsl:if test="local-name(.) = 'table'">
            <xsl:call-template name="table.longdesc"/>
          </xsl:if>
    
          <xsl:call-template name="formal.object.heading"/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
    <xsl:if test="not($formal.object.break.after = '0')">
      <br class="{$class}-break"/>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="floatstyle">
    <xsl:call-template name="floatstyle"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$floatstyle != ''">
      <xsl:call-template name="floater">
        <xsl:with-param name="class"><xsl:value-of 
                     select="$class"/>-float</xsl:with-param>
        <xsl:with-param name="floatstyle" select="$floatstyle"/>
        <xsl:with-param name="content" select="$content"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy-of select="$content"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>


<!--
follow is try set entrytbl thickness to 1pt, but failed

<xsl:template name="inherited.table.attribute">
    <xsl:param name="table.borders.with.css">1</xsl:param>
    <xsl:param name="table.cell.border.color">black</xsl:param>
    <xsl:param name="table.frame.border.style">solid</xsl:param>
    <xsl:param name="table.frame.border.color">black</xsl:param>
    <xsl:param name="table.frame.border.thickness">1pt</xsl:param>
</xsl:template>

<xsl:template match="d:entrytbl">
    <xsl:param name="table.frame.border.thickness">1pt</xsl:param>
</xsl:template>
-->

<!--============================================================================
misc setting
=============================================================================-->


</xsl:stylesheet> 