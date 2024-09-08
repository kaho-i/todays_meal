# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
   before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path
  end

  private
# アクティブであるかを判断するメソッド
  def user_state
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    user = User.find_by(email: params[:user][:email])
    # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
    return if user.nil?
      flash[:notice] = "メールアドレスまたはパスワードが一致しません"
    # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless user.valid_password?(params[:user][:password])
    # 【処理内容4】 アクティブでない会員に対する処理
    if user.is_active == false
      flash[:notice] = "退会済みです。新規登録してください"
      redirect_to new_user_registration_path
      return
    end
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
