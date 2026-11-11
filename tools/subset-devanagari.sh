#!/usr/bin/env bash
# Subsets Noto Sans Devanagari down to the glyphs the site actually uses.
#
# IMPORTANT: the subset only contains the characters in devanagari-glyphs.txt.
# If you add new Devanagari copy to the site, add those characters to that file
# and re-run this script, or the new text will render in a fallback font.
#
# Requires fonttools:  pip install fonttools brotli
set -euo pipefail
cd "$(dirname "$0")/.."

SRC="node_modules/@fontsource-variable/noto-sans-devanagari/files/noto-sans-devanagari-devanagari-wght-normal.woff2"
OUT="public/fonts/noto-sans-devanagari-subset-wght-normal.woff2"

pyftsubset "$SRC" \
  --output-file="$OUT" \
  --flavor=woff2 \
  --text-file=tools/devanagari-glyphs.txt \
  --layout-features='*' \
  --no-hinting \
  --desubroutinize

echo "wrote $OUT ($(wc -c < "$OUT") bytes)"
