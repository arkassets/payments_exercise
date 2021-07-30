require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) { Loan.create!(funded_amount: 5000.0) }

  describe '#create' do
    let(:params) { {payment: { amount_paid: amount_paid, loan_id: loan_id, payment_date: payment_date }} }

    context 'when payment data is valid' do
      let(:amount_paid) { 50 }
      let(:loan_id) { loan.id }
      let(:payment_date) { Date.parse('2020-12-12') }
      it 'responds with 201' do
        post :create, params: params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when payment data is not valid' do
      let(:amount_paid) { 50000 }
      let(:loan_id) { loan.id }
      let(:payment_date) { Date.parse('2020-12-12') }
      it 'responds with 422' do
        post :create, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  describe '#show' do
    let(:payment) { Payment.create!(loan_id: loan.id, amount_paid: 500, payment_date: Date.parse('2020-12-12')) }

    it 'responds with 200' do
      get :show, params: { id: payment.id }
      expect(response).to have_http_status(:ok)
    end

    context 'when no payemnt exists' do
      it 'responds with 404' do
        get :show, params: { id: 999 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
