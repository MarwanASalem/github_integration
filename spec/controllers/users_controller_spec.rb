require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do

    context 'successful responses' do
      login_user
      it 'returns user when user is authorized' do
        get :show

        expect(response.status).to eq(200)
      end
    end

    context 'unsuccessful responses' do
      it 'redirects user when they are not logged in' do
        get :show

        expect(response.status).to eq(302)
      end
    end

  end
end