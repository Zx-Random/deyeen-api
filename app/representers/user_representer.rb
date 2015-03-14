module UserRepresenter
  include Roar::JSON
  include Roar::Hypermedia
  include Grape::Roar::Representer

  property :id
  property :username

  link :self do |opts|
    request = Grape::Request.new(opts[:env])
    version = opts[:env]['api.version']
    "#{request.base_url}/api/#{version}/users/#{id}"
  end
end
