# GEMM Analytical Model - Equations

Auto-generated from PYTHON_FORMULAS and LATEX_SYMBOL_OVERRIDES in gemmanalytics.py.

Output order: execution

## Machine Parameters (Pre-Defined)

$$ {\mathrm{f}}_{GHz}^{(GT)} \;:\; \text{row 8: GT Freq (GHz)} $$

$$ \mathrm{|XeCU|} \;:\; \text{row 26: XeCU count} $$

$$ {\mathrm{|XeCore|}}_{perXeCU} \;:\; \text{row 27: XeCore per XeCU} $$

$$ {\mathrm{|EU|}}_{perXeCore} \;:\; \text{row 28: EU per XeCore} $$

$$ {\mathrm{|L2Banks|}}_{perXeCU} \;:\; \text{row 29: L2 banks per XeCU} $$

$$ {\mathrm{L2BankSize}}_{MB} \;:\; \text{row 30: bank capacity (MB)} $$

$$ {\mathrm{D}}_{DPAS} \;:\; \text{row 32: DPAS depth} $$

$$ {\mathrm{\eta}}_{systolic} \;:\; \text{row 35: compute efficiency \%} $$

$$ {\mathrm{L1RdBW}}_{Bp(Clk{\cdot}EU)}^{max} \;:\; \text{row 86: L1 read max (B/EU/clk)} $$

$$ {\mathrm{L1WrBW}}_{Bp(Clk{\cdot}EU)}^{max} \;:\; \text{row 87: L1 write max (B/EU/clk)} $$

$$ {\mathrm{GtiRdBW}}_{BpClk}^{max} \;:\; \text{row 97: GTI read max BW (B/clk)} $$

$$ {\mathrm{GtiWrBW}}_{BpClk}^{max} \;:\; \text{row 98: GTI write max BW (B/clk)} $$

$$ {\mathrm{MemBW}}_{GBps}^{max} \;:\; \text{row 124: max possible HBM BW (GB/s)} $$


## Workload Parameters (Pre-Defined)

$$ {\mathrm{Fmt}}^{(matA)} \;:\; \text{row 3: input A data format (e.g. fp8)} $$

$$ {\mathrm{Fmt}}^{(matB)} \;:\; \text{row 4: input B data format (e.g. fp4)} $$

$$ {\mathrm{Fmt}}^{(matD\downarrow)} \;:\; \text{row 5: output D data format (e.g. fp8)} $$

$$ {\mathrm{M}}_{dim} \;:\; \text{row 9: M dimension} $$

$$ {\mathrm{K}}_{dim} \;:\; \text{row 10: K dimension} $$

$$ {\mathrm{N}}_{dim} \;:\; \text{row 11: N dimension} $$

$$ {\mathrm{Byte}}_{perElement}^{(matD)} \;:\; \text{row 24: output bytes per element (fp32)} $$

$$ {\mathrm{\rho}}_{GT} \;:\; \text{row 34: machine occupancy \%} $$

$$ {\mathrm{M}}_{perThread} \;:\; \text{row 39: M per thread} $$

$$ {\mathrm{K}}_{perThread} \;:\; \text{row 40: K per thread} $$

$$ {\mathrm{N}}_{perThread} \;:\; \text{row 41: N per thread} $$

$$ {\mathrm{W}}_{thread}^{(ThreadGroup)} \;:\; \text{row 45: TG width in units of thread} $$

$$ {\mathrm{H}}_{thread}^{(ThreadGroup)} \;:\; \text{row 46: TG height in units of thread} $$

$$ {\mathrm{W}}_{TG,keep\ cluster\ size\ as\ 4}^{(XeCoreCluster)} \;:\; \text{row 50: XeCore cluster width in units of TG (keep cluster size as 4)} $$

$$ {\mathrm{H}}_{TG,keep\ cluster\ size\ as\ 4}^{(XeCoreCluster)} \;:\; \text{row 51: XeCore cluster height in units of TG (keep cluster size as 4)} $$

