# Resourcey - pagination
You can filter your resources using filter objects defined per single resource model. See below for an example:

```ruby
class UserFilter < Resourcey::Filter
  filter :older_than do |value, scope|
    scope.where('users.age > ?', value)
  end
end
```

Block passed to the particular filter, should always return activerecord relation, in order to allow chaining multiple filters together. You can configure your filter behaviour by passing options hash as a second parameter (optional).

Then, in data URL pass `older_than` query parameter, just like this:

```
http://api.example.com/api/users?older_than=15

# query parameter and filter name are always the same string
```

## Allowed filter options
- [multivalue](#multivalue)

### Multivalue
If your filter receives multiple values, pass `multiline: true` option, then your block will receive array with values.

```ruby
  filter :age_range, multivalue: true do |values, scope|
    scope.where('users.age between ? and ?', values.first, values.last)
  end
```

Query parameter values should be separated by commas, like this:

```
http://api.example.com/api/users?age_range=25,40
```
