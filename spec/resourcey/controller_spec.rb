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

    describe 'filtering' do
      it 'uses filter when fetching objects' do
        user_1 = create(:user, age: 23, name: 'Brad')
        user_2 = create(:user, age: 20, name: 'Tim')
        user_3 = create(:user, age: 21, name: 'James')
        user_4 = create(:user, age: 22, name: 'Gregory')

        get :index, params: { older_than: 21 }

        expect(json_response).to match_array([
            include('name' => 'Gregory'),
            include('name' => 'Brad')
          ])
      end
    end

    context 'with multivalue filter' do
      it 'uses multivalue filter when fetching objects' do
        user_1 = create(:user, age: 67, name: 'Joseph')
        user_2 = create(:user, age: 55, name: 'Steve')
        user_3 = create(:user, age: 21, name: 'Jeff')
        user_4 = create(:user, age: 130, name: 'Mike')

        get :index, params: { age_range: '22,129' }

        expect(json_response).to match_array([
            include('name' => 'Steve'),
            include('name' => 'Joseph')
          ])
      end
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
        expect(json_errors).to include('age' => include(I18n.t('errors.messages.blank')))
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

        expect(json_errors).to include('age' =>
          include(I18n.t('errors.messages.greater_than', count: 0)))
      end
    end
  end

  describe '#destroy' do
    it 'destroys the resource' do
      user = create(:user)

      expect { delete :destroy, params: { id: user.id } }.to change { User.count }
        .by(-1)
    end

    context 'cannot destroy resource' do
      it 'does not destroy the resource' do
        user = create(:user_with_posts, posts_count: 2)

        expect { delete :destroy, params: { id: user.id } }.to_not change { User.count }
      end

      it 'returns errors' do
        user = create(:user_with_posts, posts_count: 2)
        delete :destroy, params: { id: user.id }

        expect(json_errors).to include('base' => include('cannot destroy user with posts'))
      end
    end
  end
end

describe PostsController, type: :controller do
  describe '#create' do
    it 'raises exception for resource_params' do
      params = { post: { content: 'Lorem' } }

      expect { post :create, params: params }.to raise_error(Resourcey::Errors::NotImplemented)
    end
  end
end

describe PaginatedPostsController, type: :controller do
  describe '#index' do
    it 'paginates using default paginator' do
      create(:post, content: 'one')
      create(:post, content: 'two')
      create(:post, content: 'three')
      create(:post, content: 'four')
      create(:post, content: 'five')

      get :index, params: { page: 2, per_page: 2 }

      expect(json_response.count).to eq 2
      expect(json_response).to match_array([
          include('content' => 'three'),
          include('content' => 'four'),
        ])
    end

    context 'with offset paginator' do
      it 'uses correct paginator' do
        PaginatedPostsController.paginate_with :offset

        create(:post, content: 'Oo')
        create(:post, content: 'Ooo')
        create(:post, content: 'Oooo')

        expect(OffsetPaginator).to receive(:new).and_call_original

        get :index, params: { offset: 1, limit: 1 }

        PaginatedPostsController.paginate
      end
    end
  end
end
