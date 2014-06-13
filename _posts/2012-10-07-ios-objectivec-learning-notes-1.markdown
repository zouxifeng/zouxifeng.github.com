---
layout: post
title: iOS Objective C 学习笔记 1 
categories:
- iOS
- Programming
---

1. 每个Object都可以是一个id类型

2. message就是method

3. You can send Objective-C messages to remote objects—objects in other applications.
是跨进程的意思吗？

4. Protocol就是Interface，不要把这个Interface和ObjC里的Interface混淆，把它当做Java中的Interface。

5. The conformsToProtocol: test is also like the isKindOfClass: test, except
   that it tests for a type based on a protocol rather than a type based on the
   inheritance hierarchy.

6. Protocol Type Checking很有用，compiler可以进行编译期的类型检查。
    - (id <Formatting>)formattingService;
    id <MyXMLSupport> anObject;
    Formatter <Formatting> *anObject;  Formatter是class，Formatting是protocol

7. Protocols can’t be used to type class objects. Only instances can be
   statically typed to a protocol, just as only instances can be statically
   typed to a class. (However, at runtime, both classes and instances respond to
   a conformsToProtocol: message.)

8. Protocols Within Protocols 意思就是Interface的继承

9. 避免回路，比如：

```
    #import "B.h"
     
    @protocol A
     - foo:(id <B>)anObject;
    @end

    #import "A.h"
     
    @protocol B
     - bar:(id <A>)anObject;
    @end

    很显然A和B都无法被编译，如何解决这个问题，其实很简单Forward
    Reference，和C里面一样。

    To break this recursive cycle, you must use the @protocol directive to make
    a forward reference to the needed protocol instead of importing the
    interface file where the protocol is defined:

    @protocol B;
     
    @protocol A
     - foo:(id <B>)anObject;
    @endd

```

10. Properties Setter Semantics

strong weak copy assign retain

11. Properties Atomicity，默认都是atomic，所以没有atomic
    keyword，可以用nonatomic来声明非原子性的property

    If you specify strong, copy, or retain and do not specify nonatomic, then in
    a reference-counted environment, a synthesized get accessor for an object
    property uses a lock and retains and autoreleases the returned value—the
    implementation will be similar to the following：

    [_internal lock]; // lock using an object-level lock
    id result = [[value retain] autorelease];
    [_internal unlock];
    return result;

12. You use the @synthesize directive to tell the compiler that it should
    synthesize the setter and/or getter methods for a property if you do not
    supply them within the @implementation block. The @synthesize directive also
    synthesizes an appropriate instance variable if it is not otherwise
    declared.

    You can use the form property=ivar to indicate that a particular instance
    variable should be used for the property, for example:

    @synthesize firstName, lastName, age=yearsOld;

13. Categories
    Note that a category can’t declare additional instance variables for the class;
    it includes only methods. However, all instance variables within the scope of 
    the class are also within the scope of the category. That includes all instance
    variables declared by the class, even ones declared @private.

14. Extensions
    Class extensions are like anonymous categories, except that the methods they
    declare must be implemented in the main @implementation block for the
    corresponding class. Using the Clang/LLVM 2.0 compiler, you can also declare
    properties and instance variables in a class extension.

15. Associative References
      objc_setAssociatedObject
      objc_getAssociatedObject
      objc_removeAssociatedObjects
      
      Associative references有点类似setTag

16. 支持 for (Type variable in Collection or Enumerator)

17. SEL and @selector有点类似Reflection

        SEL setWidthHeight;
        setWidthHeight = @selector(setWidth:height:);
        
        setWidthHeight = NSSelectorFromString(aBuffer);
        NSString *method;
        method = NSStringFromSelector(setWidthHeight);

    A class method and an instance method with the same name are assigned the
    same selector. However, because of their separate domains, there’s no confusion
    between the two. A class could define a display class method in addition to
    a display instance method.
    
        id   helper = getTheReceiver();
        SEL  request = getTheSelector();
        [helper performSelector:request];
        
    In this example, the receiver (helper) is chosen at runtime (by the fictitious
    getTheReceiver function), and the method the receiver is asked to perform
    (request) is also determined at runtime (by the equally fictitious getTheSelector function).
    
        if ( [anObject respondsToSelector:@selector(setOrigin::)] )
            [anObject setOrigin:0.0 :0.0];
        else
            fprintf(stderr, "%s can’t be placed\n",
                [NSStringFromClass([anObject class]) UTF8String]);
                
    The respondsToSelector: runtime test is especially important when you send messages
    to objects that you don’t have control over at compile time. For example, if you write
    code that sends a message to an object represented by a variable that others can set,
    you should make sure the receiver implements a method that can respond to the message.
    
    18. Threading @synchronized
