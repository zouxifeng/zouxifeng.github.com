---
layout: post
title: Django custom field not working
categories:
- django, sql
---

Django's documents are orgnized very well, but there is no Chinese translation. So it's not easy to understand every corner well.

Django BooleanField works well in almost each circumstances, but I'm now working on a legacy project, boolean value stored in the database with char(1), 'Y' presents True and 'N' presents False.

After I'm reading Django's source code, the value BooleanField supports are 't/f', '1/0', 'True/False'. And then, how to solve 'Y/N'?

Customize a field is not quite difficult, just follow the document [Custom Field|https://docs.djangoproject.com/en/1.9/howto/custom-model-fields/].

Then I worked out my custom field - YesOrNoBooleanField. When the code is reloaded, I found the field is still string (unicode type). I have done lots of testing and logging, but still have no clue on this. I returned to the api document, which I already have read for several times. I found something which has been ignored.

> If your custom **Field** class deals with data structures that are more complex than strings, dates, integers, or floats, then you may need to override **from_db_value()** and **to_python()**.

> If present for the field subclass, **from_db_value()** will be called in all circumstances when the data is loaded from the database, including in aggregates and **values()** calls.

> **to_python()** is called by deserialization and during the **clean()** method used from forms.

**from_db_value** and **to_python** are totally different.

**from_db_value** will be called to convert raw data from database to python object.

I have spent almost 2 or 3 hours to solve the problem.
