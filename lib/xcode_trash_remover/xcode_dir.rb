# frozen_string_literal: true

require 'fileutils'

module XcodeTrashRemover
  module XcodeDir
    module_function

    TARGETS = {
      'DerivedData'     => 'Library/Developer/Xcode/DerivedData',
      'Archives'        => 'Library/Developer/Xcode/Archives',
      'CoreSimulator'   => 'Library/Developer/CoreSimulator/Devices/',
      'iOS Support'     => 'Library/Developer/Xcode/iOS DeviceSupport',
      'watchOS Support' => 'Library/Developer/Xcode/watchOS DeviceSupport',
      'Xcode Cache'     => 'Library/Caches/com.apple.dt.Xcode',
      'SPM Cache'       => 'Library/Caches/org.swift.swiftpm',
    }.freeze

    def entries(dir)
      Dir.glob(File.join(home_dir, dir, '*')).sort
    end

    def directory_sizes
      TARGETS.each_with_object({}) do |(label, dir), sizes|
        sizes[label] = entries(dir).sum { |e| dir_size(e) }
      end
    end

    def total_size
      directory_sizes.values.sum
    end

    def remove_all
      TARGETS.each_value do |dir|
        entries(dir).each { |e| FileUtils.rm_rf(e) }
      end
    end

    def dir_size(dir_path)
      normalized_path = dir_path.end_with?('/') ? dir_path : "#{dir_path}/"
      return 0 unless File.directory?(normalized_path)

      Dir.glob("#{normalized_path}**/*").sum do |file_path|
        next 0 unless File.file?(file_path)

        File.size?(file_path).to_i
      end
    end

    def home_dir
      ENV.fetch('XCODE_TRASH_REMOVER_HOME', File.expand_path('~'))
    end
  end
end
