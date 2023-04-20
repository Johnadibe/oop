require './decorate'
require './person'
require './nameable'


describe BaseDecorator do
  before :each do
    @person = Person.new(27, 'chimamandaadiche')
  end

  context 'CapitalizeDecorator' do
    it 'capitalizes the name' do
      capitalize = CapitalizeDecorator.new(@person)
      expect(capitalize.correct_name).to eq('Chimamandaadiche')
    end
  end

  context 'TrimmerDecorator' do
    it 'trims name with more than 10 characters' do
      trimmer = TrimmerDecorator.new(@person)
      expect(trimmer.correct_name).to eq('chimamanda')
      expect(trimmer.correct_name.length).to be <= 10
    end
  end
end
