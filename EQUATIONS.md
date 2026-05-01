# GEMM Analytical Model - Equations

Auto-generated from PYTHON_FORMULAS and LATEX_SYMBOL_OVERRIDES in gemmanalytics.py.

Output order: execution

### row 22 - INPUT_A_BYTES_PER_ELEMENT

$$ \mathrm{INPUT\_A\_BYTES\_PER\_ELEMENT} = \mathrm{DATA\_FORMAT\_TO\_BYTES}[\mathrm{INPUT\_A\_DATA\_FORMAT}] $$

### row 23 - INPUT_B_BYTES_PER_ELEMENT

$$ \mathrm{INPUT\_B\_BYTES\_PER\_ELEMENT} = \mathrm{DATA\_FORMAT\_TO\_BYTES}[\mathrm{INPUT\_B\_DATA\_FORMAT}] $$

### row 25 - OUTPUT_BYTES_PER_ELEMENT_AFTER_DOWN_CONVERSION

$$ \mathrm{OUTPUT\_BYTES\_PER\_ELEMENT\_AFTER\_DOWN\_CONVERSION} = \mathrm{DATA\_FORMAT\_TO\_BYTES}[\mathrm{OUTPUT\_D\_DATA\_FORMAT}] $$

### row 33 - EU_COUNT

$$ \mathrm{EU\_COUNT} = \mathrm{XECORE\_PER\_XECU} \times \mathrm{EU\_PER\_XECORE} \times \mathrm{XECU\_COUNT} $$

### row 102 - TOTAL_L2_SIZE_B_FOR_A_SINGLE_INSTANCE

$$ \mathrm{TOTAL\_L2\_SIZE\_B\_FOR\_A\_SINGLE\_INSTANCE} = \mathrm{BANK\_CAPACITY\_MB} \times \mathrm{L2\_BANKS\_PER\_XECU} \times 1024 \times 1024 $$

### row 125 - MAX_POSSIBLE_HBM_BW_FREQ_B_CLK

$$ \mathrm{MAX\_POSSIBLE\_HBM\_BW\_FREQ\_B\_CLK} = \mathrm{MAX\_POSSIBLE\_HBM\_BW\_GB\_S}/\mathrm{GT\_FREQ\_GHZ} $$

### row 36 - MMA_MAC_THROUGHPUT_PER_XECORE

$$ \mathrm{MMA\_MAC\_THROUGHPUT\_PER\_XECORE} = \min(4/(\operatorname{FLOOR}(\mathrm{INPUT\_A\_BYTES\_PER\_ELEMENT} \times 2,1)/2),4/(\operatorname{FLOOR}(\mathrm{INPUT\_B\_BYTES\_PER\_ELEMENT} \times 2,1)/2)) \times \mathrm{DPAS\_DEPTH} \times 16 \times \mathrm{EU\_PER\_XECORE} $$

### row 42 - CLKS_PER_DPAS

$$ \mathrm{CLKS\_PER\_DPAS} = \mathrm{M\_PER\_THREAD} \times \mathrm{K\_PER\_THREAD} \times \mathrm{N\_PER\_THREAD}/(\mathrm{MMA\_MAC\_THROUGHPUT\_PER\_XECORE}/\mathrm{EU\_PER\_XECORE}) $$

### row 13 - WAVES

$$ \mathrm{WAVES} = \operatorname{CEILING}(\mathrm{GPU\_TILES\_IN\_N},1) \times \operatorname{CEILING}(\mathrm{GPU\_TILES\_IN\_M},1) $$

### row 14 - TG_TILES_IN_N

$$ \mathrm{TG\_TILES\_IN\_N} = \mathrm{N}/\mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS} $$

### row 15 - TG_TILES_IN_M

$$ \mathrm{TG\_TILES\_IN\_M} = \mathrm{M}/\mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} $$

### row 16 - TG_CLUSTER_TILES_IN_N

