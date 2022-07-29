class Hero < ApplicationRecord
  validates :name, :token, presence: true
  scope :sorted_by_name, -> { order :name }
  scope :search_by_token, -> (token) { where(token: token) }
  scope :search, -> (term) { where('LOWER(name) LIKE ?', "%#{ term.downcase }%") if term.present? }
end
