# GEMM Analytical Model - Mathematical Equations

\normalsize

This document extracts all mathematical formulas from `gemmanalytics.py`'s `compute_core_values()` function.

---

## Section 1: Machine Pre-Defined Parameters (Input)

These are hardware parameters loaded from `default_machine_params.csv`.

| Variable | Equation |
|----------|----------|
| ${GT\_FREQ\_GHZ}$ | Input parameter (GPU Frequency in GHz) |
| ${XECU\_COUNT}$ | Input parameter (XeCU count) |
| ${XECORE\_PER\_XECU}$ | Input parameter (XeCore per XeCU) |
| ${EU\_PER\_XECORE}$ | Input parameter (EU per XeCore) |
| ${L2\_BANKS\_PER\_XECU}$ | Input parameter (L2 banks per XeCU) |
| ${BANK\_CAPACITY\_MB}$ | Input parameter (Bank capacity in MB) |
| ${DPAS\_DEPTH}$ | Input parameter (DPAS pipeline depth) |
| ${COMPUTE\_EFFICIENCY\_PCT}$ | Input parameter (Compute efficiency percentage) |
| ${L1\_READ\_MAX\_B\_EU\_CLK}$ | Input parameter (L1 max read in B/EU/clk) |
| ${L1\_WRITE\_MAX\_B\_EU\_CLK}$ | Input parameter (L1 max write in B/EU/clk) |
| ${GTI\_READ\_MAX\_BW\_B\_CLK}$ | Input parameter (GTI read max BW in B/clk) |
| ${GTI\_WRITE\_MAX\_BW\_B\_CLK}$ | Input parameter (GTI write max BW in B/clk) |
| ${MAX\_POSSIBLE\_HBM\_BW\_GB\_S}$ | Input parameter (Max HBM BW in GB/s) |

---

## Section 2: Workload Pre-Defined Parameters (Input)

These are workload/algorithm parameters loaded from `default_workload_params.csv`.

| Variable | Equation |
|----------|----------|
| ${INPUT\_A\_DATA\_FORMAT}$ | Input parameter (e.g., 'fp8', 'fp4') |
| ${INPUT\_B\_DATA\_FORMAT}$ | Input parameter (e.g., 'fp8', 'fp4') |
| ${OUTPUT\_D\_DATA\_FORMAT}$ | Input parameter (e.g., 'fp8') |
| $M$ | Input parameter (Matrix M dimension) |
| $K$ | Input parameter (Matrix K dimension) |
| $N$ | Input parameter (Matrix N dimension) |
| ${OUTPUT\_BYTES\_PER\_ELEMENT\_FP32}$ | Input parameter |
| ${MACHINE\_OCCUPANCY\_PCT}$ | Input parameter (Machine occupancy percentage) |
| ${M\_PER\_THREAD}$ | Input parameter (M elements per thread) |
| ${K\_PER\_THREAD}$ | Input parameter (K elements per thread) |
| ${N\_PER\_THREAD}$ | Input parameter (N elements per thread) |
| ${TG\_WIDTH\_IN\_UNITS\_OF\_THREAD}$ | Input parameter (ThreadGroup width) |
| ${TG\_HEIGHT\_IN\_UNITS\_OF\_THREAD}$ | Input parameter (ThreadGroup height) |
| ${XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_TG}$ | Input parameter (Cluster width in TGs) |
| ${XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_TG}$ | Input parameter (Cluster height in TGs) |
| ${XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_TG}$ | Input parameter (XeCU tile width in TGs) |
| ${XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_TG}$ | Input parameter (XeCU tile height in TGs) |
| ${GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT}$ | Input parameter (GPU tile width in XeCU units) |

---

## Section 3: Derived Parameters

All computed from workload and machine parameters.

### Data Format Conversion

$${INPUT\_A\_BYTES\_PER\_ELEMENT} = {DATA\_FORMAT\_TO\_BYTES}[{INPUT\_A\_DATA\_FORMAT}]$$

