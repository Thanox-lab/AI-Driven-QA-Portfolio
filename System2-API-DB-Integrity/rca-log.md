\# Root Cause Analysis Log — System 2



\## Finding 1: Postman "Get Chained User" returned 404 after successful Create (201)

\- \*\*Symptom:\*\* POST /users returns 201 with a new user ID, but GET /users/{id} 

&#x20; immediately after returns 404.

\- \*\*5 Whys:\*\*

&#x20; 1. Why 404? → The user ID doesn't exist when queried.

&#x20; 2. Why doesn't it exist? → reqres.in is a mock/simulated API.

&#x20; 3. Why does a mock API matter here? → POST requests return a fake generated ID 

&#x20;    but never persist it to a real backend.

&#x20; 4. Why is this important? → In a real system, this exact symptom (success code 

&#x20;    but data not retrievable) would indicate a write-then-read consistency bug 

&#x20;    or replica lag.

&#x20; 5. Root cause → API validation gap is NOT present; this is expected mock-API 

&#x20;    behavior, not a genuine data integrity issue.

\- \*\*Conclusion:\*\* Simulated backend limitation, not a real defect. In a production 

&#x20; system, this same symptom would require checking replication lag or write 

&#x20; confirmation before reporting success.



\## Finding 2: 8 SQL Integrity Queries — Clean Result Set

\- \*\*Symptom:\*\* 5 of 8 integrity queries (orphaned invoices, negative totals, 

&#x20; duplicate emails, high-volume customers, non-purchasing customers) returned 

&#x20; 0 rows.

\- \*\*5 Whys:\*\*

&#x20; 1. Why 0 rows across multiple integrity checks? → Chinook is a well-formed 

&#x20;    reference dataset, not live production data.

&#x20; 2. Why does that matter? → Reference datasets are typically pre-validated 

&#x20;    and don't carry real-world data entry errors.

&#x20; 3. Why run the checks anyway? → To prove the queries themselves are correct 

&#x20;    and would catch real issues if they existed.

&#x20; 4. Why is proving query correctness valuable? → It demonstrates the queries 

&#x20;    are production-ready and can be reused against live data.

&#x20; 5. Root cause → No integrity issue exists in this dataset; queries are 

&#x20;    validated and ready for use against a real production database.

\- \*\*Conclusion:\*\* This is a UI/data trustworthiness "PASS" — not a bug. The 

&#x20; value of this system is the reusable query suite, ready to flag real issues 

&#x20; when run against live data.



\## Finding 3: DELETE Idempotency

\- \*\*Symptom:\*\* Calling DELETE on the same user ID twice both returned 204 

&#x20; No Content (no error on second call).

\- \*\*5 Whys:\*\*

&#x20; 1. Why does the 2nd DELETE not error? → API doesn't check if resource 

&#x20;    already existed.

&#x20; 2. Why is that acceptable? → REST idempotency principles state DELETE 

&#x20;    should be safe to call multiple times.

&#x20; 3. Why does this matter for QA? → Improper idempotency can cause client 

&#x20;    retries to throw false errors.

&#x20; 4. Why test this specifically? → It's a common blind spot in API testing 

&#x20;    that most manual testers skip.

&#x20; 5. Root cause → No defect — this is correct RESTful idempotent design.

\- \*\*Conclusion:\*\* PASS — API follows RESTful idempotency best practice.



\## Finding 4: Missing/Invalid API Key Handling

\- \*\*Symptom:\*\* Requests without x-api-key returned 401; requests with an 

&#x20; invalid key returned 403.

\- \*\*Root cause:\*\* Intentional API design — distinguishes "no credentials" 

&#x20; (401 Unauthorized) from "bad credentials" (403 Forbidden), which is 

&#x20; correct HTTP semantic usage.

\- \*\*Conclusion:\*\* PASS — Auth layer is correctly implemented and testable.

