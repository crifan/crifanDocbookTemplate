<?xml version='1.0'?>

<!DOCTYPE stylesheet 
[

<!-- <!ENTITY docbook_xsl_ns "docbook-xsl-ns-1.76.1"> -->
<!-- <!ENTITY docbook_xsl_ns "docbook-xsl-ns-1.77.1"> -->
<!ENTITY docbook_xsl_ns "docbook-xsl-ns-1.78.1">


<!-- ============== HOME ============== -->
<!ENTITY xsl_ns_base_cygwin "/cygdrive/e/dev_root/docbook/dev/tools/&docbook_xsl_ns;">
<!ENTITY xsl_ns_base_cmd    "E:/dev_root/docbook/tools/&docbook_xsl_ns;">

<!-- ============== OFFICE ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/home/CLi/develop/docbook/tools/&docbook_xsl_ns;"> -->

<!-- ============== UNIFY ============== -->

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
<!-- <xsl:param name="table.cell.border.style">1px solid black</xsl:param> -->
<xsl:param name="table.cell.border.color">green</xsl:param>
<!-- <xsl:param name="table.cell.border.thickness">0.5pt</xsl:param> -->
<xsl:param name="table.frame.border.style">solid</xsl:param>
<xsl:param name="table.frame.border.color">black</xsl:param>
<xsl:param name="table.frame.border.thickness">1.5pt</xsl:param>


<!--============================================================================
revhistory table setting
=============================================================================-->
<!--
 from docbook-xsl-ns-1.78.0\html\titlepage.xsl
has refer: http://www.w3school.com.cn/css/css_table.asp, but 'solid' not work
-->

<xsl:template match="d:revhistory" mode="titlepage.mode">
  <xsl:variable name="numcols">
    <xsl:choose>
      <xsl:when test=".//d:authorinitials|.//d:author">3</xsl:when>
      <xsl:otherwise>2</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <xsl:variable name="title">
    <xsl:call-template name="gentext">
      <xsl:with-param name="key">RevHistory</xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="contents">
    <div>
      <xsl:apply-templates select="." mode="common.html.attributes"/>
      <xsl:call-template name="id.attribute"/>
      <table>
        <xsl:if test="$css.decoration != 0">
          <!-- changed by crifan start -->
          <!-- 
          <xsl:attribute name="style">
            <xsl:text>border-style:solid; width:100%;</xsl:text>
          </xsl:attribute>
          -->
          <xsl:attribute name="border">
            <xsl:text>1px solid black</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="width">
            <xsl:text>100%</xsl:text>
          </xsl:attribute>
          <!-- changed by crifan end -->
        </xsl:if>
        <!-- include summary attribute if not HTML5 -->
        <xsl:if test="$div.element != 'section'">
          <xsl:attribute name="summary">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">revhistory</xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <tr>
          <th align="{$direction.align.start}" valign="top" colspan="{$numcols}">
            <b>
              <xsl:call-template name="gentext">
                <xsl:with-param name="key" select="'RevHistory'"/>
              </xsl:call-template>
            </b>
          </th>
        </tr>
        <xsl:apply-templates mode="titlepage.mode">
          <xsl:with-param name="numcols" select="$numcols"/>
        </xsl:apply-templates>
      </table>
    </div>
  </xsl:variable>
  
  <xsl:choose>
    <xsl:when test="$generate.revhistory.link != 0">
      
      <!-- Compute name of revhistory file -->
      <xsl:variable name="file">
	<xsl:call-template name="ln.or.rh.filename">
	  <xsl:with-param name="is.ln" select="false()"/>
	</xsl:call-template>
      </xsl:variable>

      <xsl:variable name="filename">
        <xsl:call-template name="make-relative-filename">
          <xsl:with-param name="base.dir" select="$chunk.base.dir"/>
          <xsl:with-param name="base.name" select="$file"/>
        </xsl:call-template>
      </xsl:variable>

      <a href="{$file}">
        <xsl:copy-of select="$title"/>
      </a>

      <xsl:call-template name="write.chunk">
        <xsl:with-param name="filename" select="$filename"/>
        <xsl:with-param name="quiet" select="$chunk.quietly"/>
        <xsl:with-param name="content">
        <xsl:call-template name="user.preroot"/>
          <html>
            <head>
              <xsl:call-template name="system.head.content"/>
              <xsl:call-template name="head.content">
                <xsl:with-param name="title">
                    <xsl:value-of select="$title"/>
                    <xsl:if test="../../d:title">
                        <xsl:value-of select="concat(' (', ../../d:title, ')')"/>
                    </xsl:if>
                </xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="user.head.content"/>
            </head>
            <body>
              <xsl:call-template name="body.attributes"/>
              <xsl:copy-of select="$contents"/>
            </body>
          </html>
          <xsl:text>&#x0a;</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy-of select="$contents"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


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
      <xsl:call-template name="id.attribute">
        <xsl:with-param name="conditional" select="0"/>
      </xsl:call-template>
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
try add google analytics tracking code
=============================================================================-->
<!-- http://www.sagehill.net/docbookxsl/InsertExtHtml.html -->
<xsl:template name="user.header.content">
   <xsl:variable name="google_analytics_js" select="document('js/crifan_ga_js.xml')"/>
   <xsl:copy-of select="$google_analytics_js/ga_js/node()"/>
</xsl:template>

<!--============================================================================
misc setting
=============================================================================-->


</xsl:stylesheet> 