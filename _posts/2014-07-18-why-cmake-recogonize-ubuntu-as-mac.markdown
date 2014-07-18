---
layout: post
title: Why did cmake recogonize my Ubuntu box as an Apple machine?
categories:
- cmake
---

I copied my working folder to an Ubuntu 14.04 computer. Then build the project, and I encounter some problems.

Cmake FindJNI failed. I didn't know what was the reason, and I couldn't find any clue, so I tried to read the FindJNI.cmake source code.

After insert some logging code, I found cmake couldn't find the jdk location.

I installed Oracle JDK, and set as the default jdk. So some system wide variable was not correct. Then I set JAVA_HOME environment variable. Now cmake found the JDK location.

But cmake was still failed with FindJNI. I found the problem was cmake went into "if (APPLE)" branch, a Ubuntu box was recogonized as an Apple device, certainly cmake couldn't find required header files or library.

I tried hard, and worked with search engine. Nothing found.

Finally, I tried to delete any cmake created files CMakeCache.txt and CMakeFiles directory. After that, cmake succeeded.

Since the project working directory was copied from my local machine, and that is an MacBook Pro. Cmake must generate some files, and won't change after fgenerated if you don't delete them manually. I presumed files in CMakeFiles will be overwrote every time cmake is executed.

I have encouter to much strance problems.
