require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Associations' do
    it 'belongs_to user' do
      association_type = described_class.reflect_on_association(:user).macro
      expect(association_type).to eq :belongs_to
    end

    it 'belongs_to category' do
      association_type = described_class.reflect_on_association(:category).macro
      expect(association_type).to eq :belongs_to
    end
  end
end