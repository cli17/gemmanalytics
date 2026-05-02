# GEMM Analytical Model - Equations

Auto-generated from PYTHON_FORMULAS and LATEX_SYMBOL_OVERRIDES in gemmanalytics.py.

Output order: execution

### row 22 - INPUT A BYTES PER ELEMENT

$$ \mathrm{Bytes_{perElement}^{(matA)}} = \mathrm{DataFormatToBytes}[\mathrm{Fmt^{(matA)}}] $$

### row 23 - INPUT B BYTES PER ELEMENT

$$ \mathrm{Bytes_{perElement}^{(matB)}} = \mathrm{DataFormatToBytes}[\mathrm{Fmt^{(matB)}}] $$

### row 25 - OUTPUT BYTES PER ELEMENT AFTER DOWN CONVERSION

$$ \mathrm{Bytes_{perElement}^{(matD\downarrow)}} = \mathrm{DataFormatToBytes}[\mathrm{Fmt^{(matD\downarrow)}}] $$

### row 33 - EU COUNT

$$ \mathrm{|EU|} = \mathrm{|XeCore|_{perXeCU}} \times \mathrm{|EU|_{perXeCore}} \times \mathrm{|XeCU|} $$

### row ? - MMA MAC THROUGHPUT PER EU

$$ \mathrm{\tau_{mMACpClk{\cdot}EU}^{(peak)}} = \frac{4}{max(\mathrm{Bytes_{perElement}^{(matA)}}, \mathrm{Bytes_{perElement}^{(matB)}})} \times \mathrm{D_{DPAS}} \times 16 $$

### row 36 - MMA MAC THROUGHPUT PER XECORE

$$ \mathrm{\tau_{mMACpClk{\cdot}XeCore}^{(peak)}} = \mathrm{\tau_{mMACpClk{\cdot}EU}^{(peak)}} \times \mathrm{|EU|_{perXeCore}} $$

### row 42 - CLKS PER DPAS

$$ \mathrm{CLKS_{DPAS}} = \frac{\mathrm{M_{perThread}} \times \mathrm{K_{perThread}} \times \mathrm{N_{perThread}}}{\frac{\mathrm{\tau_{mMACpClk{\cdot}XeCore}^{(peak)}}}{\mathrm{|EU|_{perXeCore}}}} $$

### row 43 - THREAD WIDTH IN UNITS OF ELEMENTS

$$ \mathrm{W_{element}^{(Thread)}} = \mathrm{N_{perThread}} $$

### row 44 - THREAD HEIGHT IN UNITS OF ELEMENTS

$$ \mathrm{H_{element}^{(Thread)}} = \mathrm{M_{perThread}} $$

### row 47 - TG WIDTH IN UNITS OF ELEMENT REALIZED BY MULTIPLE MMA
### ITERATIONS

$$ \mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} = \mathrm{W_{thread}^{(ThreadGroup)}} \times \mathrm{W_{element}^{(Thread)}} $$

### row 14 - TG TILES IN N

$$ \mathrm{|Tiles|_{N}^{(TG)}} = \frac{\mathrm{N_{dim}}}{\mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}}} $$

### row 48 - TG HEIGHT IN UNITS OF ELEMENT

$$ \mathrm{H_{element}^{(ThreadGroup)}} = \mathrm{H_{thread}^{(ThreadGroup)}} \times \mathrm{H_{element}^{(Thread)}} $$

### row 15 - TG TILES IN M

$$ \mathrm{|Tiles|_{M}^{(TG)}} = \frac{\mathrm{M_{dim}}}{\mathrm{H_{element}^{(ThreadGroup)}}} $$

### row 52 - XECORE CLUSTER WIDTH IN UNITS OF ELEMENT

$$ \mathrm{W_{element}^{(XeCoreCluster)}} = \mathrm{W_{TG,keep\ cluster\ size\ as\ 4}^{(XeCoreCluster)}} \times \mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} $$

### row 16 - TG CLUSTER TILES IN N

$$ \mathrm{|Tiles|_{N}^{(TG\ Cluster)}} = \frac{\mathrm{N_{dim}}}{\mathrm{W_{element}^{(XeCoreCluster)}}} $$

