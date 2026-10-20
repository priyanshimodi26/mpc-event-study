# 01_import_exports.R
# Read the value-only CSV exports from data/raw/, check them, and write tidy files.
# Run from the project root.
#
# TODO:
#  - read each CSV, rename columns to date and value, parse dates
#  - check row counts, first/last dates, gaps longer than 5 days
#  - stack into one long table (series_id, date, value)
#  - write to data/derived/series_long.csv
