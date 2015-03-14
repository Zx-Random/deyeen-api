module API
  module V1
    class Users < Grape::API
      resource :users do
        desc '返回所有的用户'
        get '/', rabl: 'api/v1/users/index' do
          @users = User.all
        end

        desc '返回指定用户信息'
        get '/:id' do
          @user = User.find params[:id]
          render rabl: 'api/v1/users/show'
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
