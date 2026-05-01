# GEMM Analytical Model - Equations

Auto-generated from PYTHON_FORMULAS and LATEX_SYMBOL_OVERRIDES in gemmanalytics.py.

Output order: execution

### row 22 - INPUT_A_BYTES_PER_ELEMENT

$$ \mathrm{Bytes_{/element}^{(A)}} = \mathrm{DataFormatToBytes}[\mathrm{Fmt^{(A)}}] $$

### row 23 - INPUT_B_BYTES_PER_ELEMENT

$$ \mathrm{Bytes_{/element}^{(B)}} = \mathrm{DataFormatToBytes}[\mathrm{Fmt^{(B)}}] $$

### row 25 - OUTPUT_BYTES_PER_ELEMENT_AFTER_DOWN_CONVERSION

$$ \mathrm{Bytes_{/element}^{(D\downarrow)}} = \mathrm{DataFormatToBytes}[\mathrm{Fmt^{(D)}}] $$

### row 33 - EU_COUNT

$$ \mathrm{|EU|} = \mathrm{|XeCore|_{/XeCU}} \times \mathrm{|EU|_{/XeCore}} \times \mathrm{|XeCU|} $$

### row 102 - TOTAL_L2_SIZE_B_FOR_A_SINGLE_INSTANCE

$$ \mathrm{|L2_Bytes|} = \mathrm{L2BankSize_{MB}} \times \mathrm{|L2Banks|_{/XeCU}} \times 1024 \times 1024 $$

### row 125 - MAX_POSSIBLE_HBM_BW_FREQ_B_CLK

$$ \mathrm{MemBW_{B/clk}^{max}} = \frac{\mathrm{MemBW_{GB/s}^{max}}}{\mathrm{f_{GT, GHz}}} $$

### row 36 - MMA_MAC_THROUGHPUT_PER_XECORE

$$ \mathrm{\tau_{MMA mac/clk/XeCore}^{(peak)}} = \min(\frac{4}{\frac{\operatorname{FLOOR}(\mathrm{Bytes_{/element}^{(A)}} \times 2, 1)}{2}}, \frac{4}{\frac{\operatorname{FLOOR}(\mathrm{Bytes_{/element}^{(B)}} \times 2, 1)}{2}}) \times \mathrm{D_{DPAS}} \times 16 \times \mathrm{|EU|_{/XeCore}} $$

### row 42 - CLKS_PER_DPAS

$$ \mathrm{CLKS_{DPAS}} = \frac{\mathrm{M_{/thread}} \times \mathrm{K_{/thread}} \times \mathrm{N_{/thread}}}{\frac{\mathrm{\tau_{MMA mac/clk/XeCore}^{(peak)}}}{\mathrm{|EU|_{/XeCore}}}} $$

### row 13 - WAVES

$$ \mathrm{N_waves} = \operatorname{CEILING}(\mathrm{|Tiles|_{N}^{(GPU)}}, 1) \times \operatorname{CEILING}(\mathrm{|Tiles|_{M}^{(GPU)}}, 1) $$

### row 14 - TG_TILES_IN_N

$$ \mathrm{|Tiles|_{N}^{(TG)}} = \frac{\mathrm{N_dim}}{\mathrm{W_{elements}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}}} $$

### row 15 - TG_TILES_IN_M

$$ \mathrm{|Tiles|_{M}^{(TG)}} = \frac{\mathrm{M_dim}}{\mathrm{H_{elements}^{(ThreadGroup)}}} $$

### row 16 - TG_CLUSTER_TILES_IN_N

$$ \mathrm{|Tiles|_{N}^{(TG\ Cluster)}} = \frac{\mathrm{N_dim}}{\mathrm{W_{elements}^{(XeCoreCluster)}}} $$

### row 17 - TG_CLUSTER_TILES_IN_M

$$ \mathrm{|Tiles|_{M}^{(TG\ Cluster)}} = \frac{\mathrm{M_dim}}{\mathrm{H_{elements}^{(XeCoreCluster)}}} $$

### row 18 - XECU_TILES_IN_N

$$ \mathrm{|Tiles|_{N}^{(XeCU)}} = \frac{\mathrm{N_dim}}{\mathrm{W_{elements}^{(XeCUTile)}}} $$

### row 19 - XECU_TILES_IN_M

