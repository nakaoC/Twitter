class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:validatable
         #:recoverable, :rememberable, :trackable,
  has_many :notes
  has_many :likes
  has_many :like_notes, through: :likes, source: :note
  #              likesテーブルを経由して↑          　↑likeに紐付いたnoteを取りに行く

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #                                       ↑Relationshipモデルにuser_idカラムがないため、Userモデルがどのカラムを参照するかを示す必要がある
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  #                                       ↑Relationshipモデルにuser_idカラムがないため、Userモデルがどのカラムを参照するかを示す必要がある

  has_many :followed_users, through: :relationships, source: :followed #このインスタンスがフォローしているユーザーを取り出すメソッドを作る
  has_many :followers, through: :relationships, source: :follower #このインスタンスをフォローしているユーザーを取り出すメソッドを作る

  validates :name, presence: true


  #画像をセットする
  def set_image(file)
    if !file.nil? #画像データを受け取ったら
      file_name = file.original_filename

      File.open("public/user_images/#{file_name}",'wb'){|f|f.write(file.read)} #保存先を指定して保存
      self.image = file_name #userインスタンスに画像データを設定
    end
  end

  #「フォローする」というリレーションシップを作成する
  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end

  #フォローする相手がDB上に存在したらtrue
  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  #フォロー解除
  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
  end
end
