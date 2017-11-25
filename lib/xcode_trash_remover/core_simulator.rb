require 'fileutils'
require 'find'

module XcodeTrashRemover
  module CoreSimulator
    extend self
    def core_simulator_folders
      dirs = []

      # TODO: Select which version to delete (8, 9, Watch, TV...)
      os = ['iOS-8', 'iOS-9', 'watchOS', 'tvOS']

      core_simulator_dir = "#{File.expand_path('~')}/Library/Developer/CoreSimulator/Devices/*/*"

      Dir.glob(core_simulator_dir).each do |dir|
        next unless dir.include?('plist')
        device_plist = "/#{dir}"[1..-1]

        os.each do |os|
          dirs.push(File.dirname(dir)) if File.read(device_plist).include?(os)
        end
      end
      dirs
    end
  end
end
