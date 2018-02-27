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
      print_total_size(total)
      remove_dirs
      puts "#{total.pretty} removed!"
    end

    private

    def print_total_size(size)
      puts "Total           #{size.pretty}"
      puts '-'
      if size.zero?
        puts 'The directories are empty. No trash files.'
        exit(0)
      end
    end

    def remove_dirs
      dirs = [
        XcodeDir.derived_data,
        XcodeDir.archives,
        XcodeDir.playground_devices,
        XcodeDir.core_simulator
      ]

      dirs.each do |dir|
        dir.each do |subdir|
          remove_dir(subdir)
        end
      end
    end

    def derived_data_size
      trash_size(XcodeDir.derived_data)
    end

    def archives_size
      trash_size(XcodeDir.archives)
    end

    def playground_devices_size
      trash_size(XcodeDir.playground_devices)
    end

    def core_simulator_size
      trash_size(XcodeDir.core_simulator)
    end

    def total_size
      total = 0
      total += derived_data_size
      total += archives_size
      total += playground_devices_size
      total += core_simulator_size
      total
    end

    def trash_size(dir)
      return 0 if dir.empty?
      size = 0
      dir.each do |subdir|
        size += SizeHelper.dir_size(subdir)
      end
      size
    end

    def remove_dir(dir)
      FileUtils.rm_rf(dir.gsub(/ /, '\ '))
    end
  end
end
