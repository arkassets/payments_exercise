class Loan < ActiveRecord::Base

  has_many :payments

  validates :funded_amount, numericality: { greater_than: 0 }

  def as_json(options={})
    {
      id: id,
      funded_amount: funded_amount,
      outstanding_amount: outstanding_amount
    }
  end

  def outstanding_amount
    funded_amount - payments.pluck(:amount_paid).sum
  end
end
