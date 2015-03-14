class CreateAdminService
  def call
    user = User.find_or_create_by!(username: Rails.application.secrets.admin_name) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.admin!
      end
  end
end
