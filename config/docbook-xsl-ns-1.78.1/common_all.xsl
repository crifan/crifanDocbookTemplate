<?xml version='1.0'?>

<!DOCTYPE stylesheet [

<!-- <!ENTITY docbook_xsl_ns "docbook-xsl-ns-1.76.1"> -->
<!-- <!ENTITY docbook_xsl_ns "docbook-xsl-ns-1.77.1"> -->
<!ENTITY docbook_xsl_ns "docbook-xsl-ns-1.78.1">

<!-- ============== HOME ============== -->
<!ENTITY xsl_ns_base_cygwin "/cygdrive/e/dev_root/docbook/dev/tools/&docbook_xsl_ns;">
<!ENTITY xsl_ns_base_cmd    "E:/dev_root/docbook/tools/&docbook_xsl_ns;">
<!ENTITY config_base_cmd    "E:/dev_root/docbook/dev/config/&docbook_xsl_ns;">

<!-- ============== OFFICE ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/home/CLi/develop/docbook/tools/&docbook_xsl_ns;"> -->

<!-- ============== UNIFY ============== -->

]>

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version='1.0'>

<!--============================================================================
  This settings for all output format:
  html, chunk(htmls), fo(pdf/rtf), htmlhelp(chm)
=============================================================================-->

<!--============================================================================
font setting
=============================================================================-->
<!--
<xsl:param name="title.font.family">微软雅黑</xsl:param>
<xsl:param name="body.font.family">微软雅黑</xsl:param>
<xsl:param name="monospace.font.family">微软雅黑</xsl:param>
-->
<!-- 标题的字体 -->
<xsl:param name="title.font.family">Microsoft YaHei</xsl:param>
<!-- 主体内容，即普通内容的字体 -->
<xsl:param name="body.font.family">Microsoft YaHei</xsl:param>
<!-- 注意下面的monospace字体，包括了(programlisting)代码，所以如果代码中有中文，
那么此处设置的字体必须是支持中文的字体，否则代码中的中文都会显示###-->
<xsl:param name="monospace.font.family">Microsoft YaHei</xsl:param>
<!-- 符号类的字体 -->
<xsl:param name="symbol.font.family">Cambria Math</xsl:param>

<!--============================================================================
TOC index setting
=============================================================================-->
<!-- 自动添加（索引）编号 -->
<xsl:param name="section.autolabel" select="1"/>
<!-- 添加的编号中包括子的小节 -->
<xsl:param name="section.label.includes.component.label" select="1"/>
<!-- 引用Reference部分也编号 -->
<xsl:param name="bibliography.numbered" select="1"/>
<!-- TOC目录最大深度，默认是2 -->
<xsl:param name="toc.section.depth">8</xsl:param>

<!--============================================================================
Table setting
=============================================================================-->
<xsl:param name="table.cell.border.color">green</xsl:param>
<xsl:param name="table.frame.border.thickness">1.5pt</xsl:param>

<!-- http://docbook.sourceforge.net/release/xsl/1.75.2/doc/fo/default.table.rules.html -->
<!-- <xsl:param name="default.table.rules">none</xsl:param> -->
<!-- <xsl:param name="default.table.rules">groups</xsl:param> -->

<!--============================================================================
glossterm setting
=============================================================================-->
<xsl:param name="glossterm.auto.link">1</xsl:param>
<!-- 'primary'/'yes'/'no': http://www.sagehill.net/docbookxsl/Glossaries.html -->
<xsl:param name="glossentry.show.acronym" select="'primary'"></xsl:param>

<!--============================================================================
callout setting
=============================================================================-->
<!--
<xsl:param name="use.extensions" select="1"></xsl:param>
<xsl:param name="callouts.extension" select="1"></xsl:param>
<xsl:param name="callout.defaultcolumn">60</xsl:param>
<xsl:param name="callout.graphics.extension">.svg</xsl:param>
-->
<!-- has moved following to makefile
<xsl:param name="callout.graphics" select="1"></xsl:param>
<xsl:param name="callout.graphics.path">images/system/callouts/</xsl:param>
<xsl:param name="callout.graphics.number.limit">30</xsl:param>
-->
<!--============================================================================
misc setting
=============================================================================-->

<!--
code(programlisting/screen/synopsis) highlight
http://docbook.sourceforge.net/release/xsl/1.76.1/doc/html/highlight.source.html
NOTE: tmp not work for fop, only take effect for Saxon 6.5.x and Xalan-J

<xsl:param name="highlight.source" select="1"></xsl:param>
<xsl:param name="highlight.default.language"></xsl:param>
<xsl:param name="highlight.xslthl.config">file://&config_base_cmd;/highlight/xslthl-config_crl.xml</xsl:param>
-->

<!-- add QandA into toc -->
<xsl:param name="qanda.in.toc">1</xsl:param>
<xsl:param name="qanda.nested.in.toc">0</xsl:param>


</xsl:stylesheet>