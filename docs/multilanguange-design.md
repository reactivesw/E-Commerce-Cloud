# Multi-Language Design

In our system, multi-language is basic function, many fields set as multi-language(e.g. category's name, description).

## View Model Design

For web or other client, multi-language means different language keys and its content.
When we use json format, multi-language json string is like this:

```json
{
    "en":"content in english",
    "zh":"中文内容"
}
```

So we create a class named `LocalizedString` and add a map field to it, here is the code:

```java
class LocalizedString{
  private Map<String, String> localized;
}
```

The key is the language key, value is the content.

When you need multi-language field, just set it as `LocalizedString`, add language key and content to it,
exmaple:

```java
class Category{
  private LocalizedString name; // category name is multi language.

  ...

  name.addKeyValue("en", "content in english"); // add english content to name.
}
```

## Entity Design

We create a entity class named `LocalizedStringValue` to store multi-language in database.
In `LocalizedStringValue`, there is two field:

* language: the language key
* text: the context in this language

Here is the code:

```java
public class LocalizedStringValue {
  private String language.
  private String text.
}
```

When use it, we need a collection to store, example:

```java
class Category{
  @ElementCollection
  @CollectionTable(name="category_name")
  private Set<LocalizedStringValue> name = Collections.emptySet();
}
```

PS: use @ElementCollection and @CollectionTable instead of @OneToMany, because name or other multi-language field is embeddable, not entity.