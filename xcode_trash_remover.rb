#!/usr/bin/env ruby

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
	ARCHIVES_DIR = "/Users/#{ARGV[0]}/Library/Developer/Xcode/Archives/*"
end

def check_argv
	if ARGV.empty?
		puts 'No user path specified'.red
		puts 'Usage: ./xcode_trash_remover.rb Username' 
		abort
	end
end

def check_folders
	Directory.constants.each { |dir|
		trash_dir = Directory.const_get(dir)
		files = Dir.glob(trash_dir)
		if files.empty?
			puts "There are no files in #{trash_dir}"
		end
		files.each { |folder| puts File.basename(folder) }
	}
end

def delete_trash_files
	Directory.constants.each { |dir|
		FileUtils.rm_rf(Dir.glob(Directory.const_get(dir)))
		puts "Deleted all files from #{Directory.const_get(dir)}".red
	}
end

check_argv
check_folders
delete_trash_files