# [Fcuntion]
# Generate output from DocBook xml sources
#
# [Author]
# Crifan Li
#
# [Version]
# v2.3, 2013-09-30
#
# [Contact]
# http://www.crifan.com/about/me/
#
# [Note]
# 1. this is the main makefile for docbook
# 2. set proper enviroment variables before use this makefile
# ==office==
# (1) CLASSPATH = .;%JAVA_HOME%\lib\rt.jar;
# not need add D:\tmp\tmp_dev_root\cgwin\home\CLi\develop\docbook\tools\fop\lib\xmlgraphics-commons-1.4.jar; 
# into CLASSPATH after fixe fop cygpath bug:
# http://www.crifan.com/fop_java_lang_noclassdeffounderror_xmlgraphics_cygpath_bug_path_truncated/
# (2) FOP_HOME = /home/CLi/develop/docbook/tools/fop
# (3) JAVA_HOME = C:\Program Files (x86)\Java\jre6
# (4) PATH contain: D:\tmp\tmp_dev_root\cgwin\home\CLi\develop\docbook\tools\fop
#
# ==home==
# (1) CLASSPATH = .;%JAVA_HOME%\lib;
# (2) FOP_HOME = /cygdrive/e/dev_root/docbook/tools/fop-1.0
#  for MSYS/MingW, set to E:\dev_root\docbook\tools\fop-1.0
# later find out, for cygwin, set to E:\dev_root\docbook\tools\fop-1.0 also can work
# (3) JAVA_HOME = D:\Program Files\Java\jre7
# (4) PATH contain: 
#  hhc的路径：  E:\dev_install_root\HTML Help Workshop;
#  7z的路径：   D:\Program Files\7-Zip;
#  fop的路径：  E:\dev_root\docbook\tools\fop-1.0;
#
# 3. this makefile should be include in Makefile of src directory
# ==office==
# pwd = /home/CLi/develop/docbook/books/xxx/src
# [home]
# pwd = /cygdrive/e/dev_root/docbook/dev/books/xxx/src
# 
# [History]
# [v2.3, 2013-09-30]
# 1. support docbook_crl.css
# 2. support integrate css into htmlhelp(chm)
#
# [v2.1, 2013-09-29]
# 1. add append original Java's CLASSPATH into webhelp's classpath
# 2. upgrade to 1.78.1
#
# [v2.0, 2013-09-27]
# 1. add project name for process each target

################################################################################
# Some Fixed Varaibles
################################################################################
ONLINE_RES_DOCBOOK = http://www.crifan.com/files/res/docbook

################################################################################
# Enviroment Settings
################################################################################

# ----------------------- home config -----------------------
TOOLS_ROOT_CMD = E:/dev_root/docbook/tools
CONFIG_ROOT_CMD = E:/dev_root/docbook/dev/config
LOCAL_RELEASE_PARENT_CMD = E:/dev_root/svn_dev_root/www_crifan_com/public_html/files/doc/docbook
LOCAL_PDF_CMD = E:/tmp/books
CONFIG_ROOT_CYGWIN = /cygdrive/e/dev_root/docbook/dev/config
TOOLS_ROOT_CYGWIN = /cygdrive/e/dev_root/docbook/tools

# ----------------------- office config -----------------------
#TOOLS_ROOT_CMD = D:/tmp/tmp_dev_root/cgwin/home/CLi/develop/docbook/tools
#CONFIG_ROOT_CMD = D:/tmp/tmp_dev_root/cgwin/home/CLi/develop/docbook/config
#LOCAL_RELEASE_PARENT_CMD = D:/to_del/docbook
#LOCAL_PDF_CMD = D:/to_del/docbook
#CONFIG_ROOT_CYGWIN = NEED_UPDATE
#TOOLS_ROOT_CYGWIN = NEED_UPDATE

################################################################################
# ----------------------- common config -----------------------

################################################################################
FOP_CFG_ROOT_CMD = $(CONFIG_ROOT_CMD)/fop/conf

XML_CATALOG_ROOT_CYGWIN = $(CONFIG_ROOT_CYGWIN)/catalog
XML_CATALOG_FILES = $(XML_CATALOG_ROOT_CYGWIN)/catalog.xml

#DOCBOOK_XSL_NS_NAME=docbook-xsl-ns-1.76.1
#DOCBOOK_XSL_NS_NAME=docbook-xsl-ns-1.77.0
#DOCBOOK_XSL_NS_NAME=docbook-xsl-ns-1.77.1
DOCBOOK_XSL_NS_NAME=docbook-xsl-ns-1.78.1

CONFIG_XSL_NS_ROOT_CYGWIN = $(CONFIG_ROOT_CYGWIN)/$(DOCBOOK_XSL_NS_NAME)

TOOLS_XSL_NS_BASE_CMD = $(TOOLS_ROOT_CMD)/$(DOCBOOK_XSL_NS_NAME)
CONFIG_XSL_NS_BASE_CMD = $(CONFIG_ROOT_CMD)/$(DOCBOOK_XSL_NS_NAME)

SYS_IMG_PATH_LOCAL  = $(CONFIG_ROOT_CMD)/images/system
SYS_IMG_PATH_RELEASE= $(ONLINE_RES_DOCBOOK)/images

MAKE_FILE=$(CONFIG_ROOT_CYGWIN)/docbook.mk

TOOLS_XSL_NS_FO = $(TOOLS_XSL_NS_BASE_CMD)/fo
TOOLS_XSL_NS_HTML = $(TOOLS_XSL_NS_BASE_CMD)/html
TOOLS_XSL_NS_HTMLHELP = $(TOOLS_XSL_NS_BASE_CMD)/htmlhelp
TOOLS_XSL_NS_WEBHELP = $(TOOLS_XSL_NS_BASE_CMD)/webhelp
TOOLS_XSL_NS_WEBSITE = $(TOOLS_XSL_NS_BASE_CMD)/website

TOOLS_XSL_NS_PROFILING = $(TOOLS_XSL_NS_BASE_CMD)/profiling
TOOLS_XSL_NS_EXTENSIONS = $(TOOLS_XSL_NS_BASE_CMD)/extensions

# ----------------------- common environment variable -----------------------
OS_NAME = $(shell uname -o)
OS_NAME_LOWCASE = $(shell echo $(OS_NAME) | tr '[A-Z]' '[a-z]')

################################################################################
# Configuration/Settings
################################################################################

# ================== Common related ==================
#<xsl:param name="callout.graphics" select="1"></xsl:param>
#<xsl:param name="callout.graphics.path">images/system/callouts/</xsl:param>
#<xsl:param name="callout.graphics.number.limit">30</xsl:param>
#<xsl:param name="callout.graphics.extension">.svg</xsl:param>
#CFG_CALLOUT_GRAPHICS=0
CFG_CALLOUT_GRAPHICS=1
CALLOUT_NUMBER_LIMIT=30

