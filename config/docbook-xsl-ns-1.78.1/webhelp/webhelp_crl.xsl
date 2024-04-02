<?xml version="1.0"?>

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

]>

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:d="http://docbook.org/ns/docbook"
    xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
    xmlns:exsl="http://exslt.org/common"
    xmlns:set="http://exslt.org/sets"
    version="1.0"
    exclude-result-prefixes="doc exsl set d">


<!-- <xsl:import href="file:///E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.77.1/webhelp/xsl/webhelp.xsl"/> -->
<xsl:import href="webhelp.xsl"/>
<!-- when use cygwin xsltproc, follow href value not need file:/// -->
<!-- <xsl:import href="file:///&config_base_cmd;/common_all.xsl"/> -->
<!-- <xsl:import href="&config_base_cmd;/common_all.xsl"/> -->
<xsl:import href="&config_base_cmd;/common_all.xsl"/>
<!--<xsl:import href="file:///E:/Dev_Root/docbook/dev/config/docbook-xsl-ns-1.77.1/html/multi/chunk_crl.xsl"/>-->

<!-- !!!!NOTE!!! note css file, but is XML file, contain <style> -->
<!-- http://docbook.sourceforge.net/release/xsl/1.78.1/doc/html/docbook.css.source.html -->
<!-- <xsl:param name="docbook.css.source">&xsl_ns_base_cmd;/xhtml-1_1/docbook.css.xml</xsl:param> -->
<!-- <xsl:param name="docbook.css.source">docbook_css/xhtml-1_1/docbook.css.xml</xsl:param> -->
<!-- <xsl:param name="docbook.css.source">docbook.css_xhtml_1_1.xml</xsl:param> -->
<!-- <xsl:param name="docbook.css.source">docbook.css.xml</xsl:param> -->
<!-- http://docbook.sourceforge.net/release/xsl/1.78.1/doc/html/custom.css.source.html -->
<!-- <xsl:param name="custom.css.source"></xsl:param> -->
<!-- http://docbook.sourceforge.net/release/xsl/1.78.1/doc/html/make.clean.html.html -->
<!-- <xsl:param name="make.clean.html" select="1"></xsl:param> -->

<!--
desitinate the dir of webhelp common resource
currently those resources include common/ and favicon.ico
-->
<!--<xsl:param name="webhelp.common.dir">E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.77.1/webhelp/docs/common/</xsl:param>-->
<!--<xsl:param name="webhelp.common.dir">&xsl_ns_base_cmd;/webhelp/docs/common/</xsl:param>-->
<!-- for webhelp.common.dir have two mode: online and local, so can not set fixed value here -->
<!-- so webhelp.common.dir is configured in E:\Dev_Root\docbook\dev\config\docbook.mk -->
<!-- <xsl:param name="webhelp.common.dir">&xsl_ns_base_cmd;/webhelp/template/common/</xsl:param> -->

<!-- custom css file path -->
<!-- direct css file, should use in html.stylesheet -->
<!-- http://docbook.sourceforge.net/release/xsl/1.78.1/doc/html/html.stylesheet.html -->
<!-- 1.78.1 have rename custom.css.path to custom.css.source -->
<!-- http://docbook.sourceforge.net/release/xsl/1.78.1/doc/html/custom.css.source.html -->

<!-- http://docbook.sourceforge.net/release/xsl/1.78.0/doc/html/docbook.css.link.html -->
<!-- docbook.css.link — Insert a link referencing the default CSS stylesheet -->
<!-- <xsl:param name="docbook.css.link">1</xsl:param> -->

<xsl:param name="webhelp.autolabel">1</xsl:param>
<xsl:param name="chapter.autolabel">1</xsl:param>
<xsl:param name="appendix.autolabel">0</xsl:param>
<xsl:param name="qandadiv.autolabel">1</xsl:param>
<xsl:param name="reference.autolabel">1</xsl:param>
<xsl:param name="navig.showtitles">1</xsl:param>

<!-- remove warning: Request for label of unexpected element: bibliodiv -->
<xsl:template match="d:bibliodiv" mode="label.markup">
  <xsl:if test="@label">
    <xsl:value-of select="@label"/>
  </xsl:if>
</xsl:template>


<!--============================================================================
try add google analytics tracking code
=============================================================================-->
<!-- http://www.sagehill.net/docbookxsl/InsertExtHtml.html -->
<xsl:template name="user.header.content">
    <!-- when use cygwin xsltproc, follow href value not need file:/// -->
   <!-- <xsl:variable name="google_analytics_js" select="document('file:///&config_base_cmd;/html/js/crifan_ga_js.xml')"/> -->
   <xsl:variable name="google_analytics_js" select="document('&config_base_cmd;/html/js/crifan_ga_js.xml')"/>
   <xsl:copy-of select="$google_analytics_js/ga_js/node()"/>
</xsl:template>

</xsl:stylesheet>
