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

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                xmlns:exsl="http://exslt.org/common"
                xmlns:set="http://exslt.org/sets"
		version="1.0"
                exclude-result-prefixes="doc exsl set d">

<!-- ********************************************************************
     $Id$
     ******************************************************************** 

     This file is part customization layer on top of the XSL DocBook
     Stylesheet distribution that generates webhelp output.

     ******************************************************************** -->
<!--
<xsl:import href="../../xhtml/chunk.xsl"/>
<xsl:include href="webhelp-common.xsl"/>
<xsl:include href="titlepage.templates.xsl"/>
-->

<!--<xsl:import href="file:///E:/Dev_Root/docbook/tools/docbook-xsl-ns-1.77.1/xhtml/chunk.xsl"/>-->
<!-- when use cygwin xsltproc, follow href value not need file:/// -->
<!-- <xsl:import href="file:///&xsl_ns_base_cmd;/xhtml/chunk.xsl"/> -->
<xsl:import href="&xsl_ns_base_cmd;/xhtml/chunk.xsl"/>
<xsl:include href="webhelp-common.xsl"/>
<xsl:include href="titlepage.templates_crl.xsl"/>

</xsl:stylesheet>
