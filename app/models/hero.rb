class Hero < ApplicationRecord
  validates :name, uniqueness: { scope: :token, case_sensitive: false }
  validates :name, :token, presence: true
  validates :token, length: { minimum: 10 }
  
  scope :sorted_by_name, -> { order :name }
  scope :search_by_token, -> (token) { where(token: token) }
  scope :search, -> (name) { where('LOWER(name) LIKE ?', "%#{ name.downcase }%") if name.present? }
end