CALLOUT_GRAPHICS_PATH_LOCAL=$(SYS_IMG_PATH_LOCAL)/callouts/
CALLOUT_GRAPHICS_PATH_RELEASE=$(SYS_IMG_PATH_RELEASE)/callouts/

FO_CALLOUT_GRAPHICS_EXTENSION=.svg
HTML_CALLOUT_GRAPHICS_EXTENSION=.png

#<xsl:param name="admon.graphics">1</xsl:param>
#<xsl:param name="admon.graphics.extension">.svg</xsl:param>
#<xsl:param name="admon.graphics.path">images/system/colorsvg/</xsl:param>
#CFG_ADMON_GRAPHICS=0
CFG_ADMON_GRAPHICS=1

FO_ADMON_GRAPHICS_EXTENSION=.svg
FO_ADMON_GRAPHICS_PATH=$(SYS_IMG_PATH_LOCAL)/colorsvg/

HTML_ADMON_GRAPHICS_EXTENSION=.png
#HTML_ADMON_GRAPHICS_PATH_LOCAL=$(SYS_IMG_PATH_LOCAL)/
HTML_ADMON_GRAPHICS_PATH_LOCAL=file:///$(SYS_IMG_PATH_LOCAL)/
HTML_ADMON_GRAPHICS_PATH_RELEASE=$(SYS_IMG_PATH_RELEASE)/

# ================== HTMLS related ==================
#<xsl:param name="navig.graphics">1</xsl:param>
#<xsl:param name="navig.graphics.extension">.png</xsl:param>
#<xsl:param name="navig.graphics.path">images/system/</xsl:param>
#CFG_NAVIG_GRAPHICS=0
CFG_NAVIG_GRAPHICS=1
#NAVIG_GRAPHICS_EXTENSION=$(HTML_ADMON_GRAPHICS_EXTENSION)
#NAVIG_GRAPHICS_EXTENSION=.svg
NAVIG_GRAPHICS_EXTENSION=.gif
NAVIG_GRAPHICS_PATH_LOCAL=$(HTML_ADMON_GRAPHICS_PATH_LOCAL)
NAVIG_GRAPHICS_PATH_RELEASE=$(HTML_ADMON_GRAPHICS_PATH_RELEASE)


# ================== HTML related ==================
JS_PATH_LOCAL=$(CONFIG_XSL_NS_BASE_CMD)/html/js
JS_PATH_RELEASE=$(ONLINE_RES_DOCBOOK)/js
#JS_FILE=statistic_page_view.js
#JS_FILE_LOCAL=$(JS_PATH_LOCAL)/$(JS_FILE)
#JS_FILE_RELEASE=$(JS_PATH_RELEASE)/$(JS_FILE)
INSERT_JS_FILE_LOCAL=$(JS_PATH_LOCAL)/insert_local_pageview_js.txt
INSERT_JS_FILE_RELEASE=$(JS_PATH_LOCAL)/insert_online_pageview_js.txt

#equation/programlisting/... setting
#<xsl:param name="html.stylesheet.type">text/css</xsl:param>
#<xsl:param name="html.stylesheet">css/common_html.css</xsl:param>
#CFG_HTML_CSS=0
CFG_HTML_CSS=1
HTML_STYLESHEET_TYPE = text/css
#CSS_PATH_LOCAL = $(CONFIG_XSL_NS_BASE_CMD)/css
CSS_PATH_LOCAL = $(CONFIG_ROOT_CMD)/css
CSS_PATH_RELEASE = $(ONLINE_RES_DOCBOOK)/css
#CSS_FILENAME=common_html.css
CSS_FILENAME=docbook_crl.css
# current only support single css file
LOCAL_CSS_FILE_FULLPATH=$(CSS_PATH_LOCAL)/$(CSS_FILENAME)
#HTML_STYLESHEET_LOCAL = $(CSS_PATH_LOCAL)/$(CSS_FILENAME)
#HTML_STYLESHEET_LOCAL = file:///$(CSS_PATH_LOCAL)/$(CSS_FILENAME)
HTML_STYLESHEET_LOCAL = file:///$(LOCAL_CSS_FILE_FULLPATH)
HTML_STYLESHEET_RELEASE = $(CSS_PATH_RELEASE)/$(CSS_FILENAME)

#HTMLHELP_STYLESHEET_LOCAL = /css/$(CSS_FILENAME)
HTMLHELP_STYLESHEET_LOCAL = css/$(CSS_FILENAME)

#HTMLS_OUTPUT_BASE_CMD = ../output

################################################################################
# Different Format Settings
################################################################################

# HTMLS
HTMLS_MAIN_FILENAME = index

################################################################################
# Common Tools and Parameters Settings
################################################################################

#===============================================================================
# XSLT related
#===============================================================================
#using tools
XSLT = xsltproc
XSLT_FLAGS_COMMON = \
    --xinclude \
    --stringparam callout.graphics $(CFG_CALLOUT_GRAPHICS) \
    --stringparam admon.graphics $(CFG_ADMON_GRAPHICS)

ifeq ($(CFG_CALLOUT_GRAPHICS), 1)
XSLT_FLAGS_COMMON += --stringparam callout.graphics.number.limit $(CALLOUT_NUMBER_LIMIT)
endif

# ================== FO related ==================
XSLT_FLAGS_FO = $(XSLT_FLAGS_COMMON)

# callout settings
ifeq ($(CFG_CALLOUT_GRAPHICS), 1)
XSLT_FLAGS_FO += --stringparam callout.graphics.extension $(FO_CALLOUT_GRAPHICS_EXTENSION)
XSLT_FLAGS_FO += --stringparam callout.graphics.path $(CALLOUT_GRAPHICS_PATH_LOCAL)
endif

# admon settings
ifeq ($(CFG_ADMON_GRAPHICS), 1)
XSLT_FLAGS_FO += --stringparam admon.graphics.extension $(FO_ADMON_GRAPHICS_EXTENSION)
XSLT_FLAGS_FO += --stringparam admon.graphics.path $(FO_ADMON_GRAPHICS_PATH)
endif

# ================== HTML related ==================
XSLT_FLAGS_COMMON_HTML = $(XSLT_FLAGS_COMMON)

# css settings
ifeq ($(CFG_HTML_CSS), 1)
STRINGPARAM_HTML_STYPLESHEET_TYPE := --stringparam html.stylesheet.type $(HTML_STYLESHEET_TYPE)