### row 53 - XECORE CLUSTER HEIGHT IN UNITS OF ELEMENT

$$ \mathrm{H_{element}^{(XeCoreCluster)}} = \mathrm{H_{TG,keep\ cluster\ size\ as\ 4}^{(XeCoreCluster)}} \times \mathrm{H_{element}^{(ThreadGroup)}} $$

### row 17 - TG CLUSTER TILES IN M

$$ \mathrm{|Tiles|_{M}^{(TG\ Cluster)}} = \frac{\mathrm{M_{dim}}}{\mathrm{H_{element}^{(XeCoreCluster)}}} $$

### row 56 - XECU TILE WIDTH IN UNITS OF ELEMENT

$$ \mathrm{W_{element}^{(XeCUTile)}} = \mathrm{W_{TG}^{(XECUTile)}} \times \mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}} $$

### row 18 - XECU TILES IN N

$$ \mathrm{|Tiles|_{N}^{(XeCU)}} = \frac{\mathrm{N_{dim}}}{\mathrm{W_{element}^{(XeCUTile)}}} $$

### row 20 - GPU TILES IN N

$$ \mathrm{|Tiles|_{N}^{(GPU)}} = \frac{\frac{\mathrm{N_{dim}}}{\mathrm{W_{element}^{(XeCUTile)}}}}{\mathrm{W_{XeCU}^{(GPUTile)}}} $$

### row 57 - XECU TILE HEIGHT IN UNITS OF ELEMENT

$$ \mathrm{H_{element}^{(XeCUTile)}} = \mathrm{H_{TG}^{(XECUTile)}} \times \mathrm{H_{element}^{(ThreadGroup)}} $$

### row 19 - XECU TILES IN M

$$ \mathrm{|Tiles|_{M}^{(XeCU)}} = \frac{\mathrm{M_{dim}}}{\mathrm{H_{element}^{(XeCUTile)}}} $$

### row 59 - GPU TILE HEIGHT IN XECU UINT

$$ \mathrm{H_{XeCU}^{(GPUTile)}} = \frac{\mathrm{|XeCU|}}{\mathrm{W_{XeCU}^{(GPUTile)}}} $$

### row 21 - GPU TILES IN M

$$ \mathrm{|Tiles|_{M}^{(GPU)}} = \frac{\frac{\mathrm{M_{dim}}}{\mathrm{H_{element}^{(XeCUTile)}}}}{\mathrm{H_{XeCU}^{(GPUTile)}}} $$

### row 13 - WAVES

$$ \mathrm{N_{waves}} = \mathrm{CEILING}(\mathrm{|Tiles|_{N}^{(GPU)}}, 1) \times \mathrm{CEILING}(\mathrm{|Tiles|_{M}^{(GPU)}}, 1) $$

### row 60 - GPU TILE WIDTH IN UNITS OF ELEMETNS

$$ \mathrm{W_{element}^{(GPUTile)}} = \mathrm{W_{XeCU}^{(GPUTile)}} \times \mathrm{W_{element}^{(XeCUTile)}} $$

### row 61 - GPU TILE HEIGHT IN UNITS OF ELEMETNS

$$ \mathrm{H_{element}^{(GPUTile)}} = \mathrm{H_{XeCU}^{(GPUTile)}} \times \mathrm{H_{element}^{(XeCUTile)}} $$

### row 63 - MAT A INPUT SIZE B

$$ \mathrm{Size_{B}^{(matA)}} = \mathrm{M_{dim}} \times \mathrm{K_{dim}} \times \mathrm{Bytes_{perElement}^{(matA)}} $$

### row 64 - MAT B INPUT SIZE B

$$ \mathrm{Size_{B}^{(matB)}} = \mathrm{K_{dim}} \times \mathrm{N_{dim}} \times \mathrm{Bytes_{perElement}^{(matB)}} $$

### row 65 - MAT C INPUT D OUTPUT SIZE B

$$ \mathrm{Size_{B}^{(matC,matD)}} = \mathrm{M_{dim}} \times \mathrm{N_{dim}} \times \mathrm{Bytes_{perElement}^{(matD\downarrow)}} $$

