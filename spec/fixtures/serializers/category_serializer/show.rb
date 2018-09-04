module CategorySerializer
  class Show < Resourcey::Serializer
    attributes %i[
      moderator_id
      moderator_name
      moderator_age
      posts_count
    ]

    delegate :moderator, :posts, to: :object

    def moderator_name
      moderator.name
    end

    def moderator_age
      moderator.age
    end

    def posts_count
      posts.count
    end
  end
end
