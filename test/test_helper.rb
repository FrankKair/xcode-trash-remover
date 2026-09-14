# frozen_string_literal: true

require 'fileutils'
require 'minitest/autorun'
require 'stringio'
require 'tmpdir'

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
require 'xcode_trash_remover'

module XcodeTrashRemoverTestHelpers
  def with_temp_xcode_home
    Dir.mktmpdir('xcclean-home') do |home|
      previous_home = ENV['XCODE_TRASH_REMOVER_HOME']
      ENV['XCODE_TRASH_REMOVER_HOME'] = home
      yield home
    ensure
      ENV['XCODE_TRASH_REMOVER_HOME'] = previous_home
    end
  end

  def seed_xcode_trash(home)
    write_file(home, 'Library/Developer/Xcode/DerivedData/App Build/build.log', '12345')
    write_file(home, 'Library/Developer/Xcode/Archives/Archive 1/archive.dat', '1234567')
    write_file(home, 'Library/Developer/CoreSimulator/Devices/Device A/device.data', '12345678901')
    write_file(home, 'Library/Developer/Xcode/iOS DeviceSupport/16.0/Symbols/sym.dat', '1234')
    write_file(home, 'Library/Developer/Xcode/watchOS DeviceSupport/9.0/Symbols/sym.dat', '12')
    write_file(home, 'Library/Caches/com.apple.dt.Xcode/Downloads/cache.dat', '123456')
    write_file(home, 'Library/Caches/org.swift.swiftpm/repositories/repo.dat', '123')
  end

  def write_file(home, relative_path, content)
    path = File.join(home, relative_path)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, content)
    path
  end
end

class Minitest::Test
  include XcodeTrashRemoverTestHelpers
end
