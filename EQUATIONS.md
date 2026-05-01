# GEMM Analytical Model - Mathematical Equations

\normalsize

This document extracts all mathematical formulas from `gemmanalytics.py`'s `compute_core_values()` function.

---

## Section 1: Machine Pre-Defined Parameters (Input)

These are hardware parameters loaded from `default_machine_params.csv`.

| Variable | Equation |
|----------|----------|
| ${GT_FREQ_GHZ}$ | Input parameter (GPU Frequency in GHz) |
| ${XECU_COUNT}$ | Input parameter (XeCU count) |
| ${XECORE_PER_XECU}$ | Input parameter (XeCore per XeCU) |
| ${EU_PER_XECORE}$ | Input parameter (EU per XeCore) |
| ${L2_BANKS_PER_XECU}$ | Input parameter (L2 banks per XeCU) |
| ${BANK_CAPACITY_MB}$ | Input parameter (Bank capacity in MB) |
| ${DPAS_DEPTH}$ | Input parameter (DPAS pipeline depth) |
| ${COMPUTE_EFFICIENCY_PCT}$ | Input parameter (Compute efficiency percentage) |
| ${L1_READ_MAX_B_EU_CLK}$ | Input parameter (L1 max read in B/EU/clk) |
| ${L1_WRITE_MAX_B_EU_CLK}$ | Input parameter (L1 max write in B/EU/clk) |
| ${GTI_READ_MAX_BW_B_CLK}$ | Input parameter (GTI read max BW in B/clk) |
| ${GTI_WRITE_MAX_BW_B_CLK}$ | Input parameter (GTI write max BW in B/clk) |
| ${MAX_POSSIBLE_HBM_BW_GB_S}$ | Input parameter (Max HBM BW in GB/s) |

---

## Section 2: Workload Pre-Defined Parameters (Input)

These are workload/algorithm parameters loaded from `default_workload_params.csv`.

| Variable | Equation |
|----------|----------|
| ${INPUT_A_DATA_FORMAT}$ | Input parameter (e.g., 'fp8', 'fp4') |
| ${INPUT_B_DATA_FORMAT}$ | Input parameter (e.g., 'fp8', 'fp4') |
| ${OUTPUT_D_DATA_FORMAT}$ | Input parameter (e.g., 'fp8') |
| $M$ | Input parameter (Matrix M dimension) |
| $K$ | Input parameter (Matrix K dimension) |
| $N$ | Input parameter (Matrix N dimension) |
| ${OUTPUT_BYTES_PER_ELEMENT_FP32}$ | Input parameter |
| ${MACHINE_OCCUPANCY_PCT}$ | Input parameter (Machine occupancy percentage) |
| ${M_PER_THREAD}$ | Input parameter (M elements per thread) |
| ${K_PER_THREAD}$ | Input parameter (K elements per thread) |
| ${N_PER_THREAD}$ | Input parameter (N elements per thread) |
| ${TG_WIDTH_IN_UNITS_OF_THREAD}$ | Input parameter (ThreadGroup width) |
| ${TG_HEIGHT_IN_UNITS_OF_THREAD}$ | Input parameter (ThreadGroup height) |
| ${XECORE_CLUSTER_WIDTH_IN_UNITS_OF_TG}$ | Input parameter (Cluster width in TGs) |
| ${XECORE_CLUSTER_HEIGHT_IN_UNITS_OF_TG}$ | Input parameter (Cluster height in TGs) |
| ${XECU_TILE_WIDTH_IN_UNITS_OF_TG}$ | Input parameter (XeCU tile width in TGs) |
| ${XECU_TILE_HEIGHT_IN_UNITS_OF_TG}$ | Input parameter (XeCU tile height in TGs) |
| ${GPU_TILE_WIDTH_IN_XECU_UNIT}$ | Input parameter (GPU tile width in XeCU units) |

---

## Section 3: Derived Parameters

All computed from workload and machine parameters.

### Data Format Conversion

$${INPUT_A_BYTES_PER_ELEMENT} = {DATA_FORMAT_TO_BYTES}[{INPUT_A_DATA_FORMAT}]$$

$${INPUT_B_BYTES_PER_ELEMENT} = {DATA_FORMAT_TO_BYTES}[{INPUT_B_DATA_FORMAT}]$$

$${OUTPUT_BYTES_PER_ELEMENT_AFTER_DOWN_CONVERSION} = {DATA_FORMAT_TO_BYTES}[{OUTPUT_D_DATA_FORMAT}]$$

### Hardware Dimensions

$${EU_COUNT} = {XECU_COUNT} \times {XECORE_PER_XECU} \times {EU_PER_XECORE}$$

