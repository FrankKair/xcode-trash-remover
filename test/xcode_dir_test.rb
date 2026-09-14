# frozen_string_literal: true

require_relative 'test_helper'

class XcodeDirTest < Minitest::Test
  def test_directory_sizes_reports_each_target
    with_temp_xcode_home do |home|
      seed_xcode_trash(home)

      sizes = XcodeTrashRemover::XcodeDir.directory_sizes

      assert_equal 5, sizes['DerivedData']
      assert_equal 7, sizes['Archives']
      assert_equal 11, sizes['CoreSimulator']
      assert_equal 4, sizes['iOS Support']
      assert_equal 2, sizes['watchOS Support']
      assert_equal 6, sizes['Xcode Cache']
      assert_equal 3, sizes['SPM Cache']
    end
  end

  def test_total_size
    with_temp_xcode_home do |home|
      seed_xcode_trash(home)

      assert_equal 38, XcodeTrashRemover::XcodeDir.total_size
    end
  end

  def test_remove_all_clears_directories
    with_temp_xcode_home do |home|
      seed_xcode_trash(home)

      XcodeTrashRemover::XcodeDir.remove_all

      assert_equal 0, XcodeTrashRemover::XcodeDir.total_size
    end
  end
end