$$ {\mathrm{W}}_{TG}^{(XECUTile)} \;:\; \text{row 54: XeCU tile width in units of TG} $$

$$ {\mathrm{H}}_{TG}^{(XECUTile)} \;:\; \text{row 55: XeCU tile height in units of TG} $$

$$ {\mathrm{W}}_{XeCU}^{(GPUTile)} \;:\; \text{row 58: GPU tile width in XeCU unit} $$


## Computed Equations

### row 22 - INPUT A BYTES PER ELEMENT

$$ {\mathrm{Bytes}}_{perElement}^{(matA)} = \mathrm{DataFormatToBytes}[{\mathrm{Fmt}}^{(matA)}] $$

### row 23 - INPUT B BYTES PER ELEMENT

$$ {\mathrm{Bytes}}_{perElement}^{(matB)} = \mathrm{DataFormatToBytes}[{\mathrm{Fmt}}^{(matB)}] $$

### row 25 - OUTPUT BYTES PER ELEMENT AFTER DOWN CONVERSION

$$ {\mathrm{Bytes}}_{perElement}^{(matD\downarrow)} = \mathrm{DataFormatToBytes}[{\mathrm{Fmt}}^{(matD\downarrow)}] $$

### row 33 - EU COUNT

$$ \mathrm{|EU|} = {\mathrm{|XeCore|}}_{perXeCU} \times {\mathrm{|EU|}}_{perXeCore} \times \mathrm{|XeCU|} $$

### row 36a - MMA MAC THROUGHPUT PER EU

$$ {\mathrm{\tau}}_{mMACp(Clk{\cdot}EU)}^{(peak)} = \frac{4}{max({\mathrm{Bytes}}_{perElement}^{(matA)}, {\mathrm{Bytes}}_{perElement}^{(matB)})} \times {\mathrm{D}}_{DPAS} \times 16 $$

### row 36 - MMA MAC THROUGHPUT PER XECORE

$$ {\mathrm{\tau}}_{mMACp(Clk{\cdot}XeCore)}^{(peak)} = {\mathrm{\tau}}_{mMACp(Clk{\cdot}EU)}^{(peak)} \times {\mathrm{|EU|}}_{perXeCore} $$

### row 42 - CLKS PER DPAS

$$ {\mathrm{CLKS}}_{DPAS} = \frac{{\mathrm{M}}_{perThread} \times {\mathrm{K}}_{perThread} \times {\mathrm{N}}_{perThread}}{\frac{{\mathrm{\tau}}_{mMACp(Clk{\cdot}XeCore)}^{(peak)}}{{\mathrm{|EU|}}_{perXeCore}}} $$

### row 43 - THREAD WIDTH IN UNITS OF ELEMENTS

$$ {\mathrm{W}}_{element}^{(Thread)} = {\mathrm{N}}_{perThread} $$

### row 44 - THREAD HEIGHT IN UNITS OF ELEMENTS

$$ {\mathrm{H}}_{element}^{(Thread)} = {\mathrm{M}}_{perThread} $$

### row 47 - TG WIDTH IN UNITS OF ELEMENT REALIZED BY MULTIPLE MMA
### ITERATIONS

$$ {\mathrm{W}}_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)} = {\mathrm{W}}_{thread}^{(ThreadGroup)} \times {\mathrm{W}}_{element}^{(Thread)} $$

### row 14 - TG TILES IN N

$$ {\mathrm{|Tiles|}}_{N}^{(TG)} = \frac{{\mathrm{N}}_{dim}}{{\mathrm{W}}_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} $$

### row 48 - TG HEIGHT IN UNITS OF ELEMENT

$$ {\mathrm{H}}_{element}^{(ThreadGroup)} = {\mathrm{H}}_{thread}^{(ThreadGroup)} \times {\mathrm{H}}_{element}^{(Thread)} $$

