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
    @questa = @config['installed']['questa']

    if @questa == nil
      @log.error('No Questa tool provided in the configuration')
      return false
    end

    flist = YAML.load(File.open(File.join(@test_dir,'flist.yaml')))

    src_files = get_source_files(flist)

    questa_work_dir = File.join('.', 'work')

    vlog = @questa['vlog']
    vlib = @questa['vlib']
    vopt = @questa['vopt']

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

    params = "-64 -lint -pedanticerrors -work #{questa_work_dir}"
    params << " -l questa_vlog_compilation.log -outf options.txt"
    params << " #{src_files}"

    @log.info "Run #{vlog} #{params}"
    system("#{vlog} #{params}", {:chdir=>@work_dir})
    return false unless ( $? == 0 )

    params = "-64 -work #{questa_work_dir} -L #{questa_work_dir}"
    params << " -o dve_opt -pdu Dve +acc -l questa_vopt.log"

    if vopt == nil or vopt == ''
      @log.error('No Questa vopt provided')
      return false
    end

    @log.info "Run #{vopt} #{params}"
    system("#{vopt} #{params}", {:chdir=>@work_dir})
    return false unless ( $? == 0 )

    true
  end

  # Run simulation
  #
  public def run
    vsim = @questa['vsim']

    if vsim == nil or vsim == ''
      @log.error('No Questa vsim provided')
      return false
    end

    questa_work_dir = File.join('.', 'work')

    top = "dve_opt"

    this_dir = File.dirname(__FILE__)
    vsim_job = File.join(this_dir, 'vsim_job.tcl')


    params = "-64 -lib #{questa_work_dir} #{top} -l questa_sim.log"
    params += " -c -do #{vsim_job}"
    #params += " -dpioutoftheblue 1"
    #params += " -gblso #{test_dir}/libSmiStateAccess.so"
    #params += " -sv_lib #{@options.cosim_lib}/libsmrtlsim"
    #params += " +cosim_port=#{@options.rpc_port}"
    #params += process_additional_rtl_run_options

    #env = {"LM_LICENSE_FILE"=>"#{@options.licenses}",
    #       "LD_LIBRARY_PATH"=>"$LD_LIBRARY_PATH:/tools/local/thrift-0.9.0/lib:",
    #       "HOME"=>"/dev/null"}
    env = {
      'LM_LICENSE_FILE' => @questa['license'].gsub("\n",'')
    }
    #if @options.test_group == "dbg"
    #  env.store("DBGPORT", "socket.dbg")
    #end

    @log.info "Run #{env} #{vsim} #{params}"
    system(env, "#{vsim} #{params}", {:chdir=>@work_dir})
    return false unless ( $? == 0 )

    true
  end

private

  def get_source_files(flist)
    dut_sources =
      flist['dut'].
        collect {|path| File.join(@test_dir,path)}.
          join(' ')

    test_bench_sources =
      flist['test_bench'].
        collect {|path| File.join(@test_dir,path)}.
          join(' ')

    test_bench_sources + ' ' + dut_sources
  end

end # class Questa

end; end #HBBLib::Use

