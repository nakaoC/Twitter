class Note < ActiveRecord::Base
  validates :content, presence: true, length: {maximum: 140}
end
