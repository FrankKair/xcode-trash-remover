require 'fileutils'

module XcodeTrashRemover
  module Core
    extend self

    def check_volumes
      puts 'Dir             size'
      puts
      puts "DerivedData     #{deriveddata_size.pretty}"
      puts "Archives        #{archives_size.pretty}"
      puts "XCPGDevices     #{xcpgdevices_size.pretty}"
      puts "CoreSimulator   #{coresimulator_devices_size.pretty}"
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

    dirs = %w[
      deriveddata
      archives
      xcpgdevices
      coresimulator_devices
    ]

    dirs.each do |dir|
      define_method("#{dir}_size") do
        case dir
        when 'deriveddata'
          trash_size(XcodeDir.deriveddata)
        when 'archives'
          trash_size(XcodeDir.archives)
        when 'xcpgdevices'
          trash_size(XcodeDir.xcpgdevices)
        when 'coresimulator_devices'
          trash_size(XcodeDir.coresimulator_devices)
        end
      end
    end

    def total_size
      [deriveddata_size,
       archives_size,
       xcpgdevices_size,
       coresimulator_devices_size].reduce(:+)
    end

    def trash_size(dir)
      return 0 if dir.empty?
      dir.reduce(0) { |size, subdir| size += SizeHelper.dir_size(subdir) }
    end

    def remove_dir(dir)
      FileUtils.rm_rf(dir.gsub(/ /, '\ '))
    end
  end
end