### row 15 - TG TILES IN M

$$ {\mathrm{|Tiles|}}_{M}^{(TG)} = \frac{{\mathrm{M}}_{dim}}{{\mathrm{H}}_{element}^{(ThreadGroup)}} $$

### row 52 - XECORE CLUSTER WIDTH IN UNITS OF ELEMENT

$$ {\mathrm{W}}_{element}^{(XeCoreCluster)} = {\mathrm{W}}_{TG,keep\ cluster\ size\ as\ 4}^{(XeCoreCluster)} \times {\mathrm{W}}_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)} $$

### row 16 - TG CLUSTER TILES IN N

$$ {\mathrm{|Tiles|}}_{N}^{(TG\ Cluster)} = \frac{{\mathrm{N}}_{dim}}{{\mathrm{W}}_{element}^{(XeCoreCluster)}} $$

### row 53 - XECORE CLUSTER HEIGHT IN UNITS OF ELEMENT

$$ {\mathrm{H}}_{element}^{(XeCoreCluster)} = {\mathrm{H}}_{TG,keep\ cluster\ size\ as\ 4}^{(XeCoreCluster)} \times {\mathrm{H}}_{element}^{(ThreadGroup)} $$

### row 17 - TG CLUSTER TILES IN M

$$ {\mathrm{|Tiles|}}_{M}^{(TG\ Cluster)} = \frac{{\mathrm{M}}_{dim}}{{\mathrm{H}}_{element}^{(XeCoreCluster)}} $$

### row 56 - XECU TILE WIDTH IN UNITS OF ELEMENT

$$ {\mathrm{W}}_{element}^{(XeCUTile)} = {\mathrm{W}}_{TG}^{(XECUTile)} \times {\mathrm{W}}_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)} $$

### row 18 - XECU TILES IN N

$$ {\mathrm{|Tiles|}}_{N}^{(XeCU)} = \frac{{\mathrm{N}}_{dim}}{{\mathrm{W}}_{element}^{(XeCUTile)}} $$

### row 20 - GPU TILES IN N

$$ {\mathrm{|Tiles|}}_{N}^{(GPU)} = \frac{\frac{{\mathrm{N}}_{dim}}{{\mathrm{W}}_{element}^{(XeCUTile)}}}{{\mathrm{W}}_{XeCU}^{(GPUTile)}} $$

### row 57 - XECU TILE HEIGHT IN UNITS OF ELEMENT

$$ {\mathrm{H}}_{element}^{(XeCUTile)} = {\mathrm{H}}_{TG}^{(XECUTile)} \times {\mathrm{H}}_{element}^{(ThreadGroup)} $$

### row 19 - XECU TILES IN M

$$ {\mathrm{|Tiles|}}_{M}^{(XeCU)} = \frac{{\mathrm{M}}_{dim}}{{\mathrm{H}}_{element}^{(XeCUTile)}} $$

### row 59 - GPU TILE HEIGHT IN XECU UINT

$$ {\mathrm{H}}_{XeCU}^{(GPUTile)} = \frac{\mathrm{|XeCU|}}{{\mathrm{W}}_{XeCU}^{(GPUTile)}} $$

### row 21 - GPU TILES IN M

$$ {\mathrm{|Tiles|}}_{M}^{(GPU)} = \frac{\frac{{\mathrm{M}}_{dim}}{{\mathrm{H}}_{element}^{(XeCUTile)}}}{{\mathrm{H}}_{XeCU}^{(GPUTile)}} $$

### row 13 - WAVES

$$ {\mathrm{N}}_{waves} = \mathrm{CEILING}({\mathrm{|Tiles|}}_{N}^{(GPU)}, 1) \times \mathrm{CEILING}({\mathrm{|Tiles|}}_{M}^{(GPU)}, 1) $$

### row 60 - GPU TILE WIDTH IN UNITS OF ELEMETNS

