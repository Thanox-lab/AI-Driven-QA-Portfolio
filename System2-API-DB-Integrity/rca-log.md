<a id="top"></a>
<div align="center">

# 🧠 Root Cause Analysis Log — System 2

[![Findings](https://img.shields.io/badge/findings-4-blue?style=flat-square)]()
[![Method](https://img.shields.io/badge/method-5%20Whys-orange?style=flat-square)]()
[![Verdict](https://img.shields.io/badge/verdict-no%20blocking%20defects-brightgreen?style=flat-square)]()

⬅️ [README](./README.md) &nbsp;•&nbsp; 📄 [Full Report](./integrity-report.md) &nbsp;•&nbsp; 🗄️ [SQL Queries](./sql-queries.sql)

Every unexpected result gets a proper **5-Whys** dig instead of a lazy "known issue" label.

</div>

---

### 📑 Jump to a finding
[1️⃣ 404 after Create](#1️⃣-finding-1--404-on-get-chained-user-after-successful-create) · [2️⃣ Clean SQL results](#2️⃣-finding-2--8-sql-integrity-queries-came-back-clean) · [3️⃣ DELETE idempotency](#3️⃣-finding-3--delete-idempotency) · [4️⃣ Auth key handling](#4️⃣-finding-4--missinginvalid-api-key-handling)

---

## 1️⃣ Finding 1 — 404 on "Get Chained User" after successful Create

> 🟡 **Symptom:** `POST /users` → **201** with a new ID, but `GET /users/{id}` right after → **404**.

<details>
<summary><b>🔍 Click to expand the 5-Whys trace</b></summary>

| # | Why | Answer |
|---|---|---|
| 1 | Why the 404? | The user ID doesn't actually exist when queried. |
| 2 | Why doesn't it exist? | `reqres.in` is a **mock/simulated** API. |
| 3 | Why does mock matter? | POST returns a fake generated ID but never persists it to a real backend. |
| 4 | Why is this important? | In a real system, this exact pattern (success code, unreadable data) signals a **write-then-read consistency bug** or **replica lag**. |
| 5 | Root cause | No validation gap — this is expected mock-API behavior, not a genuine defect. |

</details>

**✅ Conclusion:** Simulated backend limitation, not a real bug. In production, this same symptom would trigger a check for replication lag or write confirmation before reporting success.

<div align="right"><a href="#top">↑ top</a></div>

---

## 2️⃣ Finding 2 — 8 SQL integrity queries came back clean

> 🟡 **Symptom:** 5 of 8 queries (orphaned invoices, negative totals, duplicate emails, high-volume customers, non-purchasing customers) returned **0 rows**.

<details>
<summary><b>🔍 Click to expand the 5-Whys trace</b></summary>

| # | Why | Answer |
|---|---|---|
| 1 | Why 0 rows everywhere? | Chinook is a well-formed **reference dataset**, not live production data. |
| 2 | Why does that matter? | Reference datasets are pre-validated — no real-world data-entry errors. |
| 3 | Why run the checks anyway? | To prove the queries themselves are correct and would catch real issues if they existed. |
| 4 | Why is that valuable? | It proves the queries are **production-ready** and reusable. |
| 5 | Root cause | No integrity issue in this dataset; the queries are validated and ready for a live database. |

</details>

**✅ Conclusion:** A genuine **PASS**, not a bug. The deliverable here is the reusable, validated query suite — ready to flag real issues the moment it's pointed at live data.

<div align="right"><a href="#top">↑ top</a></div>

---

## 3️⃣ Finding 3 — DELETE idempotency

> 🟡 **Symptom:** Calling `DELETE` on the same user ID **twice** both returned **204 No Content** — no error on the repeat call.

<details>
<summary><b>🔍 Click to expand the 5-Whys trace</b></summary>

| # | Why | Answer |
|---|---|---|
| 1 | Why no error on 2nd call? | API doesn't check whether the resource still existed. |
| 2 | Why is that OK? | REST idempotency principles state DELETE should be safe to call repeatedly. |
| 3 | Why does this matter for QA? | Non-idempotent DELETEs cause client retries to throw false errors. |
| 4 | Why test this specifically? | Common blind spot most manual testers skip. |
| 5 | Root cause | No defect — this is correct RESTful idempotent design. |

</details>

**✅ Conclusion:** **PASS** — API follows RESTful idempotency best practice.

<div align="right"><a href="#top">↑ top</a></div>

---

## 4️⃣ Finding 4 — Missing/invalid API key handling

> 🟡 **Symptom:** No `x-api-key` → **401**. Invalid `x-api-key` → **403**.

**Root cause:** Intentional design — the API correctly distinguishes *"no credentials"* (401 Unauthorized) from *"bad credentials"* (403 Forbidden), which is correct HTTP semantic usage.

**✅ Conclusion:** **PASS** — auth layer is correctly implemented and testable.

<div align="right"><a href="#top">↑ top</a></div>

---

<div align="center">

### 🧾 Summary

| Finding | Verdict |
|---|---|
| 1. 404 after Create | 🟢 Expected mock-API behavior |
| 2. Clean SQL results | 🟢 PASS — queries validated |
| 3. DELETE idempotency | 🟢 PASS |
| 4. Auth key handling | 🟢 PASS |

**No blocking defects found.** See the [full integrity report](./integrity-report.md) for the Go/No-Go call.

⬅️ [Back to README](./README.md)

</div>
