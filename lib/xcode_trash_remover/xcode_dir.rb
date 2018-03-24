module XcodeTrashRemover
  module XcodeDir
    extend self

    # Creates:
    # deriveddata, archives
    # xcpgdevices and coresimulator_devices
    # methods.

    dir_names = %w[
      Xcode/DerivedData
      Xcode/Archives
      XCPGDevices
      CoreSimulator/Devices
    ]

    dir_names.each do |dir|
      trimmed_dir_name = dir.downcase.tr('/', '_').to_s.gsub('xcode_', '')

      define_method(trimmed_dir_name) do
        root(dir)
      end
    end

    private

    def root(dir)
      Dir.glob("#{File.expand_path('~')}/Library/Developer/#{dir}/*")
    end
  end
end
