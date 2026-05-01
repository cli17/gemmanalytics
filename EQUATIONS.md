# GEMM Analytical Model - Equations

Auto-generated from PYTHON_FORMULAS and LATEX_SYMBOL_OVERRIDES in gemmanalytics.py.

Output order: execution

### row 22 - INPUT_A_BYTES_PER_ELEMENT

$$ \mathrm{Bytes_{pElement}^{(matA)}} = \mathrm{DataFormatToBytes}[\mathrm{Fmt^{(matA)}}] $$

### row 23 - INPUT_B_BYTES_PER_ELEMENT

$$ \mathrm{Bytes_{pElement}^{(matB)}} = \mathrm{DataFormatToBytes}[\mathrm{Fmt^{(matB)}}] $$

### row 25 - OUTPUT_BYTES_PER_ELEMENT_AFTER_DOWN_CONVERSION

$$ \mathrm{Bytes_{pElement}^{(D\downarrow)}} = \mathrm{DataFormatToBytes}[\mathrm{Fmt^{(matD\downarrow)}}] $$

### row 33 - EU_COUNT

$$ \mathrm{|EU|} = \mathrm{|XeCore|_{pXeCU}} \times \mathrm{|EU|_{pXeCore}} \times \mathrm{|XeCU|} $$

### row 102 - TOTAL_L2_SIZE_B_FOR_A_SINGLE_INSTANCE

$$ \mathrm{|L2Bytes|} = \mathrm{L2BankSize_{MB}} \times \mathrm{|L2Banks|_{pXeCU}} \times 1024 \times 1024 $$

### row 125 - MAX_POSSIBLE_HBM_BW_FREQ_B_CLK

$$ \mathrm{MemBW_{BpClk}^{max}} = \frac{\mathrm{MemBW_{GBps}^{max}}}{\mathrm{f_{GHz}^{(GT)}}} $$

### row 36 - MMA_MAC_THROUGHPUT_PER_XECORE

$$ \mathrm{\tau_{mMACpClk{\cdot}XeCore}^{(peak)}} = \min(\frac{4}{\frac{\mathrm{FLOOR}(\mathrm{Bytes_{pElement}^{(matA)}} \times 2, 1)}{2}}, \frac{4}{\frac{\mathrm{FLOOR}(\mathrm{Bytes_{pElement}^{(matB)}} \times 2, 1)}{2}}) \times \mathrm{D_{DPAS}} \times 16 \times \mathrm{|EU|_{pXeCore}} $$

### row 42 - CLKS_PER_DPAS

$$ \mathrm{CLKS_{DPAS}} = \frac{\mathrm{M_{pThread}} \times \mathrm{K_{pThread}} \times \mathrm{N_{pThread}}}{\frac{\mathrm{\tau_{mMACpClk{\cdot}XeCore}^{(peak)}}}{\mathrm{|EU|_{pXeCore}}}} $$

### row 13 - WAVES

$$ \mathrm{N_waves} = \mathrm{CEILING}(\mathrm{|Tiles|_{N}^{(GPU)}}, 1) \times \mathrm{CEILING}(\mathrm{|Tiles|_{M}^{(GPU)}}, 1) $$

### row 14 - TG_TILES_IN_N

$$ \mathrm{|Tiles|_{N}^{(TG)}} = \frac{\mathrm{N_dim}}{\mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}}} $$

### row 15 - TG_TILES_IN_M

$$ \mathrm{|Tiles|_{M}^{(TG)}} = \frac{\mathrm{M_dim}}{\mathrm{H_{element}^{(ThreadGroup)}}} $$

### row 16 - TG_CLUSTER_TILES_IN_N

$$ \mathrm{|Tiles|_{N}^{(TG\ Cluster)}} = \frac{\mathrm{N_dim}}{\mathrm{W_{element}^{(XeCoreCluster)}}} $$

### row 17 - TG_CLUSTER_TILES_IN_M

$$ \mathrm{|Tiles|_{M}^{(TG\ Cluster)}} = \frac{\mathrm{M_dim}}{\mathrm{H_{element}^{(XeCoreCluster)}}} $$

### row 18 - XECU_TILES_IN_N

$$ \mathrm{|Tiles|_{N}^{(XeCU)}} = \frac{\mathrm{N_dim}}{\mathrm{W_{element}^{(XeCUTile)}}} $$

### row 19 - XECU_TILES_IN_M

$$ \mathrm{|Tiles|_{M}^{(XeCU)}} = \frac{\mathrm{M_dim}}{\mathrm{H_{element}^{(XeCUTile)}}} $$