STRINGPARAM_HTML_STYPLESHEET_HTML_LOCAL := $(STRINGPARAM_HTML_STYPLESHEET_TYPE)
STRINGPARAM_HTML_STYPLESHEET_HTML_LOCAL += --stringparam html.stylesheet $(HTML_STYLESHEET_LOCAL)

STRINGPARAM_HTML_STYPLESHEET_HTML_RELEASE := $(STRINGPARAM_HTML_STYPLESHEET_TYPE)
STRINGPARAM_HTML_STYPLESHEET_HTML_RELEASE += --stringparam html.stylesheet $(HTML_STYLESHEET_RELEASE)

STRINGPARAM_HTML_STYPLESHEET_CHM_LOCAL := $(STRINGPARAM_HTML_STYPLESHEET_TYPE)
STRINGPARAM_HTML_STYPLESHEET_CHM_LOCAL += --stringparam html.stylesheet $(HTMLHELP_STYLESHEET_LOCAL)

#STRINGPARAM_HTML_STYPLESHEET_CHM_RELEASE

else
STRINGPARAM_HTML_STYPLESHEET_HTML_LOCAL := 
STRINGPARAM_HTML_STYPLESHEET_HTML_RELEASE := 

STRINGPARAM_HTML_STYPLESHEET_CHM_LOCAL :=
#STRINGPARAM_HTML_STYPLESHEET_CHM_RELEASE :=
endif

# callout settings
ifeq ($(CFG_CALLOUT_GRAPHICS), 1)
XSLT_FLAGS_COMMON_HTML += --stringparam callout.graphics.extension $(HTML_CALLOUT_GRAPHICS_EXTENSION)
endif
# admon settings
ifeq ($(CFG_ADMON_GRAPHICS), 1)
XSLT_FLAGS_COMMON_HTML += --stringparam admon.graphics.extension $(HTML_ADMON_GRAPHICS_EXTENSION)
endif
# # css settings
# ifeq ($(CFG_HTML_CSS), 1)
# XSLT_FLAGS_COMMON_HTML += $(STRINGPARAM_HTML_STYPLESHEET_COMMON_HTML)
# endif

XSLT_FLAGS_HTML_COMMON_LOCAL = 
ifeq ($(CFG_CALLOUT_GRAPHICS), 1)
XSLT_FLAGS_HTML_COMMON_LOCAL += --stringparam callout.graphics.path $(CALLOUT_GRAPHICS_PATH_LOCAL)
endif
ifeq ($(CFG_ADMON_GRAPHICS), 1)
XSLT_FLAGS_HTML_COMMON_LOCAL += --stringparam admon.graphics.path $(HTML_ADMON_GRAPHICS_PATH_LOCAL)
endif
# ifeq ($(CFG_HTML_CSS), 1)
# XSLT_FLAGS_HTML_COMMON_LOCAL += --stringparam html.stylesheet $(HTML_STYLESHEET_LOCAL)
# endif

XSLT_FLAGS_HTML_LOCAL  = $(XSLT_FLAGS_COMMON_HTML)
XSLT_FLAGS_HTML_LOCAL += $(XSLT_FLAGS_HTML_COMMON_LOCAL)
XSLT_FLAGS_HTML_LOCAL += $(STRINGPARAM_HTML_STYPLESHEET_HTML_LOCAL)

XSLT_FLAGS_HTML_COMMON_RELEASE = 
ifeq ($(CFG_CALLOUT_GRAPHICS), 1)
XSLT_FLAGS_HTML_COMMON_RELEASE += --stringparam callout.graphics.path $(CALLOUT_GRAPHICS_PATH_RELEASE)
endif
ifeq ($(CFG_ADMON_GRAPHICS), 1)
XSLT_FLAGS_HTML_COMMON_RELEASE += --stringparam admon.graphics.path $(HTML_ADMON_GRAPHICS_PATH_RELEASE)
endif
# ifeq ($(CFG_HTML_CSS), 1)
# XSLT_FLAGS_HTML_COMMON_RELEASE += --stringparam html.stylesheet $(HTML_STYLESHEET_RELEASE)
# endif

XSLT_FLAGS_HTML_RELEASE = $(XSLT_FLAGS_COMMON_HTML)
XSLT_FLAGS_HTML_RELEASE += $(XSLT_FLAGS_HTML_COMMON_RELEASE)
XSLT_FLAGS_HTML_RELEASE += $(STRINGPARAM_HTML_STYPLESHEET_HTML_RELEASE)

#HTML_CSS_FILE = $(CONFIG_XSL_NS_ROOT_CYGWIN)/html/css/common_html.css

# ================== HTMLs related ==================
XSLT_FLAGS_HTMLS = $(XSLT_FLAGS_COMMON_HTML) \
    --stringparam manifest $(PROJECT_NAME).html.manifest

#    --stringparam root.filename $(PROJECT_NAME)
#    --stringparam base.dir $(HTMLS_OUTPUT_BASE_CMD)/html/multi/

XSLT_FLAGS_HTMLS_LOCAL  = $(XSLT_FLAGS_HTMLS)
XSLT_FLAGS_HTMLS_LOCAL += $(XSLT_FLAGS_HTML_COMMON_LOCAL)
XSLT_FLAGS_HTMLS_LOCAL += $(STRINGPARAM_HTML_STYPLESHEET_HTML_LOCAL)
XSLT_FLAGS_HTMLS_LOCAL += --stringparam navig.graphics $(CFG_NAVIG_GRAPHICS)
ifeq ($(CFG_NAVIG_GRAPHICS), 1)
XSLT_FLAGS_HTMLS_LOCAL += --stringparam navig.graphics.extension $(NAVIG_GRAPHICS_EXTENSION)
XSLT_FLAGS_HTMLS_LOCAL += --stringparam navig.graphics.path $(NAVIG_GRAPHICS_PATH_LOCAL)
endif

XSLT_FLAGS_HTMLS_RELEASE  = $(XSLT_FLAGS_HTMLS)
XSLT_FLAGS_HTMLS_RELEASE += $(XSLT_FLAGS_HTML_COMMON_RELEASE)
XSLT_FLAGS_HTMLS_RELEASE += $(STRINGPARAM_HTML_STYPLESHEET_HTML_RELEASE)
XSLT_FLAGS_HTMLS_RELEASE += --stringparam navig.graphics $(CFG_NAVIG_GRAPHICS)
ifeq ($(CFG_NAVIG_GRAPHICS), 1)
XSLT_FLAGS_HTMLS_RELEASE += --stringparam navig.graphics.extension $(NAVIG_GRAPHICS_EXTENSION)
XSLT_FLAGS_HTMLS_RELEASE += --stringparam navig.graphics.path $(NAVIG_GRAPHICS_PATH_RELEASE)
endif


