# Compiler Verilog code with Verilator and execute simulation.
#
# @author     Igor Lesik 2014
# @copyright  2014
#

require 'yaml'
require 'fileutils'

module HBBLib; module Use

class Verilator

  def initialize(log, test_dir, work_dir, config)
    @log, @test_dir, @work_dir, @config = log, test_dir, work_dir, config
    @log.info("Verilator, test: #{test_dir}, work place: #{work_dir}")
    FileUtils.mkdir_p(@work_dir)
  end

  def build
    flist = YAML.load(File.open(File.join(@test_dir,'flist.yaml')))

    src_files = get_source_files(flist)
    test_bench_main = get_test_bench_main_exe(flist)

    vlog = @config['installed']['verilator']['vlog']

    params = "--assert -Wall -cc #{src_files} --exe #{test_bench_main} "
    params << " --stats" # --coverage"

    @log.info "Run #{vlog} #{params}"
    system("#{vlog} #{params}", {:chdir=>@work_dir})
    return false unless ( $? == 0 )

    obj_dir = File.join(@work_dir, 'obj_dir')
    system("make -f VDve.mk VDve", {:chdir=>obj_dir})
    return false unless ( $? == 0 )

    true
  end

  def simulate
    obj_dir = File.join(@work_dir, 'obj_dir')
    @log.info("Execute #{obj_dir}/VDve")
    system("./VDve", {:chdir=>obj_dir, [:out, :err]=>$stdout})
    return ( $? == 0 )
  end

private

  def get_source_files(flist)
    dut_sources =
      flist['dut'].
        collect {|path| File.join(@test_dir,path)}.
          join(' ')

    test_bench_sources =
      flist['verilator_test_bench'].
        collect {|path| File.join(@test_dir,path)}.
          join(' ')

    test_bench_sources + ' ' + dut_sources
  end

  def get_test_bench_main_exe(flist)
    test_bench_main = File.join(@test_dir, flist['verilator_main'])
  end
end

end; end #HBBLib::Use

