namespace :api do
	desc "显示 API 的 routes"
	task :routes => :environment do
		API::Base.routes.each do |api|
			method = api.route_method.ljust(10)
			next if api.route_path.include?('swagger_doc')
			path = api.route_path.gsub(":version", api.route_version)
			puts "     #{method} #{path}"
		end
	end
end