$$ {\mathrm{W}}_{element}^{(GPUTile)} = {\mathrm{W}}_{XeCU}^{(GPUTile)} \times {\mathrm{W}}_{element}^{(XeCUTile)} $$

### row 61 - GPU TILE HEIGHT IN UNITS OF ELEMETNS

$$ {\mathrm{H}}_{element}^{(GPUTile)} = {\mathrm{H}}_{XeCU}^{(GPUTile)} \times {\mathrm{H}}_{element}^{(XeCUTile)} $$

### row 63 - MAT A INPUT SIZE B

$$ {\mathrm{Size}}_{B}^{(matA)} = {\mathrm{M}}_{dim} \times {\mathrm{K}}_{dim} \times {\mathrm{Bytes}}_{perElement}^{(matA)} $$

### row 64 - MAT B INPUT SIZE B

$$ {\mathrm{Size}}_{B}^{(matB)} = {\mathrm{K}}_{dim} \times {\mathrm{N}}_{dim} \times {\mathrm{Bytes}}_{perElement}^{(matB)} $$

### row 65 - MAT C INPUT D OUTPUT SIZE B

$$ {\mathrm{Size}}_{B}^{(matC,matD)} = {\mathrm{M}}_{dim} \times {\mathrm{N}}_{dim} \times {\mathrm{Bytes}}_{perElement}^{(matD\downarrow)} $$

### row 66 - MAT D INTERMEDIATE SIZE B

$$ {\mathrm{Size}}_{B}^{(matD\downarrow)} = {\mathrm{M}}_{dim} \times {\mathrm{N}}_{dim} \times {\mathrm{Byte}}_{perElement}^{(matD)} $$

### row 102 - TOTAL L2 SIZE B FOR A SINGLE INSTANCE

$$ {\mathrm{L2Size}}_{B} = {\mathrm{L2BankSize}}_{MB} \times {\mathrm{|L2Banks|}}_{perXeCU} \times 1024 \times 1024 $$

### row 103 - WORKING DATA SET SIZE OF K IN L2 CORRESP 20K CLOCKS OF
### THREAD DIVERGENCE

$$ {\mathrm{|WorkingSet|}}_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)} = \min(20000 \times \frac{{\mathrm{K}}_{perThread}}{{\mathrm{CLKS}}_{DPAS}}, {\mathrm{K}}_{dim}) $$

### row 104 - TOTAL REQUIRED L2 SIZE FOR IDEAL HIT RATE B FOR A SINGLE
### INSTANCE AND SINGLE WAVE

$$
\begin{aligned}
{\mathrm{TotalRequiredL2Size}}_{matB\ always hit}^{1\ instance,\ 1\ wave} &= {\mathrm{H}}_{element}^{(XeCUTile)} \times {\mathrm{Bytes}}_{perElement}^{(matA)} \times {\mathrm{|WorkingSet|}}_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)} \\
&\quad + {\mathrm{W}}_{element}^{(XeCUTile)} \times {\mathrm{Bytes}}_{perElement}^{(matB)} \times {\mathrm{|WorkingSet|}}_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)} \\
&\quad + {\mathrm{W}}_{element}^{(XeCUTile)} \times {\mathrm{H}}_{element}^{(XeCUTile)} \times {\mathrm{Bytes}}_{perElement}^{(matD\downarrow)}
\end{aligned}
$$

### row 125 - MAX POSSIBLE HBM BW FREQ B CLK

$$ {\mathrm{MemBW}}_{BpClk}^{max} = \frac{{\mathrm{MemBW}}_{GBps}^{max}}{{\mathrm{f}}_{GHz}^{(GT)}} $$

### row 37a - WORKLOAD MAC PER XECORE

$$ {\mathrm{WL}}_{MAC}^{(XeCore)} = \frac{{\mathrm{M}}_{dim} \times {\mathrm{K}}_{dim} \times {\mathrm{N}}_{dim}}{{\mathrm{|XeCore|}}_{perXeCU} \times \mathrm{|XeCU|}} $$

