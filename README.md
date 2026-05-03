# gemmanalytics

Standalone GEMM analytics model runner.

## TL;DR (Windows)

Already cloned?

```bash
bootstrap_gemmanalytics.bat
```

New machine?

```bash
git clone https://github.com/cli17/gemmanalytics.git
cd gemmanalytics
bootstrap_gemmanalytics.bat
```

## Quick Start (Windows)

From a fresh machine:

```bash
git clone https://github.com/cli17/gemmanalytics.git
cd gemmanalytics
bootstrap_gemmanalytics.bat
```

What `bootstrap_gemmanalytics.bat` does:

- Runs `setup_gemmanalytics_tools.bat` to verify/install required tools and Python packages
- Runs `run_gemmanalytics.bat` once to validate local setup
- Opens VS Code and `gemmanalytics.py` (if `code` CLI is available)

Optional:

```bash
bootstrap_gemmanalytics.bat --no-run
```

Use `--no-run` to skip the initial generation pass.

## RowID Policy

The model uses RowIDs both for traceability back to the baseline worksheet and for stable CSV/report output ordering.

- Keep original XLSX-aligned parameters on their existing RowIDs.
- `1000-1999`: new machine pre-defined input parameters.
- `2000-2999`: new workload pre-defined input parameters.
- `4000-4999`: new machine/workload-derived extension parameters.
- `5000-5999`: new machine-stats extension parameters.

The default CSV files include a `__NEXT_AVAILABLE_ROW_ID__` tracker row. Update that tracker whenever you consume the current next available ID.

## Files

- `gemmanalytics.py`: standalone analytical model script
- `default_workload_params.csv`: default workload parameters
- `default_machine_params.csv`: default machine parameters
- `default_experiments.csv`: experiment pair selector (machine/workload combinations)

## Input CSV Formats

Workload CSV:

```csv
RowID,Name,Label,Value
```

Machine CSV:

```csv
RowID,Name,Label,TTL1,TTL2
```

Experiments CSV:

```csv
machine cfg,workload cfg
TTL-16Xe,*
TTL-16Xe-MixFmt,i8_i4
```

`*` is a wildcard:

- `machine cfg = *` means all machine columns from the machine CSV.
- `workload cfg = *` means all workload columns from the workload CSV.
- `*,*` is the previous full machine x workload cross-product behavior.

The loader ignores this metadata row if present:

- `__NEXT_AVAILABLE_ROW_ID__`

## Usage

```bash
python gemmanalytics.py --workload-params default_workload_params.csv --machine-params default_machine_params.csv --experiments default_experiments.csv
```

## Standard Regression Test

Run this after every change to `gemmanalytics.py`:

```bash
run_regression_gemmanalytics.bat
```

This repository is configured with a pre-commit hook (`.githooks/pre-commit`) that automatically runs the same regression when a commit includes `gemmanalytics.py`.

What it verifies:

- Regenerates txt, csv, md, and pdf outputs
- Checks key txt/csv/md content markers
- Performs page-by-page bitmap comparison of `EQUATIONS.pdf` vs `backup/EQUATIONS.pdf`

## Improvement And Push Workflow

Use this flow whenever you change model logic, inputs, or output contracts.

1. Sync and branch (or work on `main` if using direct-push workflow).

```bash
git pull
```

2. Make code/data updates.

- Typical files: `gemmanalytics.py`, default CSVs, regression markers, and docs.

3. Regenerate outputs locally.

```bash
run_gemmanalytics.bat
```

4. Run full regression.

```bash
run_regression_gemmanalytics.bat
```

5. If behavior intentionally changed, update baselines.

- Update marker expectations in `regression_check_gemmanalytics.py`.
- Refresh `backup/EQUATIONS.pdf` only when PDF content changes intentionally.

6. Commit with a focused message.

```bash
git add <files>
git commit -m "<clear summary>"
```

7. Push to GitHub.

```bash
git push
```

8. Verify clean local state.

```bash
git status --short
```

Note: If `gemmanalytics_output.xlsx` is open in Excel, writes can fail with `PermissionError`. Close the workbook before rerunning generation/regression.

## Output Order

- `--output-order execution`: 4-section report matching compute execution flow
- `--output-order row_tracking`: xlsx row-tracking order

## Adding A New Machine Parameter

1. Choose a RowID.
Use the original XLSX RowID when the parameter already exists there. Use `1000-1999` for a new machine input extension.

2. Add metadata in `gemmanalytics.py`.
Update `MACHINE_PRE_NAMES`, `ROW_INDEX`, `CATEGORY_MAP`, and `PARAM_DESCRIPTIONS`. Update `COMPUTE_ORDER` if display order should change.

3. Use the parameter in `compute_core_values()`.
Read it from `machine_params[...]` and propagate it into any affected formulas.

4. Add the new row to `default_machine_params.csv`.
Fill in one value per machine column.

5. Advance `__NEXT_AVAILABLE_ROW_ID__`.

## Adding A New Workload Parameter

1. Choose a RowID.
Use the original XLSX RowID when the parameter already exists there. Use `2000-2999` for a new workload input extension.

2. Add metadata in `gemmanalytics.py`.
Update `FORMAT_KEY_NAMES` or `WORKLOAD_PRE_NAMES`, `ALL_WORKLOAD_PRE_NAMES`, `ROW_INDEX`, `CATEGORY_MAP`, and `PARAM_DESCRIPTIONS`. Update `COMPUTE_ORDER` if display order should change.

3. Use the parameter in `compute_core_values()`.
Read it from `workload_params[...]` and propagate it into any affected formulas.

4. Add the new row to `default_workload_params.csv`.

5. Advance `__NEXT_AVAILABLE_ROW_ID__`.

## Notes

This repository is the standalone runtime/product copy.
The original generated script in the converter workspace is kept separately for tracing and regeneration.