$${INPUT\_B\_BYTES\_PER\_ELEMENT} = {DATA\_FORMAT\_TO\_BYTES}[{INPUT\_B\_DATA\_FORMAT}]$$

$${OUTPUT\_BYTES\_PER\_ELEMENT\_AFTER\_DOWN\_CONVERSION} = {DATA\_FORMAT\_TO\_BYTES}[{OUTPUT\_D\_DATA\_FORMAT}]$$

### Hardware Dimensions

$${EU\_COUNT} = {XECU\_COUNT} \times {XECORE\_PER\_XECU} \times {EU\_PER\_XECORE}$$

$${MMA\_MAC\_THROUGHPUT\_PER\_XECORE} = {DPAS\_DEPTH} \times {EU\_PER\_XECORE}$$

### Performance & Clock Calculations

$${CLK\_SPECIFIED\_EFFICIENCY} = \frac{M \times K \times N}{{XECORE\_PER\_XECU} \times {XECU\_COUNT} \times {MMA\_MAC\_THROUGHPUT\_PER\_XECORE} \times {COMPUTE\_EFFICIENCY\_PCT}}$$

$${CLKS\_PER\_DPAS} = \frac{{M\_PER\_THREAD} \times {K\_PER\_THREAD} \times {N\_PER\_THREAD}}{\frac{{MMA\_MAC\_THROUGHPUT\_PER\_XECORE}}{{EU\_PER\_XECORE}}}$$

### Thread & ThreadGroup Dimensions

$${THREAD\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS} = {N\_PER\_THREAD}$$

$${THREAD\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS} = {M\_PER\_THREAD}$$

$${TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS} = {TG\_WIDTH\_IN\_UNITS\_OF\_THREAD} \times {THREAD\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS}$$

$${TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} = {TG\_HEIGHT\_IN\_UNITS\_OF\_THREAD} \times {THREAD\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS}$$

### Tile Distribution

$${TG\_TILES\_IN\_N} = \frac{N}{{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS}}$$

$${TG\_TILES\_IN\_M} = \frac{M}{{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}}$$

$${XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} = {XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_TG} \times {TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS}$$

$${TG\_CLUSTER\_TILES\_IN\_N} = \frac{N}{{XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_ELEMENT}}$$

$${XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} = {XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_TG} \times {TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}$$

$${TG\_CLUSTER\_TILES\_IN\_M} = \frac{M}{{XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}}$$

$${XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} = {XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_TG} \times {TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS}$$

$${XECU\_TILES\_IN\_N} = \frac{N}{{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT}}$$

$${GPU\_TILES\_IN\_N} = \frac{N}{{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} \times {GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT}}$$

$${XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} = {XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_TG} \times {TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}$$

$${XECU\_TILES\_IN\_M} = \frac{M}{{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}}$$

$${GPU\_TILE\_HEIGHT\_IN\_XECU\_UINT} = \frac{{XECU\_COUNT}}{{GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT}}$$

$${GPU\_TILES\_IN\_M} = \frac{M}{{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} \times {GPU\_TILE\_HEIGHT\_IN\_XECU\_UINT}}$$

$$WAVES = \lceil {GPU\_TILES\_IN\_N} \rceil \times \lceil {GPU\_TILES\_IN\_M} \rceil$$

$${GPU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS} = {GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT} \times {XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT}$$

$${GPU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS} = {GPU\_TILE\_HEIGHT\_IN\_XECU\_UINT} \times {XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}$$

### Memory Sizes (Bytes)

$${MAT\_A\_INPUT\_SIZE\_B} = M \times K \times {INPUT\_A\_BYTES\_PER\_ELEMENT}$$

$${MAT\_B\_INPUT\_SIZE\_B} = K \times N \times {INPUT\_B\_BYTES\_PER\_ELEMENT}$$

$${MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B} = M \times N \times {OUTPUT\_BYTES\_PER\_ELEMENT\_AFTER\_DOWN\_CONVERSION}$$

