# GEMM Analytical Model - Mathematical Equations

\normalsize

This document extracts all mathematical formulas from `gemmanalytics.py`'s `compute_core_values()` function.

---

## Section 1: Machine Pre-Defined Parameters (Input)

These are hardware parameters loaded from `default_machine_params.csv`.

| Variable | Equation |
|----------|----------|
| $\mathrm{GT\_FREQ\_GHZ}$ | Input parameter (GPU Frequency in GHz) |
| $\mathrm{XECU\_COUNT}$ | Input parameter (XeCU count) |
| $\mathrm{XECORE\_PER\_XECU}$ | Input parameter (XeCore per XeCU) |
| $\mathrm{EU\_PER\_XECORE}$ | Input parameter (EU per XeCore) |
| $\mathrm{L2\_BANKS\_PER\_XECU}$ | Input parameter (L2 banks per XeCU) |
| $\mathrm{BANK\_CAPACITY\_MB}$ | Input parameter (Bank capacity in MB) |
| $\mathrm{DPAS\_DEPTH}$ | Input parameter (DPAS pipeline depth) |
| $\mathrm{COMPUTE\_EFFICIENCY\_PCT}$ | Input parameter (Compute efficiency percentage) |
| $\mathrm{L1\_READ\_MAX\_B\_EU\_CLK}$ | Input parameter (L1 max read in B/EU/clk) |
| $\mathrm{L1\_WRITE\_MAX\_B\_EU\_CLK}$ | Input parameter (L1 max write in B/EU/clk) |
| $\mathrm{GTI\_READ\_MAX\_BW\_B\_CLK}$ | Input parameter (GTI read max BW in B/clk) |
| $\mathrm{GTI\_WRITE\_MAX\_BW\_B\_CLK}$ | Input parameter (GTI write max BW in B/clk) |
| $\mathrm{MAX\_POSSIBLE\_HBM\_BW\_GB\_S}$ | Input parameter (Max HBM BW in GB/s) |

---

## Section 2: Workload Pre-Defined Parameters (Input)

These are workload/algorithm parameters loaded from `default_workload_params.csv`.

| Variable | Equation |
|----------|----------|
| $\mathrm{INPUT\_A\_DATA\_FORMAT}$ | Input parameter (e.g., 'fp8', 'fp4') |
| $\mathrm{INPUT\_B\_DATA\_FORMAT}$ | Input parameter (e.g., 'fp8', 'fp4') |
| $\mathrm{OUTPUT\_D\_DATA\_FORMAT}$ | Input parameter (e.g., 'fp8') |
| $M$ | Input parameter (Matrix M dimension) |
| $K$ | Input parameter (Matrix K dimension) |
| $N$ | Input parameter (Matrix N dimension) |
| $\mathrm{OUTPUT\_BYTES\_PER\_ELEMENT\_FP32}$ | Input parameter |
| $\mathrm{MACHINE\_OCCUPANCY\_PCT}$ | Input parameter (Machine occupancy percentage) |
| $\mathrm{M\_PER\_THREAD}$ | Input parameter (M elements per thread) |
| $\mathrm{K\_PER\_THREAD}$ | Input parameter (K elements per thread) |
| $\mathrm{N\_PER\_THREAD}$ | Input parameter (N elements per thread) |
| $\mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_THREAD}$ | Input parameter (ThreadGroup width) |
| $\mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_THREAD}$ | Input parameter (ThreadGroup height) |
| $\mathrm{XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_TG}$ | Input parameter (Cluster width in TGs) |
| $\mathrm{XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_TG}$ | Input parameter (Cluster height in TGs) |
| $\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_TG}$ | Input parameter (XeCU tile width in TGs) |
| $\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_TG}$ | Input parameter (XeCU tile height in TGs) |
| $\mathrm{GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT}$ | Input parameter (GPU tile width in XeCU units) |

---

## Section 3: Derived Parameters

All computed from workload and machine parameters.

### Data Format Conversion

$$\mathrm{INPUT\_A\_BYTES\_PER\_ELEMENT} = \mathrm{DATA\_FORMAT\_TO\_BYTES}[\mathrm{INPUT\_A\_DATA\_FORMAT}]$$

$$\mathrm{INPUT\_B\_BYTES\_PER\_ELEMENT} = \mathrm{DATA\_FORMAT\_TO\_BYTES}[\mathrm{INPUT\_B\_DATA\_FORMAT}]$$

$$\mathrm{OUTPUT\_BYTES\_PER\_ELEMENT\_AFTER\_DOWN\_CONVERSION} = \mathrm{DATA\_FORMAT\_TO\_BYTES}[\mathrm{OUTPUT\_D\_DATA\_FORMAT}]$$

