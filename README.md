# crifanDocbookTemplate

最后更新：`20240403`

Crifan的Docbook的模板

## 说明

最早自己创建电子书，是用的：[Docbook](https://www.crifan.com/files/doc/docbook/docbook_dev_note/release/html/docbook_dev_note.html)

而本身Docbook的环境搭建，相对很复杂。

所以之前最初弄了个[最精简版本的模板](https://www.crifan.com/files/doc/docbook/docbook_dev_note/release/html/docbook_dev_note.html#pure_win_docbook_dev_env)，下载地址是：[docbook5_demo_noTools.7z](http://crifan.com/files/res/docbook/demo/docbook5_demo_noTools.7z)

而此处是：贴出之前用的，最完整的，最全面的，最复杂的整套Docbook开发环境。

## Docbook目录

之前本身结构是：

* tools是上一级目录
  ```bash
  * docbook
    * ant
    * config
    * books
  * tools
  ```

现在为了统一整合，已移动tools到当前目录，变成：

* tools是同级目录
  ```bash
  * crifanDocbookTemplate
    * ant
    * config
    * books
    * tools
  ```

## 已发布所有Docbook源码

旧的所有的Docbook的源码都已发布：

* [ANTLR教程](https://github.com/crifan/antlr_tutorial)
* [ARM与MIPS的详细对比](https://github.com/crifan/arm_vs_mips)
* [GNU Binutils详解](https://github.com/crifan/binutils_intro)
* [蓝牙协议详解](https://github.com/crifan/bluetooth_intro)
* [建设网站详细教程](https://github.com/crifan/build_website)
* [Buildroot详解](https://github.com/crifan/buildroot_intro)
* [买房详细教程](https://github.com/crifan/buy_house)
* [字符编码详解](https://github.com/crifan/char_encoding)
* [字符编码应用](https://github.com/crifan/char_encoding_usage)
* [电脑基础知识教程](https://github.com/crifan/compute_basic)
* [crifan推荐软件](https://github.com/crifan/crifan_rec_soft)
* [详解crifan的C#库：crifanLib.cs](https://github.com/crifan/crifanlib_csharp)
* [详解crifan的Python库：crifanLib.py](https://github.com/crifan/crifanlib_python)
* [交叉编译详解](https://github.com/crifan/cross_compile)
* [crosstool-ng详解](https://github.com/crifan/crosstool_ng)
* [C#学习心得](https://github.com/crifan/csharp_summary)
* [Cygwin详解](https://github.com/crifan/cygwin_intro)
* [详解ARM的AMBA设备中的DMA设备PL08X的Linux驱动](https://github.com/crifan/dma_pl08x_analysis)
* [Docbook开发手记](https://github.com/crifan/docbook_dev_note)
* [嵌入式驱动开发](https://github.com/crifan/embedded_drv_dev)
* [嵌入式Linux软件开发](https://github.com/crifan/embedded_linux_dev)
* [嵌入式Linux驱动开发](https://github.com/crifan/embedded_linux_drv_dev)
* [嵌入式软件开发](https://github.com/crifan/embedded_soft_dev)
* [英语学习笔记](https://github.com/crifan/english_learn)
* [现场总线Fieldbus简析](https://github.com/crifan/fieldbus_intro)
* [【详解】嵌入式开发中固件的烧录方式](https://github.com/crifan/firmware_download)
* [硬件电路基础知识](https://github.com/crifan/hardware_basic)
* [【详解】中断相关的知识](https://github.com/crifan/interrupt_related)
* [JSON详解](https://github.com/crifan/json_tutorial)
* [计算机语言编程规范](https://github.com/crifan/lan_coding_rule)
* [各种计算机语言简介和总结](https://github.com/crifan/language_summary)
* [【详解】如何编写Linux下Nand Flash驱动](https://github.com/crifan/linux_nand_driver)
* [如何在Linux下写无线网卡的驱动](https://github.com/crifan/linux_wireless)
* [MPEG简介 + 如何计算CBR和VBR的MP3的播放时间](https://github.com/crifan/mpeg_vbr)
* [Linux MTD下获取Nand flash各个参数的过程的详细解析](https://github.com/crifan/nand_get_type)
* [计算机编程语言基础知识](https://github.com/crifan/programming_language_basic)
* [python中级教程：开发总结](https://github.com/crifan/python_intermediate_tutorial)
* [Python语言总结](https://github.com/crifan/python_summary)
* [Python专题教程：BeautifulSoup详解](https://github.com/crifan/python_topic_beautifulsoup)
* [Python专题教程：正则表达式re模块详解](https://github.com/crifan/python_topic_re)
* [Python专题教程：字符串和字符编码](https://github.com/crifan/python_topic_str_encoding)
* [Python专题教程：抓取网站，模拟登陆，抓取动态网页](https://github.com/crifan/python_topic_web_scrape)
* [【crifan推荐】轻量级文本编辑器，Notepad最佳替代品：Notepad++](https://github.com/crifan/rec_soft_npp)
* [【crifan推荐】支持多种协议的串口开发工具：SecureCRT](https://github.com/crifan/rec_soft_securecrt)
* [正则表达式学习心得](https://github.com/crifan/regular_expression)
* [RS232串口协议详解](https://github.com/crifan/rs232_serial_intro)
* [在Linux运行期间升级Linux系统（Uboot+kernel+Rootfs）](https://github.com/crifan/runtime_upgrade_linux)
* [软件开发基础知识](https://github.com/crifan/soft_dev_basic)
* [软件技术开发通用知识](https://github.com/crifan/soft_tech_common)
* [Code 128 Symbology Introduction](https://github.com/crifan/symbology_code128)
* [GS1-128条形码和相关的AI及FNC1的详解](https://github.com/crifan/symbology_gs1128)
* [Plessey & MSI Symbology Introduction](https://github.com/crifan/symbology_plessey)
* [UPC/UPC-A/UPC-E & EAN Barcode Symbology](https://github.com/crifan/symbology_upc)
* [Uboot中start.S源码的指令级的详尽解析](https://github.com/crifan/uboot_starts_analysis)
* [USB基础知识概论](https://github.com/crifan/usb_basic)
* [如何实现Linux下的U盘（USB Mass Storage）驱动](https://github.com/crifan/usb_disk_driver)
* [USB HID Learning Record](https://github.com/crifan/usb_hid)
* [VirtualBox教程](https://github.com/crifan/virtualbox_tutorial)
* [虚拟机教程](https://github.com/crifan/virutal_machine_tutorial)
* [VMWare教程](https://github.com/crifan/vmware_tutorial)
* [详解抓取网站，模拟登陆，抓取动态网页的原理和实现（Python，C#等）](https://github.com/crifan/web_scrape_emulate_login)
* [网站搬家详解](https://github.com/crifan/website_transfer)

## 其他说明

记得之前最后一次使用（Win系统中）的Docbook环境时，出现过：最终编译失败的问题。

具体的book，暂时记不清了。

暂时不去深究。等后续，在Mac中重建Docbook环境时，再去解决。

## TODO

另外，需要注意的是 = 后续的TODO：

* 考虑：把每个旧的Docbook，转换成新的Honkit（即Gitbook）
* 底层配置文件（比如`.xml`、`.xsl`等），还没有同步更新
  * 需要后续抽空去更新
* 整套Docbook环境，之前是基于Windows系统的
  * 此处当前电脑是Mac，也还没同步更新，有待后续更新
