# Future Session Quick Context

- Main workflow: edit machine/workload/experiments CSVs, run run_gemmanalytics.bat, review txt/csv/xlsx/md/pdf outputs.
- CSV output is raw precision (no display rounding); XLSX is the formatted human-readable view with numeric cell types.
- Regression command: run_regression_gemmanalytics.bat (includes PDF bitmap compare against backup/EQUATIONS.pdf).
- Common blocker: Excel lock on gemmanalytics_output.xlsx causes PermissionError during save.
- Keep regression markers and backup/EQUATIONS.pdf aligned with intentional output-contract changes.
- If outputs/formulas change intentionally, regenerate and refresh baselines before push.
