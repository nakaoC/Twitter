class Relationship < ActiveRecord::Base
  belongs_to :follower, class: "User"
  belongs_to :followed, class: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
