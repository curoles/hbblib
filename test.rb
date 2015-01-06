# Build and run tests one-by-one.
#
# @author     Igor Lesik 2014
# @copyright  2014
#

require 'benchmark'
require 'yaml'
require 'logger'

module HBBLib

NAME2LANG = {'v' => 'Verilog', 'sv' => 'SystemVerilog'}

class Tester

  def initialize(name, log, dir, config)
    @name, @log, @dir, @config = name, log, dir, config
    @log.progname = name
  end

  def run
    @log.info('Begin')
    tests = File.join(@dir, '*')
    subdirs = Dir.glob(tests).select {|f| File.directory? f}
    subdirs.each do |test_dir|
      dir_name = File.basename(test_dir)
      @log.info("Processing test directory: #{dir_name}")
      test_lang(test_dir, dir_name)
      test_synthesis(test_dir)
    end
  end

private

  def test_lang(test_dir, verif_name)
    verif_lang = NAME2LANG[verif_name]
    @log.info("#{verif_lang} test")

    if not @config.has_key?(verif_lang) or @config[verif_lang].empty?
      @log.warn("There are no #{verif_lang} compilers available")
    else
      @config[verif_lang].each do |tool_name|
        work_dir = File.join('.', 'build', @name, verif_name, tool_name)
        use_tool(tool_name, test_dir, work_dir)
      end 
    end

  end

  def test_synthesis(test_dir)

    if not @config.has_key?('Synthesis') or @config['Synthesis'].empty?
      @log.warn("No available synthesizers")
    else
      @config['Synthesis'].each do |tool_name|
        work_dir = File.join('.', 'build', @name, 'synth', tool_name)
        use_tool(tool_name, test_dir, work_dir)
      end 
    end

  end

  def use_tool(tool_name, test_dir, work_dir)
    @log.info("Use #{tool_name}")
    require_relative tool_path(tool_name)
    toolClass = HBBLib::Use.const_get(tool_name.capitalize)
    tool = toolClass.new(@log, test_dir, work_dir, @config)
    if not tool.build
      @log.error("Build FAILED")
      return false
    end
    tool.run
    @log.info("\n\n*** DONE WITH #{tool_name} ***\n")
  end

  def tool_path(name)
    File.join('use', name.downcase, name.capitalize)
  end
end # class Tester


class TestAll

  def initialize
    @config = YAML.load(File.read("configuration.yaml"))
    @log = Logger.new($stdout)
    @log.datetime_format = '%H:%M:%S'
    @log.level = Logger::DEBUG
  end

  def run(test_name = '*')
    tests = File.join(@config['source_path'], 'test', test_name)
    subdirs = Dir.glob(tests).select {|f| File.directory? f}
    subdirs.each do |test_dir|
      dir_name = File.basename(test_dir)
      @log.info("Processing test directory: #{dir_name}")
      tester = Tester.new(dir_name, @log, test_dir, @config)
      tester.run
    end
  end
end # class TestAll

module_function
def test_all()
  HBBLib::TestAll.new.run
end

module_function
def test_one(test_name)
  HBBLib::TestAll.new.run(test_name)
end

module_function
def trap_signal_INT(signo)
  Signal.trap(signo, "DEFAULT")
end

end # HBBLib


def run!

  # Register Ctrl-C handler
  Signal.trap("INT") do |signo|
    puts "Signal: #{Signal.signame(signo)} (Ctrl-C)"
    HBBLib.trap_signal_INT(signo)
  end

  result = false
  test_fun = lambda {HBBLib.test_all}

  if not ARGV.empty?
    puts "Test #{ARGV[0]}"
    test_fun = lambda {HBBLib.test_one(ARGV[0])}
  else
    puts "Run all tests..."
  end

  time_report = Benchmark.measure { result = test_fun.call }
  puts "Time: #{time_report}"

  return result
end

result = run!
exit(result ? 0:1)
