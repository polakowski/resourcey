# Resourcey - controller
Controller (`Resourcey::Controller` class) gives you ability to perform REST actions on your resources.

## Controller model
For controller named `UsersController`, model is `User` by default (it uses `controller_name` method from the `ActionController::Base`). If you want to change model used by controller, just call `use_model` method inside, and pass model class or model name:
```ruby
class AdminsController < Resourcey::Controller
  use_model User
  # or
  use_model :user
  # or
  use_model 'User'
end
```

## Controller serializer
For controller named `UsersController`, serializer is `UserSerializer` by default. If you want to change serializer class used by controller, just have to override `serializer` method in controller:
```ruby
class ActiveUsersController < Resourcey::Controller

  private

  def serializer
    UserSerializer
  end
end
```

More convenient solution will appear soon.

## Controller parent
By default, `Resourcey::Controller` inherits from `ActionController::Base`, you can change this behaviour by changing `controller_parent` config variable. See examples below:

```ruby
Resourcey.configure do |config|
  config.controller_parent = 'MyCustomController'
  # or
  config.controller_parent = MyCustomController
end
```

## Controller collection scope
Sometimes you need to transform your collection (activerecord_relation object) before it's rendered as json. In order to do this, call `collection_scope` method in your controller, and pass a block inside (the block will receive original collection scope). Original scope has pagination and filters already applied. See example:

```ruby
# somewhere, in post.rb
# class Post < ApplicationRecord
#   belongs_to :author
#   scope :most_recent, -> { where('posts.created_at > ?', 2.days.ago) }
# end

class PostsController < Resourcey::Controller
  collection_scope do |scope|
    scope.most_recent
  end

  # or shorter way

  collection_scope &:most_recent

  # sometimes you need to `include` some relation

  collection_scope do |scope|
    scope.includes(:author)
  end

  # ...
end
```

This method only applies for `index` action. If you want to pass parameters to scope method, [filters](/docs/FILTERING.md) are what you're looking for.

## Configured controller example
```ruby
class MostRecentPostsController < Resourcey::Controller
  use_model Post
  paginate_with :from_to
  collection_scope &:most_recent

  def serializer
    PostSerializer
  end
end
```