### row 20 - GPU_TILES_IN_N

$$ \mathrm{|Tiles|_{N}^{(GPU)}} = \frac{\frac{\mathrm{N_dim}}{\mathrm{W_{element}^{(XeCUTile)}}}}{\mathrm{W_{XeCU}^{(GPUTile)}}} $$

### row 21 - GPU_TILES_IN_M

$$ \mathrm{|Tiles|_{M}^{(GPU)}} = \frac{\frac{\mathrm{M_dim}}{\mathrm{H_{element}^{(XeCUTile)}}}}{\mathrm{H_{XeCU}^{(GPUTile)}}} $$

### row 43 - THREAD_WIDTH_IN_UNITS_OF_ELEMENTS

$$ \mathrm{W_{element}^{(Thread)}} = \mathrm{N_{pThread}} $$

### row 44 - THREAD_HEIGHT_IN_UNITS_OF_ELEMENTS

$$ \mathrm{H_{element}^{(Thread)}} = \mathrm{M_{pThread}} $$

### row 47 - TG_WIDTH_IN_UNITS_OF_ELEMENT_REALIZED_BY_MULTIPLE_MMA_ITERATIONS

$$ \mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} = \mathrm{W_{thread}^{(ThreadGroup)}} \times \mathrm{W_{element}^{(Thread)}} $$

### row 48 - TG_HEIGHT_IN_UNITS_OF_ELEMENT

$$ \mathrm{H_{element}^{(ThreadGroup)}} = \mathrm{H_{thread}^{(ThreadGroup)}} \times \mathrm{H_{element}^{(Thread)}} $$

### row 52 - XECORE_CLUSTER_WIDTH_IN_UNITS_OF_ELEMENT

$$ \mathrm{W_{element}^{(XeCoreCluster)}} = \mathrm{W_{TG,keep\ cluster\ size as 4}^{(XeCoreCluster)}} \times \mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} $$

### row 53 - XECORE_CLUSTER_HEIGHT_IN_UNITS_OF_ELEMENT

$$ \mathrm{H_{element}^{(XeCoreCluster)}} = \mathrm{H_{TG,keep\ cluster\ size as 4}^{(XeCoreCluster)}} \times \mathrm{H_{element}^{(ThreadGroup)}} $$

### row 56 - XECU_TILE_WIDTH_IN_UNITS_OF_ELEMENT

$$ \mathrm{W_{element}^{(XeCUTile)}} = \mathrm{W_{TG}^{(XECUTile)}} \times \mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} $$

### row 57 - XECU_TILE_HEIGHT_IN_UNITS_OF_ELEMENT

$$ \mathrm{H_{element}^{(XeCUTile)}} = \mathrm{H_{TG}^{(XECUTile)}} \times \mathrm{H_{element}^{(ThreadGroup)}} $$

### row 59 - GPU_TILE_HEIGHT_IN_XECU_UINT

$$ \mathrm{H_{XeCU}^{(GPUTile)}} = \frac{\mathrm{|XeCU|}}{\mathrm{W_{XeCU}^{(GPUTile)}}} $$

### row 60 - GPU_TILE_WIDTH_IN_UNITS_OF_ELEMETNS

$$ \mathrm{W_{element}^{(GPUTile)}} = \mathrm{W_{XeCU}^{(GPUTile)}} \times \mathrm{W_{element}^{(XeCUTile)}} $$

### row 61 - GPU_TILE_HEIGHT_IN_UNITS_OF_ELEMETNS

$$ \mathrm{H_{element}^{(GPUTile)}} = \mathrm{H_{XeCU}^{(GPUTile)}} \times \mathrm{H_{element}^{(XeCUTile)}} $$

### row 63 - MAT_A_INPUT_SIZE_B

$$ \mathrm{Size_{B}^{(matA)}} = \mathrm{M_dim} \times \mathrm{K_dim} \times \mathrm{Bytes_{pElement}^{(matA)}} $$

### row 64 - MAT_B_INPUT_SIZE_B

$$ \mathrm{Size_{B}^{(matB)}} = \mathrm{K_dim} \times \mathrm{N_dim} \times \mathrm{Bytes_{pElement}^{(matB)}} $$

### row 65 - MAT_C_INPUT_D_OUTPUT_SIZE_B

$$ \mathrm{Size_{matB}^{(matC,matD)}} = \mathrm{M_dim} \times \mathrm{N_dim} \times \mathrm{Bytes_{pElement}^{(D\downarrow)}} $$

