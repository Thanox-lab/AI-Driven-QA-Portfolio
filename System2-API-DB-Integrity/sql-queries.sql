-- ============================================
-- System 2: Data Integrity SQL Queries
-- Database: Chinook (SQLite) via sqliteonline.com
-- ============================================

-- Query 1: Orphaned Invoices (invoice with non-existent customer)
SELECT * FROM Invoice WHERE CustomerId NOT IN (SELECT CustomerId FROM Customer);
-- RESULT: 0 rows. No orphaned invoices — referential integrity intact.

-- Query 2: Impossible Invoice Totals
SELECT * FROM Invoice WHERE Total <= 0;
-- RESULT: 0 rows. No zero/negative totals found — data validation appears correct at write time.

-- Query 3: Duplicate Customer Emails
SELECT Email, COUNT(*) FROM Customer GROUP BY Email HAVING COUNT(*) > 1;
-- RESULT: 0 rows. No duplicate emails — unique constraint / validation working as expected.

-- Query 4: Invoice + Customer Name Cross-Check
SELECT i.InvoiceId, c.FirstName, c.LastName, i.Total 
FROM Invoice i JOIN Customer c ON i.CustomerId = c.CustomerId 
LIMIT 10;
-- RESULT: 10 rows returned (e.g. Leonie Kohler - 1.98, Bjorn Hansen - 3.96, Daan Peeters - 5.94).
-- Names and totals correctly joined; no mismatches observed in sample.

-- Query 5: Customers by Country (Dashboard Sanity Check)
SELECT Country, COUNT(*) AS CustomerCount FROM Customer 
GROUP BY Country ORDER BY CustomerCount DESC;
-- RESULT: USA-13, Canada-8, France-5, Brazil-5, Germany-4, UK-3, Portugal-2, India-2, Czech Republic-2 (+more).
-- Distribution looks reasonable, no anomalous spikes.

-- Query 6: High-Volume Customers (Fraud/VIP Review Flag)
SELECT CustomerId, COUNT(*) AS InvoiceCount FROM Invoice 
GROUP BY CustomerId HAVING COUNT(*) > 7;
-- RESULT: 0 rows. No customer exceeds 7 invoices — no unusual order volume detected.

-- Query 7: Customers Who Never Purchased (Signup Funnel Drop-off)
SELECT * FROM Customer WHERE CustomerId NOT IN (SELECT CustomerId FROM Invoice);
-- RESULT: 0 rows. Every customer has at least one invoice — no drop-off in this dataset.

-- Query 8: Top 5 Highest Invoices (Manual Fraud Review Sample)
SELECT * FROM Invoice ORDER BY Total DESC LIMIT 5;
-- RESULT: Top invoice #404 = 25.86, #299 = 23.86, #96 = 21.86, #194 = 21.86, #89 = 18.86.
-- Values reasonable, no extreme outliers requiring review.