# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'validations' do
    it { should validate_presence_of :datetime }
  end

  describe 'associations' do
    it { should belong_to :ticketable }
  end
end