### row 66 - MAT_D_INTERMEDIATE_SIZE_B

$$ \mathrm{Size_{B}^{(matD\downarrow)}} = \mathrm{M_dim} \times \mathrm{N_dim} \times \mathrm{Byte_{pElement}^{(matD)}} $$

### row 103 - WORKING_DATA_SET_SIZE_OF_K_IN_L2_CORRESP_20K_CLOCKS_OF_THREAD_DIVERGENCE

$$ \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}} = \min(20000 \times \frac{\mathrm{K_{pThread}}}{\mathrm{CLKS_{DPAS}}}, \mathrm{K_dim}) $$

### row 104 - TOTAL_REQUIRED_L2_SIZE_FOR_IDEAL_HIT_RATE_B_FOR_A_SINGLE_INSTANCE_AND_SINGLE_WAVE

$$ \mathrm{TotalRequiredL2Size_{matB\ 100\%\ hit}^{1\ instance,\ 1\ wave}} = \mathrm{H_{element}^{(XeCUTile)}} \times \mathrm{Bytes_{pElement}^{(matA)}} \times \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}} + \mathrm{W_{element}^{(XeCUTile)}} \times \mathrm{Bytes_{pElement}^{(matB)}} \times \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}} + \mathrm{W_{element}^{(XeCUTile)}} \times \mathrm{H_{element}^{(XeCUTile)}} \times \mathrm{Bytes_{pElement}^{(D\downarrow)}} $$

### row 37 - CLK_SPECIFIED_EFFICIENCY

$$ \mathrm{T_{clk}^{(total)}} = \frac{\frac{\frac{\frac{\mathrm{M_dim} \times \mathrm{K_dim} \times \mathrm{N_dim}}{\mathrm{|XeCore|_{pXeCU}}}}{\mathrm{|XeCU|}}}{\mathrm{\tau_{mMACpClk{\cdot}XeCore}^{(peak)}}}}{\mathrm{\eta_{systolic}}} $$

### row 69 - TOTAL_L2_READ_B

$$ \mathrm{L2Rd_{B}^{(total)}} = \mathrm{Size_{B}^{(matA)}} \times \mathrm{CEILING}(\frac{\mathrm{N_dim}}{\mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}}}, 1) + \mathrm{Size_{B}^{(matB)}} \times \mathrm{CEILING}(\frac{\mathrm{M_dim}}{\mathrm{H_{element}^{(ThreadGroup)}}}, 1) $$

### row 70 - TOTAL_L2_WRITE_B

$$ \mathrm{L2Wr_{B}^{(total)}} = \mathrm{Size_{matB}^{(matC,matD)}} $$

### row 71 - TOTAL_L1_READ_B

$$ \mathrm{L1Rd_{B}^{(total)}} = \mathrm{Size_{B}^{(matA)}} \times \mathrm{CEILING}(\frac{\mathrm{N_dim}}{\mathrm{W_{element}^{(Thread)}}}, 1) + \mathrm{Size_{B}^{(matB)}} \times \mathrm{CEILING}(\frac{\mathrm{M_dim}}{\mathrm{H_{element}^{(Thread)}}}, 1) $$

### row 72 - TOTAL_L1_WRITE_B

$$ \mathrm{L1Wr_{B}^{(total)}} = \mathrm{Size_{matB}^{(matC,matD)}} $$

### row 74 - L2_READ_B_XECORE_CLK