$$ \mathrm{TG\_CLUSTER\_TILES\_IN\_N} = \mathrm{N}/\mathrm{XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} $$

### row 17 - TG_CLUSTER_TILES_IN_M

$$ \mathrm{TG\_CLUSTER\_TILES\_IN\_M} = \mathrm{M}/\mathrm{XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} $$

### row 18 - XECU_TILES_IN_N

$$ \mathrm{XECU\_TILES\_IN\_N} = \mathrm{N}/\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} $$

### row 19 - XECU_TILES_IN_M

$$ \mathrm{XECU\_TILES\_IN\_M} = \mathrm{M}/\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} $$

### row 20 - GPU_TILES_IN_N

$$ \mathrm{GPU\_TILES\_IN\_N} = \mathrm{N}/\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT}/\mathrm{GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT} $$

### row 21 - GPU_TILES_IN_M

$$ \mathrm{GPU\_TILES\_IN\_M} = \mathrm{M}/\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}/\mathrm{GPU\_TILE\_HEIGHT\_IN\_XECU\_UINT} $$

### row 43 - THREAD_WIDTH_IN_UNITS_OF_ELEMENTS

$$ \mathrm{THREAD\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS} = \mathrm{N\_PER\_THREAD} $$

### row 44 - THREAD_HEIGHT_IN_UNITS_OF_ELEMENTS

$$ \mathrm{THREAD\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS} = \mathrm{M\_PER\_THREAD} $$

### row 47 - TG_WIDTH_IN_UNITS_OF_ELEMENT_REALIZED_BY_MULTIPLE_MMA_ITERATIONS

$$ \mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS} = \mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_THREAD} \times \mathrm{THREAD\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS} $$

### row 48 - TG_HEIGHT_IN_UNITS_OF_ELEMENT

$$ \mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_THREAD} \times \mathrm{THREAD\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS} $$

### row 52 - XECORE_CLUSTER_WIDTH_IN_UNITS_OF_ELEMENT

$$ \mathrm{XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_TG\_KEEP\_THE\_CLUSTER\_SIZE\_AS\_4} \times \mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS} $$

### row 53 - XECORE_CLUSTER_HEIGHT_IN_UNITS_OF_ELEMENT

$$ \mathrm{XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_TG\_KEEP\_THE\_CLUSTER\_SIZE\_AS\_4} \times \mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} $$

### row 56 - XECU_TILE_WIDTH_IN_UNITS_OF_ELEMENT

$$ \mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_TG} \times \mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS} $$

### row 57 - XECU_TILE_HEIGHT_IN_UNITS_OF_ELEMENT

$$ \mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_TG} \times \mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} $$

### row 59 - GPU_TILE_HEIGHT_IN_XECU_UINT

$$ \mathrm{GPU\_TILE\_HEIGHT\_IN\_XECU\_UINT} = \mathrm{XECU\_COUNT}/\mathrm{GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT} $$

### row 60 - GPU_TILE_WIDTH_IN_UNITS_OF_ELEMETNS

$$ \mathrm{GPU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMETNS} = \mathrm{GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT} \times \mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} $$

### row 61 - GPU_TILE_HEIGHT_IN_UNITS_OF_ELEMETNS

$$ \mathrm{GPU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMETNS} = \mathrm{GPU\_TILE\_HEIGHT\_IN\_XECU\_UINT} \times \mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} $$

### row 63 - MAT_A_INPUT_SIZE_B

$$ \mathrm{MAT\_A\_INPUT\_SIZE\_B} = \mathrm{M} \times \mathrm{K} \times \mathrm{INPUT\_A\_BYTES\_PER\_ELEMENT} $$

### row 64 - MAT_B_INPUT_SIZE_B

$$ \mathrm{MAT\_B\_INPUT\_SIZE\_B} = \mathrm{K} \times \mathrm{N} \times \mathrm{INPUT\_B\_BYTES\_PER\_ELEMENT} $$

