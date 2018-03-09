describe Resourcey::Paginator do
  describe '.class_for' do
    it 'returns class if correct' do
      expect(Resourcey::Paginator.class_for(:paged)).to eq(PagedPaginator)
    end
  end

  describe '#paginate' do
    it 'raises error for #setup' do
      params = build_params(:pagination, foo: 'bar')
      expect { Resourcey::Paginator.new(params) }.to raise_error(Resourcey::Errors::NotImplemented)
    end
  end
end

describe PagedPaginator do
  describe '#paginate' do
    it 'paginates' do
      create(:user, name: 'One')
      create(:user, name: 'Two')
      create(:user, name: 'Three')
      create(:user, name: 'Four')
      create(:user, name: 'Five')

      params = build_params(:pagination, page: 2, per_page: 2)

      paginator = PagedPaginator.new(params)
      pagination = paginator.paginate(User.all)

      expect(pagination.count).to eq 2
      expect(pagination).to match_array([
          have_attributes(name: 'Three'),
          have_attributes(name: 'Four')
        ])
    end
  end
end

describe CustomPaginator do
  describe '#paginate' do
    it 'paginates' do
      create(:user, name: 'Aa')
      create(:user, name: 'Bb')
      create(:user, name: 'Cc')
      create(:user, name: 'Dd')
      create(:user, name: 'Ee')

      params = build_params(:pagination, from: 2, to: 4)

      paginator = CustomPaginator.new(params)
      pagination = paginator.paginate(User.all)

      expect(pagination.count).to eq 3
      expect(pagination).to match_array([
          have_attributes(name: 'Bb'),
          have_attributes(name: 'Cc'),
          have_attributes(name: 'Dd')
        ])
    end
  end
end
