# Resourcey [![Gem Version](https://badge.fury.io/rb/resourcey.png)](https://badge.fury.io/rb/resourcey)
A lightweight gem for building resource-based APIs.

## Installation
Add Resourcey to your `Gemfile`:
```ruby
gem 'resourcey'
```

And then:
```
bundle
```

Or install it manually:
```
gem install resourcey
```

## Usage
### Controller
For a resource called `user`, just create `UsersController` in a correct namespace (e.g. 'api/v1')
```ruby
class Api::V1::UsersController < Resourcey::Controller
end
```

For further reading, [click here](/docs/CONTROLLER.md).

### Serializer

Now you need a serializer, let's assume that `User` has an email and an ID, go with this:
```ruby
class UserSerializer < Resourcey::Serializer
  attributes :id, :email
end
```

For further reading, [click here](/docs/SERIALIZER.md).

### Fetch the data

Don't forget to create a correct route in your `routes.rb` file, and you're good to go!
Now just visit `/api/v1/users`, and see how your resources are rendered.

```json
/* example response */

[
  { "id": 1, "email": "john.doe@example.com" },
  { "id": 2, "email": "george.doe@example.com" }
]
```

## Gem development
If you want to take part in developing resourcey, fork this repository, commit your code, and create pull request.

### Requirements
- ruby 2.4.1
- bundler

### Running local tests
- rspec