### row 37 - CLK SPECIFIED EFFICIENCY

$$ {\mathrm{T}}_{clk}^{(total)} = \frac{{\mathrm{WL}}_{MAC}^{(XeCore)}}{{\mathrm{\tau}}_{mMACp(Clk{\cdot}XeCore)}^{(peak)} \times {\mathrm{\eta}}_{systolic}} $$

### row 69 - TOTAL L2 READ B

$$
\begin{aligned}
{\mathrm{L2Rd}}_{B}^{(total)} &= {\mathrm{Size}}_{B}^{(matA)} \times \mathrm{CEILING}(\frac{{\mathrm{N}}_{dim}}{{\mathrm{W}}_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}}, 1) \\
&\quad + {\mathrm{Size}}_{B}^{(matB)} \times \mathrm{CEILING}(\frac{{\mathrm{M}}_{dim}}{{\mathrm{H}}_{element}^{(ThreadGroup)}}, 1)
\end{aligned}
$$

### row 70 - TOTAL L2 WRITE B

$$ {\mathrm{L2Wr}}_{B}^{(total)} = {\mathrm{Size}}_{B}^{(matC,matD)} $$

### row 71 - TOTAL L1 READ B

$$
\begin{aligned}
{\mathrm{L1Rd}}_{B}^{(total)} &= {\mathrm{Size}}_{B}^{(matA)} \times \mathrm{CEILING}(\frac{{\mathrm{N}}_{dim}}{{\mathrm{W}}_{element}^{(Thread)}}, 1) \\
&\quad + {\mathrm{Size}}_{B}^{(matB)} \times \mathrm{CEILING}(\frac{{\mathrm{M}}_{dim}}{{\mathrm{H}}_{element}^{(Thread)}}, 1)
\end{aligned}
$$

### row 72 - TOTAL L1 WRITE B

$$ {\mathrm{L1Wr}}_{B}^{(total)} = {\mathrm{Size}}_{B}^{(matC,matD)} $$

### row 74 - L2 READ B XECORE CLK

$$ {\mathrm{L2RdBW}}_{Bp(Clk{\cdot}XeCore)} = \frac{\frac{{\mathrm{L2Rd}}_{B}^{(total)}}{\mathrm{|XeCU|} \times {\mathrm{|XeCore|}}_{perXeCU}}}{{\mathrm{T}}_{clk}^{(total)}} $$

### row 75 - L2 WRITE B XECORE CLK

$$ {\mathrm{L2WrBW}}_{Bp(Clk{\cdot}XeCore)} = \frac{\frac{{\mathrm{L2Wr}}_{B}^{(total)}}{\mathrm{|XeCU|} \times {\mathrm{|XeCore|}}_{perXeCU}}}{{\mathrm{T}}_{clk}^{(total)}} $$

### row 76 - L2 READ WRITE B XECORE CLK

$$
\begin{aligned}
{\mathrm{L2RdWrBW}}_{Bp(Clk{\cdot}XeCore)} &= {\mathrm{L2RdBW}}_{Bp(Clk{\cdot}XeCore)} \\
&\quad + {\mathrm{L2WrBW}}_{Bp(Clk{\cdot}XeCore)}
\end{aligned}
$$

### row 79 - L1 READ B EU CLK

$$ {\mathrm{L1RdBW}}_{Bp(Clk{\cdot}EU)} = \frac{\frac{{\mathrm{L1Rd}}_{B}^{(total)}}{\mathrm{|EU|}}}{{\mathrm{T}}_{clk}^{(total)}} $$

### row 77 - L1 READ B XECORE CLK

$$ {\mathrm{L1RdBW}}_{Bp(Clk{\cdot}XeCore)} = {\mathrm{L1RdBW}}_{Bp(Clk{\cdot}EU)} \times {\mathrm{|EU|}}_{perXeCore} $$