### row 65 - MAT_C_INPUT_D_OUTPUT_SIZE_B

$$ \mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B} = \mathrm{M} \times \mathrm{N} \times \mathrm{OUTPUT\_BYTES\_PER\_ELEMENT\_AFTER\_DOWN\_CONVERSION} $$

### row 66 - MAT_D_INTERMEDIATE_SIZE_B

$$ \mathrm{MAT\_D\_INTERMEDIATE\_SIZE\_B} = \mathrm{M} \times \mathrm{N} \times \mathrm{OUTPUT\_BYTES\_PER\_ELEMENT\_FP32} $$

### row 103 - WORKING_DATA_SET_SIZE_OF_K_IN_L2_CORRESP_20K_CLOCKS_OF_THREAD_DIVERGENCE

$$ \mathrm{WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2\_CORRESP\_20K\_CLOCKS\_OF\_THREAD\_DIVERGENCE} = \min(20000 \times (\mathrm{K\_PER\_THREAD}/\mathrm{CLKS\_PER\_DPAS}),\mathrm{K}) $$

### row 104 - TOTAL_REQUIRED_L2_SIZE_FOR_IDEAL_HIT_RATE_B_FOR_A_SINGLE_INSTANCE_AND_SINGLE_WAVE

$$ \mathrm{TOTAL\_REQUIRED\_L2\_SIZE\_FOR\_IDEAL\_HIT\_RATE\_B\_FOR\_A\_SINGLE\_INSTANCE\_AND\_SINGLE\_WAVE} = (\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{INPUT\_A\_BYTES\_PER\_ELEMENT} \times \mathrm{WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2\_CORRESP\_20K\_CLOCKS\_OF\_THREAD\_DIVERGENCE})+(\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{INPUT\_B\_BYTES\_PER\_ELEMENT} \times \mathrm{WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2\_CORRESP\_20K\_CLOCKS\_OF\_THREAD\_DIVERGENCE})+(\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{OUTPUT\_BYTES\_PER\_ELEMENT\_AFTER\_DOWN\_CONVERSION}) $$

### row 37 - CLK_SPECIFIED_EFFICIENCY

$$ \mathrm{CLK\_SPECIFIED\_EFFICIENCY} = \mathrm{M} \times \mathrm{K} \times \mathrm{N}/\mathrm{XECORE\_PER\_XECU}/\mathrm{XECU\_COUNT}/\mathrm{MMA\_MAC\_THROUGHPUT\_PER\_XECORE}/\mathrm{COMPUTE\_EFFICIENCY\_PCT} $$

### row 69 - TOTAL_L2_READ_B

$$ \mathrm{TOTAL\_L2\_READ\_B} = (\mathrm{MAT\_A\_INPUT\_SIZE\_B} \times \operatorname{CEILING}(\mathrm{N}/\mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS},1)+\mathrm{MAT\_B\_INPUT\_SIZE\_B} \times \operatorname{CEILING}(\mathrm{M}/\mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT},1)) $$

### row 70 - TOTAL_L2_WRITE_B

$$ \mathrm{TOTAL\_L2\_WRITE\_B} = \mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B} $$

### row 71 - TOTAL_L1_READ_B

$$ \mathrm{TOTAL\_L1\_READ\_B} = (\mathrm{MAT\_A\_INPUT\_SIZE\_B} \times \operatorname{CEILING}(\mathrm{N}/\mathrm{THREAD\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS},1)+\mathrm{MAT\_B\_INPUT\_SIZE\_B} \times \operatorname{CEILING}(\mathrm{M}/\mathrm{THREAD\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS},1)) $$

### row 72 - TOTAL_L1_WRITE_B

$$ \mathrm{TOTAL\_L1\_WRITE\_B} = \mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B} $$

### row 74 - L2_READ_B_XECORE_CLK

