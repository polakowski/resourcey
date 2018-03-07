FactoryBot.define do
  factory :user do
    name 'Doe'
    age 10

    factory :user_with_posts do
      transient do
        posts_count 2
      end

      after :create do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
