require 'rails_helper'

RSpec.describe 'Devise Registrations', type: :request do
  describe 'POST /users' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post user_registration_path, params: { user: { email: 'test@test.com', password: '123456' } }
        }.to change(User, :count).by(1)
        
        expect(response).to redirect_to(root_path)
      end
    end
    
    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post user_registration_path, params: { user: { email: '', password: 'password' } }
        }.not_to change(User, :count)
        
        expect(response).to render_template(:new)
      end
    end
  end
end