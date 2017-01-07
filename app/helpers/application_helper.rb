module ApplicationHelper
  def current_user?(user) #ログイン中のユーザーとuserインスタンスが同じ場合trueを返す
    current_user.id == user.id
  end
end
