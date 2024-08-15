class SettingsController < ApplicationController
  before_action :set_variables

  def index
  end

  def avatar
    imagekit_service = ImagekitService.new
    @user.update(avatar_params)
    redirect_to settings_path
  end

  def delete
    @user.avatar.purge
    redirect_to settings_path
  end

  def update
    filtered_params = filter_empty_params(user_params)

    if filtered_params.empty?
      redirect_to settings_path
    else
      if @user.update(filtered_params)
        redirect_to settings_path, notice: { title: "Speichern", message: "User Daten wurden gespeichert." }
      else
        render :index, alert: { title: "Fehler", message: "Es gab Fehler beim Speichern" }
      end
    end
  end

  def email
    @email_form = EmailForm.new(email: params[:email_form][:email])

    if @email_form.save
      @user.update(email_params)
      resend_email_verification
      redirect_to settings_path, notice: { title: "Erfolgreich", message: "Deine Email Adresse wurde gespeichert. Du erhälst eine Bestätigungsmail." }
    else
      render :index, alert: { title: "Fehler", message: "Beim Speichern ist ein Fehler aufgetreten. Bitte überprüfe Deine Eingabe" }
    end
  end

  def password
    @password_form = PasswordForm.new(password: params[:password_form][:password], password_confirmation: params[:password_form][:password_confirmation])

    if @password_form.save
      @user.update(password_params)
      send_password_reset_email
      redirect_to settings_path, notice: { title: "Erfolgreich", message: "Dein neues Passwort wurde gespeichert." }
    else
      render :index, alert: { title: "Fehler", message: "Beim Speichern ist ein Fehler aufgetreten. Bitte überprüfe Deine Eingabe" }
    end
  end

  private
    def set_variables
      imagekit_service = ImagekitService.new
      @user = Current.user
      @avatar_url = imagekit_service.face_url(@user.avatar)
      @email_form = EmailForm.new(email: @user.email)
      @password_form = PasswordForm.new  
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end

    def avatar_params
      params.require(:user).permit(:avatar)
    end

    def email_params
      params.require(:email_form).permit(:email)
    end

    def password_params
      params.require(:password_form).permit(:password)
    end    

    def filter_empty_params(params)
      params.reject { |key, value| value.blank? }
    end

    def resend_email_verification
      UserMailer.with(user: @user).email_verification.deliver_later
    end

    def send_password_reset_email
      UserMailer.with(user: @user).password_reset.deliver_later
    end
end
