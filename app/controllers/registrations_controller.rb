class RegistrationsController < ApplicationController
  layout "sessions"

  skip_before_action :authenticate

  def new
    @user = UserRegistrationForm.new
  end

  def create
    @user = UserRegistrationForm.new(user_params)

    if @user.save
      user = User.find_by(email: @user.email)

      if user
        @user.errors.add(:email, "Die Email-Adresse ist bereits vergeben.")
        render :new, status: :unprocessable_entity
      end

      user = User.new(user_params)

      if user.save
        session_record = user.sessions.create!
        cookies.signed.permanent[:session_token] = { value: session_record.id, httponly: true }

        send_email_verification(user)
        redirect_to root_path, notice: "Willkommen! Du hast dich erfolgreich registriert. Bitte bestätige deine E-Mail-Adresse."
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
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
