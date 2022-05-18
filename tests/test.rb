require_relative "../lib/reshape_helper"
require "test/unit"

class ReshapeTest < Test::Unit::TestCase
	def test_default_directory
		query = ReshapeHelper::schema_query
		assert_equal("SET search_path TO migration_2_test_migration", query)
	end

	def test_custom_directory
		query = ReshapeHelper::schema_query("tests/fixtures/migrations-1")
		assert_equal("SET search_path TO migration_3_test_migration", query)
	end

	def test_multiple_directories
		query = ReshapeHelper::schema_query("tests/fixtures/migrations-1", "tests/fixtures/migrations-2")
		assert_equal("SET search_path TO migration_3_test_migration", query)
	end

	def test_custom_migration_name
		query = ReshapeHelper::schema_query("tests/fixtures/custom-migration-name")
		assert_equal("SET search_path TO migration_custom_migration_name", query)
	end

	def test_non_existent_directory
		query = ReshapeHelper::schema_query("tests/fixtures/non-existent")
		assert_equal('SET search_path TO "$user", public', query)
	end
end