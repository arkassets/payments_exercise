class Payment < ActiveRecord::Base

  belongs_to :loan

  validates :loan_id, :amount_paid, :payment_date, presence: true
  validates :amount_paid, numericality: { greater_than: 0 }
  validate :validate_payment

  def as_json(options={})
    {
      id: id,
      amount_paid: amount_paid,
      payment_date: payment_date.strftime("%Y-%m-%d")
    }
  end

  def validate_payment
    return false unless loan_id
    valid = true
    if payment_date && payment_date > Time.now
      errors.add(:payment_date, "Invalid Payment date: cannot be in future")
      valid = false
    end
    if loan && amount_paid
      if loan.outstanding_amount < amount_paid
        errors.add(:amount_paid, "amount cannot be greater than loan outstanding amount #{loan.outstanding_amount}")
        valid = false
      end
    else
      errors.add(:loan, "Invalid Loan")
      valid = false
    end
    errors.present?
  end

end
