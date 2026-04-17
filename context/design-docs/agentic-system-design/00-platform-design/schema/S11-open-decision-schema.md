# Schema 11: `open_decision`

*Every open decision surfaced in any document — tracked to resolution.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `document_id` | UUID FK → document_instance |  |
| `question_id` | UUID FK → template_question | the question that surfaced it (optional) |
| `description` | TEXT |  |
| `impact_if_unresolved` | TEXT |  |
| `owner_id` | UUID FK → users |  |
| `target_resolution_date` | DATE |  |
| `status` | ENUM | `open` / `resolved` / `deferred` / `cancelled` |
| `resolution` | TEXT |  |
| `resolved_by` | UUID FK → users |  |
| `resolved_at` | TIMESTAMPTZ |  |
| `created_at` | TIMESTAMPTZ |  |