$${MAT\_D\_INTERMEDIATE\_SIZE\_B} = M \times N \times {OUTPUT\_BYTES\_PER\_ELEMENT\_FP32}$$

---

## Section 4: Machine Stats

Performance metrics and bandwidth utilization.

### L2 Cache Statistics

$${TOTAL\_L2\_SIZE\_B\_FOR\_A\_SINGLE\_INSTANCE} = {BANK\_CAPACITY\_MB} \times {L2\_BANKS\_PER\_XECU} \times 1024 \times 1024$$

$${WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2} = \min\left(20000 \times \frac{{K\_PER\_THREAD}}{{CLKS\_PER\_DPAS}}, K\right)$$

$${TOTAL\_REQUIRED\_L2\_SIZE\_FOR\_IDEAL\_HIT\_RATE\_B} = \left({XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} \times {INPUT\_A\_BYTES\_PER\_ELEMENT} \times {WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2}\right) +$$
$$\left({XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} \times {INPUT\_B\_BYTES\_PER\_ELEMENT} \times {WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2}\right) +$$
$$\left({XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} \times {XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} \times {OUTPUT\_BYTES\_PER\_ELEMENT\_AFTER\_DOWN\_CONVERSION}\right)$$

### L2/L1 Read/Write Traffic

$${TOTAL\_L2\_READ\_B} = {MAT\_A\_INPUT\_SIZE\_B} \times \lceil\frac{N}{{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS}}\rceil + {MAT\_B\_INPUT\_SIZE\_B} \times \lceil\frac{M}{{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}}\rceil$$

$${TOTAL\_L2\_WRITE\_B} = {MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B}$$

$${TOTAL\_L1\_READ\_B} = {MAT\_A\_INPUT\_SIZE\_B} \times \lceil\frac{N}{{THREAD\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS}}\rceil + {MAT\_B\_INPUT\_SIZE\_B} \times \lceil\frac{M}{{THREAD\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS}}\rceil$$

$${TOTAL\_L1\_WRITE\_B} = {MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B}$$

### Per-Clock Bandwidth (B/clock)

$${L2\_READ\_B\_XECORE\_CLK} = \frac{{TOTAL\_L2\_READ\_B}}{{XECU\_COUNT} \times {XECORE\_PER\_XECU} \times {CLK\_SPECIFIED\_EFFICIENCY}}$$

$${L2\_WRITE\_B\_XECORE\_CLK} = \frac{{TOTAL\_L2\_WRITE\_B}}{{XECU\_COUNT} \times {XECORE\_PER\_XECU} \times {CLK\_SPECIFIED\_EFFICIENCY}}$$

$${L2\_READ\_WRITE\_B\_XECORE\_CLK} = {L2\_READ\_B\_XECORE\_CLK} + {L2\_WRITE\_B\_XECORE\_CLK}$$

$${L1\_READ\_B\_EU\_CLK} = \frac{{TOTAL\_L1\_READ\_B}}{{EU\_COUNT} \times {CLK\_SPECIFIED\_EFFICIENCY}}$$

$${L1\_READ\_B\_XECORE\_CLK} = {L1\_READ\_B\_EU\_CLK} \times {EU\_PER\_XECORE}$$

$${L1\_WRITE\_B\_EU\_CLK} = \frac{{TOTAL\_L1\_WRITE\_B}}{{EU\_COUNT} \times {CLK\_SPECIFIED\_EFFICIENCY}}$$

$${L1\_WRITE\_B\_XECORECLK} = {L1\_WRITE\_B\_EU\_CLK} \times {EU\_PER\_XECORE}$$

### Maximum Bandwidth (B/clock)

$${L2\_READ\_MAX\_B\_XECORE\_CLK} = \frac{{XECORE\_PER\_XECU} \times 64}{{XECORE\_PER\_XECU}} = 64$$

$${L2\_WRITE\_MAX\_B\_XECORE\_CLK} = {L2\_READ\_MAX\_B\_XECORE\_CLK}$$

