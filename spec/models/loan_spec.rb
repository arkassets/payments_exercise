require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { Loan.create(funded_amount: 5000) }

  describe "#associations" do
    it { expect(Loan.reflect_on_association(:payments).macro).to eq(:has_many) }
  end

  describe "#outstanding_amount" do
    it 'should return balance amount' do
      Payment.create(amount_paid: 500, loan_id: loan.id, payment_date: Date.parse("2020-12-12"))
      expect(loan.outstanding_amount).to eq 4500
    end
  end
end
