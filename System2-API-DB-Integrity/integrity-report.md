<a id="top"></a>
<div align="center">

# 📋 System 2 — API + Database Integrity Report

[![API](https://img.shields.io/badge/API-13%2F13%20PASS-brightgreen?style=flat-square)]()
[![SQL](https://img.shields.io/badge/SQL-8%2F8%20PASS-brightgreen?style=flat-square)]()
[![Decision](https://img.shields.io/badge/decision-GO-brightgreen?style=flat-square)]()

⬅️ [README](./README.md) &nbsp;•&nbsp; 🧠 [RCA Log](./rca-log.md) &nbsp;•&nbsp; 🗄️ [SQL Queries](./sql-queries.sql) &nbsp;•&nbsp; 🖼️ [Screenshots](./screenshots)

</div>

---

## 🎯 Executive Summary

Ran a full API journey (**Register → Login → Get → Update → List → Delete**) against reqres.in, followed by **8 SQL data-integrity checks** against the Chinook reference database.

**Result: all 13 API tests passed, all 8 integrity queries confirmed a clean dataset** — correct auth, correct idempotency, correct referential integrity.

## 🧭 Scope

| ✅ In Scope | 🚫 Out of Scope |
|---|---|
| API auth, CRUD lifecycle, request chaining | Load / performance testing |
| Negative & idempotency testing | Multi-region replication testing |
| DB referential integrity & duplicate detection | — |
| Business-rule validation, fraud-review sampling | — |

---

## 🧪 API Journey Results — 13 requests

| # | Request | Status | Result |
|---|---|:---:|---|
| 1 | Register User | 200 | ✅ PASS |
| 2 | Login User | 200 | ✅ PASS |
| 3 | Get Profile | 200 | ✅ PASS |
| 4 | Update Profile | 200 | ✅ PASS |
| 5 | List Users | 200 | ✅ PASS |
| 6 | Delete Account | 204 | ✅ PASS |
| 7 | Get Profile (No Auth) | 401 | ✅ PASS |
| 8 | Get Profile (Invalid Key) | 403 | ✅ PASS |
| 9 | Create User (Chaining) | 201 | ✅ PASS |
| 10 | Get Chained User | 404 | ⚠️ Expected — see [RCA #1](./rca-log.md#1️⃣-finding-1--404-on-get-chained-user-after-successful-create) |
| 11 | Delete Chained User (1st + 2nd) | 204/204 | ✅ PASS — idempotent |
| 12 | Register — Missing Password | 400 | ✅ PASS |
| 13 | Delete Non-Existent User | 204 | ✅ PASS |

📸 Full visual evidence → [Screenshot Gallery](./README.md#️-evidence-walkthrough--screenshot-gallery)

<div align="right"><a href="#top">↑ top</a></div>

---

## 🗄️ SQL Integrity Query Results — 8 queries

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

🔎 Raw query text + inline results → [`sql-queries.sql`](./sql-queries.sql)

<div align="right"><a href="#top">↑ top</a></div>

---

## 💡 Key Findings

1. **Mock API limitation** — reqres.in doesn't persist created records; not a defect. → [Details](./rca-log.md)
2. **DELETE is correctly idempotent** — repeat calls don't error.
3. **Auth layer correctly distinguishes** missing (401) vs invalid (403) credentials.
4. **Zero referential integrity violations** across all 5 structural SQL checks — confirms both data quality *and* query correctness.

---

<div align="center">

## 🟢 Go / No-Go Recommendation

### **GO**

API authentication, CRUD lifecycle, and idempotency behavior all meet expected standards.
Database integrity queries are validated and reusable against production data.
**No blocking defects found** — one documented mock-API limitation noted for awareness only.

⬅️ [Back to README](./README.md) &nbsp;•&nbsp; 🧠 [Read the full RCA](./rca-log.md)

</div>
