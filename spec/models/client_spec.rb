# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :phone }

    it { should validate_length_of(:first_name).is_at_least(2) }
    it { should validate_length_of(:last_name).is_at_least(2) }
    it { should validate_length_of(:address).is_at_least(6) }
    it { should validate_length_of(:phone).is_at_least(6) }
  end

  describe 'associations' do
    it { should have_many :installations }
    it { should have_many :services }
  end
end
