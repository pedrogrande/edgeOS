# Schema 10: `readiness_check`

*Tracks the status of each item in each document's readiness checklist.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `document_id` | UUID FK → document_instance |  |
| `question_id` | UUID FK → template_question | the checklist question this maps to |
| `status` | ENUM | `unchecked` / `pass` / `fail` / `not_applicable` |
| `notes` | TEXT |  |
| `checked_by` | UUID FK → users |  |
| `checked_at` | TIMESTAMPTZ |  |
