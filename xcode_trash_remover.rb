#!/usr/bin/env ruby
require 'fileutils'

module Directory
	DERIVED_DATA_DIRECTORY = "#{File.expand_path('~')}/Library/Developer/Xcode/DerivedData/*"
	ARCHIVES_DIRECTORY = "#{File.expand_path('~')}/Library/Developer/Xcode/Archives/*"
end

Directory.constants.each do |dir|
	trash_dir = Directory.const_get(dir)
	files = Dir.glob(trash_dir)
	if files.empty?
		puts "There are no files in #{dir}"
		next
	end
	puts "#{dir} files:"
	files.each do |folder|
		puts File.basename(folder)
		FileUtils.rm_rf(folder)
	end
	puts "Deleted all files from #{dir}"
end