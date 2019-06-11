# BenchQL 

## Requirements

Python 3.6+ and `wrk`.

```shell
pip3 install -r requirements.txt
```
Servers Requirements: depending on which servers you are using (or if you setup your custom servers).

To recreate the provided servers:

Builtin servers:
 - Go (native): github.com/graph-gophers/graphql-go.
 - Ruby (rack): dependencies on Gemfile (bundler).
 - Ruby (rails): dependencies on Gemfile (bundler).
 - Python (japronto): dependencies on requirements.txt.
 - Node (express): dependencies on yarn.
 - Python (Flask REST simple example): flask.

## Benchmark

`python3 benchql.py benchmark` will benchmark Servers and queries from a given [`config.yaml`](#config-file) and output into an optional json file (`results.json`)

```shell
python3 benchql.py benchmark config.yaml results.json
```

Also, after benchmarking a dashboard server will automatically run with the results.

## Dashboard

`python3 gbench.py dashboard results.json config.yaml` will start a dashboard server using the given results file and config warmup as headers.

Examples:

<br>
<br>

GraphQL (2 endpoints, 5 APIs):


<a href="https://ibb.co/ZJxB6yn"><img src="https://i.ibb.co/H2qtDmW/newplot-2.png" alt="newplot-2" border="0"></a>
<a href="https://ibb.co/g78GxWW"><img src="https://i.ibb.co/VNGdsCC/newplot-1.png" alt="newplot-1" border="0"></a>
<br>
<br>

REST (2 endpoints, 1 API):

<a href="https://ibb.co/6XRXpd9"><img src="https://i.ibb.co/hYRYnqQ/newplot-4.png" alt="newplot-4" border="0"></a>
<a href="https://ibb.co/Px0q6dL"><img src="https://i.ibb.co/nrtxLFG/newplot-3.png" alt="newplot-3" border="0"></a>


## Config file

The BenchQL config file is in a `yaml` format. It have two main sections: `servers` and `queries`.

The `servers` section indicates in which servers we are going to run the benchmark.
Also, we will indicate what is the startup command for running it and if there is any warmup time we should spend before benchmarking.

```yaml
servers:
- name: Graphene
  enabled: 1
  # The endpoint to run the benchmark on
  endpoint: http://localhost:8080/graphql
  run:
    # The command to run
    command: python3 app.py
    # The path where the command is going to be executed
    cwd: servers/japronto-graphene/
    # The time we will wait before benchmarking
    startupTime: 2s


```
Then, specify the warmup (or ramp-up) of the server:
```
warmup:
  concurrency: 1
  duration: 5s
  threads: 10
```
The `queries` section indicates all the different queries that we want to benchmark, in all servers.

```yaml
queries:
- name: Basic
  # The filename where the query is going to be readed
  filename: queries/basic.graphql
  # This is optional, but if present will validate the response
  # of each of the GraphQL servers against the given file.
  expected: queries/basic.json
```

## Docker

> Upcoming: dockerized servers


Build the dashboard image in docker by doing:

```
docker build -t benchql .
```

And to run the dashboard:

```
docker run -p 8080:8080 benchql 
```
