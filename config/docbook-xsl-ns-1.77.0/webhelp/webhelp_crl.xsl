<?xml version='1.0'?>

<!DOCTYPE stylesheet 
[
<!-- ============== HOME ============== -->
<!-- <!ENTITY xsl_ns_base_cygwin "/cygdrive/e/Dev_Root/docbook/tools/docbook-xsl-ns-1.76.1"> -->
<!-- <!ENTITY output_base_cmd "E:/Dev_Root/docbook/dev/books/VBR/output"> -->

<!-- ============== OFFICE ============== -->
<!ENTITY xsl_ns_base_cygwin "/home/CLi/develop/docbook/tools/docbook-xsl-ns-1.76.1">
<!ENTITY output_base_cmd "D:/tmp/tmp_dev_root/cgwin/home/CLi/develop/docbook/books/VBR/VBR/output">

]
>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:import href="&xsl_ns_base_cygwin;/webhelp/xsl/webhelp.xsl"/>

<xsl:output method="html"
            encoding="UTF-8"/>

<xsl:param name="title.font.family">msyhbd</xsl:param>
<xsl:param name="body.font.family">msyh</xsl:param>
<xsl:param name="monospace.font.family">msyh</xsl:param>

<xsl:param name="generate.toc">1</xsl:param>
<xsl:param name="html.stylesheet.type">text/css</xsl:param>
<!-- <xsl:param name="html.stylesheet">webhelp.css</xsl:param> -->
<xsl:param name="generate.index">1</xsl:param>

</xsl:stylesheet> 
