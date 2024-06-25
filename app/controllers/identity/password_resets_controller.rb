class Identity::PasswordResetsController < ApplicationController
  layout "sessions"
    
  skip_before_action :authenticate

  before_action :set_user, only: %i[ edit update ]

  def new
  end

  def edit
  end

  def create
    if @user = User.find_by(email: params[:email], verified: true)
      send_password_reset_email
      redirect_to sign_in_path, notice: "Wir haben dir eine E-Mail mit einem Link zum Zurücksetzen deines Passworts geschickt."
    else
      redirect_to new_identity_password_reset_path, alert: "Du kannst dein Passwort nicht zurücksetzen. Bitte überprüfe deine E-Mail-Adresse."
    end
  end

  def update
    if @user.update(user_params)
      redirect_to sign_in_path, notice: "Dein Passwort wurde erfolgreich geändert. Du kannst dich jetzt anmelden."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find_by_token_for!(:password_reset, params[:sid])
    rescue StandardError
      redirect_to new_identity_password_reset_path, alert: "Der Link zum Zurücksetzen des Passworts ist ungültig oder abgelaufen. Bitte fordere einen neuen an."
    end

    def user_params
      params.permit(:password, :password_confirmation)
    end

    def send_password_reset_email
      UserMailer.with(user: @user).password_reset.deliver_later
    end
end
