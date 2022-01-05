class ShippingDate < ActiveHash::Base
  self.data = [
    { id: 0, name: '—--' },
    { id: 1, name: '1日で発送' },
    { id: 2, name: '3日で発送' },
    { id: 3, name: '4~7日で発送' }
  ]

  include ActiveHash::Associations
  has_many :items
end