### Hardware Dimensions

$$\mathrm{EU\_COUNT} = \mathrm{XECU\_COUNT} \times \mathrm{XECORE\_PER\_XECU} \times \mathrm{EU\_PER\_XECORE}$$

$$\mathrm{MMA\_MAC\_THROUGHPUT\_PER\_XECORE} = \mathrm{DPAS\_DEPTH} \times \mathrm{EU\_PER\_XECORE}$$

### Performance & Clock Calculations

$$\mathrm{CLK\_SPECIFIED\_EFFICIENCY} = \frac{M \times K \times N}{\mathrm{XECORE\_PER\_XECU} \times \mathrm{XECU\_COUNT} \times \mathrm{MMA\_MAC\_THROUGHPUT\_PER\_XECORE} \times \mathrm{COMPUTE\_EFFICIENCY\_PCT}}$$

$$\mathrm{CLKS\_PER\_DPAS} = \frac{\mathrm{M\_PER\_THREAD} \times \mathrm{K\_PER\_THREAD} \times \mathrm{N\_PER\_THREAD}}{\frac{\mathrm{MMA\_MAC\_THROUGHPUT\_PER\_XECORE}}{\mathrm{EU\_PER\_XECORE}}}$$

### Thread & ThreadGroup Dimensions

$$\mathrm{THREAD\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS} = \mathrm{N\_PER\_THREAD}$$

$$\mathrm{THREAD\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS} = \mathrm{M\_PER\_THREAD}$$

$$\mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS} = \mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_THREAD} \times \mathrm{THREAD\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS}$$

$$\mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_THREAD} \times \mathrm{THREAD\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS}$$

### Tile Distribution

$$\mathrm{TG\_TILES\_IN\_N} = \frac{N}{\mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS}}$$

$$\mathrm{TG\_TILES\_IN\_M} = \frac{M}{\mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}}$$

$$\mathrm{XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_TG} \times \mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS}$$

$$\mathrm{TG\_CLUSTER\_TILES\_IN\_N} = \frac{N}{\mathrm{XECORE\_CLUSTER\_WIDTH\_IN\_UNITS\_OF\_ELEMENT}}$$

$$\mathrm{XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_TG} \times \mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}$$

$$\mathrm{TG\_CLUSTER\_TILES\_IN\_M} = \frac{M}{\mathrm{XECORE\_CLUSTER\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}}$$

$$\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_TG} \times \mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS}$$

$$\mathrm{XECU\_TILES\_IN\_N} = \frac{N}{\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT}}$$

$$\mathrm{GPU\_TILES\_IN\_N} = \frac{N}{\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT}}$$

$$\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} = \mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_TG} \times \mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}$$

$$\mathrm{XECU\_TILES\_IN\_M} = \frac{M}{\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}}$$

$$\mathrm{GPU\_TILE\_HEIGHT\_IN\_XECU\_UINT} = \frac{\mathrm{XECU\_COUNT}}{\mathrm{GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT}}$$

$$\mathrm{GPU\_TILES\_IN\_M} = \frac{M}{\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{GPU\_TILE\_HEIGHT\_IN\_XECU\_UINT}}$$

$$WAVES = \lceil \mathrm{GPU\_TILES\_IN\_N} \rceil \times \lceil \mathrm{GPU\_TILES\_IN\_M} \rceil$$

$$\mathrm{GPU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS} = \mathrm{GPU\_TILE\_WIDTH\_IN\_XECU\_UNIT} \times \mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT}$$

$$\mathrm{GPU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS} = \mathrm{GPU\_TILE\_HEIGHT\_IN\_XECU\_UINT} \times \mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}$$

### Memory Sizes (Bytes)

$$\mathrm{MAT\_A\_INPUT\_SIZE\_B} = M \times K \times \mathrm{INPUT\_A\_BYTES\_PER\_ELEMENT}$$

$$\mathrm{MAT\_B\_INPUT\_SIZE\_B} = K \times N \times \mathrm{INPUT\_B\_BYTES\_PER\_ELEMENT}$$

$$\mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B} = M \times N \times \mathrm{OUTPUT\_BYTES\_PER\_ELEMENT\_AFTER\_DOWN\_CONVERSION}$$

$$\mathrm{MAT\_D\_INTERMEDIATE\_SIZE\_B} = M \times N \times \mathrm{OUTPUT\_BYTES\_PER\_ELEMENT\_FP32}$$

---

## Section 4: Machine Stats

Performance metrics and bandwidth utilization.

### L2 Cache Statistics

$$\mathrm{TOTAL\_L2\_SIZE\_B\_FOR\_A\_SINGLE\_INSTANCE} = \mathrm{BANK\_CAPACITY\_MB} \times \mathrm{L2\_BANKS\_PER\_XECU} \times 1024 \times 1024$$

