describe Resourcey::Config do
  describe '#configure' do
    it 'sets `foo` config var' do
      expect {
        Resourcey.configure { |config| config.foo = 'new-value' }
      }.to change {
        Resourcey.config.foo
      }.from('foo').to('new-value')
    end
  end
end
