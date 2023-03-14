class SessionsController < ApplicationController

    def create
        user = User.find_by(name: params[:name])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
        else
            flash.alert = "名前とパスワードが一致しません"
        end
        redirect_to :root
    end

    def destroy
        session.delete(:user_id)
        redirect_to :root
    end

end
