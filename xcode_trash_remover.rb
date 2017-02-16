#!/usr/bin/env ruby
require 'fileutils'

module Directory
	DERIVED_DATA_DIRECTORY = "/Users/#{ARGV[0]}/Library/Developer/Xcode/DerivedData/*"
	ARCHIVES_DIRECTORY = "/Users/#{ARGV[0]}/Library/Developer/Xcode/Archives/*"
end

def check_argv
	if ARGV.empty?
		puts 'No user path specified'
		puts 'Usage: ./xcode_trash_remover.rb Username' 
		puts 'The username is the one used in the path /Users/<username>/Library/Developer/Xcode'
		abort
	end
end

def check_folders_and_delete_trash_files
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
end

check_argv
check_folders_and_delete_trash_files