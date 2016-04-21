---
title: 在Ubuntu下正确配置Spacemacs
date: 2016-04-19 16:31:36
categories: CCTV10-科教
tags:
    - Linux
    - Emacs
    - Tutorial
---

之前一直都是在Mac上用的Spacemacs, Mac下的Homebrew可以安装到基本上来说最新版本的Emacs. 所以也就没有遇到过什么问题，但后来在自己的PC上装了Ubuntu之后才发现Ubuntu自带的apt-get的Emacs版本只更新到的24.3，然而Spacemacs要求的各种library基本上都要在24.4或者以上。所以Spacemacs作者给出的建议很简单：build from source.

但其实Emacs的gnu[官网](https://www.gnu.org/software/emacs/manual/html_node/efaq/Installing-Emacs.html)上面的教程基本上是假设你电脑上该配的环境都配好了，个人感觉Emacs非要build from source的人肯定是有了电脑第一件事就是装Emacs的，可能很多dependency都还没来得及装。网上各种建议这么装那么装的感觉不是很靠谱，我参考了一些觉得[这个网站](http://ubuntuhandbook.org/index.php/2014/10/emacs-24-4-released-install-in-ubuntu-14-04/)的教程最合理，贴到这做个纪录。

<!--more-->

# 安装必要库 #

Emacs需要很多dependencies才可以正常工作，直接用Ubuntu的apt-get装Emacs是可以自动装这些dependencies，我们必须手动装这些，具体方法是下面两行命令：

```shell
sudo apt-get install build-essential
sudo apt-get build-dep emacs24
```

# 下载解压Emacs #

装好之后，就请去Emacs的官网下载最新的Emacs，[传送门](http://ftp.gnu.org/gnu/emacs/)在此。注意要下载的应该是一个叫做`emacs-(VERSION).tar.gz`的文件，这个Version就挑24开头的最大的就行。现在应该是24.5。

假设我们下载到了`~/Downloads`目录下，那接下来就是解压：

```shell
cd ~/Downloads && tar -xf emacs-(VERSION).tar.* && cd emacs-(VERSION)
```

# 安装Emacs，大功告成 #

最后依次输入下面三行命令就行了，注意后两行命令是建立在第一行命令没有Bug的基础上，而第一行命令想要没有Bug需要我们第一步正确安装所有必要的库。

```shell
./configure
make
sudo make install
```

# (Optional)安装Spacemacs #

Spacemacs是一个已经被无数人调试优化过的很好的Emacs版本，如果想要安装的话就在上面一步完成之后clone一下他的GitHub即可：

```shell
rm -rf ~/.emacs.d
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
```

最后在命令行里打入`emacs`，Spacemacs就会自动安装，升级，就搞定了。

关于Spacemacs的更多信息可以参照[官网](http://spacemacs.org/)。

Happy Coding!