$$ \mathrm{L2\_READ\_B\_XECORE\_CLK} = \mathrm{TOTAL\_L2\_READ\_B}/(\mathrm{XECU\_COUNT} \times \mathrm{XECORE\_PER\_XECU})/\mathrm{CLK\_SPECIFIED\_EFFICIENCY} $$

### row 75 - L2_WRITE_B_XECORE_CLK

$$ \mathrm{L2\_WRITE\_B\_XECORE\_CLK} = \mathrm{TOTAL\_L2\_WRITE\_B}/(\mathrm{XECU\_COUNT} \times \mathrm{XECORE\_PER\_XECU})/\mathrm{CLK\_SPECIFIED\_EFFICIENCY} $$

### row 76 - L2_READ_WRITE_B_XECORE_CLK

$$ \mathrm{L2\_READ\_WRITE\_B\_XECORE\_CLK} = \mathrm{L2\_READ\_B\_XECORE\_CLK}+\mathrm{L2\_WRITE\_B\_XECORE\_CLK} $$

### row 77 - L1_READ_B_XECORE_CLK

$$ \mathrm{L1\_READ\_B\_XECORE\_CLK} = \mathrm{L1\_READ\_B\_EU\_CLK} \times \mathrm{EU\_PER\_XECORE} $$

### row 78 - L1_WRITE_B_XECORECLK

$$ \mathrm{L1\_WRITE\_B\_XECORECLK} = \mathrm{L1\_WRITE\_B\_EU\_CLK} \times \mathrm{EU\_PER\_XECORE} $$

### row 79 - L1_READ_B_EU_CLK

$$ \mathrm{L1\_READ\_B\_EU\_CLK} = \mathrm{TOTAL\_L1\_READ\_B}/(\mathrm{EU\_COUNT})/\mathrm{CLK\_SPECIFIED\_EFFICIENCY} $$

### row 80 - L1_WRITE_B_EU_CLK

$$ \mathrm{L1\_WRITE\_B\_EU\_CLK} = \mathrm{TOTAL\_L1\_WRITE\_B}/(\mathrm{EU\_COUNT})/\mathrm{CLK\_SPECIFIED\_EFFICIENCY} $$

### row 83 - L2_READ_MAX_B_XECORE_CLK

$$ \mathrm{L2\_READ\_MAX\_B\_XECORE\_CLK} = \mathrm{XECORE\_PER\_XECU} \times 64/\mathrm{XECORE\_PER\_XECU} $$

### row 84 - L2_WRITE_MAX_B_XECORE_CLK

$$ \mathrm{L2\_WRITE\_MAX\_B\_XECORE\_CLK} = \mathrm{L2\_READ\_MAX\_B\_XECORE\_CLK} $$

### row 85 - L2_READ_WRITE_MAX_B_XECORE_CLK

$$ \mathrm{L2\_READ\_WRITE\_MAX\_B\_XECORE\_CLK} = \mathrm{L2\_WRITE\_MAX\_B\_XECORE\_CLK} $$

### row 90 - L2_READ_B_XECORE_CLK_PCT

$$ \mathrm{L2\_READ\_B\_XECORE\_CLK\_PCT} = \mathrm{L2\_READ\_B\_XECORE\_CLK}/\mathrm{L2\_READ\_MAX\_B\_XECORE\_CLK} $$

### row 91 - L2_WRITE_B_XECORE_CLK_PCT

$$ \mathrm{L2\_WRITE\_B\_XECORE\_CLK\_PCT} = \mathrm{L2\_WRITE\_B\_XECORE\_CLK}/\mathrm{L2\_WRITE\_MAX\_B\_XECORE\_CLK} $$

### row 92 - L2_READ_WRITE_B_XECORE_CLK_PCT

$$ \mathrm{L2\_READ\_WRITE\_B\_XECORE\_CLK\_PCT} = \mathrm{L2\_READ\_WRITE\_B\_XECORE\_CLK}/\mathrm{L2\_READ\_WRITE\_MAX\_B\_XECORE\_CLK} $$