$$\mathrm{WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2} = \min\left(20000 \times \frac{\mathrm{K\_PER\_THREAD}}{\mathrm{CLKS\_PER\_DPAS}}, K\right)$$

$$\mathrm{TOTAL\_REQUIRED\_L2\_SIZE\_FOR\_IDEAL\_HIT\_RATE\_B} = \left(\mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{INPUT\_A\_BYTES\_PER\_ELEMENT} \times \mathrm{WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2}\right) +$$
$$\left(\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{INPUT\_B\_BYTES\_PER\_ELEMENT} \times \mathrm{WORKING\_DATA\_SET\_SIZE\_OF\_K\_IN\_L2}\right) +$$
$$\left(\mathrm{XECU\_TILE\_WIDTH\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{XECU\_TILE\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT} \times \mathrm{OUTPUT\_BYTES\_PER\_ELEMENT\_AFTER\_DOWN\_CONVERSION}\right)$$

### L2/L1 Read/Write Traffic

$$\mathrm{TOTAL\_L2\_READ\_B} = \mathrm{MAT\_A\_INPUT\_SIZE\_B} \times \lceil\frac{N}{\mathrm{TG\_WIDTH\_IN\_UNITS\_OF\_ELEMENT\_REALIZED\_BY\_MULTIPLE\_MMA\_ITERATIONS}}\rceil + \mathrm{MAT\_B\_INPUT\_SIZE\_B} \times \lceil\frac{M}{\mathrm{TG\_HEIGHT\_IN\_UNITS\_OF\_ELEMENT}}\rceil$$

$$\mathrm{TOTAL\_L2\_WRITE\_B} = \mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B}$$

$$\mathrm{TOTAL\_L1\_READ\_B} = \mathrm{MAT\_A\_INPUT\_SIZE\_B} \times \lceil\frac{N}{\mathrm{THREAD\_WIDTH\_IN\_UNITS\_OF\_ELEMENTS}}\rceil + \mathrm{MAT\_B\_INPUT\_SIZE\_B} \times \lceil\frac{M}{\mathrm{THREAD\_HEIGHT\_IN\_UNITS\_OF\_ELEMENTS}}\rceil$$

$$\mathrm{TOTAL\_L1\_WRITE\_B} = \mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B}$$

### Per-Clock Bandwidth (B/clock)

$$\mathrm{L2\_READ\_B\_XECORE\_CLK} = \frac{\mathrm{TOTAL\_L2\_READ\_B}}{\mathrm{XECU\_COUNT} \times \mathrm{XECORE\_PER\_XECU} \times \mathrm{CLK\_SPECIFIED\_EFFICIENCY}}$$

$$\mathrm{L2\_WRITE\_B\_XECORE\_CLK} = \frac{\mathrm{TOTAL\_L2\_WRITE\_B}}{\mathrm{XECU\_COUNT} \times \mathrm{XECORE\_PER\_XECU} \times \mathrm{CLK\_SPECIFIED\_EFFICIENCY}}$$

$$\mathrm{L2\_READ\_WRITE\_B\_XECORE\_CLK} = \mathrm{L2\_READ\_B\_XECORE\_CLK} + \mathrm{L2\_WRITE\_B\_XECORE\_CLK}$$

$$\mathrm{L1\_READ\_B\_EU\_CLK} = \frac{\mathrm{TOTAL\_L1\_READ\_B}}{\mathrm{EU\_COUNT} \times \mathrm{CLK\_SPECIFIED\_EFFICIENCY}}$$

$$\mathrm{L1\_READ\_B\_XECORE\_CLK} = \mathrm{L1\_READ\_B\_EU\_CLK} \times \mathrm{EU\_PER\_XECORE}$$

$$\mathrm{L1\_WRITE\_B\_EU\_CLK} = \frac{\mathrm{TOTAL\_L1\_WRITE\_B}}{\mathrm{EU\_COUNT} \times \mathrm{CLK\_SPECIFIED\_EFFICIENCY}}$$

$$\mathrm{L1\_WRITE\_B\_XECORECLK} = \mathrm{L1\_WRITE\_B\_EU\_CLK} \times \mathrm{EU\_PER\_XECORE}$$

### Maximum Bandwidth (B/clock)

$$\mathrm{L2\_READ\_MAX\_B\_XECORE\_CLK} = \frac{\mathrm{XECORE\_PER\_XECU} \times 64}{\mathrm{XECORE\_PER\_XECU}} = 64$$

$$\mathrm{L2\_WRITE\_MAX\_B\_XECORE\_CLK} = \mathrm{L2\_READ\_MAX\_B\_XECORE\_CLK}$$

