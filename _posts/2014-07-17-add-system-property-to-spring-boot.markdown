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

Set system property for maven:

```
mvn -Drun.jvmArguments="-Djava.library.path=./libs" spring-boot:run
```

When working with pom.xml, add following with "spring-boot-maven-plugin" in "configuration" section:

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
