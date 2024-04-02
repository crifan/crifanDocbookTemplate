<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE stylesheet 
[

<!-- ============== HOME ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/cygdrive/e/Dev_Root/docbook/tools/docbook-xsl-ns-1.76.1"> -->

<!-- ============== OFFICE ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/home/CLi/develop/docbook/tools/docbook-xsl-ns-1.76.1"> -->

<!-- ============== UNIFY ============== -->
<!ENTITY xsl_ns_base_cygwin "/home/develop/docbook/tools_root/docbook-xsl-ns-1.76.1">

]
>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:import href="&xsl_ns_base_cygwin;/htmlhelp/htmlhelp.xsl"/>

<xsl:import href="../html/common_html.xsl"/>

<!--
<xsl:output method="html"
            encoding="UTF-8"
            indent="yes"/>

<xsl:param name="htmlhelp.hhp">htmlhelp.hhp</xsl:param>
<xsl:param name="htmlhelp.hhc">toc.hhc</xsl:param>
-->

<xsl:param name="htmlhelp.autolabel" select="1"></xsl:param>

<xsl:param name="htmlhelp.encoding">UTF-8</xsl:param>
<xsl:param name="chunker.output.encoding">UTF-8</xsl:param>

<!--============================================================================
has tried, but no effect
=============================================================================-->
<!--
<xsl:param name="htmlhelp.autolabel">1</xsl:param>
<xsl:param name="htmlhelp.hhp.window">MPEG简介 + 如何计算CBR和VBR的MP3的播放时间 v1.6</xsl:param>

<xsl:param name="htmlhelp.title">MPEG_VBR_title</xsl:param>

<xsl:param name="chunker.output.encoding" select="UTF-8"/>
<xsl:param name="htmlhelp.encoding">windows-1252</xsl:param>

<xsl:param name="htmlhelp.encoding">windows-1252</xsl:param>

-->

<!-- <xsl:param name="htmlhelp.encoding">UTF-8</xsl:param>--> <!-- 会找到找不到HTML的索引 -->

</xsl:stylesheet> 