# ================== CHM related ==================
XSLT_FLAGS_CHM = \
    $(XSLT_FLAGS_HTMLS) \
    $(XSLT_FLAGS_HTML_COMMON_LOCAL) \
    $(STRINGPARAM_HTML_STYPLESHEET_CHM_LOCAL) \
    --stringparam htmlhelp.chm $(PROJECT_NAME).chm

#===============================================================================
# Webhelp related
#===============================================================================

#WEBHELP_INDEX_LANGUAGE = en
WEBHELP_INDEX_LANGUAGE = zh

# A list of files to exclude from indexing
INDEXER_EXCLUDED_FILES = ix01.html

#WEBHELP_XINCLUDED_XML_FILE = xincluded-profiled.xml
WEBHELP_XINCLUDED_XML_FILE = $(PROJECT_NAME)_xincluded_profiled.xml

#WEBHELP_XSL_FILE=$(TOOLS_XSL_NS_WEBHELP)/xsl/webhelp.xsl
#WEBHELP_XSL_FILE=$(CONFIG_XSL_NS_BASE_CMD)/webhelp/webhelp_crl.xsl

WEBHELP_TEMPLATE_COMMON_LOCAL   = file:///$(TOOLS_XSL_NS_WEBHELP)/template/common/
WEBHELP_TEMPLATE_COMMON_RELEASE = $(ONLINE_RES_DOCBOOK)/webhelp/template/common/
#WEBHELP_TEMPLATE_COMMON_RELEASE = $(ONLINE_RES_DOCBOOK)/webhelp/template_new/common/

# Use this variable to pass in other stringparams
# to the xsltproc pass that generates DocBook output.
# For example:
# WEBHELP_OTHER_XSLTPROC_ARGS = --stringparam example.param ""

#http://docbook.sourceforge.net/release/xsl/1.78.1/doc/html/webhelp.base.dir.html
#if not set, default will be docs under current docbook book src directory
XSLT_FLAGS_WEBHELP = \
    --stringparam webhelp.base.dir $(OUTPUT_DIR_WEBHELP) \
    --stringparam webhelp.indexer.language $(WEBHELP_INDEX_LANGUAGE)

XSLT_FLAGS_WEBHELP_LOCAL = $(XSLT_FLAGS_WEBHELP)
XSLT_FLAGS_WEBHELP_LOCAL += $(XSLT_FLAGS_HTMLS_LOCAL) \
    --stringparam webhelp.common.dir  $(WEBHELP_TEMPLATE_COMMON_LOCAL)

#test_xslt_flags_webhelp_local:
#	@echo $(XSLT_FLAGS_WEBHELP_LOCAL)

XSLT_FLAGS_WEBHELP_RELEASE = $(XSLT_FLAGS_WEBHELP)
XSLT_FLAGS_WEBHELP_RELEASE += $(XSLT_FLAGS_HTMLS_RELEASE) \
    --stringparam webhelp.common.dir  $(WEBHELP_TEMPLATE_COMMON_RELEASE)

#default set to local
WEBHELP_OTHER_XSLTPROC_ARGS = $(XSLT_FLAGS_WEBHELP_LOCAL)

#test_webhelp_other_xsltproc_args:
#	@echo $(WEBHELP_OTHER_XSLTPROC_ARGS)

# Profiling params. For more information on 
# profiling (conditional text) and DocBook documents, see
# http://www.sagehill.net/docbookxsl/Profiling.html
# http://docbook.sourceforge.net/release/xsl/1.78.1/doc/html/profiling.html
PROFILE.ARCH = ""
PROFILE.AUDIENCE = ""
PROFILE.CONDITION = ""
PROFILE.CONFORMANCE = ""
PROFILE.LANG = ""
PROFILE.OS = ""
PROFILE.REVISION = ""
PROFILE.REVISIONFLAG = ""
PROFILE.ROLE = ""
PROFILE.SECURITY = ""
PROFILE.STATUS = ""
PROFILE.USERLEVEL = ""
PROFILE.VENDOR = ""
PROFILE.WORDSIZE = ""
PROFILE.ATTRIBUTE = ""
PROFILE.VALUE = ""

# =================================================
# You probably don't need to change anything below
# unless you choose to add a validation step.
# ================================================
INDEXER_JAR         := $(TOOLS_XSL_NS_EXTENSIONS)/webhelpindexer.jar
TAGSOUP_JAR         := $(TOOLS_XSL_NS_EXTENSIONS)/tagsoup-1.2.1.jar
LUCENE_ANALYZER_JAR := $(TOOLS_XSL_NS_EXTENSIONS)/lucene-analyzers-3.0.0.jar
LUCENE_CORE_JAR     := $(TOOLS_XSL_NS_EXTENSIONS)/lucene-core-3.0.0.jar

CLASSPATH_FROM_ENV = $(CLASSPATH)
#CLASSPATH_FROM_ENV := $(CLASSPATH)
#CLASSPATH_FROM_ENV ?= $(CLASSPATH)

#under Windows(Cygwin), (java classpath)
#(1)path seperator is semicolon ';' (not Linux's colon ':')
#(2) command contain semicolon means multile command, so need quote
# so become -> "path1;path2;path3"
#detail can refer:
#【已解决】docbook中去make webhelp编译webhelp结果出错：Error: Could not find or load main class com.nexwave.nquindexer.IndexerMain
#http://www.crifan.com/docbook_make_webhelp_error__could_not_find_or_load_main_class_com_nexwave_nquindexer_indexermain/
ifeq ($(OS_NAME_LOWCASE), cygwin)
PATH_DELIMITER = ;
else
PATH_DELIMITER = :
endif

#WEBHELP_CLASSPATH := $(INDEXER_JAR):$(TAGSOUP_JAR):$(LUCENE_ANALYZER_JAR):$(LUCENE_CORE_JAR)
#WEBHELP_CLASSPATH := "$(INDEXER_JAR);$(TAGSOUP_JAR);$(LUCENE_ANALYZER_JAR);$(LUCENE_CORE_JAR)"
#WEBHELP_CLASSPATH := $(INDEXER_JAR):$(TAGSOUP_JAR):$(LUCENE_ANALYZER_JAR):$(LUCENE_CORE_JAR)
#WEBHELP_CLASSPATH := "$(CLASSPATH_FROM_ENV)$(PATH_DELIMITER)$(INDEXER_JAR)$(PATH_DELIMITER)$(TAGSOUP_JAR)$(PATH_DELIMITER)$(LUCENE_ANALYZER_JAR)$(PATH_DELIMITER)$(LUCENE_CORE_JAR)"
#WEBHELP_CLASSPATH = "$(INDEXER_JAR)$(PATH_DELIMITER)$(TAGSOUP_JAR)$(PATH_DELIMITER)$(LUCENE_ANALYZER_JAR)$(PATH_DELIMITER)$(LUCENE_CORE_JAR)$(PATH_DELIMITER)$(CLASSPATH_FROM_ENV)"
WEBHELP_CLASSPATH := "$(INDEXER_JAR)$(PATH_DELIMITER)$(TAGSOUP_JAR)$(PATH_DELIMITER)$(LUCENE_ANALYZER_JAR)$(PATH_DELIMITER)$(LUCENE_CORE_JAR)$(PATH_DELIMITER)$(CLASSPATH_FROM_ENV)"

