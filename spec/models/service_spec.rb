require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :pressure }
    it { should validate_presence_of :in_tds }
    it { should validate_presence_of :out_tds_before }
    it { should validate_presence_of :out_tds_after }
  end

  describe 'associations' do
    it { should belong_to :client } 
    it { should have_many :service_purifier_parts }
    it { should have_many :purifier_parts } 
  end
end