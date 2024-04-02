<?xml version='1.0'?>

<!DOCTYPE stylesheet [

<!-- ============== HOME ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/cygdrive/e/Dev_Root/docbook/tools/docbook-xsl-ns-1.76.1"> -->
<!-- <!ENTITY xsl_ns_base_cmd    "E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.76.1"> -->

<!-- ============== OFFICE ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/home/CLi/develop/docbook/tools/docbook-xsl-ns-1.76.1"> -->
<!-- <!ENTITY xsl_ns_base_cmd    "D:/tmp/tmp_dev_root/cgwin/home/CLi/develop/docbook/tools/docbook-xsl-ns-1.76.1"> -->

<!-- ============== UNIFY ============== -->
<!ENTITY xsl_ns_base_cygwin "/home/develop/docbook/tools_root/docbook-xsl-ns-1.76.1">
<!-- <!ENTITY xsl_ns_base_cmd    "../../../tools/docbook-xsl-ns-1.76.1"> -->

]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!--============================================================================
  This settings for all output format:
  fo(pdf/rtf)
=============================================================================-->

<!-- <xsl:include href="docbook.xsl"/> -->
<!-- <xsl:import href="docbook.xsl"/> -->
<!-- <xsl:import href="D:\tmp\tmp_dev_root\cgwin\home\CLi\develop\docbook\tools\docbook-xsl-ns-1.76.1\fo\docbook.xsl"/> -->
<!-- <xsl:import href="D:/tmp/tmp_dev_root/cgwin/home/CLi/develop/docbook/tools/docbook-xsl-ns-1.76.1/fo/docbook.xsl"/> -->
<!-- <xsl:import href="/home/CLi/develop/docbook/tools/docbook-xsl-ns-1.76.1/fo/docbook.xsl"/> -->

<xsl:import href="&xsl_ns_base_cygwin;/fo/docbook.xsl"/>
<!-- <xsl:import href="&xsl_ns_base_cygwin;/fo/highlight.xsl"/> -->

<xsl:import href="titlepage.templates_crl.xsl"/>

<xsl:import href="../common_all.xsl"/>

<!--============================================================================
xref underline  setting
=============================================================================-->
<xsl:attribute-set name="xref.properties">
  <xsl:attribute name="color">blue</xsl:attribute>
  <xsl:attribute name="text-decoration">underline</xsl:attribute>
</xsl:attribute-set>

<!--============================================================================
ulink setting
=============================================================================-->
<xsl:param name="ulink.show" select="1"/>
<xsl:param name="ulink.footnotes" select="1"/>

<!--============================================================================
Admon setting
=============================================================================-->
<!-- has moved following to makefile -->
<!-- <xsl:param name="admon.graphics">1</xsl:param> -->
<!-- <xsl:param name="admon.graphics.extension">.png</xsl:param> -->
<!-- <xsl:param name="admon.graphics.path">&xsl_ns_base_cygwin;/images/</xsl:param> -->
<!-- <xsl:param name="admon.graphics.path">&xsl_ns_base_cmd;/images/</xsl:param> -->
<!-- <xsl:param name="admon.graphics.extension">.svg</xsl:param> -->
<!-- follow must use cmd path, otherwise can not found picture !!! -->
<!-- now put all path related settings into makefile -->
<!-- <xsl:param name="admon.graphics.path">&xsl_ns_base_cmd;/images/colorsvg/</xsl:param> -->

<!--============================================================================
verbatim(programlisting/literallayout/...) setting
=============================================================================-->
<xsl:param name="shade.verbatim" select="1"></xsl:param>
<!-- http://lists.oasis-open.org/archives/docbook/200801/msg00009.html -->
<!-- http://www.dpawson.co.uk/docbook/styling/params.html -->
<xsl:attribute-set name="shade.verbatim.style">
    <!-- <xsl:attribute name="border">0</xsl:attribute> -->
    <xsl:attribute name="background-color">Lavender</xsl:attribute>
    <xsl:attribute name="padding">1pt</xsl:attribute>
</xsl:attribute-set>

<!-- http://www.sagehill.net/docbookxsl/FittingText.html#BreakLongLines -->
<xsl:attribute-set name="monospace.verbatim.properties">
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
</xsl:attribute-set>


<!--============================================================================
equation setting
=============================================================================-->
<!-- TODO:tmp here only valid for FO(PDF), not take effect for HTML, need later fix it -->
<!-- <xsl:attribute-set name="equation.properties" use-attribute-sets="formal.object.properties"></xsl:attribute-set> -->
<xsl:attribute-set name="equation.properties" use-attribute-sets="formal.object.properties">
    <!-- http://www.dpawson.co.uk/docbook/styling/params.html#d2221e282 -->
    <!-- <xsl:attribute name="border-color">thin black ridge</xsl:attribute> -->
    <!-- http://raibledesigns.com/wiki/Wiki.jsp?page=DocBook -->
    <!-- <xsl:attribute name="border">0</xsl:attribute> -->
    <!-- <xsl:attribute name="border-style">solid</xsl:attribute> -->
    <!-- <xsl:attribute name="border-width">.1mm</xsl:attribute> -->
    <xsl:attribute name="background-color">Lavender</xsl:attribute>
    <!-- <xsl:attribute name="border-width">0.5pt</xsl:attribute> -->
    <xsl:attribute name="padding">1pt</xsl:attribute>
</xsl:attribute-set>

<!--============================================================================
formal(figure/table/equation/example/...) setting
=============================================================================-->
<!-- http://www.sagehill.net/docbookxsl/TitleFontSizes.html#FormalTitleProperties -->
<xsl:attribute-set name="formal.title.properties" 
                   use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
  
  <xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>

<!--============================================================================
hyphenate setting
=============================================================================-->
<!-- current seems following not take effect -->

<xsl:param name="hyphenate">true</xsl:param>

<!-- http://www.sagehill.net/docbookxsl/Ulinks.html#BreakLongUrls -->
<!-- <xsl:param name="ulink.hyphenate.chars">/&amp;?_</xsl:param> -->
<xsl:param name="ulink.hyphenate.chars">/&amp;?-_</xsl:param>
<xsl:param name="ulink.hyphenate">&#x200B;</xsl:param>

<!--============================================================================
misc setting
=============================================================================-->
<!-- add bookmark and support more type of figure -->
<xsl:param name="fop1.extensions">1</xsl:param>

<!-- no indent for body content -->
<xsl:param name="body.start.indent">0pt</xsl:param>

<!-- page type, height and width -->
<xsl:param name="paper.type">A4</xsl:param>

</xsl:stylesheet>