# Reshape Ruby helper

[![Tests](https://github.com/fabianlindfors/reshape-ruby/actions/workflows/test.yaml/badge.svg)](https://github.com/fabianlindfors/reshape-ruby/actions/workflows/test.yaml)

This is a Ruby helper library for the automated, zero-downtime schema migration tool [Reshape](https://github.com/fabianlindfors/reshape). To achieve zero-downtime migrations, Reshape requires that your application runs a simple query when it opens a connection to the database to select the right schema. This library automates that process with a single function which will return the correct query for your application.

## Installation

Add `reshape_helper` as a dependency to your `Gemfile`:

```ruby
gem "reshape_helper", "~> 0.1.1"
```

## Usage

The library exposes a single function, `ReshapeHelper::schema_query`, which will find all your Reshape migration files and determine the right schema query to run. Here's an example of how to use it:

```ruby
require "reshape_helper"

schema_query = ReshapeHelper::schema_query

# Run the schema query against your database when you open a new connection
db.execute(schema_query)
```

By default, `ReshapeHelper::schema_query` will look for migrations files in `migrations/` but you can specify your own directories as well:

```ruby
require "reshape_helper"

schema_query = ReshapeHelper::schema_query(
	"src/users/migrations",
	"src/todos/migrations",
)
```

## License

Released under the [MIT license](https://choosealicense.com/licenses/mit/).