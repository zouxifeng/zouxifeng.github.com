---
layout: post
title: Use spring loaded to enable hot swapping
categories:
- Java
- Agent
- Reload
---

By default there is no capability to reload classes after code change. How to enable hot swapping?

Sping Loaded project using java agent to enable code hot swapping. It is quite easy.

Maven
=====

Use MAVEN_OPTS

```
MAVEN_OPTS="-javaagent:${PATH}/springloaded-1.2.0.RELEASE.jar -noverify" mvn spring-boot:run
```

Gradle
======

In buildscript block add spring loadded library as dependency.

```
buildscript {
    ......
    dependencies {
        ......
        classpath "org.springframework:springloaded:1.2.0.RELEASE"
        ......
    }
}
```
