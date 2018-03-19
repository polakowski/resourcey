# Resourcey
![Gem Version](https://img.shields.io/gem/v/resourcey.svg?label=version&colorB=43bd15) ![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)

A lightweight rails gem for building resource-based APIs.

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
For a resource called `user`, just create `UsersController`:
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

### Pagination
To paginate resources, simply invoke `paginate` method in controller, like this:
```ruby
class ResourcesController < Resourcey::Controller
  paginate
end
```

This will use default `:paged` paginator. Now you need to pass `page` and `per_page` parameters in `pagination` parameter value, like this:

```
http://api.example.com/resources?page=3&per_page=10
```

This will fetch page 3, with 10 resources per single page. That's all! Pagination can be configured globally (see "Configuration" below). Also you can configure every controller's pagination.

For further reading, [click here](/docs/PAGINATION.md).

## Configuration
Create configuration file in your `config/initializers` folder, and configure as usual:
```ruby
Resourcey.configure do |config|
  config.some_config_variable = :some_value
end
```

### Available config variables
- `default_paginator` - name of paginator that will be used in every controller, if not configured on controller-level (default: `:paged`)

## Gem development
If you want to take part in developing resourcey, fork this repository, commit your code, and create pull request.

### Requirements
- ruby 2.4.1
- bundler

### Running local tests
- rspec
