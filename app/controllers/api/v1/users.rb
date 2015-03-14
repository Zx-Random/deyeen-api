module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      namespace :users do
        desc '返回所有的用户'
        get '/' do
          User.all
        end

        desc '创建账号'
        params do
          requires :user, type: Hash do
            requires :username, type: String, desc: '用户名'
            requires :password, type: String, desc: '密码'
          end
        end
        post '/' do
          User.create!(params[:user])
        end
      end
    end
  end
end
