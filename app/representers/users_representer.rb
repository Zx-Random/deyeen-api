require 'paginated_representer'

module UsersRepresenter
  include Roar::JSON::HAL
  include Roar::Hypermedia
  include Grape::Roar::Representer
  include PaginatedPresenter

  collection :entries, extend: UserRepresenter, as: :users, embedded: true
end
