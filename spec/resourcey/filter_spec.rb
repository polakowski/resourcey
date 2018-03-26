describe UserFilter do
  describe '.filter' do
    it 'raises error if unallowed option is provided' do
      expect {
        UserFilter.filter :foo_bar, unallowed_option: true do |value, scope|; end
      }.to raise_error(Resourcey::Errors::OptionNotAllowed)
    end
  end
end
