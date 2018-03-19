# Resourcey - pagination
To enable pagination in your controller, just call `paginate` method inside.

```ruby
class ResourcesController < Resourcey::Controller
  paginate
end
```

## Configuration
If you want to select which paginator should be used, you can do it in initializer:
```ruby
Resourcey.configure do |config|
  config.default_paginator = :offset
end
```

You can also select paginator per controller, then you should use `paginate_with` method:
```ruby
class ResourcesController < Resourcey::Controller
  paginate_with :offset
end
```

Currently there are two built-in paginators, `:paged` and `:offset`. If none of those meet your needs, you can create your own paginator.

## Adding custom paginator
To build a custom paginator, create a class and let it inherit from `Resourcey::Paginator`.
```ruby
class CustomPaginator < Resourcey::Paginator
  # which parameters should be permitted to paginator
  permit_params :from, :to

  # this method is invoked after initializer, you can setup your paginator between every call
  def setup(opts)
    @from = opts[:from]
    @to = opts[:to]
  end

  # paginate method applies paginator, should return activerecord-relation object
  def paginate(scope)
    offset = from - 1
    limit = (to - from) + 1
    scope.offset(offset).limit(limit)
  end

  private

  attr_reader :from, :to
end
```

That's it! Now you can use `:custom` paginator in initializer, or in controller. Then just:
```
http://api.example.com/custom_resources?from=6&to=9
```

## Built-in paginators
### Paged paginator
To use this paginator, set `default_paginator` config variable to `:paged`, or don't configure it at all - this is default paginator.
It receives two parameters:
- `page` - page number
- `per_page` - how many records per page

Example usage:
```
http://api.example.com/resources?page=3&per_page=10
```

### Offset paginator
To use this paginator, set `default_paginator` config variable to `:offset`. It receives two parameters:
- `offset` - number of records that should be omitted
- `limit` - how many records should be returned

Example usage:
```
http://api.example.com/resources?offset=100&limit=5
```
