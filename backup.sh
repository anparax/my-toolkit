#!/usr/bin/env bash
#
# backup.sh - compress folder into a .tag.gz archive
#
#
# ./backup.sh <folder-to-backup> [destination-folder]
#

set -euo pipefail

SOURCE="${1:-}"
DEST="${2:-.}"

if [[ -z "$SOURCE" ]]; then
    echo "Usage: $0 <folder-to-backup> [destination-folder]"
    exit 1
fi

if [[ ! -d "$SOURCE" ]]; then
    echo "Error: '$SOURCE' is not a valid directory."
    exit 1
fi

mkdir -p "$DEST"

FOLDER_NAME="$(basename "$SOURCE")"
TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"
ARCHIVE_NAME="${FOLDER_NAME}_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${DEST}/${ARCHIVE_NAME}"

echo "Backing up '$SOURCE' -> '$ARCHIVE_PATH' ..."
tar -czf "$ARCHIVE_PATH" -C "$(dirname "$SOURCE")" "$FOLDER_NAME"

echo "Done. Archive size: $(du -h "$ARCHIVE_PATH" | cut -f1)"
