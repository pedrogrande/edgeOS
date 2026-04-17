# Schema 9: `response_history`

*Immutable log of every response change — append-only, no updates or deletes.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `response_id` | UUID FK → response |  |
| `version` | INTEGER | matches `response.current_version` at time of write |
| `response_text` | TEXT |  |
| `response_structured` | JSONB |  |
| `changed_by` | UUID FK → users |  |
| `changed_at` | TIMESTAMPTZ |  |
| `change_reason` | TEXT | optional — why was this changed |

*Constraint: no UPDATE or DELETE permitted on this table — enforced at the database role level, not application logic.*