$$ \mathrm{|Tiles|_{M}^{(XeCU)}} = \frac{\mathrm{M_dim}}{\mathrm{H_{elements}^{(XeCUTile)}}} $$

### row 20 - GPU_TILES_IN_N

$$ \mathrm{|Tiles|_{N}^{(GPU)}} = \frac{\frac{\mathrm{N_dim}}{\mathrm{W_{elements}^{(XeCUTile)}}}}{\mathrm{W_{XeCU}^{(GPUTile)}}} $$

### row 21 - GPU_TILES_IN_M

$$ \mathrm{|Tiles|_{M}^{(GPU)}} = \frac{\frac{\mathrm{M_dim}}{\mathrm{H_{elements}^{(XeCUTile)}}}}{\mathrm{H_{XeCU}^{(GPUTile)}}} $$

### row 43 - THREAD_WIDTH_IN_UNITS_OF_ELEMENTS

$$ \mathrm{W_{elements}^{(Thread)}} = \mathrm{N_{/thread}} $$

### row 44 - THREAD_HEIGHT_IN_UNITS_OF_ELEMENTS

$$ \mathrm{H_{elements}^{(Thread)}} = \mathrm{M_{/thread}} $$

### row 47 - TG_WIDTH_IN_UNITS_OF_ELEMENT_REALIZED_BY_MULTIPLE_MMA_ITERATIONS

$$ \mathrm{W_{elements}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} = \mathrm{W_{threads}^{(ThreadGroup)}} \times \mathrm{W_{elements}^{(Thread)}} $$

### row 48 - TG_HEIGHT_IN_UNITS_OF_ELEMENT

$$ \mathrm{H_{elements}^{(ThreadGroup)}} = \mathrm{H_{threads}^{(ThreadGroup)}} \times \mathrm{H_{elements}^{(Thread)}} $$

### row 52 - XECORE_CLUSTER_WIDTH_IN_UNITS_OF_ELEMENT

$$ \mathrm{W_{elements}^{(XeCoreCluster)}} = \mathrm{W_{TG,keep\ cluster\ size as 4}^{(XeCoreCluster)}} \times \mathrm{W_{elements}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} $$

### row 53 - XECORE_CLUSTER_HEIGHT_IN_UNITS_OF_ELEMENT

$$ \mathrm{H_{elements}^{(XeCoreCluster)}} = \mathrm{H_{TG,keep\ cluster\ size as 4}^{(XeCoreCluster)}} \times \mathrm{H_{elements}^{(ThreadGroup)}} $$

### row 56 - XECU_TILE_WIDTH_IN_UNITS_OF_ELEMENT

$$ \mathrm{W_{elements}^{(XeCUTile)}} = \mathrm{W_{TG}^{(XECUTile)}} \times \mathrm{W_{elements}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} $$

### row 57 - XECU_TILE_HEIGHT_IN_UNITS_OF_ELEMENT

$$ \mathrm{H_{elements}^{(XeCUTile)}} = \mathrm{H_{TG}^{(XECUTile)}} \times \mathrm{H_{elements}^{(ThreadGroup)}} $$

### row 59 - GPU_TILE_HEIGHT_IN_XECU_UINT

$$ \mathrm{H_{XeCU}^{(GPUTile)}} = \frac{\mathrm{|XeCU|}}{\mathrm{W_{XeCU}^{(GPUTile)}}} $$

### row 60 - GPU_TILE_WIDTH_IN_UNITS_OF_ELEMETNS

$$ \mathrm{W_{elements}^{(GPUTile)}} = \mathrm{W_{XeCU}^{(GPUTile)}} \times \mathrm{W_{elements}^{(XeCUTile)}} $$

### row 61 - GPU_TILE_HEIGHT_IN_UNITS_OF_ELEMETNS

$$ \mathrm{H_{elements}^{(GPUTile)}} = \mathrm{H_{XeCU}^{(GPUTile)}} \times \mathrm{H_{elements}^{(XeCUTile)}} $$

### row 63 - MAT_A_INPUT_SIZE_B

$$ \mathrm{Size_{B}^{(A)}} = \mathrm{M_dim} \times \mathrm{K_dim} \times \mathrm{Bytes_{/element}^{(A)}} $$

### row 64 - MAT_B_INPUT_SIZE_B

