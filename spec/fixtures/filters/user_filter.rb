class UserFilter < Resourcey::Filter
  filter :older_than do |value, scope|
    scope.where('users.age > ?', value)
  end
end
