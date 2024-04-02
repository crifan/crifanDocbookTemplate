# crifanDocbookTemplate

最后更新：`20240402`

Crifan的Docbook的模板

## 说明

最早自己创建电子书，是用的：[Docbook](https://www.crifan.com/files/doc/docbook/docbook_dev_note/release/html/docbook_dev_note.html)

而本身Docbook的环境搭建，相对很复杂。

所以之前最初弄了个[最精简版本的模板](https://www.crifan.com/files/doc/docbook/docbook_dev_note/release/html/docbook_dev_note.html#pure_win_docbook_dev_env)，下载地址是：[docbook5_demo_noTools.7z](http://crifan.com/files/res/docbook/demo/docbook5_demo_noTools.7z)

而此处是：贴出之前用的，最完整的，最全面的，最复杂的整套Docbook开发环境。

## Docbook目录说明

之前本身结构是：

* tools是上一级目录

即：

* docbook
  * ant
  * config
  * books
* tools

现在为了统一整合，已移动tools到当前目录，变成：

* tools是同级目录

即：

* crifanDocbookTemplate
  * ant
  * config
  * books
  * tools


## TODO

另外，需要注意的是 = 后续的TODO：

* `books`目录
  * 每个docbook的源码，会分别单独发布，因为长远考虑，或许会把每个旧的Docbook，转换成新的Honkit（即Gitbook）。
* 底层配置文件（比如`.xml`、`.xsl`等），还没有同步更新
  * 需要后续抽空去更新
* 整套Docbook环境，之前是基于Windows系统的
  * 此处当前电脑是Mac，也还没同步更新，有待后续更新
