# Reshape Ruby helper

[![Tests](https://github.com/fabianlindfors/reshape-ruby/actions/workflows/test.yaml/badge.svg)](https://github.com/fabianlindfors/reshape-ruby/actions/workflows/test.yaml)

This is a Ruby helper library for the automated, zero-downtime schema migration tool [Reshape](https://github.com/fabianlindfors/reshape). To achieve zero-downtime migrations, Reshape requires that your application runs a simple query when it opens a connection to the database to select the right schema. This library automates that process with a simple method which will return the correct query for your application. It also works great with Rails!

## Installation

Add `reshape_helper` as a dependency to your `Gemfile`:

```ruby
gem "reshape_helper", "~> 0.2.1"
```

## Usage

The library includes a `ReshapeHelper::schema_query` method which will find all your Reshape migration files and determine the right schema query to run. Here's an example of how to use it:

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

## Usage with Rails

Using Reshape for zero-downtime migrations with Ruby on Rails is dead simple. After adding `reshape_helper` to your `Gemfile`, update `config/database.yml` and add a `schema_search_path` setting like this:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  schema_search_path: <%= ReshapeHelper::search_path %>
```

Now your Rails app is ready for use with Reshape. Rather than creating standard Active Record migrations using `bin/rails generate migration ...`, you should create [Reshape migration files](https://github.com/fabianlindfors/reshape) in `migrations/`. If you'd prefer to use other folders for your migrations, you can pass them along as arguments:

```yaml
schema_search_path: <%= ReshapeHelper.search_path("src/users/migrations", "src/todos/migrations") %>
```

## License

Released under the [MIT license](https://choosealicense.com/licenses/mit/).