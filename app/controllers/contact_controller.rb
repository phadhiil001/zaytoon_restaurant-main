class ContactController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    if @contact_message.save
      # Here you can add code to send the email, if necessary
      redirect_to new_contact_message_path, notice: "Your message has been sent."
    else
      render :new, alert: "There was an error sending your message."
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
