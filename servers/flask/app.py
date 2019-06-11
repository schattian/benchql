from flask import Flask, request, jsonify
app = Flask(__name__)

@app.route('/')
def hello_world():
    print(request.args)
    print(request.data)
    if len(request.args) == 0: 
        return jsonify({"string":
            "Hello World!"})
    else:
        superstring = "Hello World!"*int(request.args.get('string'))
        return jsonify({"superstring": superstring})

if __name__ == "__main__":
    app.run()
