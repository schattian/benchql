module Types
  class BaseObject < GraphQL::Schema::Object
    field :string, String, null: false

    def string
      'Hello World!'
    end
  end
end
