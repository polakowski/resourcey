describe Resourcey::Config do
  describe 'default config' do
    it 'sets default variables values' do
      expect(Resourcey.config.default_paginator).to eq(:paged)
      expect(Resourcey.config.controller_parent).to eq(ActionController::Base)
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

      it 'sets class if string passed' do
        expect {
          Resourcey.configure { |config| config.controller_parent = 'FakeParentController' }
        }.to change {
          Resourcey.config.controller_parent
        }.from(ActionController::Base).to(FakeParentController)
      end

      it 'sets class if class passed' do
        expect {
          Resourcey.configure { |config| config.controller_parent = FakeParentController }
        }. to change {
          Resourcey.config.controller_parent
        }.from(ActionController::Base).to(FakeParentController)
      end

      it 'raises error if invalid parent name' do
        expect {
          Resourcey.configure { |config| config.controller_parent = 1 }
        }.to raise_error(Resourcey::Errors::RuntimeError)
      end
    end
  end
end
