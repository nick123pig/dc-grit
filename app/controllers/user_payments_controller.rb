class UserPaymentsController < ApplicationController
  before_action :set_user_payment, only: [:show]
  before_action :set_cause

  def new
    @user_payment = UserPayment.new
  end

  def show
  end

  def create
    begin
      @amount = cause_params[:amount]
      @amount = @amount.gsub('$', '').gsub(',', '')

      customer = Stripe::Customer.create(
        :email => current_user.email,
        :source  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'DC Grit Contribution',
        :currency    => 'usd'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

    @user_payment = UserPayment.new(amount: @amount, cause: @cause, stripe_charge_id: charge.id)

    respond_to do |format|
      if @user_payment.save
        format.html { redirect_to @user_payment, notice: 'You have successfully contributed!' }
        format.json { render :show, status: :created, location: @user_payment }
      else
        format.html { render :new }
        format.json { render json: @cause.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    def set_user_payment
      @user_payment = UserPayment.find(params[:id])
    end

    def set_cause
      @cause = Cause.find(cause_params[:cause_id])
      unless @cause
        flash[:error] = "No Cause Selected"
        redirect_to causes_path 
      end
    end


    def cause_params
      params.permit(:stripeToken, :cause_id, :amount)
    end

end
