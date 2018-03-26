require 'fileutils'

module XcodeTrashRemover
  module Core
    extend self

    def check_volumes
      puts 'Dir             size'
      puts
      puts "DerivedData     #{derived_data_size.pretty}"
      puts "Archives        #{archives_size.pretty}"
      puts "XCPGDevices     #{playground_devices_size.pretty}"
      puts "CoreSimulator   #{core_simulator_size.pretty}"
      puts
    end

    def remove_trash
      total = total_size
      remove_dirs

      puts "Total           #{total.pretty}"
      puts '-'
      puts 'The directories are empty. No trash files.' if total.zero?
      puts "#{total.pretty} removed!" unless total.zero?
    end

    def show_options
      puts 'Run:'
      puts '$ xcclean -rm'
      puts 'To remove the files from your system.'
    end

    private

    def remove_dirs
      dirs = [
        XcodeDir.deriveddata, XcodeDir.archives,
        XcodeDir.xcpgdevices, XcodeDir.coresimulator_devices
      ]

      dirs.each do |dir|
        dir.each do |subdir|
          remove_dir(subdir)
        end
      end
    end

    def derived_data_size
      trash_size(XcodeDir.deriveddata)
    end

    def archives_size
      trash_size(XcodeDir.archives)
    end

    def playground_devices_size
      trash_size(XcodeDir.xcpgdevices)
    end

    def core_simulator_size
      trash_size(XcodeDir.coresimulator_devices)
    end

    def total_size
      [derived_data_size,
       archives_size,
       playground_devices_size,
       core_simulator_size].reduce(:+)
    end

    def trash_size(dir)
      return 0 if dir.empty?
      size = 0
      dir.each { |subdir| size += SizeHelper.dir_size(subdir) }
      size
    end

    def remove_dir(dir)
      FileUtils.rm_rf(dir.gsub(/ /, '\ '))
    end
  end
end