#===============================================================================
# FOP related
#===============================================================================
FOP = fop
FOP_FLAGS = --execdebug -c $(FOP_CFG_ROOT_CMD)/fop.xconf

#===============================================================================
# compression related
#===============================================================================
# compression
COMPRESS_TOOL = 7z
#compression options: http://www.dotnetperls.com/7-zip-examples
COMPRESS_LEVEL = x9 
COMPRESS_FLAG = a -m$(COMPRESS_LEVEL)
COMPRESS_SUF = 7z

################################################################################
# Path/Location Settings
################################################################################

SRC_DIR = .
MAIN_SRC_FILE = $(SRC_DIR)/$(PROJECT_NAME).xml
OUTPUT_DIR = ../output
RELEASE_DIR = ../release

IMG_DIR = $(SRC_DIR)/images

#SYS_IMG_SRC_DIR = $(CONFIG_ROOT_CYGWIN)/images/system
#SYS_IMG_DST_DIR = $(IMG_DIR)/system
#SOMEONE_UNDER_SYS_IMG = $(SYS_IMG_DST_DIR)/home.gif

OUTPUT_DIR_PO       = $(OUTPUT_DIR)/fo
OUTPUT_DIR_PDF      = $(OUTPUT_DIR)/pdf
OUTPUT_DIR_RTF      = $(OUTPUT_DIR)/rtf/fop
OUTPUT_DIR_HTML     = $(OUTPUT_DIR)/html/single
OUTPUT_DIR_TXT      = $(OUTPUT_DIR)/plain_text/w3m
OUTPUT_DIR_HTMLS    = $(OUTPUT_DIR)/html/multi
OUTPUT_DIR_HTMLHELP = $(OUTPUT_DIR)/htmlhelp
OUTPUT_DIR_CHM      = $(OUTPUT_DIR_HTMLHELP)
OUTPUT_DIR_WEBHELP  = $(OUTPUT_DIR)/webhelp

OUTPUT_FILE_PO      = $(OUTPUT_DIR_PO)/$(PROJECT_NAME).fo
OUTPUT_FILE_PDF     = $(OUTPUT_DIR_PDF)/$(PROJECT_NAME).pdf
OUTPUT_FILE_RTF     = $(OUTPUT_DIR_RTF)/$(PROJECT_NAME).rtf
OUTPUT_FILE_HTML    = $(OUTPUT_DIR_HTML)/$(PROJECT_NAME).html
OUTPUT_FILE_TXT     = $(OUTPUT_DIR_TXT)/$(PROJECT_NAME).txt
OUTPUT_FILE_HTMLS   = $(OUTPUT_DIR_HTMLS)/$(HTMLS_MAIN_FILENAME).html
#OUTPUT_FILE_HTMLS   = $(OUTPUT_DIR_HTMLS)/$(PROJECT_NAME).html
OUTPUT_FILE_HTMLHELP= $(OUTPUT_DIR_HTMLHELP)/$(PROJECT_NAME).html
OUTPUT_FILE_CHM     = $(OUTPUT_DIR_CHM)/$(PROJECT_NAME).chm
OUTPUT_FILE_WEBHELP = $(OUTPUT_DIR_WEBHELP)/index.html

XSL_NS_FILE_FO      = docbook_fo_crl.xsl
XSL_NS_FILE_HTML    = docbook_html_crl.xsl
XSL_NS_FILE_HTMLS   = chunk_html_crl.xsl
XSL_NS_FILE_HTMLHELP= docbook_htmlhelp_crl.xsl
XSL_NS_FILE_WEBHELP = docbook_webhelp_crl.xsl

RELEASE_DIR_PDF     = $(RELEASE_DIR)/pdf
RELEASE_DIR_RTF     = $(RELEASE_DIR)/rtf
RELEASE_DIR_HTML    = $(RELEASE_DIR)/html
RELEASE_DIR_TXT     = $(RELEASE_DIR)/txt
RELEASE_DIR_HTMLS   = $(RELEASE_DIR)/htmls
RELEASE_DIR_CHM     = $(RELEASE_DIR)/chm
RELEASE_DIR_WEBHELP = $(RELEASE_DIR)/webhelp


################################################################################
# Commands to Generate Files
################################################################################

# generate all files
all: pdf rtf html txt htmls chm webhelp
# copy all generated files into specific foler and also do compression
.PHONY: release_pdf release_rtf release_html release_txt release_htmls release_chm release_webhelp

release: release_pdf release_rtf release_html release_txt release_htmls release_chm release_webhelp

