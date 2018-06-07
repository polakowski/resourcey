# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
    t.integer :age
    t.timestamps
  end

  create_table :posts, force: true do |t|
    t.string :content
    t.integer :user_id
    t.integer :category_id
    t.timestamps
  end

  create_table :categories, force: true do |t|
    t.string :name
    t.string :description
    t.integer :moderator_id
    t.timestamps
  end
end