$${MMA_MAC_THROUGHPUT_PER_XECORE} = {DPAS_DEPTH} \times {EU_PER_XECORE}$$

### Performance & Clock Calculations

$${CLK_SPECIFIED_EFFICIENCY} = \frac{M \times K \times N}{{XECORE_PER_XECU} \times {XECU_COUNT} \times {MMA_MAC_THROUGHPUT_PER_XECORE} \times {COMPUTE_EFFICIENCY_PCT}}$$

$${CLKS_PER_DPAS} = \frac{{M_PER_THREAD} \times {K_PER_THREAD} \times {N_PER_THREAD}}{\frac{{MMA_MAC_THROUGHPUT_PER_XECORE}}{{EU_PER_XECORE}}}$$

### Thread & ThreadGroup Dimensions

$${THREAD_WIDTH_IN_UNITS_OF_ELEMENTS} = {N_PER_THREAD}$$

$${THREAD_HEIGHT_IN_UNITS_OF_ELEMENTS} = {M_PER_THREAD}$$

$${TG_WIDTH_IN_UNITS_OF_ELEMENT_REALIZED_BY_MULTIPLE_MMA_ITERATIONS} = {TG_WIDTH_IN_UNITS_OF_THREAD} \times {THREAD_WIDTH_IN_UNITS_OF_ELEMENTS}$$

$${TG_HEIGHT_IN_UNITS_OF_ELEMENT} = {TG_HEIGHT_IN_UNITS_OF_THREAD} \times {THREAD_HEIGHT_IN_UNITS_OF_ELEMENTS}$$

### Tile Distribution

$${TG_TILES_IN_N} = \frac{N}{{TG_WIDTH_IN_UNITS_OF_ELEMENT_REALIZED_BY_MULTIPLE_MMA_ITERATIONS}}$$

$${TG_TILES_IN_M} = \frac{M}{{TG_HEIGHT_IN_UNITS_OF_ELEMENT}}$$

$${XECORE_CLUSTER_WIDTH_IN_UNITS_OF_ELEMENT} = {XECORE_CLUSTER_WIDTH_IN_UNITS_OF_TG} \times {TG_WIDTH_IN_UNITS_OF_ELEMENT_REALIZED_BY_MULTIPLE_MMA_ITERATIONS}$$

$${TG_CLUSTER_TILES_IN_N} = \frac{N}{{XECORE_CLUSTER_WIDTH_IN_UNITS_OF_ELEMENT}}$$

$${XECORE_CLUSTER_HEIGHT_IN_UNITS_OF_ELEMENT} = {XECORE_CLUSTER_HEIGHT_IN_UNITS_OF_TG} \times {TG_HEIGHT_IN_UNITS_OF_ELEMENT}$$

$${TG_CLUSTER_TILES_IN_M} = \frac{M}{{XECORE_CLUSTER_HEIGHT_IN_UNITS_OF_ELEMENT}}$$

$${XECU_TILE_WIDTH_IN_UNITS_OF_ELEMENT} = {XECU_TILE_WIDTH_IN_UNITS_OF_TG} \times {TG_WIDTH_IN_UNITS_OF_ELEMENT_REALIZED_BY_MULTIPLE_MMA_ITERATIONS}$$

$${XECU_TILES_IN_N} = \frac{N}{{XECU_TILE_WIDTH_IN_UNITS_OF_ELEMENT}}$$

$${GPU_TILES_IN_N} = \frac{N}{{XECU_TILE_WIDTH_IN_UNITS_OF_ELEMENT} \times {GPU_TILE_WIDTH_IN_XECU_UNIT}}$$

$${XECU_TILE_HEIGHT_IN_UNITS_OF_ELEMENT} = {XECU_TILE_HEIGHT_IN_UNITS_OF_TG} \times {TG_HEIGHT_IN_UNITS_OF_ELEMENT}$$

$${XECU_TILES_IN_M} = \frac{M}{{XECU_TILE_HEIGHT_IN_UNITS_OF_ELEMENT}}$$

$${GPU_TILE_HEIGHT_IN_XECU_UINT} = \frac{{XECU_COUNT}}{{GPU_TILE_WIDTH_IN_XECU_UNIT}}$$

$${GPU_TILES_IN_M} = \frac{M}{{XECU_TILE_HEIGHT_IN_UNITS_OF_ELEMENT} \times {GPU_TILE_HEIGHT_IN_XECU_UINT}}$$

$$WAVES = \lceil {GPU_TILES_IN_N} \rceil \times \lceil {GPU_TILES_IN_M} \rceil$$

$${GPU_TILE_WIDTH_IN_UNITS_OF_ELEMENTS} = {GPU_TILE_WIDTH_IN_XECU_UNIT} \times {XECU_TILE_WIDTH_IN_UNITS_OF_ELEMENT}$$

