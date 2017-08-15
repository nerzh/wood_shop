module WoodShop
  module ModelHelper
    # FriendlyId
    def should_generate_new_friendly_id?
      slug.blank? or url_changed?
    end

    def normalize_friendly_id(text)
      text.to_slug.normalize(transliterations: [:russian, :ukrainian]).to_s
    end
    # FriendlyId end
  end
end