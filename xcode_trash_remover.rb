#!/usr/bin/env ruby
require 'fileutils'
require 'find'

module Directory
	DERIVED_DATA_DIRECTORY = "#{File.expand_path('~')}/Library/Developer/Xcode/DerivedData/*"
	ARCHIVES_DIRECTORY = "#{File.expand_path('~')}/Library/Developer/Xcode/Archives/*"
end

def dir_size(dir_path)
  total_size = 0
  Find.find(dir_path) do |path|
      if FileTest.directory?(path)
        if File.basename(path)[0] == ?.
          Find.prune
        else
          next
        end
      else
        total_size += FileTest.size(path)
      end
    end
    total_size
end

trash_size = 0
Directory.constants.each do |dir|
	trash_dir = Directory.const_get(dir)
	files = Dir.glob(trash_dir)
	if files.empty?
		puts "There are no files in #{dir}"
		next
	end
	puts "#{dir} files:"
	files.each do |folder|
		trash_size += dir_size(folder)
		puts File.basename(folder)
		FileUtils.rm_rf(folder)
	end
	puts "Deleted all files from #{dir}"
end
puts "\n#{trash_size} bytes deleted"
