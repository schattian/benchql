class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def execute
    variables = {}
    query = params[:query]
    operation_name = params[:operationName]
    context = {}
    result = RubySchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end
end