### row 80 - L1 WRITE B EU CLK

$$ {\mathrm{L1WrBW}}_{Bp(Clk{\cdot}EU)} = \frac{\frac{{\mathrm{L1Wr}}_{B}^{(total)}}{\mathrm{|EU|}}}{{\mathrm{T}}_{clk}^{(total)}} $$

### row 78 - L1 WRITE B XECORECLK

$$ {\mathrm{L1WrBW}}_{Bp(Clk{\cdot}XeCore)} = {\mathrm{L1WrBW}}_{Bp(Clk{\cdot}EU)} \times {\mathrm{|EU|}}_{perXeCore} $$

### row 83 - L2 READ MAX B XECORE CLK

$$ {\mathrm{L2RdBW}}_{Bp(Clk{\cdot}XeCore)}^{(max)} = \frac{{\mathrm{|XeCore|}}_{perXeCU} \times 64}{{\mathrm{|XeCore|}}_{perXeCU}} $$

### row 84 - L2 WRITE MAX B XECORE CLK

$$ {\mathrm{L2WrBW}}_{Bp(Clk{\cdot}XeCore)}^{(max)} = {\mathrm{L2RdBW}}_{Bp(Clk{\cdot}XeCore)}^{(max)} $$

### row 85 - L2 READ WRITE MAX B XECORE CLK

$$ {\mathrm{L2RdWrBW}}_{Bp(Clk{\cdot}XeCore)}^{(max)} = {\mathrm{L2WrBW}}_{Bp(Clk{\cdot}XeCore)}^{(max)} $$

### row 90 - L2 READ B XECORE CLK PCT

$$ {\mathrm{\eta}}_{L2RdBWpXeCore} = \frac{{\mathrm{L2RdBW}}_{Bp(Clk{\cdot}XeCore)}}{{\mathrm{L2RdBW}}_{Bp(Clk{\cdot}XeCore)}^{(max)}} $$

### row 91 - L2 WRITE B XECORE CLK PCT

$$ {\mathrm{\eta}}_{L2WrBWpXeCore} = \frac{{\mathrm{L2WrBW}}_{Bp(Clk{\cdot}XeCore)}}{{\mathrm{L2WrBW}}_{Bp(Clk{\cdot}XeCore)}^{(max)}} $$

### row 92 - L2 READ WRITE B XECORE CLK PCT

$$ {\mathrm{\eta}}_{L2RdWrBWpXeCore} = \frac{{\mathrm{L2RdWrBW}}_{Bp(Clk{\cdot}XeCore)}}{{\mathrm{L2RdWrBW}}_{Bp(Clk{\cdot}XeCore)}^{(max)}} $$

### row 93 - L1 READ B EU CLK PCT

$$ {\mathrm{\eta}}_{L1RdBWpEU} = \frac{{\mathrm{L1RdBW}}_{Bp(Clk{\cdot}EU)}}{{\mathrm{L1RdBW}}_{Bp(Clk{\cdot}EU)}^{max}} $$

### row 94 - L1 WRITE B EU CLK PCT

$$ {\mathrm{\eta}}_{L1WrBWpEU} = \frac{{\mathrm{L1WrBW}}_{Bp(Clk{\cdot}EU)}}{{\mathrm{L1WrBW}}_{Bp(Clk{\cdot}EU)}^{max}} $$

### row 106 - L2 HIT RATE ASSUMED RANDOM ACCESS WITHIN THE WORKING
### DATA SET PCT

$$ {\mathrm{L2HitRate}}_{random\ WS\ access} = \min(\frac{{\mathrm{L2Size}}_{B}}{{\mathrm{TotalRequiredL2Size}}_{matB\ always hit}^{1\ instance,\ 1\ wave}}, 1) $$

### row 107 - L2 MISS RATE PCT

$$ \mathrm{L2MissRate} = 1 - {\mathrm{L2HitRate}}_{random\ WS\ access} $$

