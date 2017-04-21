#!/usr/bin/env ruby
require 'fileutils'
require 'find'

module XcodeDirectories
	DERIVED_DATA = "#{File.expand_path('~')}/Library/Developer/Xcode/DerivedData/*"
	ARCHIVES = "#{File.expand_path('~')}/Library/Developer/Xcode/Archives/*"
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
XcodeDirectories.constants.each do |dir|
	files = Dir.glob(XcodeDirectories.const_get(dir))
	if files.empty?
		next
	end
	files.each do |folder|
		trash_size += dir_size(folder)
		FileUtils.rm_rf(folder)
	end
end
puts "Deleted all files from #{XcodeDirectories.constants[0]} and #{XcodeDirectories.constants[1]}"
puts "\n#{trash_size} bytes deleted"