$${GPU_TILE_HEIGHT_IN_UNITS_OF_ELEMENTS} = {GPU_TILE_HEIGHT_IN_XECU_UINT} \times {XECU_TILE_HEIGHT_IN_UNITS_OF_ELEMENT}$$

### Memory Sizes (Bytes)

$${MAT_A_INPUT_SIZE_B} = M \times K \times {INPUT_A_BYTES_PER_ELEMENT}$$

$${MAT_B_INPUT_SIZE_B} = K \times N \times {INPUT_B_BYTES_PER_ELEMENT}$$

$${MAT_C_INPUT_D_OUTPUT_SIZE_B} = M \times N \times {OUTPUT_BYTES_PER_ELEMENT_AFTER_DOWN_CONVERSION}$$

$${MAT_D_INTERMEDIATE_SIZE_B} = M \times N \times {OUTPUT_BYTES_PER_ELEMENT_FP32}$$

---

## Section 4: Machine Stats

Performance metrics and bandwidth utilization.

### L2 Cache Statistics

$${TOTAL_L2_SIZE_B_FOR_A_SINGLE_INSTANCE} = {BANK_CAPACITY_MB} \times {L2_BANKS_PER_XECU} \times 1024 \times 1024$$

$${WORKING_DATA_SET_SIZE_OF_K_IN_L2} = \min\left(20000 \times \frac{{K_PER_THREAD}}{{CLKS_PER_DPAS}}, K\right)$$

$${TOTAL_REQUIRED_L2_SIZE_FOR_IDEAL_HIT_RATE_B} = \left({XECU_TILE_HEIGHT_IN_UNITS_OF_ELEMENT} \times {INPUT_A_BYTES_PER_ELEMENT} \times {WORKING_DATA_SET_SIZE_OF_K_IN_L2}\right) +$$
$$\left({XECU_TILE_WIDTH_IN_UNITS_OF_ELEMENT} \times {INPUT_B_BYTES_PER_ELEMENT} \times {WORKING_DATA_SET_SIZE_OF_K_IN_L2}\right) +$$
$$\left({XECU_TILE_WIDTH_IN_UNITS_OF_ELEMENT} \times {XECU_TILE_HEIGHT_IN_UNITS_OF_ELEMENT} \times {OUTPUT_BYTES_PER_ELEMENT_AFTER_DOWN_CONVERSION}\right)$$

### L2/L1 Read/Write Traffic

$${TOTAL_L2_READ_B} = {MAT_A_INPUT_SIZE_B} \times \lceil\frac{N}{{TG_WIDTH_IN_UNITS_OF_ELEMENT_REALIZED_BY_MULTIPLE_MMA_ITERATIONS}}\rceil + {MAT_B_INPUT_SIZE_B} \times \lceil\frac{M}{{TG_HEIGHT_IN_UNITS_OF_ELEMENT}}\rceil$$

$${TOTAL_L2_WRITE_B} = {MAT_C_INPUT_D_OUTPUT_SIZE_B}$$

$${TOTAL_L1_READ_B} = {MAT_A_INPUT_SIZE_B} \times \lceil\frac{N}{{THREAD_WIDTH_IN_UNITS_OF_ELEMENTS}}\rceil + {MAT_B_INPUT_SIZE_B} \times \lceil\frac{M}{{THREAD_HEIGHT_IN_UNITS_OF_ELEMENTS}}\rceil$$

$${TOTAL_L1_WRITE_B} = {MAT_C_INPUT_D_OUTPUT_SIZE_B}$$

### Per-Clock Bandwidth (B/clock)

$${L2_READ_B_XECORE_CLK} = \frac{{TOTAL_L2_READ_B}}{{XECU_COUNT} \times {XECORE_PER_XECU} \times {CLK_SPECIFIED_EFFICIENCY}}$$

$${L2_WRITE_B_XECORE_CLK} = \frac{{TOTAL_L2_WRITE_B}}{{XECU_COUNT} \times {XECORE_PER_XECU} \times {CLK_SPECIFIED_EFFICIENCY}}$$

$${L2_READ_WRITE_B_XECORE_CLK} = {L2_READ_B_XECORE_CLK} + {L2_WRITE_B_XECORE_CLK}$$

$${L1_READ_B_EU_CLK} = \frac{{TOTAL_L1_READ_B}}{{EU_COUNT} \times {CLK_SPECIFIED_EFFICIENCY}}$$

$${L1_READ_B_XECORE_CLK} = {L1_READ_B_EU_CLK} \times {EU_PER_XECORE}$$

