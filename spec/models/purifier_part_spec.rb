require 'rails_helper'

RSpec.describe PurifierPart, type: :model do
  describe 'associations' do
    it { should have_many :service_purifier_parts }
    it { should have_many :services } 
  end
end
