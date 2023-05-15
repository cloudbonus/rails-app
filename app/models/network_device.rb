class NetworkDevice < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :bandwidth, presence: true, numericality: true
end
