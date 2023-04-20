require './decorate'

describe CapitalizeDecorator do
  context 'Capitalize  name' do
    capitalizeDecorator = CapitalizeDecorator.new('chiamanda')

    it 'Capitalize the name' do
      expect(capitalizeDecorator.correct_name).to be 'Chiamanda'
    end
  end
end
