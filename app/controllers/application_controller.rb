class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    skills_path
  end

  def after_sign_out_path_for(resource_or_scope)
    unauthenticated_root_path
  end
end
