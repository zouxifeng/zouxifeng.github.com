---
layout: post
title:  Jekyll默认markdown引擎maruku和CSS样式覆盖的问题
categories:
- Jekyll
- maruku
- markdown
- rdiscount
- CSS
---

昨天的第一篇Post其实直到5分钟之前才提交到Github上，因为遇到两个问题一直没解决。

1. markdown转换到html时，list没有正确转换；
2. ol和ul样式被覆盖后，不能正确显示序号。

第一个问题应该是markdown引擎maruku的问题，当我换用了rdiscount之后，解决了。有空的时候去看一下maruku的代码。

第二个问题由于style.css定义了\* {list-style: none}，markdown被转换成html，ol的序号不显示。对CSS不是非常了解，所以用了一个简单而笨的办法：

1. 把内容显示放在一个div里面，id为posts-content，在CSS里面定义#post-content ol {padding: 0px 1em; list-style-position: inside}，然后删除\* {list-style: none}

2. 在lsidebar和rsidebar的style增加#l/rsidebar ul {list-style: none}，这样右边的sidebar里面的ul就不会显示圆点了。

也许还有更好的方法去解决上面CSS的问题，需要去好好研究。
