RTL_SRC = ../rtl/

IF = ./apb_if.sv
RTL = ../rtl/traffic.sv
REFMOD = 
PKGS = ./my_pkg.sv 

SEED = 100
COVER = 100
TRANSA = 5000

RUN_ARGS_COMMON = -access +r -input shm.tcl \
          +uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite

sim:
	@xrun -64bit -uvm  +incdir+$(RTL_SRC) $(IF) $(PKGS) $(RTL) top.sv \
	+UVM_TESTNAME=reg_rw_test -covtest reg_rw_test-$(SEED) -svseed $(SEED)  \
	-defparam top.min_cover=$(COVER) -defparam top.min_transa=$(TRANSA) $(RUN_ARGS_COMMON) $(RUN_ARGS)


clean:
	@rm -rf INCA_libs waves.shm rtlsim/* *.history *.log rtlsim/* *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .simvision/ xcelium.d simv.daidir *.so *.o *.err

rebuild: clean sim

view_waves:
	simvision waves.shm &

view_cover:
	imc &