$$ \mathrm{Size_{B}^{(B)}} = \mathrm{K_dim} \times \mathrm{N_dim} \times \mathrm{Bytes_{/element}^{(B)}} $$

### row 65 - MAT_C_INPUT_D_OUTPUT_SIZE_B

$$ \mathrm{Size_{B}^{(C,D)}} = \mathrm{M_dim} \times \mathrm{N_dim} \times \mathrm{Bytes_{/element}^{(D\downarrow)}} $$

### row 66 - MAT_D_INTERMEDIATE_SIZE_B

$$ \mathrm{Size_{B}^{(D\downarrow)}} = \mathrm{M_dim} \times \mathrm{N_dim} \times \mathrm{Byte_{/element}^{(D)}} $$

### row 103 - WORKING_DATA_SET_SIZE_OF_K_IN_L2_CORRESP_20K_CLOCKS_OF_THREAD_DIVERGENCE

$$ \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}} = \min(20000 \times \frac{\mathrm{K_{/thread}}}{\mathrm{CLKS_{DPAS}}}, \mathrm{K_dim}) $$

### row 104 - TOTAL_REQUIRED_L2_SIZE_FOR_IDEAL_HIT_RATE_B_FOR_A_SINGLE_INSTANCE_AND_SINGLE_WAVE

$$ \mathrm{TotalRequiredL2Size_{MatB 100% hit}^{1 instance, 1 wave}} = \mathrm{H_{elements}^{(XeCUTile)}} \times \mathrm{Bytes_{/element}^{(A)}} \times \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}} + \mathrm{W_{elements}^{(XeCUTile)}} \times \mathrm{Bytes_{/element}^{(B)}} \times \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}} + \mathrm{W_{elements}^{(XeCUTile)}} \times \mathrm{H_{elements}^{(XeCUTile)}} \times \mathrm{Bytes_{/element}^{(D\downarrow)}} $$

### row 37 - CLK_SPECIFIED_EFFICIENCY

$$ \mathrm{T_{clk}^{(total)}} = \frac{\frac{\frac{\frac{\mathrm{M_dim} \times \mathrm{K_dim} \times \mathrm{N_dim}}{\mathrm{|XeCore|_{/XeCU}}}}{\mathrm{|XeCU|}}}{\mathrm{\tau_{MMA mac/clk/XeCore}^{(peak)}}}}{\mathrm{\eta_{systolic}}} $$

### row 69 - TOTAL_L2_READ_B

$$ \mathrm{L2Rd_{B}^{(total)}} = \mathrm{Size_{B}^{(A)}} \times \operatorname{CEILING}(\frac{\mathrm{N_dim}}{\mathrm{W_{elements}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}}}, 1) + \mathrm{Size_{B}^{(B)}} \times \operatorname{CEILING}(\frac{\mathrm{M_dim}}{\mathrm{H_{elements}^{(ThreadGroup)}}}, 1) $$

### row 70 - TOTAL_L2_WRITE_B

$$ \mathrm{L2Wr_{B}^{(total)}} = \mathrm{Size_{B}^{(C,D)}} $$

### row 71 - TOTAL_L1_READ_B

$$ \mathrm{L1Rd_{B}^{(total)}} = \mathrm{Size_{B}^{(A)}} \times \operatorname{CEILING}(\frac{\mathrm{N_dim}}{\mathrm{W_{elements}^{(Thread)}}}, 1) + \mathrm{Size_{B}^{(B)}} \times \operatorname{CEILING}(\frac{\mathrm{M_dim}}{\mathrm{H_{elements}^{(Thread)}}}, 1) $$

### row 72 - TOTAL_L1_WRITE_B

$$ \mathrm{L1Wr_{B}^{(total)}} = \mathrm{Size_{B}^{(C,D)}} $$

### row 74 - L2_READ_B_XECORE_CLK

