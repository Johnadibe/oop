require './person'
describe Person do
  context 'create a person' do
    person = Person.new(27, 'Microverse')

    it ' show age' do
      expect(person.age).to eq 27
    end

    it 'show name' do
      expect(person.name).to eq 'Microverse'
    end
  end
end
