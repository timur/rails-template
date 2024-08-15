class RegistrationsController < ApplicationController
  layout "sessions"

  skip_before_action :authenticate

  def new
    @user_form = UserRegistrationForm.new
  end

  def create
    user = User.find_by(email: params[:user_registration_form][:email])

    if user
      @user_form = UserRegistrationForm.new(user_params)
      @user_form.errors.add(:email, "Die Email-Adresse ist bereits vergeben.")
      render :new, status: :unprocessable_entity
    else
      @user_form = UserRegistrationForm.new(user_params)

      if @user_form.save
        user = User.create(user_params)
        session_record = user.sessions.create!
        cookies.signed.permanent[:session_token] = { value: session_record.id, httponly: true }

        send_email_verification(user)
        redirect_to root_path, notice: "Willkommen! Du hast dich erfolgreich registriert. Bitte bestätige deine E-Mail-Adresse."
      else
        render :new, status: :unprocessable_entity
      end  
    end
  end

  private
    def user_params
      params.require(:user_registration_form).permit(:email, :password, :password_confirmation)
    end

    def send_email_verification(user)
      UserMailer.with(user: user).email_verification.deliver_later
    end
end
