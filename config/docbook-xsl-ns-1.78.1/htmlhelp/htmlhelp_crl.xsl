<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE stylesheet 
[

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

]
>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:import href="&xsl_ns_base_cmd;/htmlhelp/htmlhelp.xsl"/>
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

<xsl:param name="htmlhelp.hhp.tail">css\docbook_crl.css</xsl:param>

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