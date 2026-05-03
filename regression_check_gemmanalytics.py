"""Regression checks for gemmanalytics outputs.

Checks:
- Required artifacts exist (.txt, .csv, .md, .pdf)
- Key text markers are present in txt/csv/md
- PDF is bitmap-identical to backup PDF at fixed DPI
"""

from __future__ import annotations

from pathlib import Path
import sys

import numpy as np
import pypdfium2 as pdfium


ROOT = Path(__file__).resolve().parent
TXT_PATH = ROOT / "gemmanalytics_output.txt"
CSV_PATH = ROOT / "gemmanalytics_output.csv"
MD_PATH = ROOT / "EQUATIONS.md"
PDF_PATH = ROOT / "EQUATIONS.pdf"
PDF_BACKUP_PATH = ROOT / "backup" / "EQUATIONS.pdf"


def fail(msg: str) -> int:
    print(f"[FAIL] {msg}")
    return 1


def ensure_exists(path: Path) -> bool:
    display = path.relative_to(ROOT) if path.is_absolute() else path
    if not path.exists():
        print(f"[FAIL] Missing required file: {display}")
        return False
    print(f"[OK] Found {display}")
    return True


def check_text_contains(path: Path, markers: list[str]) -> bool:
    text = path.read_text(encoding="utf-8")
    ok = True
    for marker in markers:
        if marker not in text:
            print(f"[FAIL] {path.name}: missing marker -> {marker}")
            ok = False
    if ok:
        print(f"[OK] {path.name}: all markers found")
    return ok


def compare_pdf_bitmaps(path_a: Path, path_b: Path, dpi: int = 300) -> bool:
    scale = dpi / 72.0
    doc_a = pdfium.PdfDocument(str(path_a))
    doc_b = pdfium.PdfDocument(str(path_b))

    pages_a = len(doc_a)
    pages_b = len(doc_b)
    if pages_a != pages_b:
        print(f"[FAIL] PDF page count mismatch: {pages_a} vs {pages_b}")
        return False

    for i in range(pages_a):
        img_a = doc_a[i].render(scale=scale).to_numpy()
        img_b = doc_b[i].render(scale=scale).to_numpy()

        if img_a.shape != img_b.shape:
            print(f"[FAIL] PDF page {i + 1}: size mismatch {img_a.shape} vs {img_b.shape}")
            return False

        diff_pixels = int(np.any(img_a != img_b, axis=2).sum())
        if diff_pixels != 0:
            total = img_a.shape[0] * img_a.shape[1]
            pct = (diff_pixels / total) * 100.0
            print(
                f"[FAIL] PDF page {i + 1}: bitmap differs "
                f"({diff_pixels}/{total} pixels, {pct:.6f}%)"
            )
            return False

    print(f"[OK] PDF bitmap compare passed ({pages_a} pages, {dpi} DPI)")
    return True


def main() -> int:
    ok = True

    required = [TXT_PATH, CSV_PATH, MD_PATH, PDF_PATH, PDF_BACKUP_PATH]
    for p in required:
        ok = ensure_exists(p) and ok

    if not ok:
        return 1

    ok = (
        check_text_contains(
            TXT_PATH,
            [
                "[1] MACHINE PARAMETERS (PRE-DEFINED)",
                "[4] MACHINE STATS",
                "HBM_BW_PCT = 24.76%",
            ],
        )
        and ok
    )

    ok = (
        check_text_contains(
            CSV_PATH,
            [
                "Name,Category,RowID,Description,TTL-16Xe | i8_i4,TTL-16Xe | fp8_fp4,TTL-16Xe | fp8,TTL-16Xe | fp4,TTL-16Xe-MixFmt | i8_i4",
                "GT_FREQ_GHZ,machine pre,8,GT Freq (GHz),1.9,1.9,1.9,1.9,1.9",
                "MIXED_PRECISION_DPAS,machine pre,1000,native DPAS mixed-precision support,0,0,0,0,1",
            ],
        )
        and ok
    )

    ok = (
        check_text_contains(
            MD_PATH,
            [
                "# GEMM Analytical Model - Equations",
                "## Machine Parameters (Pre-Defined)",
                "[row 8] GT Freq (GHz)",
                "[row 1000] native DPAS mixed-precision support",
            ],
        )
        and ok
    )

    ok = compare_pdf_bitmaps(PDF_PATH, PDF_BACKUP_PATH) and ok

    if ok:
        print("[PASS] Regression checks passed")
        return 0

    return fail("Regression checks failed")


if __name__ == "__main__":
    raise SystemExit(main())
