module XcodeTrashRemover
  module XcodeDir
    extend self

    def derived_data
      root('Xcode/DerivedData')
    end

    def archives
      root('Xcode/Archives')
    end

    def playground_devices
      root('XCPGDevices')
    end

    def core_simulator
      root('CoreSimulator/Devices')
    end

    private
    def root(dir)
      Dir.glob("#{File.expand_path('~')}/Library/Developer/#{dir}/*")
    end
  end
end
