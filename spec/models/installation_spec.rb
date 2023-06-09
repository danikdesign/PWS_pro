# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Installation, type: :model do
  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :pressure }
    it { should validate_presence_of :in_tds }
    it { should validate_presence_of :out_tds }
  end

  describe 'associations' do
    it { should belong_to :client }
  end
end
