# BenchQL 

## Requirements

Python 3.6+ and `wrk`.

```shell
pip3 install -r requirements.txt
```
Servers Requirements: depending on which servers you are using (or if you setup your custom servers).
Builtin servers:
 - Go: go (native).
 - Rack: dependencies on Gemfile (bundler).
 - Rails: dependencies on Gemfile (bundler).
 - Python: dependencies on requirements.txt.

## Benchmark

`python3 benchql.py benchmark` will benchmark Servers and queries from a given [`config.yaml`](#config-file) and output into an optional json file (`results.json`)

```shell
python3 benchql.py benchmark config.yaml results.json
```

Also, after benchmarking a dashboard server will automatically run with the results.

## Dashboard

`python3 gbench.py dashboard results.json` will start a dashboard server using the given results file.

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
