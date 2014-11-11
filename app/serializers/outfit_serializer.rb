class OutfitSerializer < ActiveModel::Serializer
  attributes :id, :type_of_outfit, :occasion, :brand_name, :price, :accessories, :sender_comment, :thumb_url, :photo
end
