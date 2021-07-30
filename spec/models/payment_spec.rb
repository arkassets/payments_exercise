require 'rails_helper'

RSpec.describe Payment, type: :model do

  describe "#associations" do
    it { expect(Payment.reflect_on_association(:loan).macro).to eq(:belongs_to) }
  end

  describe "#validations" do
    let(:loan) { Loan.create!(funded_amount: 5000.0) }
    let(:payment){ Payment.new(amount_paid: amount_paid, loan_id: loan_id, payment_date: payment_date) }
    let(:amount_paid) { 500 }
    let(:loan_id) { loan.id }
    let(:payment_date) { Date.parse('2020-12-12') }

    context 'when invalid payment data' do
      context 'when payment amount is nil' do
        let(:amount_paid) { nil }
        it { expect(payment.valid?).to be_falsy }
      end
      context 'when payment amount not greater than outstanding' do
        let(:amount_paid) { 5001 }
        it { expect(payment.valid?).to be_falsy }
      end
      context 'when payment amount is negative' do
        let(:amount_paid) { -101 }
        it { expect(payment.valid?).to be_falsy }
      end
      context 'when loan id is nil' do
        let(:loan_id) { nil }
        it { expect(payment.valid?).to be_falsy }
      end
      context 'when payment date not valid' do
        let(:payment_date) { Date.parse('2021-12-12') }
        it { expect(payment.valid?).to be_falsy }
      end
    end
    context 'when payment data is valid' do
      it { expect(payment.valid?).to be_truthy }
    end
  end

end
