module UserRepresenter
  include Roar::JSON::HAL
  include Roar::Hypermedia
  include Grape::Roar::Representer

  property :uuid, from: :id
  property :username

  link :self do |opts|
    request = Grape::Request.new(opts[:env])
    version = opts[:env]['api.version']
    "#{request.base_url}/api/#{version}/users/#{uuid}"
  end
end
