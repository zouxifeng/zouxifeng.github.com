---
layout: post
title: 用cmake和swig编译jni模块
categories:
- cmake
- Programming
---

这几天编译项目的问题终于解决了，记下来怕忘记。

1. Undefined symbols

遇到两次Undefined symbols的link error，最终的问题都是Undefined symbols，但是造成的原因却不一样。

一次是没有把stasm编译出的object加入library，具体原因忘记了。

这两天解决的Undefined symbols，提示信息是这样的：

```
Undefined symbols for architecture x86_64:
  "_getHairShapeEdgePoints", referenced from:
```

后来通过搜索大概获得了一个关于C编译链接的知识点，那就是C的代码编译生成的symbol是会在名字前加一个下划线，这就是为什么声明的函数是“getHairShapeEdgePoints”，但是链接错误提示Undefined symbols是“_getHairShapeEdgePoints”，如果是C++编译链接的symbol格式是“symbolname_in_in”。不能确定C++的符号格式是不是这样，没有记录下来，以后可以再查。

找到这个原因之后，我发现用swig生成的Java wrapper的代码是c代码。但是xxx_wrapJAVA这个代码是编译过程中用swig自动生成的，没法解决。在经过很长时间的尝试发现是CMakeLists.txt中swig interface “.i”文件路径不对。

```
SET_SOURCE_FILES_PROPERTIES(wrapper.i PROPERTIES CPLUSPLUS ON)
```

因为wrapper.i这个文件不是在项目当前目录下，所以要把路径加上。
```
SET_SOURCE_FILES_PROPERTIES(${subdirectory}/wrapper.i PROPERTIES CPLUSPLUS ON)
```

这样修改完成后终于可以编译出osx下的jnilib。

2. duplicate symbol

之前出现Undefined symbols错误的时候，把一部分C++模块拿出来单独编译，但是在编译swig jni wrapper模块的时候，又编译了一次，所以在链接的时候两个object中都有同一个函数的实现，把CMakeLists.txt中相关的代码移除就好了。


这几天被cmake和swig搞得死去活来，不过借着这个机会倒是对cmake好好研究了一下，很不错的一个工具。
