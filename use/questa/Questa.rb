# Compile Verilog code with Questa and execute simulation.
#
# @author     Igor Lesik 2015
# @copyright  
#
#
module HBBLib; module Use

class Questa

  def initialize(log, test_dir, work_dir, config)
    @log, @test_dir, @work_dir, @config = log, test_dir, work_dir, config
    @log.info("Questa, test: #{test_dir}, work place: #{@work_dir}")
    FileUtils.mkdir_p(@work_dir)
  end

  public def build
    flist = YAML.load(File.open(File.join(@test_dir,'flist.yaml')))

    src_files = get_source_files(flist)

    questa_work_dir = File.join('.', 'work')

    vlog = @config['installed']['questa']['vlog']
    vlib = @config['installed']['questa']['vlib']

    if vlib == nil or vlib == ''
      @log.error('No Questa vlib provided')
      return false
    end

    params = questa_work_dir

    @log.info "Run #{vlib} #{params}"
    system("#{vlib} #{params}", {:chdir=>@work_dir})
    return false unless ( $? == 0 )

    if vlog == nil or vlog == ''
      @log.error('No Verilog compiler provided')
      return false
    end

    params = "-64 -lint -work #{questa_work_dir}"
    params << " -l questa_vlog_compilation.log"
    params << " #{src_files}"

    @log.info "Run #{vlog} #{params}"
    system("#{vlog} #{params}", {:chdir=>@work_dir})
    return false unless ( $? == 0 )

    true
  end

  public def simulate
    true
  end

private

  def get_source_files(flist)
    dut_sources =
      flist['dut'].
        collect {|path| File.join(@test_dir,path)}.
          join(' ')

    test_bench_sources = ''
    #  flist['verilator_test_bench'].
    #    collect {|path| File.join(@test_dir,path)}.
    #      join(' ')

    test_bench_sources + ' ' + dut_sources
  end

end # class Questa

end; end #HBBLib::Use

