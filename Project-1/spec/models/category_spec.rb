require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Associations' do
    it 'has_many posts' do
      association_type = described_class.reflect_on_association(:posts).macro
      expect(association_type).to eq :has_many
    end
  end
end