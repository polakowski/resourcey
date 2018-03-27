# Resourcey - controller
Controller (`Resourcey::Controller` class) gives you ability to perform REST actions on your resources.

## Controller model
For controller named `UsersController`, model is `User` by default (it uses `controller_name` method from the `ActionController::Base`). If you want to change model used by controller, just call `use_model` method inside, and pass model class:
```ruby
class AdminsController < Resourcey::Controller
  use_model User
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