$$\mathrm{L2\_READ\_WRITE\_MAX\_B\_XECORE\_CLK} = \mathrm{L2\_WRITE\_MAX\_B\_XECORE\_CLK}$$

### Bandwidth Utilization (%)

$$\mathrm{L2\_READ\_B\_XECORE\_CLK\_PCT} = \frac{\mathrm{L2\_READ\_B\_XECORE\_CLK}}{\mathrm{L2\_READ\_MAX\_B\_XECORE\_CLK}}$$

$$\mathrm{L2\_WRITE\_B\_XECORE\_CLK\_PCT} = \frac{\mathrm{L2\_WRITE\_B\_XECORE\_CLK}}{\mathrm{L2\_WRITE\_MAX\_B\_XECORE\_CLK}}$$

$$\mathrm{L2\_READ\_WRITE\_B\_XECORE\_CLK\_PCT} = \frac{\mathrm{L2\_READ\_WRITE\_B\_XECORE\_CLK}}{\mathrm{L2\_READ\_WRITE\_MAX\_B\_XECORE\_CLK}}$$

$$\mathrm{L1\_READ\_B\_EU\_CLK\_PCT} = \frac{\mathrm{L1\_READ\_B\_EU\_CLK}}{\mathrm{L1\_READ\_MAX\_B\_EU\_CLK}}$$

$$\mathrm{L1\_WRITE\_B\_EU\_CLK\_PCT} = \frac{\mathrm{L1\_WRITE\_B\_EU\_CLK}}{\mathrm{L1\_WRITE\_MAX\_B\_EU\_CLK}}$$

### L2 Hit Rate & Miss Rate

$$\mathrm{L2\_HIT\_RATE\_PCT} = \min\left(\frac{\mathrm{TOTAL\_L2\_SIZE\_B\_FOR\_A\_SINGLE\_INSTANCE}}{\mathrm{TOTAL\_REQUIRED\_L2\_SIZE\_FOR\_IDEAL\_HIT\_RATE\_B}}, 1\right)$$

$$\mathrm{L2\_MISS\_RATE\_PCT} = 1 - \mathrm{L2\_HIT\_RATE\_PCT}$$

### HBM (Main Memory) Traffic

$$\mathrm{TOTAL\_L2\_READ\_TRAFFIC\_B} = \mathrm{TOTAL\_L2\_READ\_B}$$

$$\mathrm{TOTAL\_HBM\_READ\_B} = \text{(complex formula accounting for mat A/B miss probabilities)}$$

$$\mathrm{TOTAL\_HBM\_WRITE\_B} = \mathrm{MAT\_C\_INPUT\_D\_OUTPUT\_SIZE\_B}$$

$$\mathrm{TOTAL\_HBM\_B} = \mathrm{TOTAL\_HBM\_READ\_B} + \mathrm{TOTAL\_HBM\_WRITE\_B}$$

### HBM Bandwidth (B/clock and %)

$$\mathrm{MAX\_POSSIBLE\_HBM\_BW\_FREQ\_B\_CLK} = \frac{\mathrm{MAX\_POSSIBLE\_HBM\_BW\_GB\_S}}{\mathrm{GT\_FREQ\_GHZ}}$$

$$\mathrm{HBM\_READ\_B\_CLK} = \frac{\mathrm{TOTAL\_HBM\_READ\_B}}{\mathrm{CLK\_SPECIFIED\_EFFICIENCY}}$$

$$\mathrm{HBM\_WRITE\_B\_CLK} = \frac{\mathrm{TOTAL\_HBM\_WRITE\_B}}{\mathrm{CLK\_SPECIFIED\_EFFICIENCY}}$$

$$\mathrm{HBM\_TOTAL\_B\_CLK} = \frac{\mathrm{TOTAL\_HBM\_B}}{\mathrm{CLK\_SPECIFIED\_EFFICIENCY}}$$

$$\mathrm{HBM\_BW\_PCT} = \frac{\mathrm{HBM\_TOTAL\_B\_CLK}}{\mathrm{MAX\_POSSIBLE\_HBM\_BW\_FREQ\_B\_CLK}}$$

### GTI (GPU-to-Interconnect) Bandwidth (%)

$$\mathrm{GTI\_READ\_BW\_PCT} = \frac{\mathrm{HBM\_READ\_B\_CLK}}{\mathrm{GTI\_READ\_MAX\_BW\_B\_CLK}}$$

$$\mathrm{GTI\_WRITE\_BW\_PCT} = \frac{\mathrm{HBM\_WRITE\_B\_CLK}}{\mathrm{GTI\_WRITE\_MAX\_BW\_B\_CLK}}$$

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







