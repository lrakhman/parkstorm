require 'rails_helper'

RSpec.describe Region, :type => :model do
  describe '.find_ward_section' do
    it 'should return a hash with the ward_secti' do
      expect(Region.find_ward_section(41.890633, -87.629238)["ward_secti"]).to be_truthy
    end
    it 'should return the correct ward_secti' do  
      expect(Region.find_ward_section(41.890633, -87.629238)).to eq({"ward_secti"=>"4202"})
    end
    it 'should return nil for locations outside Chicago' do
      expect(Region.find_ward_section(50,50)).to eq(nil)
    end
  end
  describe '#sections_nearby' do
    let(:region) { Region.find_by_ward_secti("4202") }

    it 'should return all regions with a sufficiently large distance' do
      expect(region.sections_nearby(100).length).to eq(Region.all.count)
    end
    it 'should return self with a distance of 0' do
      expect(region.sections_nearby(0)[0]["ward_secti"]).to eq(region.ward_secti)
    end
    it 'handles in between distances' do
      expect(region.sections_nearby(1).count).to eq(15)
    end
  end
end
