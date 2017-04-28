require 'fileutils'
require 'find'
module XcodeTrashRemover

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

end