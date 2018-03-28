describe Resourcey::Config do
  describe 'default config' do
    it 'sets default variables values' do
      expect(Resourcey.config.default_paginator).to eq(:paged)
      expect(Resourcey.config.controller_parent).to eq('action_controller/base')
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

    describe 'controller_parent' do
      after { Resourcey.config = Resourcey::Config.new }

      it 'sets `controller_parent` config var' do
        expect {
          Resourcey.configure { |config| config.controller_parent = FakeParentController }
        }. to change {
          Resourcey.config.controller_parent
        }.from('action_controller/base').to(FakeParentController)
      end
    end
  end
end
