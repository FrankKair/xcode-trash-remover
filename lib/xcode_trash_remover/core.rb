require 'fileutils'
require 'find'

module XcodeTrashRemover

	module Core

		extend self

		@@xcode_directories = [
							Dir.glob("#{File.expand_path('~')}/Library/Developer/Xcode/DerivedData/*"),
							Dir.glob("#{File.expand_path('~')}/Library/Developer/Xcode/Archives/*"),
							]

		def dir_size(dir_path)
				dir_path << '/' unless dir_path.end_with?('/')

			  raise RuntimeError, "#{dir_path} is not a directory" unless File.directory?(dir_path)

			  total_size = 0
			  Dir["#{dir_path}**/*"].each do |f|
			    total_size += File.size(f) if File.file?(f) && File.size?(f)
			  end
			  total_size
		end

		# TODO: function to return best size (MB or GB)

		def get_trash_size
			trash_size = 0
			@@xcode_directories.each do |dir|
			if dir.empty?
				next
			end
			dir.each do |folder|
				trash_size += dir_size(folder)
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
