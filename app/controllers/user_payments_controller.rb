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
      @amount = params[:amount]

      @amount = @amount.gsub('$', '').gsub(',', '')

      begin
        @amount = Float(@amount).round(2)
      rescue
        flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
        redirect_to new_charge_path
        return
      end

      @amount = (@amount * 100).to_i # Must be an integer!

      if @amount < 500
        flash[:error] = 'Charge not completed. Donation amount must be at least $5.'
        redirect_to new_charge_path
        return
      end

      Stripe::Charge.create(
        :amount => @amount,
        :currency => 'usd',
        :source => params[:stripeToken],
        :description => 'Custom donation'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
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
