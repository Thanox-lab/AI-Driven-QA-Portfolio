# System 1 — Manual QA & Agile Ownership

![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Test Cases](https://img.shields.io/badge/Test%20Cases-12%2F12%20Passed-success)
![Target](https://img.shields.io/badge/Target-saucedemo.com-blue)
![Method](https://img.shields.io/badge/Approach-Risk--Based%20Testing-orange)

## 📋 Problem

Handed a 5-line requirement doc for saucedemo.com's checkout flow: *"Valid login
works. Invalid login shows an error. Items can be added to the cart. Cart count is
accurate. Checkout completes successfully."* Nothing about edge cases, duplicate
submissions, session behavior, or multi-tab consistency — the real gaps a QA analyst
has to find before they become production bugs.

## 🎯 What I Did

- Wrote a formal test plan (objective, scope, approach, tools, timeline)
- Identified 5 unstated assumptions in the requirement doc before designing a single test case
- Designed 12 risk-ranked test cases (High/Medium/Low) covering login, cart, and checkout
- Executed all 12 cases manually against the live application with full evidence capture
- Logged one observation (sort dropdown hitbox issue) with root-cause reasoning

## 🔍 Key Findings

All 12 core functional flows passed — login, cart accuracy, checkout, and rapid
double-click submission all behaved correctly with no duplicate orders. Cart state
stayed consistent across two open tabs. One minor UX observation logged: clicking
directly on the sort dropdown's arrow icon does not open the dropdown, while clicking
the visible text label does — a functional gap in the icon's click handler.

---

## 🖼️ Execution Evidence

### Login & Access Control
| Valid Login | Invalid Credentials | Locked-Out User |
|---|---|---|
| ![TC01](screenshots/tc01-valid-login.png) | ![TC02](screenshots/tc02-invalid-login.png) | ![TC03](screenshots/tc03-locked-user.png) |
| TC01 — Pass | TC02 — Pass | TC03 — Pass |

### Cart Operations
| Single Item Added | Multiple Items Added | Item Removed |
|---|---|---|
| ![TC04](screenshots/tc04-add-single-item.png) | ![TC05](screenshots/tc05-add-multiple-items.png) | ![TC06](screenshots/tc06-remove-item.png) |
| TC04 — Pass | TC05 — Pass | TC06 — Pass |

| Badge Accuracy (Add+Remove) | Cross-Tab Sync |
|---|---|
| ![TC07](screenshots/tc07-badge-accuracy.png) | ![TC08](screenshots/tc08-two-tabs-sync.png) |
| TC07 — Pass | TC08 — Pass |

### Checkout Flow
| Valid Checkout | Empty Fields Validation | Double-Click Guard |
|---|---|---|
| ![TC09](screenshots/tc09-checkout-success.png) | ![TC10](screenshots/tc10-checkout-empty-fields.png) | ![TC11](screenshots/tc11-double-click-order.png) |
| TC09 — Pass | TC10 — Pass | TC11 — Pass |

### Sorting
| Price Sort (Low to High) |
|---|
| ![TC12](screenshots/tc12-sort-by-price.png) |
| TC12 — Pass |

---

## 📁 Artifacts in This Folder

| File | Description |
|---|---|
| `test-plan.md` | Objective, scope, approach |
| `clarification-log.md` | 5 unstated requirement assumptions identified upfront |
| `test-cases.csv` | 12 risk-ranked test cases with full Actual/Status results |
| `defect-log.md` | Observation log with root-cause reasoning |
| `screenshots/` | Execution evidence for all 12 test cases |

## ✅ Result

**Go.** All 12/12 test cases passed with no functional defects. One low-severity UX
observation logged for future refinement — does not block release.
