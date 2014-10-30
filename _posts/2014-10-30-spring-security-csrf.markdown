---
layout: post
title: Why Spring Security CSRF token not insert into form with Thymeleaf template?
categories:
- spring security csrf
---

I'm trying to integrate Spring Security into current project for web security.

Today I encounter a problem, and it almost costs me 7 hours to solve.

From [Spring Security reference document](http://docs.spring.io/spring-security/site/docs/3.2.5.RELEASE/reference/htmlsingle/)

> If you are using Spring MVC <form:form> tag or Thymeleaf 2.1+, and you replace
> @EnableWebSecurity with @EnableWebMvcSecurity, the CsrfToken is automatically
> included for you (using the CsrfRequestDataValueProcessor).

But I didn't get the csrf token rendered into my template.

I've tried to convert my xml configuration into Java configuration, but it's to
difficult and I gave up.

Then I dig into the configuration file, remove configuration block by block.

After I remove

```
    <http pattern="/system/signin/" security="none" />
```

Csrf token inserted into my template.

I guess there is a conflict in the configuration. The uri path is my form login
page uri, so I think it should not be protected by spring security. And there is
an example in the document:

```
<http pattern="/css/**" security="none"/>
<http pattern="/login.jsp*" security="none"/>

<http>
  <intercept-url pattern="/**" access="ROLE_USER" />
  <form-login login-page='/login.jsp'/>
</http>
```

I just copied and editted to my own configuration.

I've just retested it, if I put back the configuration with "security=none",
csrf token disappeared again. That means the configuration in the document is
incorrect.
