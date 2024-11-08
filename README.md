# Key value store

This is a simple key value store that supports the following operations:

- `GET <key>`: Get the value of a key
- `SET <key> <value>`: Set the value of a key
- `DELETE <key>`: Delete a key
- `COUNT <value>`: Get the number of keys that have the given value
- `INCREMENT <key>`: Increment the value of a key

> More commands can be added in the future.

The project is written in Ruby and uses Rspec for testing. To run the tests.

The project have a Rest API written with Sinatra.

# How to run the project

A Dockerfile and a docker-compose.yml is provided to run the project in a container.

- To build the image: `docker-compose build`
- To run the container: `docker-compose up`
- To run the tests: `docker-compose run --rm key_value_store rspec`
- To access the container: `docker-compose run --rm key_value_store bash`
  - You can run the commands inside the container.