.PHONY:release_copy release
LOCAL_RELEASE_PROJECT=$(LOCAL_RELEASE_PARENT_CMD)/$(PROJECT_NAME)
#copy the release to local dir
release_copy:release
	mkdir -p $(LOCAL_RELEASE_PROJECT)
	rm -rf $(LOCAL_RELEASE_PROJECT)/*
	cp -a $(RELEASE_DIR) $(LOCAL_RELEASE_PROJECT)

#copy generated pdf to some folder, facilitate to find all pdf in one place
pdf_copy:pdf
	mkdir -p $(LOCAL_PDF_CMD)
	rm -rf $(LOCAL_PDF_CMD)/$(PROJECT_NAME).pdf
	cp -a $(OUTPUT_FILE_PDF) $(LOCAL_PDF_CMD)


################################################################################
# Common actions
################################################################################
#always_copy_sys_img:

# copy the system related pictures(callout/navi/admonition/...) figures to ./images/system
#copy_sys_img:always_copy_sys_img
#	cp -a $(SYS_IMG_SRC_DIR) $(SYS_IMG_DST_DIR)

# remove copied system related pictures(callout/navi/admonition/...) figures from ./images/system
#clean_sys_img:
#	rm -rf $(SYS_IMG_DST_DIR)

#exist_sys_img: always_copy_sys_img copy_sys_img
#.PHONY:copy_sys_img

################################################################################
# fo
################################################################################
$(OUTPUT_FILE_PO):$(MAIN_SRC_FILE) $(SUB_SRC_FILES) $(MAKE_FILE)
	@echo "=============================== generating ${PROJECT_NAME} fo =============================="
	export XML_CATALOG_FILES="$(XML_CATALOG_FILES)" && \
	export XML_DEBUG_CATALOG=1 && \
	$(XSLT) $(XSLT_FLAGS_FO) -o $@ $(XSL_NS_FILE_FO) $<

################################################################################
# pdf
################################################################################
$(OUTPUT_FILE_PDF): $(OUTPUT_FILE_PO)
	@echo "=============================== generating ${PROJECT_NAME} pdf =============================="
	$(FOP) $(FOP_FLAGS) $< -pdf $@

pdf: $(OUTPUT_FILE_PDF)

clean_pdf:
	@echo "=============================== cleaning ${PROJECT_NAME} pdf =============================="
	rm -f $(OUTPUT_FILE_PO)
	rm -f $(OUTPUT_FILE_PDF)

release_pdf:$(OUTPUT_FILE_PDF)
	@echo "=============================== release ${PROJECT_NAME} pdf =============================="
	cp -a $(OUTPUT_FILE_PDF) $(RELEASE_DIR_PDF)
	$(COMPRESS_TOOL) $(COMPRESS_FLAG) $(RELEASE_DIR_PDF)/$(PROJECT_NAME).$(subst release_,,$@).$(COMPRESS_SUF) $(OUTPUT_FILE_PDF)

clean_release_pdf:
	@echo "=============================== cleaning ${PROJECT_NAME} pdf release =============================="
	rm -f $(RELEASE_DIR_PDF)/*

################################################################################
# rtf
################################################################################
$(OUTPUT_FILE_RTF):$(OUTPUT_FILE_PO)
	@echo "=============================== generating ${PROJECT_NAME} rtf =============================="
	#cp -a $(SYS_IMG_SRC_DIR) $(SYS_IMG_DST_DIR)
	$(FOP) $(FOP_FLAGS) $< -rtf $@
	#rm -rf $(SYS_IMG_DST_DIR)

rtf: $(OUTPUT_FILE_RTF)

clean_rtf:
	@echo "=============================== cleaning ${PROJECT_NAME} rtf =============================="
	rm -f $(OUTPUT_FILE_PO)
	rm -f $(OUTPUT_FILE_RTF)

release_rtf:$(OUTPUT_FILE_RTF)
	@echo "=============================== release ${PROJECT_NAME} chm =============================="
	cp -a $(OUTPUT_FILE_RTF) $(RELEASE_DIR_RTF)
	$(COMPRESS_TOOL) $(COMPRESS_FLAG) $(RELEASE_DIR_RTF)/$(PROJECT_NAME).$(subst release_,,$@).$(COMPRESS_SUF) $(OUTPUT_FILE_RTF)

clean_release_rtf:
	@echo "=============================== cleaning ${PROJECT_NAME} rtf release =============================="
	rm -f $(RELEASE_DIR_RTF)/*

################################################################################
# html
################################################################################
$(OUTPUT_FILE_HTML): $(MAIN_SRC_FILE) $(SUB_SRC_FILES) $(MAKE_FILE)
	@echo "=============================== generating ${PROJECT_NAME} html =============================="
	export XML_CATALOG_FILES="$(XML_CATALOG_FILES)" && \
	export XML_DEBUG_CATALOG=1 && \
	$(XSLT) $(XSLT_FLAGS_HTML_LOCAL) -o $@ $(XSL_NS_FILE_HTML) $<
	@#cat $(INSERT_JS_FILE_LOCAL) >> $(OUTPUT_FILE_HTML)
	#cp -a $(CSS_DIR) $(OUTPUT_DIR_HTML)/
	#cp -a $(SYS_IMG_SRC_DIR) $(SYS_IMG_DST_DIR)
	cp -a $(IMG_DIR) $(OUTPUT_DIR_HTML)/
	#rm -rf $(SYS_IMG_DST_DIR)

#here Here add clean before output file is to makesure NOT use the possbile existed one which is created by 'make release'
html: clean_html $(OUTPUT_FILE_HTML)

clean_html:
	@echo "=============================== cleaning ${PROJECT_NAME} html =============================="
	rm -rf $(OUTPUT_DIR_HTML)/*

#release_html:$(OUTPUT_FILE_HTML)
release_html: $(MAIN_SRC_FILE) $(SUB_SRC_FILES) $(MAKE_FILE)
	@echo "=============================== release ${PROJECT_NAME} html =============================="
	export XML_CATALOG_FILES="$(XML_CATALOG_FILES)" && \
	export XML_DEBUG_CATALOG=1 && \
	$(XSLT) $(XSLT_FLAGS_HTML_RELEASE) -o $(OUTPUT_FILE_HTML) $(XSL_NS_FILE_HTML) $<
	@#cat $(INSERT_JS_FILE_RELEASE) >> $(OUTPUT_FILE_HTML)
	#cp -a $(CSS_DIR) $(OUTPUT_DIR_HTML)/
	#cp -a $(SYS_IMG_SRC_DIR) $(SYS_IMG_DST_DIR)
	cp -a $(IMG_DIR) $(OUTPUT_DIR_HTML)/
	#rm -rf $(SYS_IMG_DST_DIR)
	cp -a $(OUTPUT_DIR_HTML)/* $(RELEASE_DIR_HTML)
	$(COMPRESS_TOOL) $(COMPRESS_FLAG) $(RELEASE_DIR_HTML)/$(PROJECT_NAME).$(subst release_,,$@).$(COMPRESS_SUF) $(OUTPUT_DIR_HTML)/*

#clean_release_html:
clean_release_html: clean_html
	@echo "=============================== cleaning ${PROJECT_NAME} html release =============================="
	rm -rf $(RELEASE_DIR_HTML)/*

################################################################################
# txt
################################################################################
$(OUTPUT_FILE_TXT): $(OUTPUT_FILE_HTML)
	@echo "=============================== generating ${PROJECT_NAME} txt =============================="
	w3m -I UTF8 -O UTF8 -dump $(OUTPUT_FILE_HTML) > $(OUTPUT_FILE_TXT)
	unix2dos $(OUTPUT_FILE_TXT)

txt: $(OUTPUT_FILE_TXT)

clean_txt:
	@echo "=============================== cleaning ${PROJECT_NAME} txt =============================="
	rm -f $(OUTPUT_FILE_TXT)

release_txt:$(OUTPUT_FILE_TXT)
	@echo "=============================== release ${PROJECT_NAME} txt =============================="
	cp -a $(OUTPUT_FILE_TXT) $(RELEASE_DIR_TXT)
	$(COMPRESS_TOOL) $(COMPRESS_FLAG) $(RELEASE_DIR_TXT)/$(PROJECT_NAME).$(subst release_,,$@).$(COMPRESS_SUF) $(OUTPUT_FILE_TXT)

clean_release_txt:
	@echo "=============================== cleaning ${PROJECT_NAME} txt release =============================="
	rm -f $(RELEASE_DIR_TXT)/*

################################################################################
# htmls
################################################################################
$(OUTPUT_FILE_HTMLS):$(MAIN_SRC_FILE) $(SUB_SRC_FILES) $(MAKE_FILE)
	@echo "=============================== generating ${PROJECT_NAME} htmls =============================="
	export XML_CATALOG_FILES="$(XML_CATALOG_FILES)" && \
	export XML_DEBUG_CATALOG=1 && \
	$(XSLT) $(XSLT_FLAGS_HTMLS_LOCAL) -o $@ $(XSL_NS_FILE_HTMLS) $<
	#cp -a $(CSS_DIR) $(OUTPUT_DIR_HTMLS)/
	#cp -a $(SYS_IMG_SRC_DIR) $(SYS_IMG_DST_DIR)
	cp -a $(IMG_DIR) $(OUTPUT_DIR_HTMLS)/
	#rm -rf $(SYS_IMG_DST_DIR)

#here Here add clean before output file is to makesure NOT use the possbile existed one which is created by 'make release'
htmls: clean_htmls $(OUTPUT_FILE_HTMLS)

clean_htmls:
	@echo "=============================== cleaning ${PROJECT_NAME} htmls =============================="
	rm -rf $(OUTPUT_DIR_HTMLS)/*

.PHONY:release_htmls
release_htmls:$(MAIN_SRC_FILE) $(SUB_SRC_FILES) $(MAKE_FILE)
	@echo "=============================== release ${PROJECT_NAME} htmls =============================="
	export XML_CATALOG_FILES="$(XML_CATALOG_FILES)" && \
	export XML_DEBUG_CATALOG=1 && \
	$(XSLT) $(XSLT_FLAGS_HTMLS_RELEASE) -o $(OUTPUT_FILE_HTMLS) $(XSL_NS_FILE_HTMLS) $<
	#cp -a $(CSS_DIR) $(OUTPUT_DIR_HTMLS)/
	#cp -a $(SYS_IMG_SRC_DIR) $(SYS_IMG_DST_DIR)
	cp -a $(IMG_DIR) $(OUTPUT_DIR_HTMLS)/
	#rm -rf $(SYS_IMG_DST_DIR)
	cp -a $(OUTPUT_DIR_HTMLS)/* $(RELEASE_DIR_HTMLS)
	$(COMPRESS_TOOL) $(COMPRESS_FLAG) $(RELEASE_DIR_HTMLS)/$(PROJECT_NAME).$(subst release_,,$@).$(COMPRESS_SUF) $(OUTPUT_DIR_HTMLS)/*

clean_release_htmls:
	@echo "=============================== cleaning ${PROJECT_NAME} htmls release =============================="
	rm -rf $(RELEASE_DIR_HTMLS)/*

################################################################################
# website
################################################################################
website:$(MAIN_SRC_FILE) $(SUB_SRC_FILES) $(MAKE_FILE)
	@echo "=============================== generating ${PROJECT_NAME} website =============================="

################################################################################
# webhelp
################################################################################
# webhelp:
#	@echo "=============================== generating ${PROJECT_NAME} webhelp =============================="
#	ant webhelp

#above has set this value
#webhelp: WEBHELP_OTHER_XSLTPROC_ARGS = $(XSLT_FLAGS_WEBHELP_LOCAL)
webhelp: $(MAIN_SRC_FILE) $(SUB_SRC_FILES) $(MAKE_FILE) webhelp_copyfiles webhelp_chunk webhelp_index
	@echo "=============================== generating ${PROJECT_NAME} webhelp =============================="

webhelp_copyfiles:
	-rm -rf $(OUTPUT_DIR_WEBHELP)
	mkdir -p $(OUTPUT_DIR_WEBHELP)
	@#cp -r $(TOOLS_XSL_NS_WEBHELP)/template/common ${OUTPUT_DIR_WEBHELP}
	cp -a $(IMG_DIR) $(OUTPUT_DIR_WEBHELP)
	test ! -d $(IMG_DIR)/ || cp -a $(IMG_DIR)/ ${OUTPUT_DIR_WEBHELP}
	cp $(TOOLS_XSL_NS_WEBHELP)/template/favicon.ico ${OUTPUT_DIR_WEBHELP}/

#	@echo $(WEBHELP_OTHER_XSLTPROC_ARGS)
webhelp_chunk:
	$(XSLT) \
        --output $(WEBHELP_XINCLUDED_XML_FILE)  \
        --stringparam  profile.arch ${PROFILE.ARCH} \
        --stringparam  profile.audience ${PROFILE.AUDIENCE} \
        --stringparam  profile.condition ${PROFILE.CONDITION} \
        --stringparam  profile.conformance ${PROFILE.CONFORMANCE} \
        --stringparam  profile.lang ${PROFILE.LANG} \
        --stringparam  profile.os ${PROFILE.OS} \
        --stringparam  profile.revision ${PROFILE.REVISION} \
        --stringparam  profile.revisionflag ${PROFILE.REVISIONFLAG} \
        --stringparam  profile.role ${PROFILE.ROLE} \
        --stringparam  profile.security ${PROFILE.SECURITY} \
        --stringparam  profile.status ${PROFILE.STATUS} \
        --stringparam  profile.userlevel ${PROFILE.USERLEVEL} \
        --stringparam  profile.vendor ${PROFILE.VENDOR} \
        --stringparam  profile.wordsize ${PROFILE.WORDSIZE} \
        --stringparam  profile.attribute ${PROFILE.ATTRIBUTE} \
        --stringparam  profile.value ${PROFILE.VALUE} \
        $(TOOLS_XSL_NS_PROFILING)/profile.xsl  \
        $(MAIN_SRC_FILE)
	export XML_CATALOG_FILES="$(XML_CATALOG_FILES)" && \
	export XML_DEBUG_CATALOG=1 && \
	$(XSLT) --debug ${WEBHELP_OTHER_XSLTPROC_ARGS} $(XSL_NS_FILE_WEBHELP) $(WEBHELP_XINCLUDED_XML_FILE)
	rm $(WEBHELP_XINCLUDED_XML_FILE)

#	$(XSLT) --debug ${WEBHELP_OTHER_XSLTPROC_ARGS} $(WEBHELP_XSL_FILE) $(WEBHELP_XINCLUDED_XML_FILE)

webhelp_index:
	java \
        -DhtmlDir=$(OUTPUT_DIR_WEBHELP) \
        -DindexerLanguage=$(WEBHELP_INDEX_LANGUAGE) \
        -DhtmlExtension=html \
        -DdoStem=true \
        -DindexerExcludedFiles=$(INDEXER_EXCLUDED_FILES) \
        -Dorg.xml.sax.driver=org.ccil.cowan.tagsoup.Parser \
        -Djavax.xml.parsers.SAXParserFactory=org.ccil.cowan.tagsoup.jaxp.SAXFactoryImpl \
        -classpath $(WEBHELP_CLASSPATH) \
        com.nexwave.nquindexer.IndexerMain
	mkdir -p ${OUTPUT_DIR_WEBHELP}/search
	cp -r $(TOOLS_XSL_NS_WEBHELP)/template/search/* ${OUTPUT_DIR_WEBHELP}/search

clean_webhelp:
	@echo "=============================== cleaning ${PROJECT_NAME} webhelp =============================="
	@#ant clean
	-rm -rf $(OUTPUT_DIR_WEBHELP)

#overwrite default from local to release
release_webhelp: WEBHELP_OTHER_XSLTPROC_ARGS := $(XSLT_FLAGS_WEBHELP_RELEASE)
release_webhelp: webhelp
	@echo "=============================== release ${PROJECT_NAME} webhelp =============================="
	mkdir -p $(RELEASE_DIR_WEBHELP)
	- cp -a $(OUTPUT_DIR_WEBHELP)/* $(RELEASE_DIR_WEBHELP)
	- $(COMPRESS_TOOL) $(COMPRESS_FLAG) $(RELEASE_DIR_WEBHELP)/$(PROJECT_NAME).$(subst release_,,$@).$(COMPRESS_SUF) $(OUTPUT_DIR_WEBHELP)/*

clean_release_webhelp:
	@echo "=============================== cleaning ${PROJECT_NAME} webhelp release =============================="
	rm -rf $(RELEASE_DIR_WEBHELP)/*

################################################################################
# chm
################################################################################
$(OUTPUT_FILE_HTMLHELP):$(MAIN_SRC_FILE) $(SUB_SRC_FILES)
	@echo "=============================== generating ${PROJECT_NAME} chm =============================="
	export XML_CATALOG_FILES="$(XML_CATALOG_FILES)" && \
	export XML_DEBUG_CATALOG=1 && \
	$(XSLT) $(XSLT_FLAGS_CHM) -o $@ $(XSL_NS_FILE_HTMLHELP) $<
	#cp -a $(CSS_DIR) $(OUTPUT_DIR_CHM)/
	#cp -a $(SYS_IMG_SRC_DIR) $(SYS_IMG_DST_DIR)
	cp -a $(IMG_DIR) $(OUTPUT_DIR_CHM)/
	#rm -rf $(SYS_IMG_DST_DIR)

$(OUTPUT_FILE_CHM):$(OUTPUT_FILE_HTMLHELP) $(OUTPUT_DIR_CHM)/htmlhelp.hhp $(OUTPUT_DIR_CHM)/toc.hhc
	mkdir -p $(OUTPUT_DIR_CHM)/css/
	cp $(LOCAL_CSS_FILE_FULLPATH) $(OUTPUT_DIR_CHM)/css/
	-iconv -f UTF-8 -t GB18030 < $(OUTPUT_DIR_CHM)/htmlhelp.hhp > $(OUTPUT_DIR_CHM)/htmlhelp_gb18030.hhp
	-mv $(OUTPUT_DIR_CHM)/htmlhelp_gb18030.hhp $(OUTPUT_DIR_CHM)/htmlhelp.hhp
	-iconv -f UTF-8 -t GB18030 < $(OUTPUT_DIR_CHM)/toc.hhc > $(OUTPUT_DIR_CHM)/toc_gb18030.hhc
	-mv $(OUTPUT_DIR_CHM)/toc_gb18030.hhc $(OUTPUT_DIR_CHM)/toc.hhc
	@# here use '-' to ignore the hhc error
	@# case 1: normal run hhc will return 1 -> makefile consider it error -> will got Error 1
	@# case 2: for office environment, there is no hhc -> will got Error 127
	- hhc $(OUTPUT_DIR_CHM)/htmlhelp.hhp

chm: $(OUTPUT_FILE_CHM)

clean_chm:
	@echo "=============================== cleaning ${PROJECT_NAME} chm =============================="
	rm -rf $(OUTPUT_DIR_CHM)/*

release_chm:$(OUTPUT_FILE_CHM)
	@echo "=============================== release ${PROJECT_NAME} chm =============================="
	- cp -a $(OUTPUT_FILE_CHM) $(RELEASE_DIR_CHM)
	- $(COMPRESS_TOOL) $(COMPRESS_FLAG) $(RELEASE_DIR_CHM)/$(PROJECT_NAME).$(subst release_,,$@).$(COMPRESS_SUF) $(OUTPUT_FILE_CHM)

clean_release_chm:
	@echo "=============================== cleaning ${PROJECT_NAME} chm release =============================="
	rm -f $(RELEASE_DIR_CHM)/*

################################################################################
# clean all generated files
clean_all: clean_pdf clean_rtf clean_html clean_txt clean_htmls clean_chm clean_webhelp
# clean all released files
clean_release: clean_release_pdf clean_release_rtf clean_release_html clean_release_txt clean_release_htmls clean_release_chm clean_release_webhelp
# clean all of generated and released files
clean:clean_release clean_all

################################################################################
help:
	@echo  'Generate targets:'
	@echo  '  all             - Generate files to ouput folders for all formats:'
	@echo  '                    pdf/rtf/html/txt/htmls/chm'
	@echo  '  release         - Copy generated files to release folders for all formats:'
	@echo  '                    pdf/rtf/html/txt/htmls/chm'
	@echo  '  FORMAT          - Generate specific format file to ouput folder for'
	@echo  '                  - FORMAT=pdf/rtf/html/txt/htmls/chm'
	@echo  '  release_FORMAT  - do release for FORMAT=pdf/rtf/html/txt/htmls/chm'
	@echo  'Cleaning targets:'
	@echo  '  clean           - Clean generated files and released files for all format'
	@echo  '                    == clean_release clean_all'
	@echo  '  clean_all       - Clean generated files for all format'
	@echo  '  clean_FORMAT    - Clean for FORMAT=pdf/rtf/html/txt/htmls/chm'
	@echo  '  clean_release   - Clean released files for all format'
	@echo  '  clean_release_FORMAT - Clean release for FORMAT=pdf/rtf/html/txt/htmls/chm'