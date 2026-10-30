# Meetings coding rules

Apply these rules consistently when adding or revising a row in `meetings.csv`. One row is one publicly announced RBI MPC policy decision, including an off-cycle decision. Use the meeting-specific RBI release in `source_url` as the primary source.

## Coding

| Field | Rule |
| --- | --- |
| `meeting_id` | Unique integer in announcement order. Keep existing IDs stable when correcting a row. |
| `meeting_start_date`, `meeting_end_date` | First and last meeting dates, in `DD-MM-YYYY`. Record nonconsecutive meeting days in `notes`. |
| `announcement_date` | Date of the public decision announcement, in `DD-MM-YYYY`, even when it equals the meeting end date. |
| `announcement_time_ist` | Verified announcement time in IST, 24-hour `HH:MM`. Leave blank and explain in `notes` if unverified. |
| `scheduled` | `1` for a regular meeting, including one rescheduled from the original calendar; `0` for an off-cycle meeting. |
| `meeting_type` | `regular`, `regular_rescheduled`, `offcycle`, or `offcycle_advanced`. Use `offcycle_advanced` when an unscheduled decision was brought forward from a regular meeting. |
| `repo_before (%)`, `repo_after (%)` | Policy repo rates immediately before and as announced at the meeting, expressed in percent. |
| `change_bp` | `100 × (repo_after − repo_before)`, as a signed integer: cut negative, hike positive, unchanged `0`. |
| `stance_before`, `stance_after` | Stance immediately before and as announced at the meeting. Use the existing labels: `Accommodative`, `Neutral`, `Calibrated Tightening`, `Withdrawal of Accommodation`. |
| `stance_change_code` | `+1` for a tighter stance, `0` for no change, `-1` for a looser stance. This records direction, not size. Use the transition table below. |
| `source_url` | Meeting-specific RBI policy release supporting the coded decision. |
| `notes` | Briefly record unusual scheduling, nonconsecutive dates, nuanced wording, or another judgement call; otherwise leave blank. |

### Stance transition codes

| Before → after | Code |
| --- | ---: |
| Accommodative → Neutral | `+1` |
| Neutral → Calibrated Tightening | `+1` |
| Accommodative → Withdrawal of Accommodation | `+1` |
| Calibrated Tightening → Neutral | `-1` |
| Neutral → Accommodative | `-1` |
| Withdrawal of Accommodation → Neutral | `-1` |
| Same label → same label | `0` |

## Rules for ambiguous cases

1. A rescheduled regular meeting remains `scheduled = 1` and has `meeting_type = regular_rescheduled`. An off-cycle meeting has `scheduled = 0`; distinguish `offcycle_advanced` from `offcycle` using the RBI announcement.
2. Code the stated stance label and record any qualifying guidance in `notes`. If wording suggests a new transition absent from the table, read the release and log the decision before assigning a direction.
3. Do not infer an announcement time from the usual schedule. Keep the announcement date and time as published; derive any market-specific trading event date later, using that market's trading hours and calendar.
4. Do not treat `change_bp` as an unexpected policy surprise. The rate action and stance direction are separate variables; either can change without the other.

## Log of judgement calls

| Announcement date | Wording or circumstance | Code or treatment | Why |
| --- | --- | --- | --- |
| 27-03-2020 | MPC met on 24, 26 and 27 March | `offcycle_advanced`; actual days in `notes` | Start/end dates alone do not show the gap. |
| 08-04-2022 | Accommodative stance retained with focus on withdrawal | `stance_change_code = 0`; qualifier in `notes` | Stated stance remained Accommodative. |
| 04-05-2022 | Same stance wording at an off-cycle decision; meeting on 2 and 4 May | `offcycle`, `stance_change_code = 0`; days and qualifier in `notes` | Rate change does not itself change the stance code. |
| 08-06-2022 | Stance changed to Withdrawal of Accommodation | `stance_change_code = +1` | First coded change from Accommodative to that stance. |
