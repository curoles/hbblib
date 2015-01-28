# Synthesise Verilog code with SMI PD synthesis tool.
#
# @author     Igor Lesik 2015
# @copyright  
#
require 'yaml'
require_relative '../../utils/which'

module HBBLib; module Use

class Smpdsyn

  def initialize(log, test_dir, work_dir, config)
    @log, @test_dir, @work_dir, @config = log, test_dir, work_dir, config
    @log.info("SM pd-runSyn RTL Compiler, test: #{test_dir}, work place: #{@work_dir}")
    FileUtils.mkdir_p(@work_dir)
  end

  public def build
    @smpdsyn = @config['installed']['smpdsyn']
    return false unless make_setup_tcl_file
    true
  end

  public def run
    synth = @smpdsyn['bin']

    if synth == nil or synth == ''
      @log.error('No pd-runSyn provided')
      return false
    end

    params = '-run init,generic,map'

    env = {}
    env['CAD']             = @smpdsyn['CAD']          unless ENV['CAD']
    env['SMI_PROJECT']     = @smpdsyn['SMI_PROJECT']  unless ENV['SMI_PROJECT']
    env['SMI_PROJECT_VER'] = 'unknown'                unless ENV['SMI_PROJECT_VER']
    env['SMI_TECH_DIR']    = @smpdsyn['SMI_TECH_DIR'] unless ENV['SMI_TECH_DIR']
    env['LM_LICENSE_FILE'] = @smpdsyn['license']      unless ENV['LM_LICENSE_FILE']

    unless which('rc')
      cadnrc_home = @config['installed']['cadnrc']['home']
      if cadnrc_home
        env['PATH'] = "#{ENV['PATH']}:#{cadnrc_home}/bin:"
      end
    end

    @log.info "Run #{synth} #{params}"
    system(env, "#{synth} #{params}", {:chdir=>@work_dir})
    return false unless ( $? == 0 )

    true
  end

private

  def make_setup_tcl_file
    flist = YAML.load(File.open(File.join(@test_dir,'flist.yaml')))

    synth_flist = File.join(@work_dir,'flist')

    make_synth_flist_file(flist, synth_flist)

    sdc_files = File.absolute_path(File.join(@test_dir,flist['synth_sdc'][0]))

    script = <<HERE
set DESIGN Synth
set vars(rtl_dir)   #{@test_dir}
set vars(rtl_flist) #{File.absolute_path(synth_flist)}
set vars(user_sdc_files) { #{sdc_files} }
set vars(def_files) {}
#set vars(rtl_overwrite)
#set vars(keep_constant_flops) "true"
HERE
    setup_tcl = File.join(@work_dir, 'setup.tcl')

    File.open(setup_tcl, 'w') {|file| file.write(script)}

    true
  end

  def  make_synth_flist_file(flist, synth_flist_file)
    synth_flist = get_source_files(flist)
    File.open(synth_flist_file, 'w') {|file| file.write(synth_flist)}
  end

  def get_source_files(flist, delim="\n")
    dut_sources =
      flist['dut'].
        collect {|path| File.join(@test_dir,path)}.
          join(delim)

    synth_test_sources = flist['synth'] ?
      flist['synth'].
        collect {|path| File.join(@test_dir,path)}.
          join(delim)
      : ''

    synth_test_sources + delim + dut_sources
  end

end # class Smpdsyn

end; end #HBBLib::Use

