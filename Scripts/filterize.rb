#!/usr/bin/env ruby -wKU
# Filterize.rb
# Author: Justin Williams
# Date: December 05, 2012
#
# INPUT
# 0: Directory Path: Should contain JSON and other assets (REQUIRED)
# 1: Filter Name (REQUIRED)
# 2: Output Directory Path (OPTIONAL)
#
# OUTPUT
# `.filter` files for each supported resolution (NAME_1536.filter, NAME_2448.filter, etc.)
#
# SAMPLE USAGE
# ./filterize.rb [Directory Path] [FilterName]
#

require 'digest/sha1'
require 'FileUtils'
require 'json'

# These are the file sizes we are supporting.
FILTER_SIZES = %w{ 1536 1936 2448 }

# Check input
INPUT_DIR_PATH = ARGV[0] || raise("Error: Input directory required")
FILTER_NAME = ARGV[1] || raise("Error: Filter name required")
OUTPUT_DIR_PATH = ARGV[2] || File.expand_path(File.dirname(__FILE__))

# Check that the path is valid
if !File.directory?(INPUT_DIR_PATH)
	raise("Error: Directory path is not valid.")
end

Dir.chdir(INPUT_DIR_PATH)

# Delete the manifest if it exists.
# Create a new manifest: set MANIFEST = $CWD/manifest.json
manifest = "#{INPUT_DIR_PATH}/Manifest.json"
if File.exists?(manifest)
	FileUtils.rm(manifest)
end

#echo '{' > $MANIFEST

MANIFEST = []
IMAGES = []

# Iterate each item for each FILTER_SIZE
FILTER_SIZES.each do |n|

	filter_name = "#{FILTER_NAME}_#{n}"
	filter_path = "/tmp/#{filter_name}"
	FileUtils.rm_rf(filter_path) if Dir.exists?(filter_path)
	FileUtils.mkdir(filter_path) 

	puts "Generating #{filter_name}"
	Dir.foreach(INPUT_DIR_PATH) do |item|
		next if item == '.' or item == '..'

		# If we are an image, check to see if it contains an extension for a file size at the end	
		if (File.extname(item) == '.jpg' or File.extname(item) == '.png')
			if /_(#{n}).(jpg|png)/.match(File.basename(item))
				fixed_name = File.basename(item).sub(/_(#{n})/, '')
				# Copy the file without the underscore to our path
				FileUtils.cp(item, "#{filter_path}/#{fixed_name}")

				MANIFEST << fixed_name
				IMAGES << fixed_name
			else 
				# next if the file name matches something already in the manifest.
				next if IMAGES.include?(File.basename(item).sub(/_(#{FILTER_SIZES.join("|")})/, ''))
				FileUtils.cp(item, "#{filter_path}/#{File.basename(item)}")
				MANIFEST << File.basename(item)
			end
		else 
			FileUtils.cp(item, "#{filter_path}/#{File.basename(item)}")
			MANIFEST << File.basename(item)
		end
	end

	# Generate the Manifest file.
	manifest_items = {}
	MANIFEST.uniq.each do |file|
		manifest_items[file] = Digest::SHA1.base64digest file
	end

	# Write the manifest
	file = File.new("#{filter_path}/Manifest.json", "w")
	file.write JSON.pretty_generate(manifest_items)
	file.close

	# Zip it up
	Dir.chdir(filter_path)
	%x(zip -r #{filter_name}.filter . -x "*__MACOSX" -x "*.DS_Store")

	# Copy it to the script path location
	puts "Copying #{filter_name} to output directory #{OUTPUT_DIR_PATH}"
	FileUtils.cp("#{filter_name}.filter", "#{OUTPUT_DIR_PATH}/#{filter_name}.filter") 

	# Back to the start path
	Dir.chdir(INPUT_DIR_PATH)
end