$${L2\_READ\_WRITE\_MAX\_B\_XECORE\_CLK} = {L2\_WRITE\_MAX\_B\_XECORE\_CLK}$$

### Bandwidth Utilization (%)

$${L2\_READ\_B\_XECORE\_CLK\_PCT} = \frac{{L2\_READ\_B\_XECORE\_CLK}}{{L2\_READ\_MAX\_B\_XECORE\_CLK}}$$

$${L2\_WRITE\_B\_XECORE\_CLK\_PCT} = \frac{{L2\_WRITE\_B\_XECORE\_CLK}}{{L2\_WRITE\_MAX\_B\_XECORE\_CLK}}$$

$${L2\_READ\_WRITE\_B\_XECORE\_CLK\_PCT} = \frac{{L2\_READ\_WRITE\_B\_XECORE\_CLK}}{{L2\_READ\_WRITE\_MAX\_B\_XECORE\_CLK}}$$

$${L1\_READ\_B\_EU\_CLK\_PCT} = \frac{{L1\_READ\_B\_EU\_CLK}}{{L1\_READ\_MAX\_B\_EU\_CLK}}$$

$${L1\_WRITE\_B\_EU\_CLK\_PCT} = \frac{{L1\_WRITE\_B\_EU\_CLK}}{{L1\_WRITE\_MAX\_B\_EU\_CLK}}$$

### L2 Hit Rate & Miss Rate

$${L2\_HIT\_RATE\_PCT} = \min\left(\frac{{TOTAL\_L2\_SIZE\_B\_FOR\_A\_SINGLE\_INSTANCE}}{{TOTAL\_REQUIRED\_L2\_SIZE\_FOR\_IDEAL\_HIT\_RATE\_B}}, 1\right)$$

$${L2\_MISS\_RATE\_PCT} = 1 - {L2\_HIT\_RATE\_PCT}$$

### HBM (Main Memory) Traffic

$${TOTAL\_L2\_READ\_TRAFFIC\_B} = {TOTAL\_L2\_READ\_B}$$

$${TOTAL\_HBM\_READ\_B} = \text{(complex formula accounting for mat A/B miss probabilities)}$$

$${TOTAL\_HBM\_WRITE\_B} = {MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B}$$

$${TOTAL\_HBM\_B} = {TOTAL\_HBM\_READ\_B} + {TOTAL\_HBM\_WRITE\_B}$$

### HBM Bandwidth (B/clock and %)

$${MAX\_POSSIBLE\_HBM\_BW\_FREQ\_B\_CLK} = \frac{{MAX\_POSSIBLE\_HBM\_BW\_GB\_S}}{{GT\_FREQ\_GHZ}}$$

$${HBM\_READ\_B\_CLK} = \frac{{TOTAL\_HBM\_READ\_B}}{{CLK\_SPECIFIED\_EFFICIENCY}}$$

$${HBM\_WRITE\_B\_CLK} = \frac{{TOTAL\_HBM\_WRITE\_B}}{{CLK\_SPECIFIED\_EFFICIENCY}}$$

$${HBM\_TOTAL\_B\_CLK} = \frac{{TOTAL\_HBM\_B}}{{CLK\_SPECIFIED\_EFFICIENCY}}$$

$${HBM\_BW\_PCT} = \frac{{HBM\_TOTAL\_B\_CLK}}{{MAX\_POSSIBLE\_HBM\_BW\_FREQ\_B\_CLK}}$$

### GTI (GPU-to-Interconnect) Bandwidth (%)

$${GTI\_READ\_BW\_PCT} = \frac{{HBM\_READ\_B\_CLK}}{{GTI\_READ\_MAX\_BW\_B\_CLK}}$$

$${GTI\_WRITE\_BW\_PCT} = \frac{{HBM\_WRITE\_B\_CLK}}{{GTI\_WRITE\_MAX\_BW\_B\_CLK}}$$

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




