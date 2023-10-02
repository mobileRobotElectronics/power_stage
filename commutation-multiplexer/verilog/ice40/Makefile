## (C)2023 Will Green, open source hardware released under the MIT License

# configuration
SHELL = /bin/sh
FPGA_PKG = sg48
FPGA_TYPE = up5k
PCF = icebreaker.pcf

PROJ = commutation_multiplex

# included modules
# PATH_LIB = ../../lib
# ADD_SRC += ${PATH_LIB}/
# ADD_SRC += ${PATH_LIB}/

commutation_multiplex: commutation_multiplex.rpt commutation_multiplex.bin

%.json: top_%.sv $(ADD_SRC)
	yosys -ql $(basename $@)-yosys.log -p 'synth_ice40 -abc9 -device u -top top_$(basename $@) -json $@' $< $(ADD_SRC)

%.asc: %.json
	nextpnr-ice40 --${FPGA_TYPE} --package ${FPGA_PKG} --json $< --pcf ${PCF} --asc $@

%.rpt: %.asc
	icetime -d ${FPGA_TYPE} -mtr $@ $<

%.bin: %.asc
	icepack $< $(subst top_,,$@)

prog: $(PROJ).bin
	iceprog $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo iceprog $<	

all: commutation_multiplex

clean:
	rm -f *.json *.asc *.rpt *.bin *yosys.log

.PHONY: all clean