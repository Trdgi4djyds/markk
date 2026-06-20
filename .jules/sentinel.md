## 2026-06-20 - Gating error details in UI
**Vulnerability:** Information disclosure via React Error Boundary.
**Learning:** React Error Boundaries (both functional with `useRouteError` and class-based) were rendering full `error.stack` and `error.message` to the UI, which can leak sensitive information about the application's internal structure and dependencies in production.
**Prevention:** Always gate detailed error information and stack traces behind `import.meta.env.DEV` (or similar environment checks) in UI components. Provide generic error messages for production users.
