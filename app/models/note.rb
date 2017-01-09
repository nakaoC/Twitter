class Note < ActiveRecord::Base
  belongs_to :user
  has_many :likes

  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true
end
