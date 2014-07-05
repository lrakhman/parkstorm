require 'rails_helper'

RSpec.describe Region, :type => :model do

  describe '.find_by_location' do

    it 'should return a Region' do
      expect(Region.find_by_location(41.890633, -87.629238)).to be_a Region
    end

    it 'should return the correct ward_secti' do  
      expect(Region.find_by_location(41.890633, -87.629238).ward_secti).to eq("4202")
    end

    it 'should return nil for locations outside Chicago' do
      expect(Region.find_by_location(50,50)).to eq(nil)
    end

    it 'should handle discontinuous polygons' do
      region1 = Region.find_by_location(41.803713, -87.613624)
      region2 = Region.find_by_location(41.804873, -87.613774)
      region3 = Region.find_by_location(41.806256, -87.613613)
      expect(region1).to eq(region3)
      expect(region1).not_to eq(region2)
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

    it 'should return only self with a distance of 0' do
      expect(region.sections_nearby(0).count). to eq(1)
    end

    it 'handles in between distances' do
      expect(region.sections_nearby(1).count).to eq(15)
    end
  end

  describe '#cleaning_days' do
    
    let(:region) { Region.find(2) }

    it 'should return an array of dates' do
      expect(region.cleaning_days).to be_a Array
      expect(region.cleaning_days.first).to be_a Date
    end

    it 'should contain the correct number of dates' do
      expect(region.cleaning_days.count).to eq(12)
    end

    it 'should return the correct dates' do
      expect(region.cleaning_days.first).to eq(Date.new(2014,05,05))
      expect(region.cleaning_days.last).to eq(Date.new(2014,11,10))
    end
  end

  describe '#next_cleaning_day' do
    
    let(:region) { Region.find(4) }

    it 'should return a date' do
      expect(region.next_cleaning_day).to be_a Date
    end

    it 'should return a date after today' do
      expect(region.next_cleaning_day).to be >= Date.today
    end

    it 'should return nil if there are no future cleaning dates' do
      expect(Region.find(600).next_cleaning_day).to be nil
    end
  end

  describe '.areas_to_display' do
    
    let(:area) { Region.areas_to_display([41.890633, -87.629238], 1) }

    it 'should return an array of two arrays' do
      expect(area[0]).to be_a Array
      expect(area[1]).to be_a Array
    end

    it 'should return two empty arrays if the location is not in Chicago' do
      area = Region.areas_to_display([50,50], 10)
      expect(area[0]).to be_empty
      expect(area[1]).to be_empty
    end

    it 'should return all regions with a sufficiently large radius' do
      area = Region.areas_to_display([41.890633, -87.62939], 100)
      expect(area[0].count + area[1].count).to eq(Region.all.count)

    end
  end
end
