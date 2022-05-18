require "toml"
require "json"

DEFAULT_SEARCH_PATH = '"$user", public'

class ReshapeHelper
	def self.schema_query(*dirs)
		search_path = self.search_path(*dirs) || DEFAULT_SEARCH_PATH
		"SET search_path TO #{search_path}"
	end

	def self.search_path(*dirs)
		# Default to searching the migrations folder
		if dirs.empty?
			dirs = ["migrations"]
		end

		migrations = self.find_migrations(dirs)

		search_path = if migrations.empty?
			nil
		else
			"migration_#{migrations.last()}"
		end

		search_path
	end

	private

	def self.find_migrations(dirs)
		# Find all files in the specified folders
		files = dirs.flat_map do |dir|
			Dir.glob("#{dir}/*")
		end

		# Sort files by their names
		files = files.sort_by { |file| File.basename(file, ".*") }

		migrations = files.map do |file_path|
			contents = File.read(file_path)
			migration = self.decode_migration_file(file_path, contents)

			if migration.key?("name")
				migration["name"]
			else
				# Use the file name as migration name if no name is set in the migration file
				File.basename(file_path, ".*")
			end
		end

		migrations
	end

	def self.decode_migration_file(file_path, contents)
		if contents.empty?
			return {}
		end

		extension = File.extname(file_path)
		case extension
		when ".toml"
			TOML::Parser.new(contents).parsed
		when ".json"
			JSON.parse(contents)
		else
			raise "Unrecognized migration file extension #{extension}"
		end
	end
end