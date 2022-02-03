class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は空欄か、○○○-○○○○の形で入力がされてません' }
    validates :prefecture_id, numericality: { other_than: 0, message: "は”---”以外を選択してください" }
    validates :city
    validates :block
    validates :phone_number, format: { with:/\A[0-9]{11}\z/, message: 'は10桁もしくは11桁ではないか、"-"が抜けているか、空欄です' }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(order_id: order.id, postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number)
  end
end
