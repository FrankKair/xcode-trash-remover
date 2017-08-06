require 'fileutils'
require 'find'

module XcodeTrashRemover
	module Core
		extend self

		@@xcode_directories = [
							Dir.glob("#{File.expand_path('~')}/Library/Developer/Xcode/DerivedData/*"),
							Dir.glob("#{File.expand_path('~')}/Library/Developer/Xcode/Archives/*"),
							]

		def get_trash_size
			trash_size = 0
			@@xcode_directories.each do |dir|
				if dir.empty?
					next
				end
				dir.each do |folder|
					trash_size += SizeHelper::dir_size(folder)
				end
			end
			trash_size
		end

		def remove_trash
			@@xcode_directories.each do |dir|
				dir.each do |folder|
					FileUtils.rm_rf(folder.gsub(/ /, '\ '))
				end
			end
		end
	end
end