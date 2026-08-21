# Defect & Observation Log

## OBS-01: Sort dropdown arrow icon non-responsive
**Severity:** Low | **Priority:** Low
**Steps to Reproduce:**
1. Go to Products page
2. Click directly on the dropdown arrow icon (not the text) for the sort control
**Expected:** Dropdown opens
**Actual:** Dropdown does not open at all when clicking the arrow icon; clicking the
visible text label ("Name (A to Z)") is the only way that reliably opens it.
**Root Cause:** The arrow icon appears to be a purely decorative/visual element with
no click handler attached, while the actual interactive element is scoped to the
text label only. The icon and the functional control are not the same clickable region.
**Environment:** Chrome/Brave, Desktop
**Screenshot:** captured during TC12 execution

---

## Notes
- No functional bugs found in the core login, cart, and checkout flows during this session.
- All 12 risk-ranked test cases passed.
- The dropdown issue (OBS-01) is a minor UX/interaction gap, not a functional defect —
  logged for completeness since a real QA analyst reports what they observe, not only
  what fails a scripted assertion.
