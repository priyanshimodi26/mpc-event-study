# RBI MPC Surprise Event Study

How do Indian government bond yields, the rupee, and bank and NBFC stocks react when the Reserve Bank of India's Monetary Policy Committee (MPC) surprises the market?

**Status:** in progress (started October 2026). Results will be added here when the analysis is complete.

**Tools:** Bloomberg Terminal (Excel add-in downloads), R, Stata, Quarto.

---

## Research question

When the RBI's rate decision or guidance differs from what the market expected, how far do the following move around the announcement, and does the reaction differ by instrument?

- G-sec yields at different maturities (short end versus long end)
- OIS rates
- USD/INR
- Bank equities (Nifty Bank)
- NBFC equities, relative to the Nifty

## Hypotheses

1. A hawkish surprise raises short-tenor yields by more than long-tenor yields (curve flattening).
2. A hawkish surprise lowers bank and NBFC returns relative to the Nifty, with a larger effect for NBFCs.
3. The rupee reaction is smaller and less consistent than the rates reaction.
4. Changes in stance or guidance move longer tenors even when the rate decision is in line.

## Approach

- **Sample:** MPC meetings from October 2016 to the latest meeting (about 60 events, including off-cycle meetings).
- **Surprise measures:**
  1. *Consensus surprise:* actual decision minus the Bloomberg economist survey median, in basis points.
  2. *Market-implied surprise:* change in short-dated INR OIS rates across the announcement.
  3. *Stance surprise:* a dummy for a change in stance or guidance (+1 tighter, -1 looser, 0 none), coded by hand using the rules in `docs/stance_coding_rules.md`.
- **Event windows:** pre-event close to day 0 close, and to day +2 close. A placebo comparison uses the same windows on non-meeting days.
- **Estimation:** regressions of each outcome's change on the surprise, with a control for the same-day change in US 10-year yields, Newey-West standard errors and bootstrap confidence intervals. Robustness checks drop off-cycle meetings, swap surprise measures and split the sample around the 2022 tightening cycle.
- **Replication:** the headline regression is run in both Stata and R.

## Data

| Series | Source | In this repo? |
| --- | --- | --- |
| Economist survey consensus, OIS, G-sec yields, USD/INR, equity indices, NBFC prices, global controls | Bloomberg Terminal (downloaded through the Excel add-in) | No. Licensed data is not committed. |
| MPC dates, decisions and policy statements | RBI website | Yes, in `data/derived/meetings.csv` |
| Policy rates and benchmark yields (public fallback) | RBI DBIE, FBIL | Yes, in `data/public/` |
| Surprise series, event table, regression results | Derived by this project | Yes, in `data/derived/` and `output/` |

Every Bloomberg ticker, field and terminal function used is listed in [`docs/data_dictionary.md`](docs/data_dictionary.md), and each download is recorded in [`bloomberg/pull_log.md`](bloomberg/pull_log.md).

## Repository structure

```text
mpc-event-study/
├── README.md
├── LICENSE
├── .gitignore                  excludes data/raw/ and Bloomberg workbooks
├── bloomberg/
│   └── pull_log.md             date, series, settings and issues for each download
├── 01_import_exports.R         reads the CSV exports, checks them, writes tidy files
├── 02_build_events.R           meeting calendar, surprises, event windows
├── 03_analysis.do              Stata regressions, HAC errors, tables
├── 04_figures.R                figures for the note
├── 05_replicate_in_R.R         headline regression replicated in R
├── note.qmd                    research note (Quarto)
├── data/
│   ├── raw/                    value-only CSV exports from the terminal (not committed)
│   ├── public/                 public RBI and FBIL files
│   └── derived/                meeting calendar, event table, results
├── docs/
│   ├── data_dictionary.md      every ticker, field and function used
│   └── stance_coding_rules.md  rules for the stance dummy
└── output/
    ├── tables/                 Stata and R tables
    └── figures/                PNG and PDF figures
```

## Requirements

- **R** 4.3 or later, with the packages `tidyverse`, `lubridate`, `readxl`, `haven`, `sandwich`, `lmtest`, `boot`, `fixest`, `ggplot2` and `renv`
- **Stata** 17 or later, with the SSC packages `estout` and `coefplot` (`ssc install estout` and `ssc install coefplot`)
- **Quarto** for the note
- **Bloomberg Terminal with the Excel add-in**, only needed to download the raw data

## How to reproduce

1. Clone the repo and open the project folder in RStudio and Stata (set the working directory to the project root).
2. Restore the R packages with `renv::restore()`.
3. **With a Bloomberg terminal:** download each series listed in `docs/data_dictionary.md` using the Excel add-in (`=BDH()`), paste as values, and save one CSV per series as `data/raw/{series_id}_{YYYYMMDD}.csv`.
   **Without a terminal:** use the public RBI and FBIL files in `data/public/`. Results that depend on the survey consensus and OIS data cannot be reproduced without Bloomberg.
4. Run the scripts in order:
   1. `01_import_exports.R`
   2. `02_build_events.R`
   3. `03_analysis.do` (in Stata)
   4. `04_figures.R`
   5. `05_replicate_in_R.R`
5. Render the note with `quarto render note.qmd`.

## Project status

- [ ] Meeting calendar built and verified (`data/derived/meetings.csv`)
- [ ] Stance coding rules written and applied
- [ ] Data dictionary completed
- [ ] Bloomberg data downloaded and spot-checked
- [ ] Event table and surprise measures built
- [ ] Baseline event study (Stata)
- [ ] Bank and NBFC results
- [ ] Intraday section (if data is available)
- [ ] Robustness checks and R replication
- [ ] Research note drafted
- [ ] Note, README and results finalised, release tagged

## Limitations

These will be updated with the final results. Known issues to address:

- About 60 meetings, and most decisions are "no change", so surprise measures have little variation and some estimates will be imprecise.
- Announcement times have varied over the sample, so the daily windows may include other same-day news.
- Intraday data is available only for recent meetings.
- An event study shows association around the announcement, not a full causal effect.

## Data and licensing

Bloomberg data is licensed and is not included in this repository. Only derived outputs (surprise series, regression results, charts) are published, subject to the terms of the data provider. The code is released under the MIT licence. Data files remain subject to their original sources' terms.

## Author

Priyanshi Modi, BITS Pilani, Goa Campus (M.Sc. Economics and B.E. Computer Science). GitHub: [priyanshimodi26](https://github.com/priyanshimodi26)
