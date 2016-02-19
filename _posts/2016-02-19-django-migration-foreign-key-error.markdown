---
layout: post
title: Django migration fail to add foreign key constraint
categories:
- django, sql
---

Recently, I'm working on a project to add features to an old legacy product which has already run for 5 years.

Today I run into a problem and for several hours searching and thinking, the problem is resolved finally.

For new features, I need to create a model and add foreign key constraint with models.ForeignKeyField to refer another table.

It was successful when running 'makemigrations' command. But when I wanted to make real migration with 'migrate' command, I got exception raised, and prompted mysql error "can't add foreign key constraint" with error code "1215".

After searching online, I got a mysql diagnose command "show engine innodb status", and get the detail explaination for the error:

> Cannot find an index in the referenced table where the referenced columns appear as the first columns, or column types in the table and the referenced table do not match for constraint.

I felt puzzled, the column is a primary key of the referenced table, primary key will generate primary key index automatically, what's the problem?

Then I used 'sqlmigrate' command to get real migration sql django will generate. After reading the sql, I found the problem, the field type is not the same. CharField will be generated as "varchar(n)", but the foreign key constraint referenced is a "char(n)". I need a fixed char field.

I found following django issue [Support for fixed Char database field|https://code.djangoproject.com/ticket/9349].

Run "migrate" again, still "1215" error, what to do now?

With mysql shell, check field type with "show create table", I found the deference. The the referenced table is an old table which only set charset with utf8 within create table command. But the newly added table which created by django migration not only set charset but also set "collate=utf8_unicode_ci". So each char field or varchar field definition was added "COLLATE utf8_unicode_ci" implicitly by mysql.

That's the reason. But how to resovle it? Django model can't specify raw sql options. After some digging, django migration api RunSQL jumped out [Migration Operations|https://docs.djangoproject.com/en/1.9/ref/migration-operations/].

RunSQL can accept a list of sql.

But after I replace original CreateModel api with RunSQL to create table and add foreign key constraint directly, I got some other django exception.

After reading RunSQL api and example more carefully, I got following message:

> The state_operations argument is so you can supply operations that are equivalent to the SQL in terms of project state; for example, if you are manually creating a column, you should pass in a list containing an AddField operation here so that the autodetector still has an up-to-date state of the model (otherwise, when you next run makemigrations, it won’t see any operation that adds that field and so will try to run it again). For example:

```python
migrations.RunSQL(
    "ALTER TABLE musician ADD COLUMN name varchar(255) NOT NULL;",
    state_operations=[
      migrations.AddField(
        'musician',
        'name',
        models.CharField(max_length=255),
      ),
    ],
)
```

I have to preserve the model state here, move django generated migrations.CreateModel to state_operations.

Run "migrate" again, everything is done now.
