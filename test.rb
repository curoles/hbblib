# Build and run tests one-by-one.
#
# @author     Igor Lesik 2014
# @copyright  2014
#

require 'benchmark'
require 'yaml'

module HBBLib

class TestAll

  def initialize
    @config = YAML.load(File.read("configuration.yaml"))
  end

  def run
    puts @config
  end
end # class TestAll

module_function
def test_all()
  HBBLib::TestAll.new.run
end

module_function
def trap_signal_INT(signo)
  Signal.trap(signo, "DEFAULT")
end

end # HBBLib


def run!
  puts "Run all tests..."

  # Register Ctrl-C handler
  Signal.trap("INT") do |signo|
    puts "Signal: #{Signal.signame(signo)} (Ctrl-C)"
    HBBLib.trap_signal_INT(signo)
  end

  result = false

  time_report = Benchmark.measure { result = HBBLib.test_all }
  puts "Time: #{time_report}"

  return result
end

result = run!
exit(result ? 0:1)
