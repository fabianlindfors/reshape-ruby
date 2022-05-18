require_relative "../lib/reshape_helper"
require "test/unit"

class ReshapeTest < Test::Unit::TestCase
	def test_default_directory
		assert_schema_path("migration_2_test_migration")
	end

	def test_custom_directory
		assert_schema_path("migration_3_test_migration", "tests/fixtures/migrations-1")
	end

	def test_multiple_directories
		assert_schema_path("migration_3_test_migration", "tests/fixtures/migrations-1", "tests/fixtures/migrations-2")
	end

	def test_custom_migration_name
		assert_schema_path("migration_custom_migration_name", "tests/fixtures/custom-migration-name")
	end

	def test_non_existent_directory
		assert_schema_path(nil, "tests/fixtures/non-existent")
	end

	def assert_schema_path(expected, *dirs)
		schema_path = ReshapeHelper::search_path(*dirs)
		query = ReshapeHelper::schema_query(*dirs)

		assert_equal(expected, schema_path)
		if expected.nil?
			assert_equal('SET search_path TO "$user", public', query)
		else
			assert_equal("SET search_path TO #{expected}", query)
		end
	end
end