### row 66 - MAT D INTERMEDIATE SIZE B

$$ \mathrm{Size_{B}^{(matD\downarrow)}} = \mathrm{M_{dim}} \times \mathrm{N_{dim}} \times \mathrm{Byte_{perElement}^{(matD)}} $$

### row 102 - TOTAL L2 SIZE B FOR A SINGLE INSTANCE

$$ \mathrm{L2Size_{B}} = \mathrm{L2BankSize_{MB}} \times \mathrm{|L2Banks|_{perXeCU}} \times 1024 \times 1024 $$

### row 103 - WORKING DATA SET SIZE OF K IN L2 CORRESP 20K CLOCKS OF
### THREAD DIVERGENCE

$$ \mathrm{|WorkingSet|_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)}} = \min(20000 \times \frac{\mathrm{K_{perThread}}}{\mathrm{CLKS_{DPAS}}}, \mathrm{K_{dim}}) $$

### row 104 - TOTAL REQUIRED L2 SIZE FOR IDEAL HIT RATE B FOR A SINGLE
### INSTANCE AND SINGLE WAVE

$$
\begin{aligned}
\mathrm{TotalRequiredL2Size_{matB\ always hit}^{1\ instance,\ 1\ wave}} &= \mathrm{H_{element}^{(XeCUTile)}} \times \mathrm{Bytes_{perElement}^{(matA)}} \times \mathrm{|WorkingSet|_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)}} \\
&\quad + \mathrm{W_{element}^{(XeCUTile)}} \times \mathrm{Bytes_{perElement}^{(matB)}} \times \mathrm{|WorkingSet|_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)}} \\
&\quad + \mathrm{W_{element}^{(XeCUTile)}} \times \mathrm{H_{element}^{(XeCUTile)}} \times \mathrm{Bytes_{perElement}^{(matD\downarrow)}}
\end{aligned}
$$

### row 125 - MAX POSSIBLE HBM BW FREQ B CLK

$$ \mathrm{MemBW_{BpClk}^{max}} = \frac{\mathrm{MemBW_{GBps}^{max}}}{\mathrm{f_{GHz}^{(GT)}}} $$

### row 37a - WORKLOAD MAC PER XECORE

$$ \mathrm{WL_{MAC}^{(XeCore)}} = \frac{\mathrm{M_{dim}} \times \mathrm{K_{dim}} \times \mathrm{N_{dim}}}{\mathrm{|XeCore|_{perXeCU}} \times \mathrm{|XeCU|}} $$

### row 37 - CLK SPECIFIED EFFICIENCY

$$ \mathrm{T_{clk}^{(total)}} = \frac{\mathrm{WL_{MAC}^{(XeCore)}}}{\mathrm{\tau_{mMACpClk{\cdot}XeCore}^{(peak)}} \times \mathrm{\eta_{systolic}}} $$

### row 69 - TOTAL L2 READ B

$$
\begin{aligned}
\mathrm{L2Rd_{B}^{(total)}} &= \mathrm{Size_{B}^{(matA)}} \times \mathrm{CEILING}(\frac{\mathrm{N_{dim}}}{\mathrm{W_{element}^{(ThreadGroup, realized\ by\ multiple\ MMA\ iterations)}}}, 1) \\
&\quad + \mathrm{Size_{B}^{(matB)}} \times \mathrm{CEILING}(\frac{\mathrm{M_{dim}}}{\mathrm{H_{element}^{(ThreadGroup)}}}, 1)
\end{aligned}
$$

### row 70 - TOTAL L2 WRITE B

$$ \mathrm{L2Wr_{B}^{(total)}} = \mathrm{Size_{B}^{(matC,matD)}} $$

### row 71 - TOTAL L1 READ B

$$
\begin{aligned}
\mathrm{L1Rd_{B}^{(total)}} &= \mathrm{Size_{B}^{(matA)}} \times \mathrm{CEILING}(\frac{\mathrm{N_{dim}}}{\mathrm{W_{element}^{(Thread)}}}, 1) \\
&\quad + \mathrm{Size_{B}^{(matB)}} \times \mathrm{CEILING}(\frac{\mathrm{M_{dim}}}{\mathrm{H_{element}^{(Thread)}}}, 1)
\end{aligned}
$$

