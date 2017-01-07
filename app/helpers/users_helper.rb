module UsersHelper
  def image_for(user) #ユーザーに対応した画像表示
    if user.image
     image_tag "/user_images/#{user.image}"
    else
     image_tag "egg_blue.png"
    end
  end
end
