# Defect & Observation Log

## OBS-01: Sort dropdown arrow icon non-responsive
**Severity:** Low | **Priority:** Low
**Steps to Reproduce:**
1. Go to Products page
2. Click directly on the dropdown arrow icon (not the text) for the sort control
**Expected:** Dropdown opens
**Actual:** Dropdown does not open when clicking the arrow icon specifically; clicking the
visible text label ("Name (A to Z)") opens it correctly.
**Root Cause:** Likely a small clickable-area/hitbox mismatch between the icon and the
underlying select element — the icon may be a decorative element sitting outside the
actual interactive boundary.
**Environment:** Chrome/Brave, Desktop
**Screenshot:** captured during TC12 execution

---

## Notes
- No functional bugs found in the core login, cart, and checkout flows during this session.
- All 12 risk-ranked test cases passed.
- The dropdown issue (OBS-01) is a minor UX/interaction gap, not a functional defect —
  logged for completeness since a real QA analyst reports what they observe, not only
  what fails a scripted assertion.