### row 108 - TOTAL L2 READ TRAFFIC B

$$ {\mathrm{L2RdB}}_{total} = {\mathrm{L2Rd}}_{B}^{(total)} $$

### row 110 - PROBABILITY OF MATA HIT IN L2 DURING A NON FIRST WAVE
### PCT

$$
\begin{aligned}
{\mathrm{P}}_{L2Hit,\ after\ 1st\ wave}^{(matA)} &= \mathrm{IF}({\mathrm{Size}}_{B}^{(matA)} \\
&\quad + {\mathrm{Size}}_{B}^{(matB)} \\
&\quad + {\mathrm{Size}}_{B}^{(matC,matD)} \le {\mathrm{L2Size}}_{B}, 1.0, \mathrm{IF}({\mathrm{K}}_{dim} > 2 \times {\mathrm{|WorkingSet|}}_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)}, 0.0, 1 \\
&\quad - \frac{{\mathrm{K}}_{dim} - {\mathrm{|WorkingSet|}}_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)}}{{\mathrm{|WorkingSet|}}_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)}}))
\end{aligned}
$$

### row 111 - PROBABILITY OF MATB HIT IN L2 DURING A NON FIRST WAVE
### PCT

$$
\begin{aligned}
{\mathrm{P}}_{L2Hit,\ after\ 1st\ wave}^{(matB)} &= \mathrm{IF}({\mathrm{Size}}_{B}^{(matA)} \\
&\quad + {\mathrm{Size}}_{B}^{(matB)} \\
&\quad + {\mathrm{Size}}_{B}^{(matC,matD)} \le {\mathrm{L2Size}}_{B}, 1.0, 0.0)
\end{aligned}
$$

### row 112 - PROBABILITY OF MATA MISS IN L2 DURING A NON FIRST WAVE
### PCT

$$
\begin{aligned}
{\mathrm{P}}_{L2Miss,\ after\ 1st\ wave}^{(matA)} &= 1 \\
&\quad - {\mathrm{P}}_{L2Hit,\ after\ 1st\ wave}^{(matA)}
\end{aligned}
$$

### row 113 - PROBABILITY OF MATB MISS IN L2 DURING A NON FIRST WAVE
### PCT

$$
\begin{aligned}
{\mathrm{P}}_{L2Miss,\ after\ 1st\ wave}^{(matB)} &= 1 \\
&\quad - {\mathrm{P}}_{L2Hit,\ after\ 1st\ wave}^{(matB)}
\end{aligned}
$$

### row 116 - TOTAL HBM READ B AFTER A COMPLETION OF A WAVE CONSIDER
### COLD CACHE

$$ {\mathrm{MemRdB}}_{cold\ start}^{(wave)} = \frac{\left({\mathrm{MemRdB}}_{cold\ start}^{(wave)}\right)_{\mathrm{num}}}{2} $$

$$
\begin{aligned}
\left({\mathrm{MemRdB}}_{cold\ start}^{(wave)}\right)_{\mathrm{num}} &= {\mathrm{Size}}_{B}^{(matA)} \\
&\quad + {\mathrm{Size}}_{B}^{(matA)} \times \left(\mathrm{CEILING}(\frac{{\mathrm{N}}_{dim}}{{\mathrm{W}}_{element}^{(XeCUTile)}}, 1) - 1\right) \times {\mathrm{P}}_{L2Miss,\ after\ 1st\ wave}^{(matA)} \\
&\quad + {\mathrm{Size}}_{B}^{(matB)} \\
&\quad + {\mathrm{Size}}_{B}^{(matB)} \times \left(\mathrm{CEILING}(\frac{{\mathrm{M}}_{dim}}{{\mathrm{H}}_{element}^{(XeCUTile)}}, 1) - 1\right) \times {\mathrm{P}}_{L2Miss,\ after\ 1st\ wave}^{(matB)} \\
&\quad + \left(\left({\mathrm{MemRdB}}_{cold\ start}^{(wave)}\right)_{\mathrm{num}}\right)_{\mathrm{aux4}} \times \mathrm{L2MissRate}
\end{aligned}
$$

