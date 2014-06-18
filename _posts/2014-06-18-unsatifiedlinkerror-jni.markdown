---
layout: post
title: Cause of UnsatisfiedLinkError
categories:
- Java
- JNI
---

调用JNI接口总会遇到UnsatisfiedLinkError，总结一下原因：

1. native模块找不到

    * 需要把native模块加到java.library.path或者放到PATH环境变量中。
    * 如果是Linux/Unix/OSX，System.loadLibrary("modulename")，不能用文件全名，比如libmodulea，而要用modulea，扩展名不要，会自动选择。

2. native方法调用错误

    * 用于swig的module.i接口文件需要加上%include "nativecode.h"，这样用swig生成代码的时候会自动把nativecode.h中的类、函数导出。
    * CMakeLists.txt拼写错误，造成有一个模块没有正确编译。
