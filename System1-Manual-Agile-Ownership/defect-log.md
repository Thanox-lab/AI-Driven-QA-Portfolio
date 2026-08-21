# Defect & Observation Log

## BUG-01: Reset App State does not revert "Remove" buttons
**Severity:** Medium | **Priority:** Medium
Adding items to cart, then Reset App State from the ☰ menu, clears the cart badge
but the product buttons still show "Remove" instead of reverting to "Add to cart."
Reset likely clears cart data without re-binding the button states.

![Bug 01](screenshots/bug01-reset-state.png)

---

## BUG-02: Corrupted page when reopening via browser history
**Severity:** Medium | **Priority:** Low
Reopening the app from browser History loads a broken, unstyled page with an error
banner overlapping the password field. Likely a stale bfcache/history restore that
skips re-fetching styles.

![Bug 02](screenshots/bug02-corrupted-history-page.png)

---

## BUG-03: Second login requires re-entering the URL manually
**Severity:** Medium | **Priority:** Medium
From the corrupted state in BUG-02, logging in again doesn't work — the URL has to
be manually retyped in a new tab before login succeeds.

![Bug 03](screenshots/bug03-second-login-fail.png)

---

## BUG-04: Clear ("x") icon on username field is non-functional
**Severity:** Low | **Priority:** Low
Typing a wrong username and clicking the field's "x" icon doesn't clear the text —
the icon appears decorative, not wired to a clear handler.

![Bug 04](screenshots/bug04-clear-icon-nonfunctional.png)

---

## BUG-05: Visual/functional defects across special test user accounts
**Severity:** Medium | **Priority:** Low (test-account-specific, by design)

| User | Observed Issue | Evidence |
|---|---|---|
| `problem_user` | All product images replaced with an unrelated dog image | ![problem_user](screenshots/bug05-problem-user.png) |
| `performance_glitch_user` | Bike Light renders inconsistently vs. other products | ![performance_glitch_user](screenshots/bug05-performance-glitch-user.png) |
| `error_user` | Last Name field on checkout won't accept input; Continue does nothing — order can never finish | ![error_user](screenshots/bug05-error-user.png) |
| `visual_user` | Dog image on backpack; cart icon/layout visibly misaligned | ![visual_user](screenshots/bug05-visual-user.png) |

These are SauceDemo's built-in "broken" test accounts, each isolating a different
bug category on purpose.

---

## BUG-06: Product prices randomized/incorrect for visual_user
**Severity:** Medium | **Priority:** Low
Under `visual_user`, listed prices don't match the real catalog values (e.g. $52.48
shown for a $29.99 backpack). A separate data-integrity issue from the layout bug
above, seen in the same session.

![Bug 06](screenshots/bug06-price-glitch.png)

---

## OBS-01: Sort dropdown arrow icon has no click handler
**Severity:** Low | **Priority:** Low
Clicking the dropdown arrow icon on the Products page does nothing — only clicking
the visible text label ("Name (A to Z)") opens the sort menu.

![OBS 01](screenshots/obs01-sort-dropdown.png)

---

## Notes
All 12 core risk-ranked test cases (TC01–TC12) passed on the standard `standard_user`
flow. The defects above came from additional adversarial/exploratory testing beyond
the scripted plan — special user accounts and browser navigation edge cases —
which is standard QA ownership beyond the written test plan.