### row 93 - L1_READ_B_EU_CLK_PCT

$$ \mathrm{L1\_READ\_B\_EU\_CLK\_PCT} = \mathrm{L1\_READ\_B\_EU\_CLK}/\mathrm{L1\_READ\_MAX\_B\_EU\_CLK} $$

### row 94 - L1_WRITE_B_EU_CLK_PCT

$$ \mathrm{L1\_WRITE\_B\_EU\_CLK\_PCT} = \mathrm{L1\_WRITE\_B\_EU\_CLK}/\mathrm{L1\_WRITE\_MAX\_B\_EU\_CLK} $$

### row 106 - L2_HIT_RATE_ASSUMED_RANDOM_ACCESS_WITHIN_THE_WORKING_DATA_SET_PCT

$$ \mathrm{L2\_HIT\_RATE\_ASSUMED\_RANDOM\_ACCESS\_WITHIN\_THE\_WORKING\_DATA\_SET\_PCT} = \min(\mathrm{TOTAL\_L2\_SIZE\_B\_FOR\_A\_SINGLE\_INSTANCE}/\mathrm{TOTAL\_REQUIRED\_L2\_SIZE\_FOR\_IDEAL\_HIT\_RATE\_B\_FOR\_A\_SINGLE\_INSTANCE\_AND\_SINGLE\_WAVE},1) $$

### row 107 - L2_MISS_RATE_PCT

$$ \mathrm{L2\_MISS\_RATE\_PCT} = 1-\mathrm{L2\_HIT\_RATE\_ASSUMED\_RANDOM\_ACCESS\_WITHIN\_THE\_WORKING\_DATA\_SET\_PCT} $$

### row 108 - TOTAL_L2_READ_TRAFFIC_B

$$ \mathrm{TOTAL\_L2\_READ\_TRAFFIC\_B} = \mathrm{TOTAL\_L2\_READ\_B} $$

### row 110 - PROBABILITY_OF_MATA_HIT_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{PROBABILITY\_OF\_MATA\_HIT\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT} = \operatorname{IF}(\mathrm{MAT\_A\_INPUT\_SIZE\_B}+\mathrm{MAT\_B\_INPUT\_SIZE\_B}+\mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B} <= \mathrm{TOTAL\_L2\_SIZE\_B\_FOR\_A\_SINGLE\_INSTANCE},1.0, \operatorname{IF}(\mathrm{K}>2 \times \mathrm{WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2\_CORRESP\_20K\_CLOCKS\_OF\_THREAD\_DIVERGENCE},0.0,1-(\mathrm{K}-\mathrm{WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2\_CORRESP\_20K\_CLOCKS\_OF\_THREAD\_DIVERGENCE})/\mathrm{WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2\_CORRESP\_20K\_CLOCKS\_OF\_THREAD\_DIVERGENCE})) $$

### row 111 - PROBABILITY_OF_MATB_HIT_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{PROBABILITY\_OF\_MATB\_HIT\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT} = \operatorname{IF}(\mathrm{MAT\_A\_INPUT\_SIZE\_B}+\mathrm{MAT\_B\_INPUT\_SIZE\_B}+\mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B} <= \mathrm{TOTAL\_L2\_SIZE\_B\_FOR\_A\_SINGLE\_INSTANCE},1.0, 0.0) $$

### row 112 - PROBABILITY_OF_MATA_MISS_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{PROBABILITY\_OF\_MATA\_MISS\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT} = 1-\mathrm{PROBABILITY\_OF\_MATA\_HIT\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT} $$

### row 113 - PROBABILITY_OF_MATB_MISS_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{PROBABILITY\_OF\_MATB\_MISS\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT} = 1-\mathrm{PROBABILITY\_OF\_MATB\_HIT\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT} $$

### row 116 - TOTAL_HBM_READ_B_AFTER_A_COMPLETION_OF_A_WAVE_CONSIDER_COLD_CACHE

