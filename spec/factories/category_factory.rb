FactoryBot.define do
  factory :category do
    name 'C_Foo'
    description 'Lorem ipsum'
    moderator { create(:user) }
  end
end
