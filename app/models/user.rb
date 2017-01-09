class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:validatable
         #:recoverable, :rememberable, :trackable,
  has_many :notes
  has_many :likes
  has_many :like_notes, through: :likes, source: :note
  #              likesテーブルを経由して↑          　↑likeに紐付いたnoteを取りに行く
  validates :name, presence: true


  #画像をセットする
  def set_image(file)
    if !file.nil? #画像データを受け取ったら
      file_name = file.original_filename

      File.open("public/user_images/#{file_name}",'wb'){|f|f.write(file.read)} #保存先を指定して保存
      self.image = file_name #userインスタンスに画像データを設定
    end
  end
end
