describe Resourcey::Config do
  describe 'default config' do
    it 'sets default variables values' do
      expect(Resourcey.config.default_paginator).to eq(:paged)
    end
  end

  describe '#configure' do
    it 'sets `default_paginator` config var' do
      expect {
        Resourcey.configure { |config| config.default_paginator = :foobar }
      }.to change {
        Resourcey.config.default_paginator
      }.from(:paged).to(:foobar)
    end
  end
end
