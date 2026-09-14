# frozen_string_literal: true

require 'optparse'

module XcodeTrashRemover
  module CLI
    module_function

    PRETTY_SIZE_UNITS = %w[B KiB MiB GiB TiB].freeze

    def run(argv, out: $stdout, err: $stderr)
      options = {}
      parser = option_parser(options, out)
      args = argv.dup

      parser.parse!(args)

      unless args.empty? 
        err.puts "Unexpected arguments: #{args.join(' ')}"
        err.puts parser
        return 1
      end

      return 0 if options[:help]

      if options[:check] == options[:remove]
        err.puts 'Choose exactly one of --check or --remove.'
        err.puts parser
        return 1
      end

      print_volumes(out)

      if options[:remove]
        total = XcodeDir.total_size
        XcodeDir.remove_all
        print_removal(total, out)
      end

      0
    rescue OptionParser::ParseError => e
      err.puts e.message
      err.puts parser
      1
    end

    def print_volumes(output)
      output.puts 'Dir             size'
      output.puts

      XcodeDir.directory_sizes.each do |label, size|
        output.puts format('%-15s %s', label, pretty_size(size))
      end

      output.puts
    end

    def print_removal(total, output)
      output.puts format('%-15s %s', 'Total', pretty_size(total))
      output.puts '-'
      output.puts 'The directories are empty. No trash files.' if total.zero?
      output.puts "#{pretty_size(total)} removed!" unless total.zero?
    end

    def pretty_size(bytes)
      return '0 B' if bytes.zero?
    
      unit_index = (Math.log2(bytes) / 10).to_i
      unit_index = [unit_index, PRETTY_SIZE_UNITS.length - 1].min
    
      value = bytes.to_f / (1 << (10 * unit_index))
    
      if unit_index.zero?
        "#{bytes} B"
      else
        "#{value.round(2)} #{PRETTY_SIZE_UNITS[unit_index]}"
      end
    end

    def option_parser(options, out)
      OptionParser.new do |opt|
        opt.banner = 'Usage: xcclean [options]'
        opt.separator ''
        opt.separator 'Options:'

        opt.on('--check', 'Check Xcode trash volumes') do
          options[:check] = true
        end

        opt.on('--remove', 'Remove Xcode trash files') do
          options[:remove] = true
        end

        opt.on('-h', '--help', 'Show this help') do
          out.puts opt
          options[:help] = true
        end
      end
    end
  end
end