$${L1_WRITE_B_EU_CLK} = \frac{{TOTAL_L1_WRITE_B}}{{EU_COUNT} \times {CLK_SPECIFIED_EFFICIENCY}}$$

$${L1_WRITE_B_XECORECLK} = {L1_WRITE_B_EU_CLK} \times {EU_PER_XECORE}$$

### Maximum Bandwidth (B/clock)

$${L2_READ_MAX_B_XECORE_CLK} = \frac{{XECORE_PER_XECU} \times 64}{{XECORE_PER_XECU}} = 64$$

$${L2_WRITE_MAX_B_XECORE_CLK} = {L2_READ_MAX_B_XECORE_CLK}$$

$${L2_READ_WRITE_MAX_B_XECORE_CLK} = {L2_WRITE_MAX_B_XECORE_CLK}$$

### Bandwidth Utilization (%)

$${L2_READ_B_XECORE_CLK_PCT} = \frac{{L2_READ_B_XECORE_CLK}}{{L2_READ_MAX_B_XECORE_CLK}}$$

$${L2_WRITE_B_XECORE_CLK_PCT} = \frac{{L2_WRITE_B_XECORE_CLK}}{{L2_WRITE_MAX_B_XECORE_CLK}}$$

$${L2_READ_WRITE_B_XECORE_CLK_PCT} = \frac{{L2_READ_WRITE_B_XECORE_CLK}}{{L2_READ_WRITE_MAX_B_XECORE_CLK}}$$

$${L1_READ_B_EU_CLK_PCT} = \frac{{L1_READ_B_EU_CLK}}{{L1_READ_MAX_B_EU_CLK}}$$

$${L1_WRITE_B_EU_CLK_PCT} = \frac{{L1_WRITE_B_EU_CLK}}{{L1_WRITE_MAX_B_EU_CLK}}$$

### L2 Hit Rate & Miss Rate

$${L2_HIT_RATE_PCT} = \min\left(\frac{{TOTAL_L2_SIZE_B_FOR_A_SINGLE_INSTANCE}}{{TOTAL_REQUIRED_L2_SIZE_FOR_IDEAL_HIT_RATE_B}}, 1\right)$$

$${L2_MISS_RATE_PCT} = 1 - {L2_HIT_RATE_PCT}$$

### HBM (Main Memory) Traffic

$${TOTAL_L2_READ_TRAFFIC_B} = {TOTAL_L2_READ_B}$$

$${TOTAL_HBM_READ_B} = \text{(complex formula accounting for mat A/B miss probabilities)}$$

$${TOTAL_HBM_WRITE_B} = {MAT_C_INPUT_D_OUTPUT_SIZE_B}$$

$${TOTAL_HBM_B} = {TOTAL_HBM_READ_B} + {TOTAL_HBM_WRITE_B}$$

### HBM Bandwidth (B/clock and %)

$${MAX_POSSIBLE_HBM_BW_FREQ_B_CLK} = \frac{{MAX_POSSIBLE_HBM_BW_GB_S}}{{GT_FREQ_GHZ}}$$

$${HBM_READ_B_CLK} = \frac{{TOTAL_HBM_READ_B}}{{CLK_SPECIFIED_EFFICIENCY}}$$

$${HBM_WRITE_B_CLK} = \frac{{TOTAL_HBM_WRITE_B}}{{CLK_SPECIFIED_EFFICIENCY}}$$

$${HBM_TOTAL_B_CLK} = \frac{{TOTAL_HBM_B}}{{CLK_SPECIFIED_EFFICIENCY}}$$

$${HBM_BW_PCT} = \frac{{HBM_TOTAL_B_CLK}}{{MAX_POSSIBLE_HBM_BW_FREQ_B_CLK}}$$

### GTI (GPU-to-Interconnect) Bandwidth (%)

$${GTI_READ_BW_PCT} = \frac{{HBM_READ_B_CLK}}{{GTI_READ_MAX_BW_B_CLK}}$$

$${GTI_WRITE_BW_PCT} = \frac{{HBM_WRITE_B_CLK}}{{GTI_WRITE_MAX_BW_B_CLK}}$$

---

## Legend

- $\lceil \cdot \rceil$ = CEILING (round up)
- $\lfloor \cdot \rfloor$ = FLOOR (round down)
- B = Bytes
- clk = Clock cycle
- EU = Execution Unit
- XeCore = XE Core processor
- XeCU = XE Compute Unit
- L1 = Level 1 cache
- L2 = Level 2 cache
- HBM = High-Bandwidth Memory
- GTI = GPU-to-Interconnect
- BW = Bandwidth
- TG = ThreadGroup
- DPAS = Dot Product Accumulate Sparse
- MMA = Matrix Multiply Accumulate



