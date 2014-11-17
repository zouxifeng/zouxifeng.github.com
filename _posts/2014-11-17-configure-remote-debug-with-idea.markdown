---
layout: post
title: Configure remote debugger and attach to Intellij IDEA
categories:
- ide
---

Intellij IDEA 14 release is out. And I've downloaded the community version. It's amazingly sharp.

But there is one thing inconvinient. In run/debug mode, automatic build will be disabled. Although I can build manually with shortcut key. But I really need automatic build with run/debug mode. Since JRebel will hot swap changed classes at run time, it will save me lot of time during redeploy/reload.

I start a debug configuration with IDEA, and copy command line output from console. Then I add some vm arguments. Finally the command is like this:

```
#!/bin/sh

JAVA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=50005"
java "$JAVA_OPTS" -Drebel.env.ide.plugin.version=6.0.0-idea13 -Drebel.env.ide.version=14.0.1 -Drebel.env.ide.product=IC -Drebel.env.ide=intellij -Drebel.notification.url=http://localhost:53963 -agentpath:/var/folders/wf/xpv_8nbn51qg18r_b3tz07nm0000gn/T/jrebel6-temp/lib/libjrebel64.dylib -Dspring.profiles.active=develop -Dlocal.config=classpath*:local-config.properties -Dmaven.home=/usr/local/Cellar/maven/3.2.3/libexec -Didea.modules.paths.file=/Users/zouxifeng/Library/Caches/IdeaIC14/Maven/idea-projects-state-5ba4b3da.properties -Dclassworlds.conf=/Users/zouxifeng/Library/Caches/IdeaIC14/tmp/idea-1296834744010889401-mvn.conf -Didea.launcher.port=7534 "-Didea.launcher.bin.path=/opt/homebrew-cask/Caskroom/intellij-idea-ce/14/IntelliJ IDEA 14 CE.app/Contents/bin" -Dfile.encoding=UTF-8 -classpath "/usr/local/Cellar/maven/3.2.3/libexec/boot/plexus-classworlds-2.5.1.jar:/opt/homebrew-cask/Caskroom/intellij-idea-ce/14/IntelliJ IDEA 14 CE.app/Contents/lib/idea_rt.jar" com.intellij.rt.execution.application.AppMain org.codehaus.classworlds.Launcher -Didea.version=14.0.1 --offline -DskipTests=true -pl gl_shop_web jetty:run -P develop
```

Attention:

```
-agentpath should point to the jrebel agent file.
```

But if you use the install path of the agent file, since it contains space in the file path with my macbook, and maven will exit reporting the file path is wrong.