### row 72 - TOTAL L1 WRITE B

$$ \mathrm{L1Wr_{B}^{(total)}} = \mathrm{Size_{B}^{(matC,matD)}} $$

### row 74 - L2 READ B XECORE CLK

$$ \mathrm{L2RdBW_{Bp(Clk{\cdot}XeCore)}} = \frac{\frac{\mathrm{L2Rd_{B}^{(total)}}}{\mathrm{|XeCU|} \times \mathrm{|XeCore|_{perXeCU}}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 75 - L2 WRITE B XECORE CLK

$$ \mathrm{L2WrBW_{Bp(Clk{\cdot}XeCore)}} = \frac{\frac{\mathrm{L2Wr_{B}^{(total)}}}{\mathrm{|XeCU|} \times \mathrm{|XeCore|_{perXeCU}}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 76 - L2 READ WRITE B XECORE CLK

$$
\begin{aligned}
\mathrm{L2RdWrBW_{Bp(Clk{\cdot}XeCore)}} &= \mathrm{L2RdBW_{Bp(Clk{\cdot}XeCore)}} \\
&\quad + \mathrm{L2WrBW_{Bp(Clk{\cdot}XeCore)}}
\end{aligned}
$$

### row 79 - L1 READ B EU CLK

$$ \mathrm{L1RdBW_{Bp(Clk{\cdot}EU)}} = \frac{\frac{\mathrm{L1Rd_{B}^{(total)}}}{\mathrm{|EU|}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 77 - L1 READ B XECORE CLK

$$ \mathrm{L1RdBW_{Bp(Clk{\cdot}XeCore)}} = \mathrm{L1RdBW_{Bp(Clk{\cdot}EU)}} \times \mathrm{|EU|_{perXeCore}} $$

### row 80 - L1 WRITE B EU CLK

$$ \mathrm{L1WrBW_{Bp(Clk{\cdot}EU)}} = \frac{\frac{\mathrm{L1Wr_{B}^{(total)}}}{\mathrm{|EU|}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 78 - L1 WRITE B XECORECLK

$$ \mathrm{L1WrBW_{Bp(Clk{\cdot}XeCore)}} = \mathrm{L1WrBW_{Bp(Clk{\cdot}EU)}} \times \mathrm{|EU|_{perXeCore}} $$

### row 83 - L2 READ MAX B XECORE CLK

$$ \mathrm{L2RdBW_{Bp(Clk{\cdot}XeCore)}^{(max)}} = \frac{\mathrm{|XeCore|_{perXeCU}} \times 64}{\mathrm{|XeCore|_{perXeCU}}} $$

### row 84 - L2 WRITE MAX B XECORE CLK

$$ \mathrm{L2WrBW_{Bp(Clk{\cdot}XeCore)}^{(max)}} = \mathrm{L2RdBW_{Bp(Clk{\cdot}XeCore)}^{(max)}} $$

### row 85 - L2 READ WRITE MAX B XECORE CLK

$$ \mathrm{L2RdWrBW_{Bp(Clk{\cdot}XeCore)}^{(max)}} = \mathrm{L2WrBW_{Bp(Clk{\cdot}XeCore)}^{(max)}} $$

### row 90 - L2 READ B XECORE CLK PCT

$$ \mathrm{\eta_{L2RdBWpXeCore}} = \frac{\mathrm{L2RdBW_{Bp(Clk{\cdot}XeCore)}}}{\mathrm{L2RdBW_{Bp(Clk{\cdot}XeCore)}^{(max)}}} $$

### row 91 - L2 WRITE B XECORE CLK PCT

$$ \mathrm{\eta_{L2WrBWpXeCore}} = \frac{\mathrm{L2WrBW_{Bp(Clk{\cdot}XeCore)}}}{\mathrm{L2WrBW_{Bp(Clk{\cdot}XeCore)}^{(max)}}} $$

### row 92 - L2 READ WRITE B XECORE CLK PCT

$$ \mathrm{\eta_{L2RdWrBWpXeCore}} = \frac{\mathrm{L2RdWrBW_{Bp(Clk{\cdot}XeCore)}}}{\mathrm{L2RdWrBW_{Bp(Clk{\cdot}XeCore)}^{(max)}}} $$

### row 93 - L1 READ B EU CLK PCT

$$ \mathrm{\eta_{L1RdBWpEU}} = \frac{\mathrm{L1RdBW_{Bp(Clk{\cdot}EU)}}}{\mathrm{L1RdBW_{Bp(Clk{\cdot}EU)}^{max}}} $$

### row 94 - L1 WRITE B EU CLK PCT

$$ \mathrm{\eta_{L1WrBWpEU}} = \frac{\mathrm{L1WrBW_{Bp(Clk{\cdot}EU)}}}{\mathrm{L1WrBW_{Bp(Clk{\cdot}EU)}^{max}}} $$

### row 106 - L2 HIT RATE ASSUMED RANDOM ACCESS WITHIN THE WORKING
### DATA SET PCT

$$ \mathrm{L2HitRate_{random\ WS\ access}} = \min(\frac{\mathrm{L2Size_{B}}}{\mathrm{TotalRequiredL2Size_{matB\ always hit}^{1\ instance,\ 1\ wave}}}, 1) $$

### row 107 - L2 MISS RATE PCT

$$ \mathrm{L2MissRate} = 1 - \mathrm{L2HitRate_{random\ WS\ access}} $$

### row 108 - TOTAL L2 READ TRAFFIC B

$$ \mathrm{L2RdB_{total}} = \mathrm{L2Rd_{B}^{(total)}} $$

### row 110 - PROBABILITY OF MATA HIT IN L2 DURING A NON FIRST WAVE
### PCT

$$
\begin{aligned}
\mathrm{P_{L2Hit,\ after\ 1st\ wave}^{(matA)}} &= \mathrm{IF}(\mathrm{Size_{B}^{(matA)}} \\
&\quad + \mathrm{Size_{B}^{(matB)}} \\
&\quad + \mathrm{Size_{B}^{(matC,matD)}} \le \mathrm{L2Size_{B}}, 1.0, \mathrm{IF}(\mathrm{K_{dim}} > 2 \times \mathrm{|WorkingSet|_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)}}, 0.0, 1 \\
&\quad - \frac{\mathrm{K_{dim}} - \mathrm{|WorkingSet|_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)}}}{\mathrm{|WorkingSet|_{20K\ clks\ of\ thread\ divergence}^{(K\ in\ L2)}}}))
\end{aligned}
$$

### row 111 - PROBABILITY OF MATB HIT IN L2 DURING A NON FIRST WAVE
### PCT

$$
\begin{aligned}
\mathrm{P_{L2Hit,\ after\ 1st\ wave}^{(matB)}} &= \mathrm{IF}(\mathrm{Size_{B}^{(matA)}} \\
&\quad + \mathrm{Size_{B}^{(matB)}} \\
&\quad + \mathrm{Size_{B}^{(matC,matD)}} \le \mathrm{L2Size_{B}}, 1.0, 0.0)
\end{aligned}
$$

### row 112 - PROBABILITY OF MATA MISS IN L2 DURING A NON FIRST WAVE
### PCT

$$
\begin{aligned}
\mathrm{P_{L2Miss,\ after\ 1st\ wave}^{(matA)}} &= 1 \\
&\quad - \mathrm{P_{L2Hit,\ after\ 1st\ wave}^{(matA)}}
\end{aligned}
$$

### row 113 - PROBABILITY OF MATB MISS IN L2 DURING A NON FIRST WAVE
### PCT

$$
\begin{aligned}
\mathrm{P_{L2Miss,\ after\ 1st\ wave}^{(matB)}} &= 1 \\
&\quad - \mathrm{P_{L2Hit,\ after\ 1st\ wave}^{(matB)}}
\end{aligned}
$$

### row 116 - TOTAL HBM READ B AFTER A COMPLETION OF A WAVE CONSIDER
### COLD CACHE

$$ \mathrm{MemRdB_{cold\ start}^{(wave)}} = \frac{\left(\mathrm{MemRdB_{cold\ start}^{(wave)}}\right)_{\mathrm{num}}}{2} $$

$$
\begin{aligned}
\left(\mathrm{MemRdB_{cold\ start}^{(wave)}}\right)_{\mathrm{num}} &= \mathrm{Size_{B}^{(matA)}} \\
&\quad + \mathrm{Size_{B}^{(matA)}} \times \left(\mathrm{CEILING}(\frac{\mathrm{N_{dim}}}{\mathrm{W_{element}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss,\ after\ 1st\ wave}^{(matA)}} \\
&\quad + \mathrm{Size_{B}^{(matB)}} \\
&\quad + \mathrm{Size_{B}^{(matB)}} \times \left(\mathrm{CEILING}(\frac{\mathrm{M_{dim}}}{\mathrm{H_{element}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss,\ after\ 1st\ wave}^{(matB)}} \\
&\quad + \left(\left(\mathrm{MemRdB_{cold\ start}^{(wave)}}\right)_{\mathrm{num}}\right)_{\mathrm{aux4}} \times \mathrm{L2MissRate}
\end{aligned}
$$

$$
\begin{aligned}
\left(\left(\mathrm{MemRdB_{cold\ start}^{(wave)}}\right)_{\mathrm{num}}\right)_{\mathrm{aux4}} &= \mathrm{L2RdB_{total}} \\
&\quad - \left(\left(\left(\mathrm{MemRdB_{cold\ start}^{(wave)}}\right)_{\mathrm{num}}\right)_{\mathrm{aux4}}\right)_{\mathrm{aux1}}
\end{aligned}
$$

$$
\begin{aligned}
\left(\left(\left(\mathrm{MemRdB_{cold\ start}^{(wave)}}\right)_{\mathrm{num}}\right)_{\mathrm{aux4}}\right)_{\mathrm{aux1}} &= \mathrm{Size_{B}^{(matA)}} \\
&\quad + \mathrm{Size_{B}^{(matA)}} \times \left(\mathrm{CEILING}(\frac{\mathrm{N_{dim}}}{\mathrm{W_{element}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss,\ after\ 1st\ wave}^{(matA)}} \\
&\quad + \mathrm{Size_{B}^{(matB)}} \\
&\quad + \mathrm{Size_{B}^{(matB)}} \times \left(\mathrm{CEILING}(\frac{\mathrm{M_{dim}}}{\mathrm{H_{element}^{(XeCUTile)}}}, 1) - 1\right) \times \mathrm{P_{L2Miss,\ after\ 1st\ wave}^{(matB)}}
\end{aligned}
$$

### row 117 - TOTAL HBM WRITE B

$$ \mathrm{MemWrB^{(total)}} = \mathrm{Size_{B}^{(matC,matD)}} $$

### row 118 - TOTAL HBM B

$$ \mathrm{MemRdWrB^{(total)}} = \mathrm{MemWrB^{(total)}} + \mathrm{MemRdB_{cold\ start}^{(wave)}} $$

### row 121 - HBM READ B CLK

$$ \mathrm{MemRdBW_{BpClk}} = \frac{\mathrm{MemRdB_{cold\ start}^{(wave)}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 122 - HBM WRITE B CLK

$$ \mathrm{MemWrBW_{BpClk}} = \frac{\mathrm{MemWrB^{(total)}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 123 - HBM TOTAL B CLK

$$ \mathrm{MemRdWrBW_{BpClk}} = \frac{\mathrm{MemRdWrB^{(total)}}}{\mathrm{T_{clk}^{(total)}}} $$

### row 126 - HBM BW PCT

$$ \mathrm{\eta_{MemBW}} = \frac{\mathrm{MemRdWrBW_{BpClk}}}{\mathrm{MemBW_{BpClk}^{max}}} $$

### row 127 - GTI READ BW PCT

$$ \mathrm{\eta_{GTIRdBW}} = \frac{\mathrm{MemRdBW_{BpClk}}}{\mathrm{GtiRdBW_{BpClk}^{max}}} $$

### row 128 - GTI WRITE BW PCT

$$ \mathrm{\eta_{GTIWrBW}} = \frac{\mathrm{MemWrBW_{BpClk}}}{\mathrm{GtiWrBW_{BpClk}^{max}}} $$
