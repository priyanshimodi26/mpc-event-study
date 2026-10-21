# Data dictionary

Confirm every ticker and field in SECF and FLDS before downloading. Example tickers are starting points, not verified.

| series_id | Description | Ticker | Field | Frequency | Units | Found via | Pull date | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| repo_rate | RBI policy repo rate | (search "RBI repo" in SECF) | PX_LAST | Event | % | SECF |  |  |
| repo_consensus | Economist survey median, repo rate | (ECO, India RBI repo rate release) | (confirm in FLDS) | Event | % | ECO |  |  |
| ois_1m | INR OIS, 1 month | (SECF) | PX_LAST | Daily | % | SECF / WIRP |  |  |
| ois_3m | INR OIS, 3 months | (SECF) | PX_LAST | Daily | % | SECF / WIRP |  |  |
| gsec_2y | India govt generic 2-year yield | (SECF) | PX_LAST | Daily | % | SECF |  |  |
| gsec_5y | India govt generic 5-year yield | (SECF) | PX_LAST | Daily | % | SECF |  |  |
| gsec_10y | India govt generic 10-year yield | GIND10YR Index | PX_LAST | Daily | % | SECF |  |  |
| tbill_91d | 91-day T-bill yield | (SECF) | PX_LAST | Daily | % | SECF |  |  |
| usdinr | USD/INR spot | USDINR Curncy | PX_LAST | Daily | INR per USD | SECF |  |  |
| nifty | Nifty 50 index | NIFTY Index | PX_LAST | Daily | Index points | SECF |  |  |
| nifty_bank | Nifty Bank index | NSEBANK Index | PX_LAST | Daily | Index points | SECF |  |  |
| nbfc_1 ... nbfc_n | Listed NBFCs in the basket | (SECF) | PX_LAST | Daily | INR | SECF |  | List constituents here |
| us10y | US 10-year Treasury yield | USGG10YR Index | PX_LAST | Daily | % | SECF |  | Global control |
| india_vix | India VIX | (SECF) | PX_LAST | Daily | Index points | SECF |  | Control |
