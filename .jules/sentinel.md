## 2025-05-23 - [Information Disclosure via Error Boundaries]
**Vulnerability:** Application internals, including stack traces and detailed error messages, were exposed to end-users in production through React Error Boundaries.
**Learning:** Default error boundary implementations often prioritize developer experience by displaying the full error object, which can leak sensitive path information and code structure.
**Prevention:** Always gate detailed error reporting behind environment checks (e.g., `import.meta.env.DEV`) and provide generic, user-friendly messages for production users.
