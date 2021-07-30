class LoansController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Loan.all
  end

  def create
    loan = Loan.new(loan_params)
    if loan.valid? && loan.save!
      render json: { message: "Loan created Succeesfully. Loan Id #{loan.id}", status: :created }
    else
      render json: loan.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: Loan.find(params[:id])
  end

  def payments
    render json: Loan.find(params[:id]).payments
  end

  private

  def loan_params
    params.require(:loan).permit(:funded_amount)
  end
end
