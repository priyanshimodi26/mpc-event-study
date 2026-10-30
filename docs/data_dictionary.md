# Market data dictionary

This file records the series used alongside RBI MPC announcements. Meeting dates, rates, and stance codes are defined in [`meetings_coding_rules.md`](meeting_coding_rules.md).

| series_id | Description | Ticker / source | Field | Frequency | Units | Found via | Pull date | Observation time / timezone | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| repo_rate | RBI policy repo rate announced at each meeting | [`meetings.csv`](../data/derived/meetings.csv) (`repo_after (%)`) | — | Event | % | RBI release | — | `announcement_time_ist` | Use the coded announcement series; Bloomberg may be used to cross-check. |
| repo_consensus | Pre-announcement economist survey median for the repo decision | ECO, India RBI repo release (verify) | Confirm in FLDS | Event | % | ECO |  | Survey timestamp in IST:  | Keep only a consensus available before the announcement; otherwise leave missing. Record survey source and cutoff. |
| ois_1m | INR overnight indexed swap, 1 month | Verify in SECF | `PX_LAST` (verify) | Daily | % | SECF / WIRP |  |  | Confirm instrument, quote convention, and history. |
| ois_3m | INR overnight indexed swap, 3 months | Verify in SECF | `PX_LAST` (verify) | Daily | % | SECF / WIRP |  |  | Confirm instrument, quote convention, and history. |
| gsec_2y | India government generic 2-year yield | Verify in SECF | `PX_LAST` (verify) | Daily | % | SECF |  |  | Confirm benchmark definition. |
| gsec_5y | India government generic 5-year yield | Verify in SECF | `PX_LAST` (verify) | Daily | % | SECF |  |  | Confirm benchmark definition. |
| gsec_10y | India government generic 10-year yield | `GIND10YR Index` (verify) | `PX_LAST` (verify) | Daily | % | SECF |  |  | Confirm benchmark definition. |
| tbill_91d | India 91-day Treasury bill yield | Verify in SECF | `PX_LAST` (verify) | Daily | % | SECF |  |  | Confirm quote convention. |
| usdinr | USD/INR spot | `USDINR Curncy` (verify) | `PX_LAST` (verify) | Daily | INR per USD | SECF |  |  | Record the fixing or close used. |
| nifty | Nifty 50 index | `NIFTY Index` (verify) | `PX_LAST` (verify) | Daily | Index points | SECF |  |  | Record exchange close and calendar. |
| nifty_bank | Nifty Bank index | `NSEBANK Index` (verify) | `PX_LAST` (verify) | Daily | Index points | SECF |  |  | Record exchange close and calendar. |
| nbfc_1 | First chosen listed NBFC | Verify in SECF | `PX_LAST` (verify) | Daily | INR | SECF |  |  | Replace this template with one row per constituent; record inclusion rule and membership dates. |
| us10y | US 10-year Treasury yield | `USGG10YR Index` (verify) | `PX_LAST` (verify) | Daily | % | SECF |  |  | Global control; record US observation time and calendar. |
| india_vix | India VIX | Verify in SECF | `PX_LAST` (verify) | Daily | Index points | SECF |  |  | Record exchange close and calendar. |

## Collection and timing rules

1. Record the exact ticker, Bloomberg field, definition, download date, and observation time for every selected series. State the timezone and whether `PX_LAST` represents a close, fixing, or another observation for that instrument.
2. Do not use a consensus estimate published or updated after the MPC announcement. Record its pre-announcement timestamp and leave `repo_consensus` missing if no suitable survey exists. A rate surprise, if used, is `repo_after (%) − repo_consensus`; keep its unit explicit.
3. Derive the trading event date separately for each market from `announcement_date` and `announcement_time_ist`. For daily data, an announcement after that market's observation time, on a weekend, or on its holiday maps to the next available trading observation. Document the calendar and cutoff used.
4. Distinguish a holiday or market closure from a missing quote. Never fill a missing observation with the previous value without documenting and justifying the rule. Check coverage around every event before analysis.
5. Record yield and OIS changes in basis points (`100 ×` the difference between percentage quotes). Define price, index, and FX returns separately; state whether simple or log returns are used. Keep the direction of USD/INR explicit: a higher quote means more INR per USD.
6. Finalize the NBFC basket before testing outcomes. List each security on its own row with its ticker, inclusion criteria, and membership dates; avoid selecting constituents using information unavailable at the event date.
