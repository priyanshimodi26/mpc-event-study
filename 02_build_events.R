# 02_build_events.R
# Build the meeting calendar join, surprise measures, and event windows.
#
# TODO:
#  - read data/derived/meetings.csv and data/derived/series_long.csv
#  - pre-event close, day 0 close, day +2 close for each meeting
#  - changes in bp (yields) and log returns (FX, equities); NBFC basket excess return
#  - surprises: consensus (bp), OIS, stance dummy
#  - placebo table on non-meeting days
#  - write data/derived/event_table.csv and data/derived/placebo_table.csv
