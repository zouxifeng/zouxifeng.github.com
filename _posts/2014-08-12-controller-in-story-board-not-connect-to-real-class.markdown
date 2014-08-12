---
layout: post
title: Why does controller in storyboard not connect to the real view controller code?
categories:
- iOS
---

I have following the example in the blog post [http://www.raywenderlich.com/50308/storyboards-tutorial-in-ios-7-part-1].

But when I run the project, the app crash, says unrecognized identifier of setPlayer.

After search with Google, a question on the StackOverflow give me some hints. Maybe the view controller on storyboard is not connect to the code.

It is the reason! You have to click the view controller dock to select the view controller.

Fix it.
