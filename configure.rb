#!/usr/bin/env ruby
# Setup and configure HBBLib tool.
#
# @author     Igor Lesik 2014
# @copyright  2014

require 'ostruct'
require 'yaml'
require 'logger'
require 'optparse'
#require 'optparse/time'
require 'pathname'
require 'erb'
require 'tempfile'



module HBBLib

# Test provider for ArmApp test group.
#
class Configurator

  attr_reader :log

  # Constructor.
  # @param args [Array] command line options
  #
  def initialize(args)
    make_logger($stdout)
    @configuration = {}
    @work_dir = Dir.pwd #File.expand_path(File.dirname(__FILE__))
    @options = parse_options(args)
    @configuration.store('source_path', @options.src_dir)
  end

  # Read config files and generate configuration.
  #
  def run()
    if @options.config_files.empty?
      auto_config
    else
      process_config_files(@options.config_files)
    end
    dump_configuration(@configuration)
    make_directories
    make_test_script
    true
  end

private

  # Create and configure logger.
  #
  def make_logger(output, level=Logger::DEBUG)
    @logger = Logger.new(output)
    @logger.level = level
    @log = @logger
  end

  def make_directories
    log.info "Work directory: #{@work_dir}"

    build_dir = File.join(@work_dir, 'build')

    log.info "Make build directory: #{build_dir}"
    FileUtils::mkdir_p build_dir

    #FileUtils::mkdir_p File.join(@@work[:build], 'hwlib')
    #@logger.info "Make run directory: #{@@work[:run]}"
    #FileUtils::mkdir_p @@work[:run]
  end

  # Read configuration files
  #
  def process_config_files(files)
    files.each do |filename|
      process_config_file_template(filename)
    end
  end

  # Read configuration file
  #
  def process_config_file(filename)
    log.info("Processing #{filename}")

    File.open(filename) do |yaml_file|
      YAML.load_stream(yaml_file).each do |yaml|
        #puts yaml
        @configuration.merge!(yaml) #{|key, oldval, newval| return newval}
      end
    end

  end

  # Read configuration file template
  #
  def process_config_file_template(template_filename)
    log.info("Processing #{template_filename}")

    test_filename = File.basename(          # Get just file name w/o path
      template_filename, '.yaml') 
    test_file = Tempfile.new(test_filename) # Create empty temp file
    test_file.write("# Original template #{template_filename}")
    test_file.close                         # Close temp file for now
    begin
      process_config_template(              # Process template and
        template_filename, test_file.path)  #   write result to the temp file
      process_config_file(test_file.path)   # Process the file
    ensure
      test_file.close                       # Close the temp file
      test_file.unlink                      # Delete the temp file
    end

  end

  def fatal_erb(failure, template, filename)
    errline = failure.backtrace.grep(/^\(erb\)/)[0].split(':')[1].to_i
    errline_text = template.split("\n")[errline-1]
    erb_error = "ERB: #{failure.message}, file #{filename}, line #{errline}: #{errline_text}"
    puts failure.backtrace

    raise RuntimeError, erb_error
  end

  def process_config_template(template_path, test_file_path)
    template = File.read(template_path)

    renderer = ERB.new(template, 0, '%><>-')
    output = 'something went wrong if you see this'
    begin
      output = renderer.result(binding) #or_some_object.get_binding)
    rescue RuntimeError => e
      output = "Runtime error: #{e.message}"
      fatal_erb(e, template, template_path)
      return false
    rescue NoMethodError => e
      output = "Undefined method: #{e.message}"
      fatal_erb(e, template, template_path)
      return false
    rescue ArgumentError => e
      output = "Argument error: #{e.message}"
      fatal_erb(e, template, template_path)
      return false
    ensure
      #
    end

    File.open(test_file_path, 'w') do |f|
      f.write output
    end
    true
  end

  def dump_configuration(params, dir = @work_dir, filename = 'configuration.yaml')
    file_path = File.join(dir, filename)
    log.info("Dump configuration to #{file_path}")
    File.open(file_path, "w") do |file|
      file.write params.to_yaml
    end
  end

  def make_test_script
    script = <<HERE
#!#{@configuration['installed']['ruby']['path']}
require_relative '#{@options.src_dir}/test'
HERE
    File.open('test.rb', 'w') {|file| file.write(script); file.chmod(0777)}
  end

  def auto_config
    require_relative './utils/which'
    log.warn("Auto configuring...")
    installed_tools = {}
    verilog_compilers = []
    sverilog_compilers = []
    path = nil
    if path = which('ruby')
      log.warn("Found ruby: #{path}")
      installed_tools.store('ruby', {'path' => path})
    end
    path = nil
    if path = which('gcc')
      log.warn("Found gcc: #{path}")
      installed_tools.store('gcc', {'path' => path})
    end
    path = nil
    if path = which('verilator')
      log.warn("Found verilator: #{path}")
      installed_tools.store('verilator', {'vlog' => path})
      verilog_compilers << 'verilator'
    end


    @configuration['installed'] = installed_tools unless installed_tools.empty?
    @configuration['Verilog'] = verilog_compilers unless verilog_compilers.empty?

  end

  # Parse command line options
  # @return [OpenStruct] structure holding all options
  #
  def parse_options(args)
    # The options specified on the command line will be collected in *op*.
    op = OpenStruct.new

    # Specify default values
    op.log_level = Logger::DEBUG
    op.src_dir = File.expand_path(File.dirname(__FILE__))

    op.config_files = []

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: configure.rb --config cfg_file.yaml [--config another.yaml]"

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-c", "--config FILE", "Configuration file") do |filename|
        log.debug("add config file #{filename}")
        op.config_files << Pathname(filename).realpath
      end

      #opts.on("-l", "--log FILE", "Log file") do |filename|
      #  op.log_name = filename
      #end

      opts.on("--log-level LEVEL", "Logging level") do |level|
        op.log_level = level
      end

      opts.separator ""
      opts.separator "Common options:"

      # No argument, shows at tail.  This will print an options summary.
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

      # Typical switch to print the version.
      opts.on_tail("--version", "Show version") do
        #puts "Ruby version: #{RUBY_VERSION}"
        require_relative './version'
        puts "HBBLib version: #{HBBLib::VERSION_STR}"
        exit
      end
    end

    opt_parser.parse!(args)

    # Not parsed options must be extra ???
    #op.test_args = args
    #args.each do |filename|
    #end

    op
  end

end # class Configurator

module_function
def configure()
  HBBLib::Configurator.new(ARGV).run
end

module_function
def trap_signal_INT(signo)
  Signal.trap(signo, "DEFAULT")
end

end # HBBLib module

def run!
  puts "Ruby version: #{RUBY_VERSION}"

  # Register Ctrl-C handler
  Signal.trap("INT") do |signo|
    puts "Signal: #{Signal.signame(signo)} (Ctrl-C)"
    HBBLib.trap_signal_INT(signo)
  end

  result = false

  require 'benchmark'
  time_report = Benchmark.measure { result = HBBLib.configure }
  puts "Time: #{time_report}"

  return result
end

# Run if this is top level program
if __FILE__ == $PROGRAM_NAME
  result = run!
  exit(result ? 0:1)
else
  puts "This program is standalone executable! Use it properly."
  exit 1
end
