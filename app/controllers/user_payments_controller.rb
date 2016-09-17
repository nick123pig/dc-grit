class UserPaymentsController < ApplicationController
  before_action :set_user_payment, only: [:show]
  before_action :set_project

  def new
    @user_payment = UserPayment.new
  end

  def show
  end


  def create
    begin
      @amount = user_payment_params[:amount]

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

      charge = Stripe::Charge.create(
        :amount => @amount,
        :currency => 'usd',
        :source => user_payment_params[:stripeToken],
        :description => 'Custom donation'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

    @user_payment = UserPayment.new(user_payment_params.except(:stripeToken), stripe_charge_id: charge.id)

    @user_payment.user = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user_payment
      @user_payment = UserPayment.find(params[:id])
    end

    def set_project
      @project = Project.find(user_payment_params[:project_id])
      unless @project
        flash[:error] = "No Project Selected"
        redirect_to projects_path 
      end
    end

    def user_payment_params
      params.permit(:stripeToken, :project_id, :amount)
    end

end
