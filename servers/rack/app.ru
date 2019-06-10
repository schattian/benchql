require 'graphql_server'

module Rack
  class CommonLogger
    def log(env, status, header, began_at)
    end
  end
end

class QueryType < GraphQL::Schema::Object
  field :string, String, null: false
  field :list_of_objects, [QueryType], null: false

  def list_of_objects
    @a = []
    100.times do 
      @a << QueryType.new({},{})
    end
    @a
  end

  def string
    'Hello World!'
  end

end

class RackSchema < GraphQL::Schema
  query(QueryType)
end

run GraphQLServer.new(schema: RackSchema)
