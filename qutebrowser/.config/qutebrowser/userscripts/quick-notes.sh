#!/usr/bin/env bash
#
# Qutebrowser userscript to add selected text to quick notes file.
# Adds selected text to $NOTES_DIR/quick-notes.md with timestamp header.
#
NOTES_DIR="$HOME/notes"

# Check if text is selected
if [ -z "$QUTE_SELECTED_TEXT" ]; then
  echo "message-warning 'No text selected'" >> "$QUTE_FIFO"
  exit 0
fi

# Check if NOTES_DIR is set
if [ -z "$NOTES_DIR" ]; then
  echo "message-error 'NOTES_DIR environment variable not set'" >> "$QUTE_FIFO"
  exit 0
fi

# Create the notes file path
notes_file="$NOTES_DIR/quick-note.md"

# Create notes directory if it doesn't exist
mkdir -p "$NOTES_DIR"

# Generate timestamp header
timestamp=$(date "+%d.%m.%Y %H:%M:%S")
header="## $timestamp - from qutebrowser"

# Append to the notes file
{
    echo "$header"
    echo ""
    echo "$QUTE_SELECTED_TEXT"
    echo ""
} >> "$notes_file"

# Check if write was successful
if [ $? -eq 0 ]; then
  echo "message-info 'Added note to $notes_file'" >> "$QUTE_FIFO"
else
  echo "message-error 'Error writing to the quick notes file $notes_file'" >> "$QUTE_FIFO"
  exit 1
fi
