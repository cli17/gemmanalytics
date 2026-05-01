# gemmanalytics

Standalone GEMM analytics model runner.

## Files

- `gemmanalytics.py`: standalone analytical model script
- `default_workload_params.csv`: default workload parameters
- `default_machine_params.csv`: default machine parameters

## Usage

```bash
python gemmanalytics.py --workload-params default_workload_params.csv --machine-params default_machine_params.csv
```

## Output Order

- `--output-order execution`: 4-section report matching compute execution flow
- `--output-order row_tracking`: xlsx row-tracking order

## Notes

This repository is the standalone runtime/product copy.
The original generated script in the converter workspace is kept separately for tracing and regeneration.
