class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :region #, scope :swept_soon, -> { where(Region.)}

	# scope :swept_soon, -> { where()}

	# where the region.swept_soon? == true; runs block on each thing in
	# association and only return the ones that are true
end
