# 名前空間admin　管理者用コントローラの親クラス

class Admin::Base < ApplicationController
    before_action :admin_login_required

    private def admin_login_required
        raise Forbidden unless current_user&.administrator?
    end

end