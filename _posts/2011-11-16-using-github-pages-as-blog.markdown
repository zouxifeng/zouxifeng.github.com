---
layout: post
title: 用Github Pages做blog
categories:
- Github Pages
- Jekyll
---

做技术那么多年了，写Blog也有很长时间，但是总觉得无趣。

最近发现Github Pages可以用来写Blog，特别是基于Jekyll，可以用markdown来写blog，让本来无趣的事变得有趣。

原因有以下几点：

1.  使用Git进行版本控制

    不管新浪博客还是以前的msn space，都没有版本管理。而Github pages，每一个页面就是一个文件。


2.  可以用markdown或者textile写内容

    markdown和textile可以让人专注于内容，便于以后的数据处理，而不像用html编辑器编辑出来的内容。


3.  迁移方便
    
    就算以后要换个地方写Blog，把blog原文件copy过去，找个支持markdown或者textile的blog程序。

    再不行就找个程序先对原文件处理，然后再导入blog数据库。


4.  技术人写blog就是应该有点技术范


所以从今天开始就用markdown来写blog了，至于新浪那边的blog，有空的时候就转过来。

唯一有点缺憾，Github因为安全的原因不支持plugins，让我费了老劲整出来的Categories和Archives显示不了。

以后写个脚本，每次push到Github上的时候，把Categories和Archives抽取成静态内容。
