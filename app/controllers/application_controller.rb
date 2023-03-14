class ApplicationController < ActionController::Base
    private def current_user
        User.find(session[:user_id]) if session[:user_id]
    end

    # helper_methodは引数に指定されたメソッドをテンプレートの中でも使えるヘルパーメソッドとして登録
    helper_method :current_user

    class LoginRequired < StandardError; end
    class Forbidden < StandardError; end

    # ログインしていなければエラーを返す
    private def login_required
        raise LoginRequired unless current_user
    end
end
