#!/usr/bin/env bash
# Subsets each face to the IAST diacritics the site uses, so transliterated
# Sanskrit (Kaaladarshi, pratyaksa, anumana) renders in the real typeface
# instead of falling back to a system font.
#
# The base latin subsets do not cover Latin Extended-A or Latin Extended
# Additional, and shipping the full latin-ext cuts would add ~192KB for about
# thirty glyphs.
#
# IMPORTANT: if you add IAST characters not in iast-glyphs.txt, add them there
# and re-run this, or they will fall back.
#
# Requires fonttools:  pip install fonttools brotli
set -euo pipefail
cd "$(dirname "$0")/.."

sub () {
  local src="$1" out="$2"
  pyftsubset "$src" \
    --output-file="public/fonts/$out" \
    --flavor=woff2 \
    --text-file=tools/iast-glyphs.txt \
    --layout-features='*' \
    --no-hinting \
    --desubroutinize
  printf '  %-46s %s bytes\n' "$out" "$(wc -c < "public/fonts/$out")"
}

V=node_modules/@fontsource-variable
M=node_modules/@fontsource/ibm-plex-mono/files

sub "$V/archivo/files/archivo-latin-ext-wght-normal.woff2"              archivo-iast-wght-normal.woff2
sub "$V/inter/files/inter-latin-ext-wght-normal.woff2"                  inter-iast-wght-normal.woff2
sub "$V/source-serif-4/files/source-serif-4-latin-ext-wght-normal.woff2" source-serif-4-iast-wght-normal.woff2
sub "$M/ibm-plex-mono-latin-ext-400-normal.woff2"                       ibm-plex-mono-iast-400-normal.woff2
sub "$M/ibm-plex-mono-latin-ext-500-normal.woff2"                       ibm-plex-mono-iast-500-normal.woff2
