module API
  module V1
    class Users < Grape::API
      resource :users do
        desc '返回所有的用户'
        get '/' do
          users = User.page(params[:page])
          UsersRepresenter.for_collection.prepare(users)
        end

        desc '返回指定用户信息'
        get '/:uuid' do
          user = User.find_by!(uuid: params[:uuid])
          UserRepresenter.prepare(user)
        end

        desc '创建账号'
        params do
          requires :user, type: Hash do
            requires :username, type: String, desc: '用户名'
            requires :password, type: String, desc: '密码'
          end
        end
        post '/' do
          user = User.create!(permitted_params[:user])
          UserRepresenter.prepare(user)
        end
      end
    end
  end
end
