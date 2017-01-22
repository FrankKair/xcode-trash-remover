#!/usr/bin/env ruby

# Usage:
# ./xcode_trash_remover.rb Username

require 'fileutils'

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end
end

module Directory
	DERIVED_DATA_DIR = "/Users/#{ARGV[0]}/Library/Developer/Xcode/DerivedData/*"
end

def check_argv
	if ARGV.empty?
		puts 'No user path specified'.red
		abort
	end
end

def check_folder
	files = Dir.glob(Directory::DERIVED_DATA_DIR)
	if files.empty?
		puts 'There are no files in the directory.'
		abort
	end
	files.each { |folder| puts File.basename(folder) }
end

def delete_derived_data_files
	FileUtils.rm_rf(Dir.glob(Directory::DERIVED_DATA_DIR))
	puts "Deleted all files from #{Directory::DERIVED_DATA_DIR}".red
end

check_argv
check_folder
delete_derived_data_files