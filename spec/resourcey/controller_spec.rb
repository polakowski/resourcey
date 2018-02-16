describe UsersController, type: :controller do
  describe '#index' do
    it 'renders attributes' do
      user_1 = User.create! name: 'Tom'
      user_2 = User.create! name: 'John'

      get :index

      binding.pry

      expect(json_response).to match_array([
        include('name' => user_1.name),
        include('name' => user_2.name)
      ])
    end
  end

  describe '#show' do
    it 'renders attributes' do
      user_1 = User.create! name: 'Tom'
      user_2 = User.create! name: 'John'
      user_3 = User.create! name: 'Timothy'

      get :show, params: { id: user_2.id }

      expect(json_response).to include('name' => user_2.name)
    end
  end
end
