module OrderableById
extend ActiveSupport::Concern

included do 
	scope :by_recently_id, -> { order (id: :desc)}
	end
end