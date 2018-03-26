class UserFilter < Resourcey::Filter
  filter :older_than do |value, scope|
    scope.where('users.age > ?', value)
  end

  filter :age_range, multivalue: true do |values, scope|
    scope.where('users.age between ? and ?', values.first, values.last)
  end
end
