---
layout: post
title: Set custom preprocessor macro in Xcode build setting
categories:
- iOS
---

Now I use a header file to manage environment variable. For example, api server for local development and staging area are different, so I create a header file "Settings.h", 

```
#ifdef DEVELOP
#import "LocalSettings.h"
#else
#define API_SERVER @"http://localhost:8000"
#endif
```

"LocalSettings.h" contains local working space settings, and will be ignore by .gitignore.

Add "Settings.h" to ${PROJECT}-Prefix.pch,

```
#ifdef __OBJC__
    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>
    #import "Settings.h"
#endif
```

Now code is ready, need to add something to project build settings.

Find "Preprocessor Macros" in project build settings, just add "DEVELOP" to "Debug" configuration.

It's done.
