# gemmanalytics

Standalone GEMM analytics model runner.

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

## Input CSV Formats

Workload CSV:

```csv
RowID,Name,Label,Value
```

Machine CSV:

```csv
RowID,Name,Label,TTL1,TTL2
```

The loader ignores these metadata rows if present:

- `__ROW_ID_POLICY_1__` through `__ROW_ID_POLICY_4__`
- `__NEXT_AVAILABLE_ROW_ID__`

## Usage

```bash
python gemmanalytics.py --workload-params default_workload_params.csv --machine-params default_machine_params.csv
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