$$ \mathrm{TOTAL\_HBM\_READ\_B\_AFTER\_A\_COMPLETION\_OF\_A\_WAVE\_CONSIDER\_COLD\_CACHE} = (\mathrm{MAT\_A\_INPUT\_SIZE\_B}+\mathrm{MAT\_A\_INPUT\_SIZE\_B} \times (\operatorname{CEILING}(\mathrm{N}/\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT},1)-1) \times \mathrm{PROBABILITY\_OF\_MATA\_MISS\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT}+\mathrm{MAT\_B\_INPUT\_SIZE\_B}+\mathrm{MAT\_B\_INPUT\_SIZE\_B} \times (\operatorname{CEILING}(\mathrm{M}/\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT},1)-1) \times \mathrm{PROBABILITY\_OF\_MATB\_MISS\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT}+(\mathrm{TOTAL\_L2\_READ\_TRAFFIC\_B}-(\mathrm{MAT\_A\_INPUT\_SIZE\_B}+\mathrm{MAT\_A\_INPUT\_SIZE\_B} \times (\operatorname{CEILING}(\mathrm{N}/\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT},1)-1) \times \mathrm{PROBABILITY\_OF\_MATA\_MISS\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT}+\mathrm{MAT\_B\_INPUT\_SIZE\_B}+\mathrm{MAT\_B\_INPUT\_SIZE\_B} \times (\operatorname{CEILING}(\mathrm{M}/\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT},1)-1) \times \mathrm{PROBABILITY\_OF\_MATB\_MISS\_IN\_L2\_DURING\_A\_NON\_FIRST\_WAVE\_PCT})) \times \mathrm{L2\_MISS\_RATE\_PCT})/2 $$

### row 117 - TOTAL_HBM_WRITE_B

$$ \mathrm{TOTAL\_HBM\_WRITE\_B} = \mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B} $$

### row 118 - TOTAL_HBM_B

$$ \mathrm{TOTAL\_HBM\_B} = \mathrm{TOTAL\_HBM\_WRITE\_B}+\mathrm{TOTAL\_HBM\_READ\_B\_AFTER\_A\_COMPLETION\_OF\_A\_WAVE\_CONSIDER\_COLD\_CACHE} $$

### row 121 - HBM_READ_B_CLK

$$ \mathrm{HBM\_READ\_B\_CLK} = \mathrm{TOTAL\_HBM\_READ\_B\_AFTER\_A\_COMPLETION\_OF\_A\_WAVE\_CONSIDER\_COLD\_CACHE}/\mathrm{CLK\_SPECIFIED\_EFFICIENCY} $$

### row 122 - HBM_WRITE_B_CLK

$$ \mathrm{HBM\_WRITE\_B\_CLK} = \mathrm{TOTAL\_HBM\_WRITE\_B}/\mathrm{CLK\_SPECIFIED\_EFFICIENCY} $$

### row 123 - HBM_TOTAL_B_CLK

$$ \mathrm{HBM\_TOTAL\_B\_CLK} = \mathrm{TOTAL\_HBM\_B}/\mathrm{CLK\_SPECIFIED\_EFFICIENCY} $$

### row 126 - HBM_BW_PCT

$$ \mathrm{HBM\_BW\_PCT} = \mathrm{HBM\_TOTAL\_B\_CLK}/\mathrm{MAX\_POSSIBLE\_HBM\_BW\_FREQ\_B\_CLK} $$

### row 127 - GTI_READ_BW_PCT

$$ \mathrm{GTI\_READ\_BW\_PCT} = \mathrm{HBM\_READ\_B\_CLK}/\mathrm{GTI\_READ\_MAX\_BW\_B\_CLK} $$

### row 128 - GTI_WRITE_BW_PCT

$$ \mathrm{GTI\_WRITE\_BW\_PCT} = \mathrm{HBM\_WRITE\_B\_CLK}/\mathrm{GTI\_WRITE\_MAX\_BW\_B\_CLK} $$
