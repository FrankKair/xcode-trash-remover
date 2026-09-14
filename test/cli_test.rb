# frozen_string_literal: true

require_relative 'test_helper'

class CliTest < Minitest::Test
  def test_help_returns_success
    stdout = StringIO.new
    stderr = StringIO.new

    status = XcodeTrashRemover::CLI.run(['--help'], out: stdout, err: stderr)

    assert_equal 0, status
    assert_includes stdout.string, 'Usage: xcclean [options]'
    assert_empty stderr.string
  end

  def test_requires_exactly_one_action
    stdout = StringIO.new
    stderr = StringIO.new

    status = XcodeTrashRemover::CLI.run([], out: stdout, err: stderr)

    assert_equal 1, status
    assert_includes stderr.string, 'Choose exactly one of --check or --remove.'
  end

  def test_check_shows_all_directory_sies
    with_temp_xcode_home do |home|
      seed_xcode_trash(home)

      stdout = StringIO.new
      stderr = StringIO.new

      status = XcodeTrashRemover::CLI.run(['--check'], out: stdout, err: stderr)

      assert_equal 0, status
      rendered = stdout.string
      assert_includes rendered, 'DerivedData'
      assert_includes rendered, 'Archives'
      assert_includes rendered, 'CoreSimulator'
      assert_includes rendered, 'iOS Support'
      assert_includes rendered, 'watchOS Support'
      assert_includes rendered, 'Xcode Cache'
      assert_includes rendered, 'SPM Cache'
    end
  end

  def test_remove_runs_check_and_cleanup
    with_temp_xcode_home do |home|
      seed_xcode_trash(home)

      stdout = StringIO.new
      stderr = StringIO.new

      status = XcodeTrashRemover::CLI.run(['--remove'], out: stdout, err: stderr)

      assert_equal 0, status
      assert_empty stderr.string
      assert_includes stdout.string, 'DerivedData'
      assert_includes stdout.string, '38 B removed!'
      assert_equal 0, XcodeTrashRemover::XcodeDir.total_size
    end
  end
end
