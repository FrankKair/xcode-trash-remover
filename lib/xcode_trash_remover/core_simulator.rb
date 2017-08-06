require 'fileutils'
require 'find'

module XcodeTrashRemover
	module CoreSimulator
		extend self
		def get_core_simulator_folders
			dirs = []

			# TODO: Select which version to delete (8, 9, Watch, TV...)
			os = ['iOS-8', 'iOS-9', 'watchOS', 'tvOS']

			core_simulator_dir = "#{File.expand_path('~')}/Library/Developer/CoreSimulator/Devices/*/*"

			Dir.glob(core_simulator_dir).each do |dir|
				unless dir.include?('plist')
					next
				end
				device_plist = "/#{dir}"[1..-1]

				os.each do |os|
					if File.read(device_plist).include?(os)
						dirs.push(File.dirname(dir))
					end
				end
			end
			dirs
		end
	end
end