module XcodeTrashRemover
  module XcodeDir
    dir_names = %w[
      Xcode/DerivedData
      Xcode/Archives
      XCPGDevices
      CoreSimulator/Devices
    ]

    dir_names.each do |dir|
      trimmed_dir_name = dir.downcase
                            .tr('/', '_')
                            .to_s
                            .gsub('xcode_', '')

      define_method(trimmed_dir_name) do
        root(dir)
      end
    end

    private

    def root(dir)
      Dir.glob("#{File.expand_path('~')}/Library/Developer/#{dir}/*")
    end

    module_function :deriveddata,
                    :archives,
                    :xcpgdevices,
                    :coresimulator_devices,
                    :root
  end
end
