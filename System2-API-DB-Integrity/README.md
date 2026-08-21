# System 2 — API + Database Integrity Testing

[![Status](https://img.shields.io/badge/status-complete-brightgreen)]()
[![API Tests](https://img.shields.io/badge/API%20tests-13%2F13%20passed-success)]()
[![SQL Checks](https://img.shields.io/badge/SQL%20integrity%20checks-8%2F8%20passed-success)]()
[![Recommendation](https://img.shields.io/badge/recommendation-GO-brightgreen)]()

> Part of the **AI-Driven QA Portfolio** — end-to-end API testing combined with SQL-based database integrity validation, backed by root-cause analysis for every non-trivial result.

---

## 📌 Overview

This project simulates a real-world QA workflow that spans two layers of a system:

1. **API Layer** — A full user lifecycle (Register → Login → Get → Update → List → Delete) tested against [reqres.in](https://reqres.in), including auth, chaining, negative, and idempotency scenarios.
2. **Database Layer** — 8 targeted SQL integrity queries run against the **Chinook** reference database to check for referential integrity, duplicates, business-rule violations, and fraud-review signals.

Every unexpected or noteworthy result is backed by a documented **5-Whys Root Cause Analysis**, not just a pass/fail label — reflecting how a QA engineer would actually investigate anomalies in a production environment.

## ✅ Final Result

| Layer | Checks Run | Passed | Notes |
|---|---|---|---|
| API | 13 | 13 | 1 expected mock-API behavior (see RCA) |
| SQL / Database | 8 | 8 | Clean dataset, all queries production-ready |

**Recommendation: 🟢 GO** — No blocking defects. See [`integrity-report.md`](./integrity-report.md) for full details.

---

## 📁 Project Structure

```
System2-API-DB-Integrity/
├── README.md                 → You are here
├── integrity-report.md       → Full test report (API + SQL results, Go/No-Go call)
├── rca-log.md                → 5-Whys root cause analysis for key findings
├── sql-queries.sql           → All 8 SQL integrity queries + inline results
└── screenshots/              → Evidence captures for every test step
    ├── system2-01-register-user.png
    ├── system2-02-login-user.png
    ├── system2-03-get-profile.png
    ├── system2-04-update-profile.png
    ├── system2-05-list-users.png
    ├── system2-06-delete-account.png
    ├── system2-07-get-profile-no-auth.png
    ├── system2-08-get-profile-invalid-key.png
    ├── system2-09-create-user-chaining.png
    ├── system2-10-get-chained-user-404.png
    ├── system2-11a-delete-chained-user-first-call.png
    ├── system2-11b-delete-chained-user-idempotency.png
    ├── system2-12-register-missing-password.png
    ├── system2-13-delete-nonexistent-user.png
    ├── system2-sql-00a-customer-structure.png
    ├── system2-sql-00b-invoice-structure.png
    ├── system2-sql-q1-orphaned-invoices.png
    ├── system2-sql-q2-negative-totals.png
    ├── system2-sql-q3-duplicate-emails.png
    ├── system2-sql-q4-invoice-customer-join.png
    ├── system2-sql-q5-country-count.png
    ├── system2-sql-q6-high-volume-customers.png
    ├── system2-sql-q7-never-purchased.png
    └── system2-sql-q8-top5-highest-invoices.png
```

---

## 🧪 API Testing — 13 Requests

Tested the full CRUD lifecycle plus negative and edge cases against reqres.in using Postman.

| # | Request | Status | Result |
|---|---|---|---|
| 1 | Register User | 200 | ✅ PASS |
| 2 | Login User | 200 | ✅ PASS |
| 3 | Get Profile | 200 | ✅ PASS |
| 4 | Update Profile | 200 | ✅ PASS |
| 5 | List Users | 200 | ✅ PASS |
| 6 | Delete Account | 204 | ✅ PASS |
| 7 | Get Profile (No Auth) | 401 | ✅ PASS — correctly rejected |
| 8 | Get Profile (Invalid Key) | 403 | ✅ PASS — correctly rejected |
| 9 | Create User (Chaining) | 201 | ✅ PASS |
| 10 | Get Chained User | 404 | ⚠️ Expected — mock API doesn't persist data (see RCA #1) |
| 11 | Delete Chained User (1st + 2nd call) | 204 / 204 | ✅ PASS — idempotent |
| 12 | Register — Missing Password | 400 | ✅ PASS — validation works |
| 13 | Delete Non-Existent User | 204 | ✅ PASS — graceful handling |

## 🗄️ Database Integrity — 8 SQL Queries

Ran against the Chinook SQLite reference database via sqliteonline.com.

| # | Check | Result |
|---|---|---|
| 1 | Orphaned Invoices | 0 rows — ✅ PASS |
| 2 | Negative / Zero Totals | 0 rows — ✅ PASS |
| 3 | Duplicate Customer Emails | 0 rows — ✅ PASS |
| 4 | Invoice–Customer Join Accuracy | 10/10 correct — ✅ PASS |
| 5 | Customer Distribution by Country | Reasonable spread — ✅ PASS |
| 6 | High-Volume Customer Flag | 0 rows — ✅ PASS |
| 7 | Non-Purchasing Customers | 0 rows — ✅ PASS |
| 8 | Top 5 Highest Invoices | No outliers — ✅ PASS |

Full query text + inline results: [`sql-queries.sql`](./sql-queries.sql)

---

## 🔍 Root Cause Analysis Highlights

Full 5-Whys breakdowns are in [`rca-log.md`](./rca-log.md). Summary:

- **Finding 1 — "Get Chained User" 404 after 201 Create:** Not a defect. reqres.in is a mock API and doesn't persist created records to a real backend. In a production system, this exact symptom would trigger a check for write-then-read consistency or replica lag.
- **Finding 2 — Clean SQL result set (5/8 queries returned 0 rows):** Not a defect. Chinook is a well-formed reference dataset. The value delivered is a **validated, reusable query suite** ready to catch real issues against live production data.
- **Finding 3 — DELETE idempotency:** Confirmed PASS — repeated DELETE calls on the same resource correctly return 204 with no error, per REST best practice.
- **Finding 4 — Auth error handling:** Confirmed PASS — API correctly distinguishes missing credentials (401) from invalid credentials (403).

---

## 🛠️ Tools & Tech Used

- **Postman** — API request design, chaining, environment variables
- **reqres.in** — Mock REST API for CRUD/auth testing
- **SQLite (Chinook DB)** via sqliteonline.com — SQL integrity testing
- **Command Prompt** — Screenshot organization / file management
- **Markdown** — Documentation & reporting

## 👤 Author

Part of the **AI-Driven QA Portfolio** — a series of projects demonstrating API testing, database validation, and structured root-cause analysis using AI-assisted QA workflows.

---

*For the full narrative report with executive summary and Go/No-Go recommendation, see [`integrity-report.md`](./integrity-report.md).*
