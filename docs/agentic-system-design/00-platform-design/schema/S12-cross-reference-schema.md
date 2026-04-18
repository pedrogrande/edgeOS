# Schema 12: `cross_reference`

*Explicit traceability links between responses across documents — the machine-readable version of the traceability matrix in Test \& Acceptance.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `source_document_id` | UUID FK → document_instance |  |
| `source_question_id` | UUID FK → template_question |  |
| `target_document_id` | UUID FK → document_instance |  |
| `target_question_id` | UUID FK → template_question |  |
| `reference_type` | ENUM | `populates` / `constrains` / `validates` / `informs` |
| `is_auto_generated` | BOOLEAN | created by Dependency Service or manually |
| `created_at` | TIMESTAMPTZ |  |
