require 'rails_helper'

RSpec.describe Planet, type: :model do
  context 'create planet' do
    it 'save if valid params' do
      planet = described_class.new(name: 'Mars', km_from_earth: 900)

      expect{ planet.save }.to change(Planet, :count).by(1)
      expect(Planet.find_by(name: 'Mars').km_from_earth).to eq(900)
    end
  end
end