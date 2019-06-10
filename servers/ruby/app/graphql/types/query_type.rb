module Types
  class QueryType < Types::BaseObject
    field :list_of_objects, [Types::BaseObject], null: false

    def list_of_objects
      @a = []
      100.times do 
        @a << Types::BaseObject.new({},{})
      end
        @a
    end
  end
end
