# frozen_string_literal: true

class Staffs::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  before_action :creatable?, only: [:new, :create]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def creatable?
    redirect_to root_url unless staff_signed_in?
    if !current_staff_is_admin?
      redirect_to staffs_screen_url, alert: "権限がありません"
    end
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # def create
  #   # ここでStaff.new（と同等の操作）を行う
  #   build_resource(sign_up_params)

  #   # ここでStaff.save（と同等の操作）を行う
  #   resource.save

  #   # ブロックが与えられたらresource(=Staff)を呼ぶ
  #   yield resource if block_given?
  #   if resource.persisted?
  #   # 先程のresource.saveが成功していたら
  #     if resource.active_for_authentication?
  #     # confirmable/lockableどちらかのactive_for_authentication?がtrueだったら
  #       # flashメッセージを設定
  #       set_flash_message! :notice, :signed_up
  #       # サインアップ操作
  #       sign_up(resource_name, resource)
  #       # リダイレクト先を指定
  #       respond_with resource, location: staff_after_sign_up_path_for(resource)
  #     else
  #       set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
  #       # sessionを削除
  #       expire_data_after_sign_in!
  #       respond_with resource, location: after_inactive_sign_up_path_for(resource)
  #     end
  #   else
  #   # 先程のresource.saveが失敗していたら
  #     # passwordとpassword_confirmationをnilにする
  #     clean_up_passwords resource
  #     # validatable有効時に、パスワードの最小値を設定する
  #     set_minimum_password_length
  #     respond_with resource
  #   end
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def current_staff_is_admin?
    staff_signed_in? && current_staff.admin?
  end

  def sign_up(resource_name, resource)
    if !current_staff_is_admin?
      sign_in(resource_name, resource)
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    staffs_path(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    staffs_path(resource)
  end
end
