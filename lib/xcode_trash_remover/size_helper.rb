require 'fileutils'
require 'find'

module XcodeTrashRemover
  module SizeHelper
    extend self

    # TODO: function to return best size (MB or GB).

    def dir_size(dir_path)
      dir_path << '/' unless dir_path.end_with?('/')
      total_size = 0
      if File.directory?(dir_path)
        Dir["#{dir_path}**/*"].each do |f|
          total_size += File.size(f) if File.file?(f) && File.size?(f)
        end
      end
      total_size
    end
  end
end
