## 2026-05-24 - Information Leakage Prevention
**Vulnerability:** Application details and stack traces were exposed in the UI through Error Boundaries.
**Learning:** React Error Boundaries by default might expose sensitive internal state or stack traces if not properly gated.
**Prevention:** Always gate detailed error messages and stack traces behind environment checks (e.g., `import.meta.env.DEV`) in production-facing components.
