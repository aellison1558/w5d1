class UserComment < ActiveRecord::Base
  validates :user_id, :author_id, :body, presence: true

  belongs_to :user
  belongs_to :author, class_name: "User"
end
