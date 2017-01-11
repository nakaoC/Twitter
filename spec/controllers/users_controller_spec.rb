require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Get #show' do
    it "ユーザー詳細" do
      user = User.new(name: "ryo",id: 1)

      get :show, id: user.id
      expect(response).to render_template :show
    end
  end

end
