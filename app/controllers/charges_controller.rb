class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.name}",
      amount: 25_00
    }
  end

  # Creates a Stripe Customer object, for associating
  # with the charge

  def create
  customer = Stripe::Customer.create(
    email: current_user.email,
    card:  params[:stripeToken]
    )

  # Where the real magic happens
  charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: 25_00,
    description: "Premium Membership - #{current_user.email}",
    currency: 'usd'
    )

    current_user.update_attribute(:role, 'premium')

  flash[:notice] = "Congratulations, #{current_user.email}! Enjoy your new Premium membership."
  redirect_to wikis_path # or wherever

  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This 'rescue block' catches and displays those errors.
  rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
  end

  # Updating the private attribute to false (aka public) on every wiki which belongs to the user
  # Downgrade user role back to standard
  def downgrade
      current_user.wikis.each {|w| w.update_attribute(:private, false) }
      current_user.update_attribute(:role, 'standard')
      flash[:notice] = "Congratulations, #{current_user.email}! You have downgraded to Standard membership."
      redirect_to wikis_path
  end

end
