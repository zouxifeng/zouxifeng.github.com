---
layout: post
title: Cause of UnsatisfiedLinkError
categories:
- Java
- JNI
---

想要把SWIG去掉，直接用C++代码和cmake编译jni模块，但是只有.a，没有.jnilib。一直不知道如何解决，在仔细研究了一下UseSWIG.cmake模块之后，找到了原因。

在需要最后链接生成jni模块，调用add_library的时候用add_library(${modulename} MODULE ARG1...ARGN)。注意${modulename}后面的MODULE参数。

cmake文档关于add_library是这么解释的：

> MODULE libraries are plugins that are not linked into other targets but may be loaded dynamically at runtime using dlopen-like functionality.

花了很长时间，又解决一个小问题。有点失望。