$$ \mathrm{L2RdB_{p(Clk{\cdot}XeCore)}} = \frac{\frac{\mathrm{L2Rd_{B}^{(total)}}}{\mathrm{|XeCU|} \times \mathrm{|XeCore|_{pXeCU}}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 75 - L2_WRITE_B_XECORE_CLK

$$ \mathrm{L2WrB_{p(Clk{\cdot}XeCore)}} = \frac{\frac{\mathrm{L2Wr_{B}^{(total)}}}{\mathrm{|XeCU|} \times \mathrm{|XeCore|_{pXeCU}}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 76 - L2_READ_WRITE_B_XECORE_CLK

$$ \mathrm{L2RdWrB_{p(Clk{\cdot}XeCore)}} = \mathrm{L2RdB_{p(Clk{\cdot}XeCore)}} + \mathrm{L2WrB_{p(Clk{\cdot}XeCore)}} $$

### row 77 - L1_READ_B_XECORE_CLK

$$ \mathrm{L1RdB_{p(Clk{\cdot}XeCore)}} = \mathrm{L1RdB_{p(Clk{\cdot}EU)}} \times \mathrm{|EU|_{pXeCore}} $$

### row 78 - L1_WRITE_B_XECORECLK

$$ \mathrm{L1WrB_{p(Clk{\cdot}XeCore)}} = \mathrm{L1WrB_{p(Clk{\cdot}EU)}} \times \mathrm{|EU|_{pXeCore}} $$

### row 79 - L1_READ_B_EU_CLK

$$ \mathrm{L1RdB_{p(Clk{\cdot}EU)}} = \frac{\frac{\mathrm{L1Rd_{B}^{(total)}}}{\mathrm{|EU|}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 80 - L1_WRITE_B_EU_CLK

$$ \mathrm{L1WrB_{p(Clk{\cdot}EU)}} = \frac{\frac{\mathrm{L1Wr_{B}^{(total)}}}{\mathrm{|EU|}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 83 - L2_READ_MAX_B_XECORE_CLK

$$ \mathrm{L2RdB_{p(Clk{\cdot}XeCore)}^{(max)}} = \frac{\mathrm{|XeCore|_{pXeCU}} \times 64}{\mathrm{|XeCore|_{pXeCU}}} $$

### row 84 - L2_WRITE_MAX_B_XECORE_CLK

$$ \mathrm{L2WrB_{p(Clk{\cdot}XeCore)}^{(max)}} = \mathrm{L2RdB_{p(Clk{\cdot}XeCore)}^{(max)}} $$

### row 85 - L2_READ_WRITE_MAX_B_XECORE_CLK

$$ \mathrm{L2RdWrB_{p(Clk{\cdot}XeCore)}^{(max)}} = \mathrm{L2WrB_{p(Clk{\cdot}XeCore)}^{(max)}} $$

### row 90 - L2_READ_B_XECORE_CLK_PCT

$$ \mathrm{\eta_{L2RdB/p(Clk{\cdot}XeCore)}} = \frac{\mathrm{L2RdB_{p(Clk{\cdot}XeCore)}}}{\mathrm{L2RdB_{p(Clk{\cdot}XeCore)}^{(max)}}} $$

### row 91 - L2_WRITE_B_XECORE_CLK_PCT

$$ \mathrm{\eta_{L2WrB/p(Clk{\cdot}XeCore)}} = \frac{\mathrm{L2WrB_{p(Clk{\cdot}XeCore)}}}{\mathrm{L2WrB_{p(Clk{\cdot}XeCore)}^{(max)}}} $$

### row 92 - L2_READ_WRITE_B_XECORE_CLK_PCT

$$ \mathrm{\eta_{L2RdWrB/p(Clk{\cdot}XeCore)}} = \frac{\mathrm{L2RdWrB_{p(Clk{\cdot}XeCore)}}}{\mathrm{L2RdWrB_{p(Clk{\cdot}XeCore)}^{(max)}}} $$

### row 93 - L1_READ_B_EU_CLK_PCT

$$ \mathrm{\eta_{L1RdB/p(Clk{\cdot}EU)}} = \frac{\mathrm{L1RdB_{p(Clk{\cdot}EU)}}}{\mathrm{L1RdBW_{BpClk{\cdot}EU}^{max}}} $$

### row 94 - L1_WRITE_B_EU_CLK_PCT

$$ \mathrm{\eta_{L1WrB/p(Clk{\cdot}EU)}} = \frac{\mathrm{L1WrB_{p(Clk{\cdot}EU)}}}{\mathrm{L1WrBW_{BpClk{\cdot}EU}^{max}}} $$

### row 106 - L2_HIT_RATE_ASSUMED_RANDOM_ACCESS_WITHIN_THE_WORKING_DATA_SET_PCT

$$ \mathrm{L2HitRate_{random\ WS\ access}} = \min(\frac{\mathrm{|L2Bytes|}}{\mathrm{TotalRequiredL2Size_{matB\ 100\%\ hit}^{1\ instance,\ 1\ wave}}}, 1) $$

### row 107 - L2_MISS_RATE_PCT

$$ \mathrm{L2MissRate} = 1 - \mathrm{L2HitRate_{random\ WS\ access}} $$

### row 108 - TOTAL_L2_READ_TRAFFIC_B

$$ \mathrm{L2RdB_{total}} = \mathrm{L2Rd_{B}^{(total)}} $$

### row 110 - PROBABILITY_OF_MATA_HIT_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{P_{L2Hit, after 1st wave}^{(matA)}} = \mathrm{IF}(\mathrm{Size_{B}^{(matA)}} + \mathrm{Size_{B}^{(matB)}} + \mathrm{Size_{matB}^{(matC,matD)}} \le \mathrm{|L2Bytes|}, 1.0, \mathrm{IF}(\mathrm{K_dim} > 2 \times \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}}, 0.0, 1 - \frac{\mathrm{K_dim} - \mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}}}{\mathrm{|WorkingSet|_{20K clks of thread divergence}^{(K in L2)}}})) $$

### row 111 - PROBABILITY_OF_MATB_HIT_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{P_{L2Hit, after 1st wave}^{(matB)}} = \mathrm{IF}(\mathrm{Size_{B}^{(matA)}} + \mathrm{Size_{B}^{(matB)}} + \mathrm{Size_{matB}^{(matC,matD)}} \le \mathrm{|L2Bytes|}, 1.0, 0.0) $$

### row 112 - PROBABILITY_OF_MATA_MISS_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{P_{L2Miss, after 1st wave}^{(matA)}} = 1 - \mathrm{P_{L2Hit, after 1st wave}^{(matA)}} $$

### row 113 - PROBABILITY_OF_MATB_MISS_IN_L2_DURING_A_NON_FIRST_WAVE_PCT

$$ \mathrm{P_{L2Miss, after 1st wave}^{(matB)}} = 1 - \mathrm{P_{L2Hit, after 1st wave}^{(matB)}} $$

### row 116 - TOTAL_HBM_READ_B_AFTER_A_COMPLETION_OF_A_WAVE_CONSIDER_COLD_CACHE

$$ \mathrm{MemRdB_{cold start}^{(wave)}} = \frac{\mathrm{Size_{B}^{(matA)}} + \mathrm{Size_{B}^{(matA)}} \times \left(\mathrm{CEILING}(\frac{\mathrm{N_dim}}{\mathrm{W_{element}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss, after 1st wave}^{(matA)}} + \mathrm{Size_{B}^{(matB)}} + \mathrm{Size_{B}^{(matB)}} \times \left(\mathrm{CEILING}(\frac{\mathrm{M_dim}}{\mathrm{H_{element}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss, after 1st wave}^{(matB)}} + \left(\mathrm{L2RdB_{total}} - \left(\mathrm{Size_{B}^{(matA)}} + \mathrm{Size_{B}^{(matA)}} \times \left(\mathrm{CEILING}(\frac{\mathrm{N_dim}}{\mathrm{W_{element}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss, after 1st wave}^{(matA)}} + \mathrm{Size_{B}^{(matB)}} + \mathrm{Size_{B}^{(matB)}} \times \left(\mathrm{CEILING}(\frac{\mathrm{M_dim}}{\mathrm{H_{element}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss, after 1st wave}^{(matB)}}\right)\right) \times \mathrm{L2MissRate}}{2} $$

### row 117 - TOTAL_HBM_WRITE_B

$$ \mathrm{MemWrB^{(total)}} = \mathrm{Size_{matB}^{(matC,matD)}} $$

### row 118 - TOTAL_HBM_B

$$ \mathrm{MemRdWrB^{(total)}} = \mathrm{MemWrB^{(total)}} + \mathrm{MemRdB_{cold start}^{(wave)}} $$

### row 121 - HBM_READ_B_CLK

$$ \mathrm{MemRdB_{pClk}} = \frac{\mathrm{MemRdB_{cold start}^{(wave)}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 122 - HBM_WRITE_B_CLK

$$ \mathrm{MemWrB_{pClk}} = \frac{\mathrm{MemWrB^{(total)}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 123 - HBM_TOTAL_B_CLK

$$ \mathrm{MemRdWrB_{pClk}} = \frac{\mathrm{MemRdWrB^{(total)}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 126 - HBM_BW_PCT

$$ \mathrm{\eta_{MemBW}} = \frac{\mathrm{MemRdWrB_{pClk}}}{\mathrm{MemBW_{BpClk}^{max}}} $$

### row 127 - GTI_READ_BW_PCT

$$ \mathrm{\eta_{GTIRdBW}} = \frac{\mathrm{MemRdB_{pClk}}}{\mathrm{GtiRdBW_{BpClk}^{max}}} $$

### row 128 - GTI_WRITE_BW_PCT

$$ \mathrm{\eta_{GTIWrBW}} = \frac{\mathrm{MemWrB_{pClk}}}{\mathrm{GtiWrBW_{BpClk}^{max}}} $$
