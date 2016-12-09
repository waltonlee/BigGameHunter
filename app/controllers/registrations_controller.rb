class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.skip_confirmation!
    if resource.save
      sign_in resource
      render :status => 200,
           :json => { :success => true,
                      :info => "Registered",
                      :data => { :user => resource,
                                 :auth_token => current_user.authentication_token } }
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => resource.errors,
                        :data => {} }
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, {:gametype_ids => []}, :receive, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, {:gametype_ids => []}, :receive, :email, :password, :password_confirmation, :current_password)
  end
end
