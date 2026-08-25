#!/usr/bin/env bash
# Prints the sha256 of a published slopengine macOS release tarball so it can
# be pasted into Casks/slopengine.rb.
#
# Usage: scripts/checksum.sh 0.6.4
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "usage: $0 <version>" >&2
    exit 1
fi

version="$1"
url="https://github.com/slopnode/engine/releases/download/v${version}/slopengine-osx-arm64-v${version}.tar.gz"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

curl -sfL "$url" -o "$tmp"
shasum -a 256 "$tmp" | awk '{print $1}'
