class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q_for_item

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      items_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def set_q_for_item
    @q = Item.ransack(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active])
  end
end