$$
\begin{aligned}
\left(\left({\mathrm{MemRdB}}_{cold\ start}^{(wave)}\right)_{\mathrm{num}}\right)_{\mathrm{aux4}} &= {\mathrm{L2RdB}}_{total} \\
&\quad - \left(\left(\left({\mathrm{MemRdB}}_{cold\ start}^{(wave)}\right)_{\mathrm{num}}\right)_{\mathrm{aux4}}\right)_{\mathrm{aux1}}
\end{aligned}
$$

$$
\begin{aligned}
\left(\left(\left({\mathrm{MemRdB}}_{cold\ start}^{(wave)}\right)_{\mathrm{num}}\right)_{\mathrm{aux4}}\right)_{\mathrm{aux1}} &= {\mathrm{Size}}_{B}^{(matA)} \\
&\quad + {\mathrm{Size}}_{B}^{(matA)} \times \left(\mathrm{CEILING}(\frac{{\mathrm{N}}_{dim}}{{\mathrm{W}}_{element}^{(XeCUTile)}}, 1) - 1\right) \times {\mathrm{P}}_{L2Miss,\ after\ 1st\ wave}^{(matA)} \\
&\quad + {\mathrm{Size}}_{B}^{(matB)} \\
&\quad + {\mathrm{Size}}_{B}^{(matB)} \times \left(\mathrm{CEILING}(\frac{{\mathrm{M}}_{dim}}{{\mathrm{H}}_{element}^{(XeCUTile)}}, 1) - 1\right) \times {\mathrm{P}}_{L2Miss,\ after\ 1st\ wave}^{(matB)}
\end{aligned}
$$

### row 117 - TOTAL HBM WRITE B

$$ {\mathrm{MemWrB}}^{(total)} = {\mathrm{Size}}_{B}^{(matC,matD)} $$

### row 118 - TOTAL HBM B

$$
\begin{aligned}
{\mathrm{MemRdWrB}}^{(total)} &= {\mathrm{MemWrB}}^{(total)} \\
&\quad + {\mathrm{MemRdB}}_{cold\ start}^{(wave)}
\end{aligned}
$$

### row 121 - HBM READ B CLK

$$ {\mathrm{MemRdBW}}_{BpClk} = \frac{{\mathrm{MemRdB}}_{cold\ start}^{(wave)}}{{\mathrm{T}}_{clk}^{(total)}} $$

### row 122 - HBM WRITE B CLK

$$ {\mathrm{MemWrBW}}_{BpClk} = \frac{{\mathrm{MemWrB}}^{(total)}}{{\mathrm{T}}_{clk}^{(total)}} $$

### row 123 - HBM TOTAL B CLK

$$ {\mathrm{MemRdWrBW}}_{BpClk} = \frac{{\mathrm{MemRdWrB}}^{(total)}}{{\mathrm{T}}_{clk}^{(total)}} $$

### row 126 - HBM BW PCT

$$ {\mathrm{\eta}}_{MemBW} = \frac{{\mathrm{MemRdWrBW}}_{BpClk}}{{\mathrm{MemBW}}_{BpClk}^{max}} $$

### row 127 - GTI READ BW PCT

$$ {\mathrm{\eta}}_{GTIRdBW} = \frac{{\mathrm{MemRdBW}}_{BpClk}}{{\mathrm{GtiRdBW}}_{BpClk}^{max}} $$

### row 128 - GTI WRITE BW PCT

$$ {\mathrm{\eta}}_{GTIWrBW} = \frac{{\mathrm{MemWrBW}}_{BpClk}}{{\mathrm{GtiWrBW}}_{BpClk}^{max}} $$
