from japronto import Application
from ujson import dumps, loads
from graphql import graphql
from schema import schema

headers = {
    'Content-Type': 'application/json; charset=utf8'
}

def json_response(request, data):
    return request.Response(
        text=dumps(data),
        headers=headers
    )


def get_json_body(request):
    return loads(request.body)


def get_query_data(request):
    if request.body:
        if request.mime_type == "application/graphql":
            return {
                'query': request.body.decode("utf-8"),
                'operationName': request.query.get('operationName')
            }
        return get_json_body(request)

def graphql_view(request):
    data = get_query_data(request)
    query = data.get('query')
    operation_name = data.get('operationName')
    result = graphql(schema, query, operation_name=operation_name, validate=False)
    return json_response(request, result.to_dict())


if __name__ == '__main__':
    app = Application()
    app.router.add_route('/graphql', graphql_view)
    app.run()
