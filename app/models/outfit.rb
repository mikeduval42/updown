class Outfit < ActiveRecord::Base
	belongs_to :user
	has_attached_file :photo, :styles => { :thumb => "100x100#", :medium => "500x500>", :large => "800x800>" }
	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

	def thumb_url
		photo.url(:thumb)
	end
end
