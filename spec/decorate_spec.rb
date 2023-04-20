require './decorate'
require './person'


describe BaseDecorator do
  before :each do
    @person = Person.new(27, 'chimamandaadiche')
  end

  context 'CapitalizeDecorator' do
    it 'capitalize the name' do
      capitalize = CapitalizeDecorator.new(@person)
      expect(capitalize.correct_name).to eql('Chimamandaadiche')
    end
  end

  context 'TrimmerDecorator' do
    it 'trim name with more than 10 characters' do
      trimmer = TrimmerDecorator.new(@person)
      expect(trimmer.correct_name).to eql('chimamanda')
      expect(trimmer.correct_name.length).to be <= 10
    end
  end
end
