# Schema 15: `audit_event`

*Every application action — structurally separate, append-only. Written by infrastructure, never by application code that could suppress it.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `event_type` | TEXT | e.g. `response.created`, `document.generated`, `readiness_check.passed` |
| `actor_id` | UUID FK → users |  |
| `system_id` | UUID FK → design_system | for system-scoped actions |
| `target_entity_type` | TEXT | e.g. `response`, `document_instance`, `open_decision` |
| `target_entity_id` | UUID |  |
| `event_data` | JSONB | full context at time of event |
| `created_at` | TIMESTAMPTZ |  |
| `session_id` | UUID | to correlate events within a session |

*Constraint: no UPDATE or DELETE permitted — enforced at the database role level.*
