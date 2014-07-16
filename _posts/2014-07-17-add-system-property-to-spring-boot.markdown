---
layout: post
title: How to add "java.library.path" system property to spring boot project?
categories:
- Java
- JNI
---

There are some ways to start a spring boot enabled project, using gradle or maven will be the most convinient during developerment.

*But how to add "java.library.path" jvm option to point the custom native module?*

Maven
=====

Using MAVEN_OPTS environment variable with CLI or specify in the pom.xml.

With "spring-boot-maven-plugin" in "configuration" section add following:

```
<jvmArguments>
    -Djava.library.path=./libs
</jvmArguments>
```

Gradle
======

I finished this by add following in the build.gradle:

```
tasks.withType(JavaExec) {
    systemProperty "java.library.path", file("./libs")
}
```
