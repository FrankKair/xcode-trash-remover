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
				FileUtils.rm_rf(folder)
				end
			end
		end

	end

end