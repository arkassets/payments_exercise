require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    let(:params) { {loan: { funded_amount: funded_amount }} }

    context 'when funded_amount is greater than zero' do
      let(:funded_amount) { 5000 }
      it 'responds with 201' do
        post :create, params: params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when funded_amount is less than zero' do
      let(:funded_amount) { -5000 }
      it 'responds with 422' do
        post :create, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, params: { id: loan.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#payments' do
    let(:loan) { Loan.create!(funded_amount: 5000.0) }
    it 'responds with 200' do
      get :payments, params: { id: loan.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
