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
      puts "Total           #{total.pretty}"
      puts '-'
      if total.zero?
        puts 'The directories are empty. No trash files.'
        exit(0)
      end

      dirs = [
        Dir.glob("#{File.expand_path('~')}/Library/Developer/Xcode/DerivedData/*"),
        Dir.glob("#{File.expand_path('~')}/Library/Developer/Xcode/Archives/*"),
        Dir.glob("#{File.expand_path('~')}/Library/Developer/XCPGDevices/*"),
        Dir.glob("#{File.expand_path('~')}/Library/Developer/CoreSimulator/Devices/*")
      ]

      dirs.each do |dir|
        dir.each do |subdir|
          remove_dir(subdir)
        end
      end
      puts "#{total.pretty} removed!"
    end

    private

    def total_size
      total = 0
      total += derived_data_size
      total += archives_size
      total += playground_devices_size
      total += core_simulator_size
      total
    end

    def derived_data_size
      dir = Dir.glob("#{File.expand_path('~')}/Library/Developer/Xcode/DerivedData/*")
      trash_size(dir)
    end

    def archives_size
      dir = Dir.glob("#{File.expand_path('~')}/Library/Developer/Xcode/Archives/*")
      trash_size(dir)
    end

    def playground_devices_size
      dir = Dir.glob("#{File.expand_path('~')}/Library/Developer/XCPGDevices/*")
      trash_size(dir)
    end

    def core_simulator_size
      dir = Dir.glob("#{File.expand_path('~')}/Library/Developer/CoreSimulator/Devices/*")
      trash_size(dir)
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
