\# System 2 — API + Database Integrity Report



\## Executive Summary

Ran a full API journey (Register → Login → Get → Update → List → Delete) against 

reqres.in, followed by 8 SQL data-integrity checks against the Chinook reference 

database. All 13 API tests passed; all integrity queries confirmed a clean dataset 

with correct auth, idempotency, and referential integrity behavior.



\## Scope

\- API: Authentication, CRUD lifecycle, request chaining, negative/idempotency testing

\- Database: Referential integrity, duplicate detection, business-rule validation, 

&#x20; fraud-review sampling

\- Out of scope: Load testing, multi-region replication testing



\## API Journey Results (13 requests)

| # | Request | Status | Result |

|---|---|---|---|

| 1 | Register User | 200 | PASS |

| 2 | Login User | 200 | PASS |

| 3 | Get Profile | 200 | PASS |

| 4 | Update Profile | 200 | PASS |

| 5 | List Users | 200 | PASS |

| 6 | Delete Account | 204 | PASS |

| 7 | Get Profile (No Auth) | 401 | PASS (correctly rejected) |

| 8 | Get Profile (Invalid Key) | 403 | PASS (correctly rejected) |

| 9 | Create User (Chaining) | 201 | PASS |

| 10 | Get Chained User | 404 | Expected — see RCA Finding 1 |

| 11 | Delete Chained User (1st + 2nd call) | 204 / 204 | PASS (idempotent) |

| 12 | Register Missing Password | 400 | PASS (validation works) |

| 13 | Delete Non-Existent User | 204 | PASS (graceful handling) |



\## SQL Integrity Query Results (8 queries)

| # | Check | Result |

|---|---|---|

| 1 | Orphaned Invoices | 0 rows — PASS |

| 2 | Negative/Zero Totals | 0 rows — PASS |

| 3 | Duplicate Customer Emails | 0 rows — PASS |

| 4 | Invoice-Customer Join Accuracy | 10/10 correct — PASS |

| 5 | Customer Distribution by Country | Reasonable spread — PASS |

| 6 | High-Volume Customer Flag | 0 rows — PASS |

| 7 | Non-Purchasing Customers | 0 rows — PASS |

| 8 | Top 5 Highest Invoices | Sampled, no outliers — PASS |



\## Key Findings

1\. Mock API (reqres.in) doesn't persist created records — a known simulated-backend 

&#x20;  limitation, not a defect (see rca-log.md).

2\. DELETE endpoint is correctly idempotent — repeat calls don't error.

3\. Auth layer correctly distinguishes missing (401) vs invalid (403) credentials.

4\. Chinook dataset shows zero referential integrity violations across all 5 

&#x20;  structural checks — confirms both data quality and query correctness.



\## Go/No-Go Recommendation

\*\*GO.\*\* API authentication, CRUD lifecycle, and idempotency behavior all meet 

expected standards. Database integrity queries are validated and reusable against 

production data. No blocking defects found; one documented mock-API limitation 

noted for awareness, not action.

