class StripeChargeService
  def initialize(order, token)
    @order = order
    @token = token
  end

  def call
    charge = Stripe::Charge.create(
      amount: (@order.total_price * 100).to_i,
      currency: 'cad',
      description: "Order ##{@order.id}",
      source: @token
    )
    @order.update(stripe_charge_id: charge.id, status: 'paid')
  rescue Stripe::CardError => e
    @order.errors.add(:base, e.message)
    false
  end
end
