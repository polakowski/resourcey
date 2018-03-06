describe UsersController, type: :controller do
  describe '#index' do
    it 'renders attributes' do
      user_1 = create(:user, name: 'Tom')
      user_2 = create(:user, name: 'John')

      get :index

      expect(json_response).to match_array([
        include('name' => 'Tom'),
        include('name' => 'John')
      ])
    end
  end

  describe '#show' do
    it 'renders attributes' do
      user_1 = create(:user, name: 'Tom')
      user_2 = create(:user, name: 'John')
      user_3 = create(:user, name: 'George')

      get :show, params: { id: user_2.id }

      expect(json_response).to include('name' => 'John')
      expect(json_response).to_not include('name' => 'Tom')
    end
  end

  describe '#create' do
    context 'with valid params' do
      params = { user: { name: 'James', age: 55 } }

      it 'creates resource' do
        expect { post :create, params: params }.to change { User.count }.by(1)
      end

      it 'returns serialized resource' do
        post :create, params: params
        expect(json_response).to include('name' => 'James')
      end
    end

    context 'with invalid params' do
      params = { user: { name: 'No-age' } }

      it 'does not create resource' do
        expect { post :create, params: params }.to_not change { User.count }
      end

      it 'returns errors' do
        post :create, params: params
        expect(json_response['errors']).to include('age')
        expect(json_response['errors']['age']).to include(I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      params = { user: { name: 'Not a regular name' } }

      it 'updates resource' do
        user = create(:user, name: 'Regular name')

        expect { post :update, params: params.merge(id: user.id) }
          .to change { user.reload.name }.from('Regular name').to('Not a regular name')
      end

      it 'returns serialized resource' do
        user = create(:user, name: 'Regular name')

        post :update, params: params.merge(id: user.id)

        expect(json_response).to include('name' => 'Not a regular name')
        expect(json_response).to_not include('name' => 'Regular')
      end
    end

    context 'with invalid params' do
      params = { user: { age: -10 } }

      it 'does not update resource' do
        user = create(:user)

        expect { post :update, params: params.merge(id: user.id) }
          .to_not change { user.reload.name }
      end

      it 'returns errors' do
        user = create(:user)

        post :update, params: params.merge(id: user.id)

        expect(json_response['errors']).to include('age')
        expect(json_response['errors']['age'])
          .to include(I18n.t('errors.messages.greater_than', count: 0))
      end
    end
  end

  describe '#destroy' do
    it 'destroys the resource' do
      user = create(:user)

      expect { delete :destroy, params: { id: user.id } }.to change { User.count }
        .by(-1)
    end
  end
end