$$ \mathrm{L2RdB_{/clk/XeCore}} = \frac{\frac{\mathrm{L2Rd_{B}^{(total)}}}{\mathrm{|XeCU|} \times \mathrm{|XeCore|_{/XeCU}}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 75 - L2_WRITE_B_XECORE_CLK

$$ \mathrm{L2WrB_{/clk/XeCore}} = \frac{\frac{\mathrm{L2Wr_{B}^{(total)}}}{\mathrm{|XeCU|} \times \mathrm{|XeCore|_{/XeCU}}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 76 - L2_READ_WRITE_B_XECORE_CLK

$$ \mathrm{L2RdWrB_{/clk/XeCore}} = \mathrm{L2RdB_{/clk/XeCore}} + \mathrm{L2WrB_{/clk/XeCore}} $$

### row 77 - L1_READ_B_XECORE_CLK

$$ \mathrm{L1RdB_{/clk/XeCore}} = \mathrm{L1RdB_{/clk/EU}} \times \mathrm{|EU|_{/XeCore}} $$

### row 78 - L1_WRITE_B_XECORECLK

$$ \mathrm{L1WrB_{/clk/XeCore}} = \mathrm{L1WrB_{/clk/EU}} \times \mathrm{|EU|_{/XeCore}} $$

### row 79 - L1_READ_B_EU_CLK

$$ \mathrm{L1RdB_{/clk/EU}} = \frac{\frac{\mathrm{L1Rd_{B}^{(total)}}}{\mathrm{|EU|}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 80 - L1_WRITE_B_EU_CLK

$$ \mathrm{L1WrB_{/clk/EU}} = \frac{\frac{\mathrm{L1Wr_{B}^{(total)}}}{\mathrm{|EU|}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 83 - L2_READ_MAX_B_XECORE_CLK

$$ \mathrm{L2RdB_{/clk/XeCore}^{(max)}} = \frac{\mathrm{|XeCore|_{/XeCU}} \times 64}{\mathrm{|XeCore|_{/XeCU}}} $$

### row 84 - L2_WRITE_MAX_B_XECORE_CLK

$$ \mathrm{L2WrB_{/clk/XeCore}^{(max)}} = \mathrm{L2RdB_{/clk/XeCore}^{(max)}} $$

### row 85 - L2_READ_WRITE_MAX_B_XECORE_CLK

$$ \mathrm{L2RdWrB_{/clk/XeCore}^{(max)}} = \mathrm{L2WrB_{/clk/XeCore}^{(max)}} $$

### row 90 - L2_READ_B_XECORE_CLK_PCT

$$ \mathrm{\eta_{L2RdB/clk/XeCore}} = \frac{\mathrm{L2RdB_{/clk/XeCore}}}{\mathrm{L2RdB_{/clk/XeCore}^{(max)}}} $$

### row 91 - L2_WRITE_B_XECORE_CLK_PCT

$$ \mathrm{\eta_{L2WrB/clk/XeCore}} = \frac{\mathrm{L2WrB_{/clk/XeCore}}}{\mathrm{L2WrB_{/clk/XeCore}^{(max)}}} $$

### row 92 - L2_READ_WRITE_B_XECORE_CLK_PCT

$$ \mathrm{\eta_{L2RdWrB/clk/XeCore}} = \frac{\mathrm{L2RdWrB_{/clk/XeCore}}}{\mathrm{L2RdWrB_{/clk/XeCore}^{(max)}}} $$

### row 93 - L1_READ_B_EU_CLK_PCT

$$ \mathrm{\eta_{L1RdB/clk/EU}} = \frac{\mathrm{L1RdB_{/clk/EU}}}{\mathrm{L1RdBW_{B/clk/EU}^{max}}} $$

### row 94 - L1_WRITE_B_EU_CLK_PCT

$$ \mathrm{\eta_{L1WrB/clk/EU}} = \frac{\mathrm{L1WrB_{/clk/EU}}}{\mathrm{L1WrBW_{B/clk/EU}^{max}}} $$

### row 106 - L2_HIT_RATE_ASSUMED_RANDOM_ACCESS_WITHIN_THE_WORKING_DATA_SET_PCT

$$ \mathrm{L2HitRate_{random\ WS\ access}} = \min(\frac{\mathrm{|L2_Bytes|}}{\mathrm{TotalRequiredL2Size_{MatB 100% hit}^{1 instance, 1 wave}}}, 1) $$

### row 107 - L2_MISS_RATE_PCT

$$ \mathrm{L2MissRate}} = 1 - \mathrm{L2HitRate_{random\ WS\ access}} $$

### row 108 - TOTAL_L2_READ_TRAFFIC_B

$$ \mathrm{L2RdB_{total}} = \mathrm{L2Rd_{B}^{(total)}} $$

### row 110 - PROBABILITY_OF_MATA_HIT_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{P_{L2Hit, after 1st wave}^{(A)}} = \operatorname{IF}(\mathrm{Size_{B}^{(A)}} + \mathrm{Size_{B}^{(B)}} + \mathrm{Size_{B}^{(C,D)}} \le \mathrm{|L2_Bytes|}, 1.0, \operatorname{IF}(\mathrm{K_dim} > 2 \times \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}}, 0.0, 1 - \frac{\mathrm{K_dim} - \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}}}{\mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}}})) $$

### row 111 - PROBABILITY_OF_MATB_HIT_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{P_{L2Hit, after 1st wave}^{(B)}} = \operatorname{IF}(\mathrm{Size_{B}^{(A)}} + \mathrm{Size_{B}^{(B)}} + \mathrm{Size_{B}^{(C,D)}} \le \mathrm{|L2_Bytes|}, 1.0, 0.0) $$

### row 112 - PROBABILITY_OF_MATA_MISS_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{P_{L2Miss, after 1st wave}^{(A)}} = 1 - \mathrm{P_{L2Hit, after 1st wave}^{(A)}} $$

### row 113 - PROBABILITY_OF_MATB_MISS_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{P_{L2Miss, after 1st wave}^{(B)}} = 1 - \mathrm{P_{L2Hit, after 1st wave}^{(B)}} $$

### row 116 - TOTAL_HBM_READ_B_AFTER_A_COMPLETION_OF_A_WAVE_CONSIDER_COLD_CACHE

$$ \mathrm{MemRdB_{cold start}^{(wave)}} = \frac{\mathrm{Size_{B}^{(A)}} + \mathrm{Size_{B}^{(A)}} \times \left(\operatorname{CEILING}(\frac{\mathrm{N_dim}}{\mathrm{W_{elements}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss, after 1st wave}^{(A)}} + \mathrm{Size_{B}^{(B)}} + \mathrm{Size_{B}^{(B)}} \times \left(\operatorname{CEILING}(\frac{\mathrm{M_dim}}{\mathrm{H_{elements}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss, after 1st wave}^{(B)}} + \left(\mathrm{L2RdB_{total}} - \left(\mathrm{Size_{B}^{(A)}} + \mathrm{Size_{B}^{(A)}} \times \left(\operatorname{CEILING}(\frac{\mathrm{N_dim}}{\mathrm{W_{elements}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss, after 1st wave}^{(A)}} + \mathrm{Size_{B}^{(B)}} + \mathrm{Size_{B}^{(B)}} \times \left(\operatorname{CEILING}(\frac{\mathrm{M_dim}}{\mathrm{H_{elements}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss, after 1st wave}^{(B)}}\right)\right) \times \mathrm{L2MissRate}}}{2} $$

### row 117 - TOTAL_HBM_WRITE_B

$$ \mathrm{MemWrB^{(total)}} = \mathrm{Size_{B}^{(C,D)}} $$

### row 118 - TOTAL_HBM_B

$$ \mathrm{MemRdWrB^{(total)}} = \mathrm{MemWrB^{(total)}} + \mathrm{MemRdB_{cold start}^{(wave)}} $$

### row 121 - HBM_READ_B_CLK

$$ \mathrm{MemRdB_{/clk}} = \frac{\mathrm{MemRdB_{cold start}^{(wave)}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 122 - HBM_WRITE_B_CLK

$$ \mathrm{MemWrB_{/clk}} = \frac{\mathrm{MemWrB^{(total)}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 123 - HBM_TOTAL_B_CLK

$$ \mathrm{MemRdWrB_{/clk}} = \frac{\mathrm{MemRdWrB^{(total)}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 126 - HBM_BW_PCT

$$ \mathrm{\eta_{MemBW}} = \frac{\mathrm{MemRdWrB_{/clk}}}{\mathrm{MemBW_{B/clk}^{max}}} $$

### row 127 - GTI_READ_BW_PCT

$$ \mathrm{\eta_{GTIRdBW}} = \frac{\mathrm{MemRdB_{/clk}}}{\mathrm{GtiRdBW_{B/clk}^{max}}} $$

### row 128 - GTI_WRITE_BW_PCT

$$ \mathrm{\eta_{GTIWrBW}} = \frac{\mathrm{MemWrB_{/clk}}}{\mathrm{GtiWrBW_{B/clk}^{max}}} $$
