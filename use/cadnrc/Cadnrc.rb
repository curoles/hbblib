# Synthesise Verilog code with Cadence RTL Compiuler.
#
# @author     Igor Lesik 2015
# @copyright  
#
#
module HBBLib; module Use

class Cadnrc

  def initialize(log, test_dir, work_dir, config)
    @log, @test_dir, @work_dir, @config = log, test_dir, work_dir, config
    @log.info("Cadence RTL Compiler, test: #{test_dir}, work place: #{@work_dir}")
    FileUtils.mkdir_p(@work_dir)
  end

  public def build
    true
  end

  public def run
    true
  end

private

end # class Cadnrc

end; end #HBBLib::Use

