# Data Schemas

## Core Design Principles for the Schema

- Every canonical question is a **database record**, not a code constant — this enables versioning, A/B testing of question wording, and future question addition without a code deploy
- Responses are **never deleted** — only superseded by a new version; full history is preserved
- The generated document is **never the source of truth** — it is a computed view, always regenerable
- The audit log is **structurally separate** from application storage — a separate table, append-only enforced at the database constraint level

## Schema index

Schema 1: `users`
Schema 2: `design_system`
Schema 3: `template_definition`
Schema 4: `template_dependency`
Schema 5: `template_section`
Schema 6: `template_question`
Schema 7: `document_instance`
Schema 8: `response`
Schema 9: `response_history`
Schema 10: `readiness_check`
Schema 11: `open_decision`
Schema 12: `cross_reference`
Schema 13: `generated_document`
Schema 14: `collaborator`
Schema 15: `audit_event`
