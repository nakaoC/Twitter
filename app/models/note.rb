class Note < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy #noteを削除した時likeも削除される
  has_many :liking_users, through: :likes, source: :user

  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true
end
